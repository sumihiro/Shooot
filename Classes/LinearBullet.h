//
//  LinearBullet.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet.h"

// 直線弾クラス
@interface LinearBullet : Bullet {

}

- (id) initWithSpaceshipX:(float)spaceshipx spaceshipY:(float)spaceshipy viewW:(int)vieww viewH:(int)viewh;

@end
