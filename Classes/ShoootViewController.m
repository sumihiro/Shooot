//
//  ShoootViewController.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ShoootViewController.h"
#import "QuartzCore/QuartzCore.h"

@implementation ShoootViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		
	}
    return self;
}
 */

-(void)awakeFromNib {
	//thread = nil;
	//isThreadrunning = NO;
	
	dir = 0; // 渦巻き状弾の方向パラメータ
	t1 = 0, t2 = 0; // スリープ用
	interval = 0; // 弾発射の間隔調整用
	
	halfsizeofspaceship = 36; // 画像のサイズ 72x72
	halfsizeofenemy = 36; // 画像のサイズ 72x72
	halfsizeofmybullet = 8; // 画像のサイズ 16x16
	sizeofbullet = 9; // 画像サイズ 9ｘ9
	
	nwaybulletmode = 0, snipebulletmode = 0;
	framerate=0, framecount=0, time1forfps=0, time2forfps=0; // FPS用
	gameovercount = 0;
	touchaction;
	bgimagex = 0;
	isShake = NO;
	
	bullet1 = [[LinkedList alloc] init];
	bullet2 = [[LinkedList alloc] init];
	cd = [[CollisionDetect alloc] init];
	//paintlife = new Paint();
	//paintlife.setStyle(Style.FILL);
	//paintlife.setARGB(100, 0, 255, 0);
	//painthit = new Paint();
	//painthit.setStyle(Style.FILL);
	//painthit.setARGB(100, 255, 0, 0);
	recthit = CGRectZero;
	
	fpsFont = [[UIFont systemFontOfSize:16.0f] retain];
	fpsColor = [[UIColor redColor] retain];
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[(ShootView*)self.view setDelegate:self];
	
	appDelegate = (ShoootAppDelegate*)[[UIApplication sharedApplication] delegate];

	CGRect viewFrame = [[self view] frame];
	viewh = viewFrame.size.height;
	vieww = viewFrame.size.width;
	
	
	// キャラクタを生成
	spaceship = [[Spaceship alloc] initWithX:vieww/2
										   Y:viewh - halfsizeofspaceship*2
									   viewW:vieww];
	enemy1 = [[Enemy alloc] initWithInitX:(float)RAND() * vieww/2
									initY:(float)RAND() * vieww / 2
									   vx:RAND() * 2
									   vy:RAND() * 2
									viewW:vieww viewH:viewh];
	enemy2 = [[Enemy alloc] initWithInitX:(float)RAND() * vieww/2
									initY:(float)RAND() * vieww / 2
									   vx:RAND() * 2
									   vy:RAND() * 2
									viewW:vieww viewH:viewh];
	mybullet = [[LinearBullet alloc] initWithSpaceshipX:spaceship.x
											 spaceshipY:spaceship.y
												  viewW:vieww viewH:viewh];

	// 背景をSurfaceViewのサイズに変更
	//ShoootActivity.bgimage = Bitmap.createScaledBitmap(ShoootActivity.bgimage,
	//												   vieww, viewh, true);

	// 長方形の初期化
	recthit = [[self view] frame];
	
	// スレッドの開始
	timer = [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(run) userInfo:nil repeats:YES];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	//isThreadrunning = NO;
	@synchronized(self) {
		[timer invalidate];
	}

	[(ShootView*)self.view setDelegate:nil];
	appDelegate = nil;
	
	[spaceship release];
	[enemy1 release];
	[enemy2 release];
	[mybullet release];
}


- (void)dealloc {
	[fpsFont release];
	[fpsColor release];
	
	[bullet1 release];
	[bullet2 release];
	[cd release];
	
    [super dealloc];
}

#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point = [touch locationInView:self.view];
	touchx = point.x;
	
	touchAction = [event type];
}

#pragma mark -
-(void)run {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	// TODO Auto-generated method stub
	// ゲームのメインループ
	//while (isThreadrunning) {
		@synchronized (self) {
			t1 = [NSDate timeIntervalSinceReferenceDate];
			// 自機移動
			if(spaceship.x + halfsizeofspaceship < touchx){
				[spaceship right:touchx];
			}else{
				[spaceship left:touchx];
			}
			
			// 自弾移動
			if(mybullet.isLive == true && spaceship.life > 0){
				[mybullet move];
			}else{
				mybullet.x = spaceship.x + halfsizeofspaceship;
				mybullet.y = spaceship.y;
				mybullet.isLive = YES;
			}
			
			[enemy1 move]; // 敵機移動
			[enemy2 move];
			
			// 敵弾生成
			interval++;
			interval = interval & 65535;
			if(interval % 2 == 0){
				NwayBullet *nb = [[NwayBullet alloc] initWithInitX:enemy1.x + halfsizeofenemy
															 initY:enemy1.y + halfsizeofenemy
															   dir:dir
															 viewW:vieww
															 viewH:viewh
															  mode:nwaybulletmode];
				dir = ++dir & 255; // 念のため256で0クリア
				[bullet1 add:nb];
			}
			if(interval % 4 == 0){
				SnipeBullet *sb = [[SnipeBullet alloc] initWithInitX:enemy2.x + halfsizeofenemy
															   initY:enemy2.y + halfsizeofenemy
														  spaceshipX:spaceship.x + halfsizeofspaceship
														  spaceshipY:spaceship.y
															   viewW:vieww
															   viewH:viewh
																mode:snipebulletmode];
				[bullet2 add:sb];
			}
			// 敵弾移動と当り判定
			[bullet1 reset];
			while ([bullet1 hasNext]) {
				NwayBullet *nwaybullet = (NwayBullet*)[bullet1 next];
				[nwaybullet move];
				// 当り判定
				if(nwaybullet.y > viewh - halfsizeofspaceship*2 - sizeofbullet){
					if([cd test:nwaybullet withSpaceship:spaceship]){
						spaceship.life--;
						isHit = true;
					}
				}
				if(nwaybullet.isLive == false){
					[bullet1 remove];
				}
			}
			
			[bullet2 reset];
			while ([bullet2 hasNext]) {
				SnipeBullet *snipebullet = (SnipeBullet*)[bullet2 next];
				[snipebullet move:spaceship.x];
				// 当り判定
				if(snipebullet.y > viewh - halfsizeofspaceship*2 - sizeofbullet){
					if([cd test:snipebullet withSpaceship:spaceship]){
						spaceship.life--;
						isHit = true;
					}
				}
				if(snipebullet.isLive == false){
					[bullet2 remove];
				}
			}

		}
		
		// 自弾と敵の当り判定
		if([cd test:mybullet withEnemy:enemy1]){
			nwaybulletmode = 1 - nwaybulletmode;
			[bullet1 removeAll];
			mybullet.x = spaceship.x + halfsizeofspaceship;
			mybullet.y = spaceship.y;
			spaceship.life = spaceship.life + 5;
		}
		if([cd test:mybullet withEnemy:enemy2]){
			snipebulletmode = 1 - snipebulletmode;
			[bullet2 removeAll];
			mybullet.x = spaceship.x + halfsizeofspaceship;
			mybullet.y = spaceship.y;
			spaceship.life = spaceship.life + 5;
		}
		if(spaceship.life > vieww){ // 自機ライフの上限設定
			spaceship.life = vieww;
		}
		
		// 描画の処理
		[self.view setNeedsDisplay];
		/*
		Canvas canvas = holder.lockCanvas(); // ロックをかける
		drawOnCanvas(canvas);
		holder.unlockCanvasAndPost(canvas); // ロックを解除
		*/
		
		// スリープ
		/*
		t2 = [NSDate timeIntervalSinceReferenceDate];
		if(t2 - t1 < 16/1000){ // 1000 / 60 = 16.6666
			@try {
				[NSThread sleepForTimeInterval:(16/1000 - (t2 - t1))];
			} 
			@catch (NSException *e) {
			}
		}
		 */
		
		// Game Over と 再開
		if(spaceship.life < 0){	
			gameovercount++;
			if(gameovercount > 60*4){ // 4秒くらい待つ
				if(touchaction == UIEventTypeTouches && 
				   touchx > 1 && touchx < vieww){
					spaceship.life = vieww;
					touchaction = 0;
					gameovercount = 0;
					// 敵弾を消し、敵機の座標と速度初期化
					[bullet1 removeAll];
					[bullet2 removeAll];
					
					//FIXME: initが2回呼ばれるのはよろしくない。別のメソッド名を用意すべき
					[enemy1 initWithInitX:(float)RAND() * vieww/2
									initY:(float)RAND() * vieww/2
									   vx:RAND() * 2
									   vy:RAND() * 2];
					[enemy2 initWithInitX:(float)RAND() * vieww/2
									initY:(float)RAND() * vieww/2
									   vx:RAND() * 2
									   vy:RAND() * 2];
				}
			}
		}
		
		// FPS処理
		time1forfps = [NSDate timeIntervalSinceReferenceDate];
		if(time1forfps - time2forfps > 1){
			framerate = framecount;
			framecount = 0;
			time2forfps = time1forfps;
		}
		framecount++;
	//}	
	[pool release];
}

-(void)drawOnCanvas:(CGContextRef)canvas {
	// 背景描画
	if(isShake){
		switch (bgimagex){
			case 0:
				bgimagex = 5;
				[appDelegate vibrate]; // 実機を振動
				break;
			case 5:
				bgimagex = -5;
				break;
			case -5:
				bgimagex = 0;
				isShake = false;
		}
	}
	[[appDelegate bgimage] drawAtPoint:CGPointMake(0, 0)];
	//canvas.drawBitmap(ShoootActivity.bgimage, bgimagex, 0, null);
	
	// 敵機描画
	[[appDelegate enemy] drawAtPoint:CGPointMake(enemy1.x, enemy1.y)];
	//canvas.drawBitmap(ShoootActivity.enemy, 
	//				  enemy1.x, enemy1.y, null);
	[[appDelegate enemy] drawAtPoint:CGPointMake(enemy2.x, enemy2.y)];
	//canvas.drawBitmap(ShoootActivity.enemy, 
	//				  enemy2.x, enemy2.y, null);
	
	// 敵弾描画
	[bullet1 reset];
	while ([bullet1 hasNext]) {
		NwayBullet *bullet = [bullet1 next];
		[[appDelegate bullet1] drawAtPoint:CGPointMake(bullet.x, bullet.y)];
	}
	//for(NwayBullet bullet: bullet1){
	//	canvas.drawBitmap(ShoootActivity.bullet1, bullet.x, bullet.y, null);
	//}
	[bullet2 reset];
	while ([bullet2 hasNext]) {
		NwayBullet *bullet = [bullet2 next];
		[[appDelegate bullet2] drawAtPoint:CGPointMake(bullet.x, bullet.y)];
	}
	//for(SnipeBullet bullet: bullet2){
	//	canvas.drawBitmap(ShoootActivity.bullet2, bullet.x, bullet.y, null);
	//}		
	
	if(spaceship.life > 0){
		// 自機描画
		[[appDelegate spaceship] drawAtPoint:CGPointMake(spaceship.x, spaceship.y)];
		//canvas.drawBitmap(ShoootActivity.spaceship, 
		//				  spaceship.x, spaceship.y, null);
		// 自弾描画
		[[appDelegate mybullet] drawAtPoint:CGPointMake(mybullet.x, mybullet.y)];
		//canvas.drawBitmap(ShoootActivity.mybullet, 
		//				  mybullet.x-halfsizeofmybullet, mybullet.y, null);
		
		// ライフゲージ描画
		//FIXME: 矩形の描画方法を調べる
		//canvas.drawRect(0, 5, spaceship.life, 20, paintlife);
		
		// hit時の処理
		if(isHit){
			recthit.origin.x = bgimagex;
			recthit.size.width = bgimagex + vieww;
			//canvas.drawRect(recthit, painthit);
			isHit = false;
			if(isShake==false)isShake=true;
		}
	}else{
		// Game Over描画
		isShake = false;
		bgimagex = 0;
		NSString *go = [[NSString alloc] initWithFormat:@"GAME OVER"];
		[go drawAtPoint:CGPointMake(vieww/2 - 43, viewh/2 - 10) withFont:[UIFont systemFontOfSize:14.0f]];
		[go release];
		//Paint gameover = new Paint();
		//gameover.setARGB(255, 255, 0, 0);
		//gameover.setTextSize(16);	
		//canvas.drawText("GAME OVER", vieww/2 - 43, viewh/2 - 10, gameover);
	}
	
	// FPS表示
	[fpsColor set];
	NSString *fps = [[NSString alloc] initWithFormat:@"FPS : %d",framerate];
	[fps drawAtPoint:CGPointMake(1, 40) withFont:fpsFont];
	[fps release];
	//canvas.drawText("FPS : " + String.valueOf(framerate), 1, 40, painthit);
}

@end
