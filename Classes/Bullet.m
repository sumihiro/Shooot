//
//  Bullet.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bullet.h"


@implementation Bullet

@synthesize x,y;
@synthesize vx,vy;
@synthesize vieww,viewh;
@synthesize isLive;

- (id) init
{
	self = [super init];
	if (self != nil) {
		isLive = YES;
	}
	return self;
}


//　移動メソッド
-(void) move {
	x = x + (float)vx;
	y = y + (float)vy;
	// 画面の外に出たら弾を消す。9は弾のサイズ
	if(x > vieww || x < -9){
		isLive = NO;
	}
	if(y > viewh || y < -9){
		isLive = NO;
	}
}

@end


 /* Programming by Nikkei Software 2010 April       */
/* http://software.nikkeibp.co.jp                  */
/* This code comes with no warranty and no support */

/*
package com.foo.bar;

// 弾の抽象クラス
public abstract class Bullet {
	float x, y; // 位置
	double vx, vy; // 速度
	int vieww, viewh; // 画面の幅と高さ
	boolean isLive = true; // 弾の生死フラグ
	
	//　移動メソッド
	public void move(){
		x = x + (float)vx;
		y = y + (float)vy;
		// 画面の外に出たら弾を消す。9は弾のサイズ
		if(x > vieww || x < -9){
			isLive = false;
		}
		if(y > viewh || y < -9){
			isLive = false;
		}
	}
}
*/