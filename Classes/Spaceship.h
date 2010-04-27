//
//  Spaceship.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovableObject.h"

@interface Spaceship : MovableObject {
	int life; // ライフ
	float halfsizeofspaceship;
}

@property (readwrite) int life;

-(float)right:(float)touchx;
-(float)left:(float)touchx;

@end
