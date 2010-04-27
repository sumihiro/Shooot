//
//  Bullet.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// 弾の抽象クラス
@interface Bullet : NSObject {
	float x, y; // 位置
	double vx, vy; // 速度
	int vieww, viewh; // 画面の幅と高さ
	BOOL isLive; // 弾の生死フラグ
}

@property (readwrite) float x;
@property (readwrite) float y;
@property (readwrite) double vx;
@property (readwrite) double vy;
@property (readwrite) int vieww;
@property (readwrite) int viewh;
@property (readwrite) BOOL isLive;

-(void) move;


@end
