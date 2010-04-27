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
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ShoootViewController *viewController;

@end

