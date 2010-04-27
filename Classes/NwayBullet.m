//
//  NwayBullet.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NwayBullet.h"


@implementation NwayBullet

@synthesize dir,mode;

- (id) initWithInitX:(float)initx initY:(float)inity dir:(int)dir viewW:(int)vieww viewH:(int)viewh mode:(int)mode
{
	self = [super init];
	if (self != nil) {
		self.mode = mode;
		x = initx; y = inity;
		if(mode == 0){ // 渦巻き状弾
			self.vx = 2 * cos(M_PI*dir*10 / 180);
			self.vy = 2 * sin(M_PI*dir*10 / 180);			
		}else{ // ランダム弾
			self.vx = (5 - (-5) + 1) * RAND() + (-5);
			if(abs(self.vx) < 2){ // 遅すぎる場合は加算
				if(self.vx > 0)self.vx++; else self.vx--;
			}
			self.vy = (5 - (-5) + 1) * RAND() + (-5);
			if(abs(self.vy) < 2){ // 遅すぎる場合は加算
				if(self.vy > 0) self.vy++; else self.vy--;
			}
		}
		self.vieww = vieww; self.viewh = viewh;
		
	}
	return self;
}

@end

/* Programming by Nikkei Software 2010 April       */
/* http://software.nikkeibp.co.jp                  */
/* This code comes with no warranty and no support */

/*
package com.foo.bar;

import java.lang.Math;

// 多方向弾クラス
public class NwayBullet extends Bullet{
	double dir; // 方向
	int mode; // 0=渦巻き状弾、1=ランダム弾
	
	public NwayBullet(float initx, float inity, int dir, 
					  int vieww, int viewh, int mode){
		this.mode = mode;
		x = initx; y = inity;
		if(mode == 0){ // 渦巻き状弾
			this.vx = 2 * Math.cos(Math.PI*dir*10 / 180);
			this.vy = 2 * Math.sin(Math.PI*dir*10 / 180);			
		}else{ // ランダム弾
			this.vx = (5 - (-5) + 1) * Math.random() + (-5);
			if(Math.abs(this.vx) < 2){ // 遅すぎる場合は加算
				if(this.vx > 0)this.vx++; else this.vx--;
			}
			this.vy = (5 - (-5) + 1) * Math.random() + (-5);
			if(Math.abs(this.vy) < 2){ // 遅すぎる場合は加算
				if(this.vy > 0) this.vy++; else this.vy--;
			}
		}
		this.vieww = vieww; this.viewh = viewh;
	}
}

*/