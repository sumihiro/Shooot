//
//  ShoootViewController.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Spaceship.h"
#import "Enemy.h"
#import "LinearBullet.h"
#import "CollisionDetect.h"
#import "LinkedList.h"
#import "NwayBullet.h"
#import "SnipeBullet.h"
#import "ShootView.h"

#import "ShoootAppDelegate.h"

@interface ShoootViewController : UIViewController {
	//SurfaceHolder holder = null;
	//NSThread *thread;
	//BOOL isThreadrunning;
	NSTimer *timer;
	UIEventType touchAction;
	float touchx; // タッチされたx座標
	int vieww, viewh; // SurfaveViewの幅と高さ
	int dir; // 渦巻き状弾の方向パラメータ
	NSTimeInterval t1, t2; // スリープ用
	int interval; // 弾発射の間隔調整用
	BOOL isHit;
	Spaceship *spaceship;
	Enemy *enemy1, *enemy2;
	int halfsizeofspaceship; // 画像のサイズ 72x72
	int halfsizeofenemy; // 画像のサイズ 72x72
	int halfsizeofmybullet; // 画像のサイズ 16x16
	int sizeofbullet; // 画像サイズ 9ｘ9
	LinkedList *bullet1;
	LinkedList *bullet2;
	LinearBullet *mybullet;
	CollisionDetect *cd;
	//Paint paintlife, painthit;
	int nwaybulletmode, snipebulletmode;
	long framerate, framecount, time1forfps, time2forfps; // FPS用
	int gameovercount;
	int touchaction;
	int bgimagex;
	BOOL isShake;
	// 長方形のクラス public Rect (int left, int top, int right, int bottom)
	CGRect recthit;
	
	UIFont *fpsFont;
	UIColor *fpsColor;
	UIFont *gameoverFont;
	
	ShoootAppDelegate *appDelegate;
}

-(void)drawOnCanvas:(CGContextRef)canvas;


@end

