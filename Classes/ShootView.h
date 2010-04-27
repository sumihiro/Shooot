//
//  ShootView.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShootView : UIView {
	id delegate;
}

@property (nonatomic,assign) id delegate;

@end
