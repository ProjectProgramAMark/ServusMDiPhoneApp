//
//  LoginPatientViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "LoginPatientViewController.h"

@implementation LoginPatientViewController

@synthesize touchIDVerfied;

- (void)viewDidLoad {
    [super viewDidLoad];
    //_loginFormBackgroundView.layer.cornerRadius = 10.0f;
    if (kInputDummyDataForDebug)
    {
        // _emailField.text = @"meredithgray";
        //_passwordField.text = @"kalanaj";
       // _emailField.text = @"apphunter";
      //  _passwordField.text = @"fidem3@";
    }
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;

    
    self.navigationController.navigationBar.barTintColor = [UIColor flatWhiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Color all navigation items accordingly to new barTintColor
    self.navigationController.navigationBar.tintColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:self.navigationController.navigationBar.barTintColor isFlat:YES];
   // self.navigationController.title = @"Doctor Portal";
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    
    for (UIButton * button in self.allButtons) {
        //    button.layer.borderColor = [[UIColor whiteColor] CGColor];
        //   button.layer.borderWidth = 1;
        //  button.layer.cornerRadius = 5;
    }
    
    /* UIColor *color = [UIColor lightTextColor];
     _emailField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
     _passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];*/
    
    if (IS_IPHONE) {
        _emailField.frame = CGRectMake(20, (windowHeight/2) - (_emailField.frame.size.height), windowWidth - 40.0, _emailField.frame.size.height);
        _passwordField.frame = CGRectMake(20, (windowHeight/2), windowWidth - 40.0, _passwordField.frame.size.height);
        emailLine.frame = CGRectMake(20, (windowHeight/2), windowWidth - 40.0, emailLine.frame.size.height);
        passwordLine.frame = CGRectMake(20, (windowHeight/2) +  _passwordField.frame.size.height, windowWidth - 40.0, passwordLine.frame.size.height);
        // loginButton.frame = CGRectMake(10, loginButton.frame.origin.y, windowWidth - 20.0f, 40);
        
         if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        loginButton.frame = CGRectMake(20, loginButton.frame.origin.y, windowWidth - 40.0f, 40);
        loginButton.center = CGPointMake(windowWidth/2, windowHeight - 180);
        registerButton.frame =  CGRectMake(20, registerButton.frame.origin.y, windowWidth - 40.0f, 40);
        registerButton.center = CGPointMake(windowWidth/2, windowHeight - 120);
        forgotButton.frame =  CGRectMake(20, forgotButton.frame.origin.y, windowWidth - 40.0f, 40);
        forgotButton.center = CGPointMake(windowWidth/2, windowHeight - 60);
        patientButton.frame =  CGRectMake(20, patientButton.frame.origin.y, windowWidth - 40.0f, 40);
        patientButton.center = CGPointMake(windowWidth/2, windowHeight - 60);
             
         } else {
             loginButton.frame = CGRectMake(20, loginButton.frame.origin.y, windowWidth - 40.0f, 30);
             registerButton.frame =  CGRectMake(20, registerButton.frame.origin.y, windowWidth - 40.0f, 30);
             forgotButton.frame =  CGRectMake(20, forgotButton.frame.origin.y, windowWidth - 40.0f, 30);
             loginButton.center = CGPointMake(windowWidth/2, windowHeight - 100);
             registerButton.center = CGPointMake(windowWidth/2, windowHeight - 65);
             forgotButton.center = CGPointMake(windowWidth/2, windowHeight - 30);
         }
        
    } else {
        
    }
    

}

- (void)viewDidAppear:(BOOL)animated {
   // if (touchIDVerfied == true) {
    //    touchIDVerfied = false;
        PatientLogin *doc = [PatientLogin getFromUserDefault];
        if (doc != nil) {
            
            
            isPatientPasscode = true;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode"
                                                            message:@"Enter your passcode login"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Done", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
        }
   // }
    _passwordField.text = @"";
    _emailField.text = @"";
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}

- (IBAction)onLoginAction:(id)sender
{
    [Flurry logEvent:@"LoginPatient"];
    NSString * strEmail = _emailField.text;
    NSString * strPwd = _passwordField.text;
    
    if ( [strEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        
        [[[AFViewShaker alloc] initWithView:_emailField] shake];
        
    } else if ([strPwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        [[[AFViewShaker alloc] initWithView:_passwordField] shake];
        
    } else {
        
        
        
        [[AppController sharedInstance] loginPatientWithPassword:_passwordField.text Email:_emailField.text Completion:^(BOOL success, NSString *message) {
            if (success)
            {
                
               
                
                self.navigationController.navigationBarHidden = false;
              //  [self performSegueWithIdentifier:@"showDashboardSegue" sender:nil];
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                DashboardPatientViewController *vc = (DashboardPatientViewController *)[sb instantiateViewControllerWithIdentifier:@"DashboardPatientViewController"];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                [self showAlertViewWithMessage:message withTag:1 withTitle:@"Login Failed." andViewController:self isCancelButton:NO];
                [[[AFViewShaker alloc] initWithView:loginButton] shake];
            }
        }];
        
    }
    
}

- (IBAction)onSignUpAction:(id)sender
{
    self.navigationController.navigationBarHidden = false;
   // [self performSegueWithIdentifier:@"showRegisPerInforSegue" sender:nil];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    RegisterPatientViewController *vc = (RegisterPatientViewController *)[sb instantiateViewControllerWithIdentifier:@"RegisterPatientViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)onDoctorLoginAction:(id)sender
{
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (IS_IPHONE) {

    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        loginButton.frame = CGRectMake(20, loginButton.frame.origin.y, windowWidth - 40.0f, 40);
        registerButton.frame =  CGRectMake(20, registerButton.frame.origin.y, windowWidth - 40.0f, 40);
        forgotButton.frame =  CGRectMake(20, forgotButton.frame.origin.y, windowWidth - 40.0f, 40);
         loginButton.center = CGPointMake(windowWidth/2, windowHeight - 220);
        registerButton.center = CGPointMake(windowWidth/2, windowHeight - 160);
        forgotButton.center = CGPointMake(windowWidth/2, windowHeight - 100);
    } else {
        loginButton.frame = CGRectMake(20, loginButton.frame.origin.y, windowWidth - 40.0f, 30);
        registerButton.frame =  CGRectMake(20, registerButton.frame.origin.y, windowWidth - 40.0f, 30);
        forgotButton.frame =  CGRectMake(20, forgotButton.frame.origin.y, windowWidth - 40.0f, 30);
        loginButton.center = CGPointMake(windowWidth/2, windowHeight - 120);
        registerButton.center = CGPointMake(windowWidth/2, windowHeight - 85);
        forgotButton.center = CGPointMake(windowWidth/2, windowHeight - 50);
    }
        
    }
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)forgotPassword:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    ForgotPasswordViewController *vc = (ForgotPasswordViewController *)[sb instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (isPatientPasscode == true) {
        
        isPatientPasscode =false;
        
        if (buttonIndex == 1) {
            
            
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
            [SVProgressHUD showWithStatus:@"Checking..."];
            [[AppController sharedInstance] checkPMasterPasscode:passcodeString completion:^(BOOL success, NSString *message) {
                
                [SVProgressHUD dismiss];
                if (success) {
                    self.navigationController.navigationBarHidden = false;
                    //  [self performSegueWithIdentifier:@"showDashboardSegue" sender:nil];
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                    DashboardPatientViewController *vc = (DashboardPatientViewController *)[sb instantiateViewControllerWithIdentifier:@"DashboardPatientViewController"];
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                    
                } else {
                    isPatientPasscode =true;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Invalid passcode. Try again."
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"Done", nil];
                    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                    [alert show];
                }
                
            }];

            
            
        }
        
    } else if (tryAgainPasscode == true) {
        tryAgainPasscode = false;
        if (buttonIndex == 1) {
            isPatientPasscode = true;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode"
                                                            message:@"Enter your passcode login"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Done", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
            
        }
    }
    
    
    
}

@end
