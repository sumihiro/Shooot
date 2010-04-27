//
//  Spaceship.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Spaceship.h"


@implementation Spaceship

@synthesize life;

- (id) init
{
	self = [super init];
	if (self != nil) {
		halfsizeofspaceship = 36;
	}
	return self;
}

- (id) initWithX:(int)x Y:(int)y viewW:(int)vieww
{
	self = [self init];
	if (self != nil) {
		self.x = (float)x;
		self.y = (float)y;
		life = vieww; // SurfaceViewの横幅をライフとして使う
	}
	return self;
}

// 右移動
-(float)right:(float)touchx {
	float distance = touchx - x + halfsizeofspaceship;
	return x = x  + distance / 10;
}
// 左移動
-(float)left:(float)touchx {
	float distance = x + halfsizeofspaceship - touchx;
	return x = x - distance / 10;
}


@end

 /* Programming by Nikkei Software 2010 April       */
/* http://software.nikkeibp.co.jp                  */
/* This code comes with no warranty and no support */

/*
package com.foo.bar;

// 自機クラス
public class Spaceship extends MovableObject{
	int life; // ライフ
	private final float halfsizeofspaceship = 36;
	
	public Spaceship(int x, int y, int vieww){
		this.x = (float)x;
		this.y = (float)y;
		life = vieww; // SurfaceViewの横幅をライフとして使う
	}
	
	// 右移動
	public float right(float touchx){
		float distance = touchx - x + halfsizeofspaceship;
		return x = x  + distance / 10;
	}
	// 左移動
	public float left(float touchx){
		float distance = x + halfsizeofspaceship - touchx;
		return x = x - distance / 10;
	}
}
*/
