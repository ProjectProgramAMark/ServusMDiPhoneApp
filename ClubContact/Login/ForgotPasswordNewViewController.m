//
//  ForgotPasswordNewViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/17/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import "ForgotPasswordNewViewController.h"

@interface ForgotPasswordNewViewController ()

@end

@implementation ForgotPasswordNewViewController

@synthesize allTextFields;
@synthesize viewShaker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    backgroundImageView.frame = CGRectMake(backgroundImageView.frame.origin.x, -10, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);
    logoImageView.frame = CGRectMake(logoImageView.frame.origin.x, 100, logoImageView.frame.size.width, logoImageView.frame.size.height);
    
    loginView.center = CGPointMake(loginView.center.x, (windowHeight/2) );
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    
    actIndicator.hidden = true;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _usernameTextField.frame.size.height)];
    leftView.backgroundColor = _usernameTextField.backgroundColor;
    _usernameTextField.leftView = leftView;
    _usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _emailTextField.frame.size.height)];
    leftView2.backgroundColor = _emailTextField.backgroundColor;
    _emailTextField.leftView = leftView2;
    _emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:)
                   name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // keyboard frame is in window coordinates
    NSDictionary *userInfo = [notification userInfo];
    keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // convert own frame to window coordinates, frame is in superview's coordinates
    CGRect ownFrame = [self.view.window convertRect:self.view.frame fromView:self.view.superview];
    
    // calculate the area of own frame that is covered by keyboard
    CGRect coveredFrame = CGRectIntersection(ownFrame, keyboardFrame);
    
    // now this might be rotated, so convert it back
    coveredFrame = [self.view.window convertRect:coveredFrame toView:self.view.superview];
    
    // set inset to make up for covered array at bottom
    //  self.contentInset = UIEdgeInsetsMake(0, 0, coveredFrame.size.height, 0);
    //self.scrollIndicatorInsets = self.contentInset;
    offSetKeyboard = keyboardFrame.size.height;
    
    int someotherOffSet = 100 + (self.view.frame.size.height -250);
    int commentOffset = (windowHeight - someotherOffSet) - offSetKeyboard;
    commentOffset2 = commentOffset;
    if (isOffSet == true) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             //  commentContainerView.frame = CGRectMake(0, (windowHeight - 42) - offSetKeyboard, commentContainerView.frame.size.width, commentContainerView.frame.size.height);
             loginView.center = CGPointMake(loginView.center.x, (windowHeight/2) - (offSetKeyboard - 200));
             
             if (IS_IPHONE_5) {
                 backgroundImageView.frame = CGRectMake(backgroundImageView.frame.origin.x, -20, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);
                 logoImageView.frame = CGRectMake(logoImageView.frame.origin.x, 70, logoImageView.frame.size.width, logoImageView.frame.size.height);
                 
                 
             }
             
             
         }     completion:^(BOOL finished)
         {
         }];
        
    }
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}




- (IBAction)onLoginAction:(id)sender
{
    [Flurry logEvent:@"LoginDoctor"];
    NSString * strUsername = _usernameTextField.text;
    NSString * strEmail = _emailTextField.text;
    
    if ( [strUsername stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        
        [[[AFViewShaker alloc] initWithView:_usernameTextField] shake];
        
    } else if ([strEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        [[[AFViewShaker alloc] initWithView:_emailTextField] shake];
        
    } else {
        actIndicator.hidden = false;
        [[AppController sharedInstance] getRecoverPassword:strUsername Email:strEmail Completion:^(BOOL success, NSString *message) {
            
            if (success)
            {
                actIndicator.hidden = true;
                [self showAlertViewWithMessage:@"We sent you an email with your new password. Please check your email." withTag:1 withTitle:@"" andViewController:self isCancelButton:NO];
                
            }else {
             // [SVProgressHUD dismiss];
             actIndicator.hidden = true;
             [self showAlertViewWithMessage:message withTag:1 withTitle:@"" andViewController:self isCancelButton:NO];
             //[[[AFViewShaker alloc] initWithView:loginButton] shake];
            }
         
         }];
        
    }
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([_usernameTextField isFirstResponder]) {
        isOffSet = true;
    } else if ([_emailTextField isFirstResponder]) {
        isOffSet = true;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([_emailTextField isFirstResponder]) {
        isOffSet = false;
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             //  commentContainerView.frame = CGRectMake(0, (windowHeight - 42) - offSetKeyboard, commentContainerView.frame.size.width, commentContainerView.frame.size.height);
             //  self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
             backgroundImageView.frame = CGRectMake(backgroundImageView.frame.origin.x, -10, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);
             logoImageView.frame = CGRectMake(logoImageView.frame.origin.x, 100, logoImageView.frame.size.width, logoImageView.frame.size.height);
             
             
             loginView.center = CGPointMake(loginView.center.x, (windowHeight/2) );
             
         }     completion:^(BOOL finished)
         {
         }];
        
        
    } else if ([_usernameTextField isFirstResponder]) {
        isOffSet = false;
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             // self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
             backgroundImageView.frame = CGRectMake(backgroundImageView.frame.origin.x, -10, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);
             logoImageView.frame = CGRectMake(logoImageView.frame.origin.x, 100, logoImageView.frame.size.width, logoImageView.frame.size.height);
             
             
             loginView.center = CGPointMake(loginView.center.x, (windowHeight/2) );
             
         }     completion:^(BOOL finished)
         {
         }];
        
    }
    
    return true;
}



@end
