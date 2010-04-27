//
//  CollisionDetect.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinearBullet.h"
#import "Enemy.h"
#import "Bullet.h"
#import "Spaceship.h"

// 当り判定クラス
@interface CollisionDetect : NSObject {
	int sizeofenemy; // 画像のサイズ 72x72
	int sizeofspaceship; // 画像のサイズ 72x72
	int sizeofmybullet; // 画像のサイズ 16x16
	int halfsizeofbullet; // 画像のサイズ 9x9
}

-(BOOL)test:(LinearBullet*)lb withEnemy:(Enemy*)e;
-(BOOL)test:(Bullet*)b withSpaceship:(Spaceship*)s;

@end
