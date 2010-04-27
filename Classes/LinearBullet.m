//
//  LinearBullet.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LinearBullet.h"


@implementation LinearBullet

- (id) initWithSpaceshipX:(float)spaceshipx spaceshipY:(float)spaceshipy viewW:(int)vieww viewH:(int)viewh
{
	self = [super init];
	if (self != nil) {
		x = spaceshipx;
		y = spaceshipy;
		vx = 0;
		vy = -5;	
		self.vieww = vieww; 
		self.viewh = viewh;
	}
	return self;
}

@end

/* Programming by Nikkei Software 2010 April       */
/* http://software.nikkeibp.co.jp                  */
/* This code comes with no warranty and no support */

/*
package com.foo.bar;

// 直線弾クラス
public class LinearBullet extends Bullet{
	
	public LinearBullet(float spaceshipx, float spaceshipy, int vieww, int viewh){
		x = spaceshipx;
		y = spaceshipy;
		vx = 0;
		vy = -5;	
		this.vieww = vieww; 
		this.viewh = viewh;
	}
}
*/

