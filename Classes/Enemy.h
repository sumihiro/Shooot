//
//  Enemy.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovableObject.h"

// 敵のクラス
@interface Enemy : MovableObject {
	double vx, vy; // 速度
	int vieww, viewh; // 画面の幅と高さ
	int halfsizeofspaceship; // 画像のサイズ 72x72の半分
	int halfsizeofenemy; // 画像のサイズ 72x72の半分
}

@property (readwrite) double vx;
@property (readwrite) double vy;
@property (readwrite) int vieww;
@property (readwrite) int viewh;

- (id) initWithInitX:(float)initx initY:(float)inity vx:(double)vx vy:(double)vy viewW:(int)vieww viewH:(int)viewH;
- (id)initWithInitX:(float)initx initY:(float)inity vx:(double)vx vy:(double)VY;
-(void) move;

@end
