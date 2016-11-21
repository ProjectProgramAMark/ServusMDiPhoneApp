//
//  BaseViewController.h
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "PersonalSignatureView.h"
#import "AppController.h"
#import "SVProgressHUD.h"
#import "Account.h"
#import "AppDelegate.h"
#import "CNPGridMenu.h"
#import "IAButton.h"
#import "CornerView.h"
#import "ConnectionManager.h"

@interface BaseViewController : UIViewController
{
    UIView *_blurView;
    PersonalSignatureView *_personalSignatureView;
    AppController *_appController;
}

@property (strong, nonatomic) NSArray *users;


#pragma mark - Progress

- (void)showProgressWithMessage:(NSString *)message;

- (void)showerrorProgressMessage:(NSString *)message;

- (void)showSuccessProgressMessage:(NSString *)message;

- (void)dismissProgress;

#pragma mark - Action

- (void)showPersonalSignatureView:(PersonalSignatureViewBlock)acceptBlock;

- (void)addBlurView;

- (void)removeBlurView;

- (void)showAlertViewWithMessage:(NSString *)message withTag:(int)tag withTitle:(NSString *)title andViewController:(UIViewController *)viewController isCancelButton:(BOOL)isCancelButton;

- (void)addSwipeGestureShowCalendar;

/**
 *  Create custom UIBarButtonItem instance
 */
- (UIBarButtonItem *)cornerBarButtonWithColor:(UIColor *)color
                                        title:(NSString *)title
                                didTouchesEnd:(dispatch_block_t)action;
/**
 *  Default back button
 */
- (void)setDefaultBackBarButtonItem:(dispatch_block_t)didTouchesEndAction;

/**
 *  Configure IAButton
 */
- (void)configureAIButton:(IAButton *)button
            withImageName:(NSString *)name
                  bgColor:(UIColor *)bgColor
            selectedColor:(UIColor *)selectedColor;

@end
