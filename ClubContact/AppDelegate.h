//
//  AppDelegate.h
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFCalendarViewController.h"
#import "AppController.h"
#import <Stripe/Stripe.h>
#import "Flurry.h"
#import "AGPushNoteView.h"
#import <Quickblox/QBUUser.h>

//#import "DashboardV2ViewController.h"
@class DashboardV2ViewController;
@class RearViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FFCalendarViewController *calendarViewController;
@property (nonatomic) QBUUser *userQB;
@property (nonatomic) QBUUser *docQB;

@property (strong, nonatomic) DashboardV2ViewController *dashVC;
@property (strong, nonatomic) RearViewController *rearVC;

+ (AppDelegate *)sharedInstance;

- (UIViewController *)viewControllerWithIndentifier:(NSString *)identifier;

@end

