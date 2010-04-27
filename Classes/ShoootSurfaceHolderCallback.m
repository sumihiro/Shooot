//
//  ShoootSurfaceHolderCallback.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ShoootSurfaceHolderCallback.h"


@implementation ShoootSurfaceHolderCallback

@end

/* Programming by Nikkei Software 2010 April       */
/* http://software.nikkeibp.co.jp                  */
/* This code comes with no warranty and no support */

/*
package com.foo.bar;

import java.util.Iterator;
import java.util.LinkedList;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.Paint.Style;
import android.view.SurfaceHolder;

public class ShoootSurfaceHolderCallback implements SurfaceHolder.Callback, Runnable {
	private SurfaceHolder holder = null;
	private Thread thread = null;
	private boolean isThreadrunning = true;
	private float touchx; // タッチされたx座標
	int vieww, viewh; // SurfaveViewの幅と高さ
	private int dir = 0; // 渦巻き状弾の方向パラメータ
	private long t1 = 0, t2 = 0; // スリープ用
	private int interval = 0; // 弾発射の間隔調整用
	private boolean isHit = false;
	Spaceship spaceship;
	Enemy enemy1, enemy2;
	private final int halfsizeofspaceship = 36; // 画像のサイズ 72x72
	private final int halfsizeofenemy = 36; // 画像のサイズ 72x72
	private final int halfsizeofmybullet = 8; // 画像のサイズ 16x16
	private final int sizeofbullet = 9; // 画像サイズ 9ｘ9
	private LinkedList<NwayBullet> bullet1;
	private LinkedList<SnipeBullet> bullet2;
	private LinearBullet mybullet;
	private CollisionDetect cd;
	private Paint paintlife, painthit;
	private int nwaybulletmode = 0, snipebulletmode = 0;
	private long framerate=0, framecount=0, time1forfps=0, time2forfps=0; // FPS用
	private int gameovercount = 0;
	private int touchaction;
	private int bgimagex = 0;
	private boolean isShake = false;
	// 長方形のクラス public Rect (int left, int top, int right, int bottom)
	private Rect recthit;
	
	// コンストラクタ
	public ShoootSurfaceHolderCallback(){
		bullet1 = new LinkedList<NwayBullet>();
		bullet2 = new LinkedList<SnipeBullet>();
		cd = new CollisionDetect();
		paintlife = new Paint();
		paintlife.setStyle(Style.FILL);
		paintlife.setARGB(100, 0, 255, 0);
		painthit = new Paint();
		painthit.setStyle(Style.FILL);
		painthit.setARGB(100, 255, 0, 0);
		recthit = new Rect();
	}
	
	// タッチされた位置を取得
	public void getTouchPosition(float x, int action){
		touchx = x;
		touchaction = action; // ゲームの再開の処理のため
	}
	
	// コールバック関数
	public void surfaceChanged(SurfaceHolder holder, int format, int width,
							   int height) {
		// TODO Auto-generated method stub
	}
	
	// コールバック関数
	public void surfaceCreated(SurfaceHolder holder) {
		// TODO Auto-generated method stub
		// 各種の初期処理。スレッドの開始前に
		this.holder = holder;
		// キャラクタを生成
		spaceship = new Spaceship(vieww/2, viewh - halfsizeofspaceship*2, vieww);
		enemy1 = new Enemy((float)Math.random() * vieww/2, (float)Math.random() * vieww / 2,
						   Math.random() * 2, Math.random() * 2, vieww, viewh);
		enemy2 = new Enemy((float)Math.random() * vieww/2, (float)Math.random() * vieww / 2,
						   Math.random() * 2, Math.random() * 2, vieww, viewh);
		mybullet = new LinearBullet(spaceship.x, spaceship.y, vieww, viewh);
		// 背景をSurfaceViewのサイズに変更
		ShoootActivity.bgimage = Bitmap.createScaledBitmap(ShoootActivity.bgimage,
														   vieww, viewh, true);
		// 長方形の初期化
		recthit.top = 0; recthit.bottom = viewh;
		
		// スレッドの開始		
		thread = new Thread(this);
		thread.start();	
	}
	
	// コールバック関数
	public void surfaceDestroyed(SurfaceHolder holder) {
		// TODO Auto-generated method stub
		// スレッドの終了
		boolean retry = true;
		synchronized (this.holder) {
			isThreadrunning = false;
		}
		while (retry) {
			try {
				thread.join();
				retry = false;
			} catch (InterruptedException e) {
			}
		}
		thread = null;	
	}
	
	public void run() {
		// TODO Auto-generated method stub
		// ゲームのメインループ
		while (isThreadrunning) {
			synchronized (holder) {
				t1 = System.currentTimeMillis();
				// 自機移動
				if(spaceship.x + halfsizeofspaceship < touchx){
					spaceship.right(touchx);
				}else{
					spaceship.left(touchx);
				}
				
				// 自弾移動
				if(mybullet.isLive == true && spaceship.life > 0){
					mybullet.move();
				}else{
					mybullet.x = spaceship.x + halfsizeofspaceship;
					mybullet.y = spaceship.y;
					mybullet.isLive = true;
				}
				
				enemy1.move(); // 敵機移動
				enemy2.move();
				
				// 敵弾生成
				interval++;
				interval = interval & 65535;
				if(interval % 2 == 0){
					NwayBullet nb = new NwayBullet(enemy1.x + halfsizeofenemy, 
												   enemy1.y + halfsizeofenemy, dir, vieww, viewh, 
												   nwaybulletmode);
					dir = ++dir & 255; // 念のため256で0クリア
					bullet1.add(nb);
				}
				if(interval % 4 == 0){
					SnipeBullet sb = new SnipeBullet(enemy2.x + halfsizeofenemy, 
													 enemy2.y + halfsizeofenemy,
													 spaceship.x + halfsizeofspaceship, 
													 spaceship.y, vieww, viewh, snipebulletmode);
					bullet2.add(sb);
				}
				// 敵弾移動と当り判定
				for(Iterator<NwayBullet> it = bullet1.iterator(); it.hasNext();){
					NwayBullet nwaybullet = (NwayBullet)it.next();
					nwaybullet.move();
					// 当り判定
					if(nwaybullet.y > viewh - halfsizeofspaceship*2 - sizeofbullet){
						if(cd.test(nwaybullet, spaceship)){
							spaceship.life--;
							isHit = true;
						}
					}
					if(nwaybullet.isLive == false){
						it.remove();
					}
				}
				
				for(Iterator<SnipeBullet> it = bullet2.iterator(); it.hasNext();){
					SnipeBullet snipebullet = (SnipeBullet)it.next();
					snipebullet.move(spaceship.x);
					// 当り判定
					if(snipebullet.y > viewh - halfsizeofspaceship*2 - sizeofbullet){
						if(cd.test(snipebullet, spaceship)){
							spaceship.life--;
							isHit = true;
						}
					}
					if(snipebullet.isLive == false){
						it.remove();
					}
				}
			}
			
			// 自弾と敵の当り判定
			if(cd.test(mybullet, enemy1)){
				nwaybulletmode = 1 - nwaybulletmode;
				bullet1.removeAll(bullet1);
				mybullet.x = spaceship.x + halfsizeofspaceship;
				mybullet.y = spaceship.y;
				spaceship.life = spaceship.life + 5;
			}
			if(cd.test(mybullet, enemy2)){
				snipebulletmode = 1 - snipebulletmode;
				bullet2.removeAll(bullet2);
				mybullet.x = spaceship.x + halfsizeofspaceship;
				mybullet.y = spaceship.y;
				spaceship.life = spaceship.life + 5;
			}
			if(spaceship.life > vieww){ // 自機ライフの上限設定
				spaceship.life = vieww;
			}
			
			// 描画の処理
			Canvas canvas = holder.lockCanvas(); // ロックをかける
			drawOnCanvas(canvas);
			holder.unlockCanvasAndPost(canvas); // ロックを解除
			
			// スリープ
			t2 = System.currentTimeMillis();
			if(t2 - t1 < 16){ // 1000 / 60 = 16.6666
				try {
					Thread.sleep(16 - (t2 - t1));
				} catch (InterruptedException e) {
				}
			}
			
			// Game Over と 再開
			if(spaceship.life < 0){	
				gameovercount++;
				if(gameovercount > 60*4){ // 4秒くらい待つ
					if(touchaction == android.view.MotionEvent.ACTION_DOWN && 
					   touchx > 1 && touchx < vieww){
						spaceship.life = vieww;
						touchaction = 0;
						gameovercount = 0;
						// 敵弾を消し、敵機の座標と速度初期化
						bullet1.removeAll(bullet1);
						bullet2.removeAll(bullet2);
						enemy1.init((float)Math.random() * vieww/2,
									(float)Math.random() * vieww/2,
									Math.random() * 2, Math.random() * 2);
						enemy2.init((float)Math.random() * vieww/2,
									(float)Math.random() * vieww/2,
									Math.random() * 2, Math.random() * 2);
					}
				}
			}
			
			// FPS処理
			time1forfps = System.currentTimeMillis();
			if(time1forfps - time2forfps > 1000){
				framerate = framecount;
				framecount = 0;
				time2forfps = time1forfps;
			}
			framecount++;
		}	
	}
	
	// 描画メソッド
	public void drawOnCanvas(Canvas canvas){
		// 背景描画
		if(isShake){
			switch (bgimagex){
				case 0:
					bgimagex = 5;
					ShoootActivity.vibrator.vibrate(16*3); // 実機を振動
					break;
				case 5:
					bgimagex = -5;
					break;
				case -5:
					bgimagex = 0;
					isShake = false;
			}
		}
		canvas.drawBitmap(ShoootActivity.bgimage, bgimagex, 0, null);
		
		// 敵機描画
		canvas.drawBitmap(ShoootActivity.enemy, 
						  enemy1.x, enemy1.y, null);
		canvas.drawBitmap(ShoootActivity.enemy, 
						  enemy2.x, enemy2.y, null);
		
		// 敵弾描画
		for(NwayBullet bullet: bullet1){
			canvas.drawBitmap(ShoootActivity.bullet1, bullet.x, bullet.y, null);
		}
		for(SnipeBullet bullet: bullet2){
			canvas.drawBitmap(ShoootActivity.bullet2, bullet.x, bullet.y, null);
		}		
		
		if(spaceship.life > 0){
			// 自機描画
			canvas.drawBitmap(ShoootActivity.spaceship, 
							  spaceship.x, spaceship.y, null);
			// 自弾描画
			canvas.drawBitmap(ShoootActivity.mybullet, 
							  mybullet.x-halfsizeofmybullet, mybullet.y, null);
			
			// ライフゲージ描画
			canvas.drawRect(0, 5, spaceship.life, 20, paintlife);
			
			// hit時の処理
			if(isHit){
				recthit.left = bgimagex;
				recthit.right = bgimagex + vieww;
				canvas.drawRect(recthit, painthit);
				isHit = false;
				if(isShake==false)isShake=true;
			}
		}else{
			// Game Over描画
			isShake = false;
			bgimagex = 0;
			Paint gameover = new Paint();
			gameover.setARGB(255, 255, 0, 0);
			gameover.setTextSize(16);	
			canvas.drawText("GAME OVER", vieww/2 - 43, viewh/2 - 10, gameover);
		}
		
		// FPS表示
		canvas.drawText("FPS : " + String.valueOf(framerate), 1, 40, painthit);
	}
}

*/
