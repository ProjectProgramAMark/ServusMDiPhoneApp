//
//  EntryViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/23/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "EntryViewController.h"
#import "Doctor.h"

@implementation EntryViewController


- (void)viewDidLoad {
    
    self.navigationController.navigationBar.barTintColor = [UIColor flatWhiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Color all navigation items accordingly to new barTintColor
    self.navigationController.navigationBar.tintColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:self.navigationController.navigationBar.barTintColor isFlat:YES];
    self.navigationController.title = @"FLASHMD";
    
    isDoctorPassCode = false;
    
}

- (void)viewWillAppear:(BOOL)animated {
  //  self.navigationController.navigationBarHidden = true;
  //  doctorImage.frame =  CGRectMake(0, 0, self.view.frame.size.width/2, windowHeight);
    //patientImage.frame =  CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, windowHeight);
    self.navigationController.navigationBarHidden = false;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    LoginViewController *vc = (LoginViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
   // [self.navigationController pushViewController:vc animated:YES];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return true;
}

- (void)viewDidAppear:(BOOL)animated {
    Doctor *doc = nil;
    PatientLogin *patient = nil;
    
    if (doc != nil) {
       /* LAContext *context = [[LAContext alloc] init];
        
        NSError *error = nil;
        
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            // Authenticate User
              [self showProgressWithMessage:@""];
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                    localizedReason:@"Are you the device owner?"
                              reply:^(BOOL success, NSError *error) {
                                  
                                  if (error) {
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                      message:@"There was a problem verifying your identity."
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"Ok"
                                                                            otherButtonTitles:nil];
                                      [alert show];
                                       [self dismissProgress];
                                      return;
                                  }
                                  
                                  if (success) {
   
                                      
                                      UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                                      LoginViewController *vc = (LoginViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
                                      vc.touchIDVerfied = true;
                                      [self.navigationController pushViewController:vc animated:NO];
                                      // [self dismissProgress];
                                      
                                  } else {
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                      message:@"You are not the device owner."
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"Ok"
                                                                            otherButtonTitles:nil];
                                      [alert show];
                                       [self dismissProgress];
                                      [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDoctorUserDefault];
                                      [[NSUserDefaults standardUserDefaults] synchronize];
                                  }
                                  
                              }];
            
        }*/
        /*isDoctorPassCode = true;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode"
                                                        message:@"Enter your passcode login"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Done", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert show];
*/
        
    } else if (patient != nil) {
        
       /* LAContext *context = [[LAContext alloc] init];
        
        NSError *error = nil;
        
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            // Authenticate User
            [self showProgressWithMessage:@""];
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                    localizedReason:@"Are you the device owner?"
                              reply:^(BOOL success, NSError *error) {
                                  
                                  if (error) {
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                      message:@"There was a problem verifying your identity."
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"Ok"
                                                                            otherButtonTitles:nil];
                                      [alert show];
                                      [self dismissProgress];
                                      return;
                                  }
                                  
                                  if (success) {
                                      
                                      
                                      self.navigationController.navigationBarHidden = false;
                                      
                                      UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                                      LoginPatientViewController *vc = (LoginPatientViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginPatientViewController"];
                                      vc.touchIDVerfied = true;
                                      [self.navigationController pushViewController:vc animated:YES];
                                      // [self dismissProgress];
                                      
                                  } else {
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                      message:@"You are not the device owner."
                                                                                     delegate:nil
                                                                            cancelButtonTitle:@"Ok"
                                                                            otherButtonTitles:nil];
                                      [alert show];
                                      [self dismissProgress];
                                      [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientRegisterUserDefault];
                                      [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientUserDefault];
                                      [[NSUserDefaults standardUserDefaults] synchronize];
                                  }
                                  
                              }];
            
        }*/
        
      /*  isDoctorPassCode = false;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode"
                                                        message:@"Enter your passcode login"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Done", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert show];*/

        
    }
}

- (void)viewDidDisappear:(BOOL)animated {
      [self dismissProgress];
}

- (IBAction)accessDoctor:(id)sender {
     self.navigationController.navigationBarHidden = false;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    LoginViewController *vc = (LoginViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginViewController"];

    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)accessPatient:(id)sender {
   /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming Soon"
                                                    message:@"This section will be available soon."
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];*/
    
     self.navigationController.navigationBarHidden = false;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    LoginPatientViewController *vc = (LoginPatientViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginPatientViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (isDoctorPassCode == true) {
   
    if (buttonIndex == 1) {
    
        
        NSString *passcodeString = [alertView textFieldAtIndex:0].text;
        [SVProgressHUD showWithStatus:@"Checking..."];
        [[AppController sharedInstance] checkDoctorPasscode:passcodeString completion:^(BOOL success, NSString *message) {
            [SVProgressHUD dismiss];
            if (success) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                LoginViewController *vc = (LoginViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
                vc.touchIDVerfied = true;
                [self.navigationController pushViewController:vc animated:NO];
                
               
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid passcode. Try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }

        }];

        
        
    }
        
    } else {
        NSString *passcodeString = [alertView textFieldAtIndex:0].text;
        [SVProgressHUD showWithStatus:@"Checking..."];
        [[AppController sharedInstance] checkPMasterPasscode:passcodeString completion:^(BOOL success, NSString *message) {
            
            [SVProgressHUD dismiss];
            if (success) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                LoginViewController *vc = (LoginViewController *)[sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
                vc.touchIDVerfied = true;
                [self.navigationController pushViewController:vc animated:NO];
                
                
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid passcode. Try again."
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Ok", nil];
                alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                [alert show];

            }
            
        }];


        
    }
    
    
    
}

@end
