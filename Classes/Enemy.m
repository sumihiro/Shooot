//
//  Enemy.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy

@synthesize vx,vy;
@synthesize vieww,viewh;

- (id) init
{
	self = [super init];
	if (self != nil) {
		halfsizeofspaceship = 36; // 画像のサイズ 72x72の半分
		halfsizeofenemy = 36; // 画像のサイズ 72x72の半分
	}
	return self;
}

- (id) initWithInitX:(float)initx initY:(float)inity vx:(double)vx vy:(double)vy viewW:(int)vieww viewH:(int)viewH
{
	self = [self init];
	if (self != nil) {
		x = initx; y = inity;
		self.vx = vx; self.vy = vy;
		self.vieww = vieww; self.viewh = viewh;
	}
	return self;
}


// 座標と速度初期化
- (id)initWithInitX:(float)initx initY:(float)inity vx:(double)vx vy:(double)vy
{
	self = [self init];
	if (self != nil) {
		x = initx; y = inity;
		self.vx = vx; self.vy = vy;
	}
	return self;
}

// 移動メソッド
-(void) move {
	x = x + (float)vx; y = y + (float)vy;
	// 画面の外周で反転
	if(x > vieww - halfsizeofenemy || x < -halfsizeofenemy){
		vx = -vx;
	}
	if(y > viewh - halfsizeofspaceship * 6 || y < -halfsizeofenemy){
		vy = -vy;
	}
}
	
@end

/* Programming by Nikkei Software 2010 April       */
/* http://software.nikkeibp.co.jp                  */
/* This code comes with no warranty and no support */

/*
package com.foo.bar;

// 敵のクラス
public class Enemy extends MovableObject{
	double vx, vy; // 速度
	int vieww, viewh; // 画面の幅と高さ
	private final int halfsizeofspaceship = 36; // 画像のサイズ 72x72の半分
	private final int halfsizeofenemy = 36; // 画像のサイズ 72x72の半分
											// コンストラクタ
	public Enemy(float initx, float inity, double vx, double vy, 
				 int vieww, int viewh){
		x = initx; y = inity;
		this.vx = vx; this.vy = vy;
		this.vieww = vieww; this.viewh = viewh;
	}
	
	// 座標と速度初期化
	public void init(float initx, float inity, double vx, double vy){
		x = initx; y = inity;
		this.vx = vx; this.vy = vy;
	}
	
	// 移動メソッド
	public void move(){
		x = x + (float)vx; y = y + (float)vy;
		// 画面の外周で反転
		if(x > vieww - halfsizeofenemy || x < -halfsizeofenemy){
			vx = -vx;
		}
		if(y > viewh - halfsizeofspaceship * 6 || y < -halfsizeofenemy){
			vy = -vy;
		}
	}
}
*/