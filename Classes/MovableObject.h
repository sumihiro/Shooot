//
//  MovableObject.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


// 移動物体の抽象クラス
@interface MovableObject : NSObject {
	float x, y;
}

@property (readwrite) float x;
@property (readwrite) float y;

@end
