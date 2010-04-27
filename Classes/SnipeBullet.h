//
//  SnipeBullet.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet.h"

// 狙い撃ち弾クラス
@interface SnipeBullet : Bullet {
	float halfsizeofspaceship;
	float spaceshipy;
	double ax, ay; // 加速度
	int mode; // 0=直線、1=ホーミング
}

@property (readwrite) float spaceshipy;
@property (readwrite) double ax;
@property (readwrite) double ay;
@property (readwrite) int mode;

-(id)initWithInitX:(float)initx initY:(float)inity spaceshipX:(float)spaceshipx spaceshipY:(float)spaceshipy viewW:(int)vieww viewH:(int)viewh mode:(int)mode;
-(void)move:(float)spaceshipx;

@end
