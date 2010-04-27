//
//  ShoootAppDelegate.m
//  Shooot
//
//  Created by 上田 澄博 on 10/04/27.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ShoootAppDelegate.h"
#import "ShoootViewController.h"

#import <AudioToolbox/AudioServices.h>

@implementation ShoootAppDelegate

@synthesize window;
@synthesize viewController;

@synthesize bgimage;
@synthesize spaceship;
@synthesize enemy;
@synthesize mybullet;
@synthesize bullet1, bullet2;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch  
	self.bgimage = [UIImage imageNamed:@"earthrise.png"];
	self.spaceship = [UIImage imageNamed:@"spaceship.png"];
	self.enemy = [UIImage imageNamed:@"enemy.png"];
	self.mybullet = [UIImage imageNamed:@"mybullet.png"];
	self.bullet1 = [UIImage imageNamed:@"bullet1.png"];
	self.bullet2 = [UIImage imageNamed:@"bullet2.png"];
	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
	[bgimage release];
	[spaceship release];
	[enemy release];
	[mybullet release];
	[bullet1 release];
	[bullet2 release];
	
    [viewController release];
    [window release];
    [super dealloc];
}

#pragma mark -
-(void)vibrate {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
