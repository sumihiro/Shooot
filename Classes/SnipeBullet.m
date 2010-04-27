//
//  SnipeBullet.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SnipeBullet.h"


@implementation SnipeBullet
@synthesize spaceshipy;
@synthesize ax,ay;
@synthesize mode;


- (id) init
{
	self = [super init];
	if (self != nil) {
		halfsizeofspaceship = 36;
		self.ax = 0;
		self.ay = 0;
	}
	return self;
}

- (id) initWithInitX:(float)initx initY:(float)inity spaceshipX:(float)spaceshipx spaceshipY:(float)spaceshipy viewW:(int)vieww viewH:(int)viewh mode:(int)mode
{
	self = [self init];
	if (self != nil) {
		x = initx;
		y = inity;
		self.spaceshipy = spaceshipy;
		self.mode = mode;
		
		if(mode == 0){ // 直線
			double rad = atan2(spaceshipy - y, spaceshipx - x);
			vx = 4 * cos(rad);
			vy = 4 * sin(rad);
		}else{ // ホーミング
			vx = 0;
			vy = -5;
		}
		
		self.vieww = vieww;
		self.viewh = viewh;
	}
	return self;
}

//　移動メソッド
-(void)move:(float)spaceshipx {
	if(mode == 0){ // 直線
		x = x + (float)vx;
		y = y + (float)vy;
		// 画面の外に出たら弾を消す
		if(x > vieww || x < -9){
			isLive = false;
		}
		if(y > viewh || y < -9){
			isLive = false;
		}
	}else{ // ホーミング
		double rad = atan2(spaceshipy - y,
								spaceshipx + halfsizeofspaceship - x);
		ax = cos(rad) / 12;
		vx = vx + ax;
		if(vy < 3){
			ay = sin(rad) / 12;
			vy = vy + ay;
		}
		x = x + (float)vx;
		y = y + (float)vy;
		// 画面の外に出たら弾を消す。ホーミングの場合、画面外でも±100は消さない
		if(x > vieww + 100 || x < -100){
			isLive = NO;
		}
		if(y > viewh || y < -100){
			isLive = NO;
		}
	}
}

@end

/* Programming by Nikkei Software 2010 April       */
/* http://software.nikkeibp.co.jp                  */
/* This code comes with no warranty and no support */

/*
package com.foo.bar;

import java.lang.Math;

// 狙い撃ち弾クラス
public class SnipeBullet extends Bullet{
	private final float halfsizeofspaceship = 36;
	float spaceshipy;
	double ax = 0, ay = 0; // 加速度
	int mode; // 0=直線、1=ホーミング
	
	public SnipeBullet(float initx, float inity, float spaceshipx, float spaceshipy,
					   int vieww, int viewh, int mode){
		x = initx;
		y = inity;
		this.spaceshipy = spaceshipy;
		this.mode = mode;
		
		if(mode == 0){ // 直線
			double rad = Math.atan2(spaceshipy - y, spaceshipx - x);
			vx = 4 * Math.cos(rad);
			vy = 4 * Math.sin(rad);
		}else{ // ホーミング
			vx = 0;
			vy = -5;
		}
		
		this.vieww = vieww;
		this.viewh = viewh;
	}
	
	//　移動メソッド
	public void move(float spaceshipx){
		if(mode == 0){ // 直線
			x = x + (float)vx;
			y = y + (float)vy;
			// 画面の外に出たら弾を消す
			if(x > vieww || x < -9){
				isLive = false;
			}
			if(y > viewh || y < -9){
				isLive = false;
			}
		}else{ // ホーミング
			double rad = Math.atan2(spaceshipy - y,
									spaceshipx + halfsizeofspaceship - x);
			ax = Math.cos(rad) / 12;
			vx = vx + ax;
			if(vy < 3){
				ay = Math.sin(rad) / 12;
				vy = vy + ay;
			}
			x = x + (float)vx;
			y = y + (float)vy;
			// 画面の外に出たら弾を消す。ホーミングの場合、画面外でも±100は消さない
			if(x > vieww + 100 || x < -100){
				isLive = false;
			}
			if(y > viewh || y < -100){
				isLive = false;
			}
		}
	}
}

*/
