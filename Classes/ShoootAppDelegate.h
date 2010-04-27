//
//  ShoootAppDelegate.h
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShoootViewController;

@interface ShoootAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ShoootViewController *viewController;

	UIImage *bgimage;
	UIImage *spaceship;
	UIImage *enemy;
	UIImage *mybullet;
	UIImage *bullet1, *bullet2;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ShoootViewController *viewController;

@property (nonatomic,retain) UIImage *bgimage;
@property (nonatomic,retain) UIImage *spaceship;
@property (nonatomic,retain) UIImage *enemy;
@property (nonatomic,retain) UIImage *mybullet;
@property (nonatomic,retain) UIImage *bullet1;
@property (nonatomic,retain) UIImage *bullet2;

-(void)vibrate;

@end

