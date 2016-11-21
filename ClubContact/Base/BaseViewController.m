//
//  BaseViewController.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize users;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _appController = [AppController sharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Progress

- (void)showProgressWithMessage:(NSString *)message
{
    [SVProgressHUD showWithStatus:message];
}

- (void)showerrorProgressMessage:(NSString *)message
{
    [SVProgressHUD showErrorWithStatus:message];
}

- (void)showSuccessProgressMessage:(NSString *)message
{
    [SVProgressHUD showSuccessWithStatus:message];
}

- (void)dismissProgress
{
    [SVProgressHUD dismiss];
}

#pragma mark - Action

- (void)addSwipeGestureShowCalendar
{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onShowCalendarAction)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)onShowCalendarAction
{
    [self.navigationController pushViewController:[AppDelegate sharedInstance].calendarViewController animated:YES];
}

- (void)showPersonalSignatureView:(PersonalSignatureViewBlock)acceptBlock
{
    _personalSignatureView = (PersonalSignatureView *)[Utils viewFromNibNamed:@"PersonalSignatureView"];
    _personalSignatureView.center = self.view.center;
    _personalSignatureView.acceptPersonalSignatureViewBlock = acceptBlock;
    [self addBlurView];
    [[AppDelegate sharedInstance].window addSubview:_personalSignatureView];
    [Utils animationShowPopupView:_personalSignatureView];
}

- (void)hidePersonalSignature
{
    [_personalSignatureView removeFromSuperview];
}

#pragma mark - BlurView

- (void)addBlurView
{
    _blurView = [[UIView alloc] initWithFrame:[AppDelegate sharedInstance].window.bounds];
    _blurView.backgroundColor = [UIColor darkTextColor];
    _blurView.alpha = 0.7f;
    [[AppDelegate sharedInstance].window addSubview:_blurView];
}

- (void)removeBlurView
{
    if (_blurView) {
        [_blurView removeFromSuperview];
        _blurView = nil;
    }
}

- (void)showAlertViewWithMessage:(NSString *)message withTag:(int)tag withTitle:(NSString *)title andViewController:(UIViewController *)viewController isCancelButton:(BOOL)isCancelButton
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:viewController cancelButtonTitle:(isCancelButton ? @"Cancel" : nil) otherButtonTitles:(isCancelButton ? @"YES" : @"OK"), nil];
    alert.tag = tag;
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)configureAIButton:(IAButton *)button
            withImageName:(NSString *)name
                  bgColor:(UIColor *)bgColor
            selectedColor:(UIColor *)selectedColor {
    
    UIImage *icon = [UIImage imageNamed:name];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    button.backgroundColor = bgColor;
    button.selectedColor = selectedColor;
    [button setIconView:iconView];
}

- (UIBarButtonItem *)cornerBarButtonWithColor:(UIColor *)color
                                        title:(NSString *)title
                                didTouchesEnd:(dispatch_block_t)action {
    
    return ({
        
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:({
            
            CornerView *cornerView = [[CornerView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            cornerView.touchesEndAction = action;
            cornerView.userInteractionEnabled = YES;
            cornerView.bgColor = color;
            cornerView.title = title;
            cornerView;
        })];
        
        backButtonItem;
    });
}

- (void)setDefaultBackBarButtonItem:(dispatch_block_t)didTouchesEndAction {
    
    UIBarButtonItem *backBarButtonItem =
    [self cornerBarButtonWithColor:ConnectionManager.instance.me.color
                             title:[NSString stringWithFormat:@"%lu", (unsigned long)ConnectionManager.instance.me.index + 1]
                     didTouchesEnd:^
     {
         didTouchesEndAction();
     }];
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}

@end
