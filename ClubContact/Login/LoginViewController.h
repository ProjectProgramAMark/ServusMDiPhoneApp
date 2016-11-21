//
//  LoginViewController.h
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AFViewShaker.h"
#import "Chameleon.h"
#import "ForgotPasswordViewController.h"
#import "DashboardPatientViewController.h"
#import "PatientLogin.h"
#import "ForgotPasswordNewViewController.h"
#import "DashboardV2ViewController.h"
#import "RearViewController.h"
#import "SWRevealViewController.h"
#import "RearViewPatientViewController.h"


@interface LoginViewController : BaseViewController <UITextFieldDelegate, UIAlertViewDelegate, QBRTCClientDelegate>{
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *registerButton;
    IBOutlet UIButton *patientButton;
     IBOutlet UIImageView *backgroundImageView;
    IBOutlet UIImageView *logoImageView;
    IBOutlet UIView *emailLine;
    IBOutlet UIView *passwordLine;
    IBOutlet UIView *loginView;
    IBOutlet UIButton *forgotButton;
    IBOutlet UIActivityIndicatorView *actIndicator;
    
    BOOL isDoctorPassCode;
    BOOL isPatientPassCode;
    BOOL tryAgainPasscode;
    
    int offSetKeyboard;
    CGRect keyboardFrame;
    BOOL isOffSet;
    int commentOffset2;
    
}

@property (weak, nonatomic) IBOutlet UIView *loginFormBackgroundView;

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray * allTextFields;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray * allButtons;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) AFViewShaker * viewShaker;
@property (nonatomic) BOOL touchIDVerfied;

@end
