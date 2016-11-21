//
//  RegisterPatientViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "BaseViewController.h"
#import "Chameleon.h"
#import "Chameleon.h"
#import "CountryPicker.h"
#import "AFViewShaker.h"
#import "PatientRegister.h"
#import "TermsViewController.h"

@interface RegisterPatientViewController : BaseViewController <UITextFieldDelegate>
{
    Account *_account;
    
    IBOutlet UIButton *nextButton;
    
    IBOutlet UIScrollView *iphoneBackScroll;
    IBOutlet UIView *textEnterView;
    
    IBOutlet UILabel *poweredLabel;
    IBOutlet UIImageView *fidemLogoIMG;
    IBOutlet UIButton *termsAgreeButton;
    IBOutlet UIButton *showTermsButton;
}

@property (weak, nonatomic) IBOutlet UIScrollView *regisFormPerInforScrollView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *specialityTextField;
@property (weak, nonatomic) IBOutlet UITextField *mlTextField;
@property (weak, nonatomic) IBOutlet UITextField *suffixTextField;
@property (weak, nonatomic) IBOutlet UITextField *deaTextField;
@property (weak, nonatomic) IBOutlet UITextField *npiTextField;
@property (weak, nonatomic) IBOutlet UITextField *meTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegement;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray * allTextFields;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray * allButtons;
@property (nonatomic, strong) AFViewShaker * viewShaker;


- (IBAction)agreeToTerms:(id)sender;
- (IBAction)showTerms:(id)sender;

@end
