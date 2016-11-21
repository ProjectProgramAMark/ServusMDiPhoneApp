//
//  LoginPatientViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewController.h"
#import "DoctorProfileViewController.h"
#import "MessagePatientsList.h"
#import "Chameleon.h"
#import "UIImageView+WebCache.h"
#import "Doctor.h"
#import "CNPGridMenu.h"
#import "Patient.h"
#import "MSGPatientGridCell.h"
#import "RequestsViewController.h"
#import "PatientDetailViewController.h"
#import "RefillPatientsViewController.h"
#import "ConsultationListView.h"
#import "DoctorListViewController.h"
#import "MySessionViewController.h"
#import "MSGPatientGridCelliPhone.h"
#import "iPhoneCalendarViewController.h"
#import "AFViewShaker.h"
#import "RegisterPatientViewController.h"
#import "DashboardPatientViewController.h"
#import "ForgotPasswordViewController.h"
#import "Flurry.h"

@interface LoginPatientViewController : BaseViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *registerButton;
    IBOutlet UIButton *patientButton;
     IBOutlet UIButton *forgotButton;
    IBOutlet UIImageView *backgroundImageView;
    IBOutlet UIView *emailLine;
    IBOutlet UIView *passwordLine;
    BOOL isPatientPasscode;
    BOOL tryAgainPasscode;
    
}

@property (weak, nonatomic) IBOutlet UIView *loginFormBackgroundView;

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray * allTextFields;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray * allButtons;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) AFViewShaker * viewShaker;
@property (nonatomic) BOOL touchIDVerfied;


@end
