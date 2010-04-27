//
//  NwayBullet.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet.h"

@interface NwayBullet : Bullet {
	double dir; // 方向
	int mode; // 0=渦巻き状弾、1=ランダム弾
}

@property (readwrite) double dir;
@property (readwrite) int mode;

- (id) initWithInitX:(float)initx initY:(float)inity dir:(int)dir viewW:(int)vieww viewH:(int)viewh mode:(int)mode;

@end
