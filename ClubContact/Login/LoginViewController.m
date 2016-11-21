//
//  LoginViewController.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "LoginViewController.h"
#import "AppController.h"
#import "Doctor.h"
#import "Flurry.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize viewShaker;
@synthesize allButtons;
@synthesize allTextFields;
@synthesize touchIDVerfied;

#pragma mark - UIViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    //_loginFormBackgroundView.layer.cornerRadius = 10.0f;
    if (kInputDummyDataForDebug)
    {
       // _emailField.text = @"meredithgray";
        //_passwordField.text = @"kalanaj";
      //   _emailField.text = @"apphunter";
      //  _passwordField.text = @"fidem3@";
    }
    
   
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    
    [self setNeedsStatusBarAppearanceUpdate];
    

    self.navigationController.title = @"";
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    

    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _passwordField.frame.size.height)];
    leftView.backgroundColor = _passwordField.backgroundColor;
    _passwordField.leftView = leftView;
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _emailField.frame.size.height)];
    leftView2.backgroundColor = _passwordField.backgroundColor;
    _emailField.leftView = leftView2;
    _emailField.leftViewMode = UITextFieldViewModeAlways;
    
   /*_passwordField.layer.sublayerTransform = CATransform3DMakeTranslation(0, 0, 0);
    _emailField.layer.sublayerTransform = CATransform3DMakeTranslation(0, 0, 0);*/
    actIndicator.hidden = true;
  
    
    if (IS_IPHONE) {

        backgroundImageView.frame = CGRectMake(backgroundImageView.frame.origin.x, -10, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);
        logoImageView.frame = CGRectMake(logoImageView.frame.origin.x, 100, logoImageView.frame.size.width, logoImageView.frame.size.height);
        
        loginView.center = CGPointMake(loginView.center.x, (windowHeight/2) );
    }
    
    
  
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:)
                   name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
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



- (void)viewWillAppear:(BOOL)animated {
    //self.navigationController.navigationBarHidden = true;
   /* if (touchIDVerfied == true) {
        touchIDVerfied = false;
        Doctor *doc = [Doctor getFromUserDefault];
        if (doc != nil) {
            self.navigationController.navigationBarHidden = false;
            [self performSegueWithIdentifier:@"showDashboardSegue" sender:nil];
        }
    }*/
}

- (void)viewDidAppear:(BOOL)animated {
   // if (touchIDVerfied == true) {
   //     touchIDVerfied = false;
        Doctor *doc = [Doctor getFromUserDefault];
   PatientLogin *doc2 = [PatientLogin getFromUserDefault];
        if (doc != nil) {
            isDoctorPassCode = true;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode"
                                                            message:@"Enter your passcode login"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Done", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
            /*
           self.navigationController.navigationBarHidden = true;
            
            DashboardV2ViewController *vc = [[DashboardV2ViewController alloc] init];
            
            RearViewController *rearViewController = [[RearViewController alloc] init];
            
            UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
            
            SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
            
            
            [self.navigationController pushViewController:revealController animated:YES];*/
            

        } else if (doc2 != nil) {
            isPatientPassCode = true;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode"
                                                            message:@"Enter your passcode login"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Done", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
            
            
         /*   self.navigationController.navigationBarHidden = true;
            // [self performSegueWithIdentifier:@"showDashboardSegue" sender:nil];
            DashboardPatientViewController *vc = [[DashboardPatientViewController alloc] initWithNibName:@"DashboardPatientViewController" bundle:nil];
            
            RearViewPatientViewController *rearViewController = [[RearViewPatientViewController alloc] init];
            
            UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
            
            SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
            
            
            [self.navigationController pushViewController:revealController animated:YES];*/
        }
    
 
        //}
    
     loginView.center = CGPointMake(loginView.center.x, (windowHeight/2) );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}





- (void)loadVideoChatDoctorUser {
    Doctor *plogin = [Doctor getFromUserDefault];
    [SVProgressHUD dismiss];
    
    
    // Success, You have got Application session, now READ something.
    QBUUser *user = [QBUUser user];
    user.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
    user.password =  [NSString stringWithFormat:@"passwordmyfidem"];
    user.email = plogin.email;
    user.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];
    
    [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
        // Success, do something
        [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
            // Success, do something
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.userQB = user1;
            [self logInChatWithDoctorUser:user1];
            [SVProgressHUD dismiss];
        } errorBlock:^(QBResponse *response) {
            // error handling
            [SVProgressHUD dismiss];
            NSLog(@"error: %@", response.error);
        }];
    } errorBlock:^(QBResponse *response) {
        // error handling
        NSLog(@"error: %@", response.error);
        [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
            // Success, do something
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.userQB = user1;
            [self logInChatWithDoctorUser:user1];
            [SVProgressHUD dismiss];
        } errorBlock:^(QBResponse *response) {
            // error handling
            [SVProgressHUD dismiss];
            NSLog(@"error: %@", response.error);
        }];
    }];
    
    
    
    /*[QBRequest createSessionWithSuccessBlock:^(QBResponse *response, QBASession *session) {
        // Success, You have got Application session, now READ something.
        QBUUser *user = [QBUUser user];
        user.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
        user.password =  [NSString stringWithFormat:@"passwordmyfidem"];
        user.email = plogin.email;
        user.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];
        
        [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
            // Success, do something
            [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
                // Success, do something
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userQB = user1;
                [self logInChatWithDoctorUser:user1];
                [SVProgressHUD dismiss];
            } errorBlock:^(QBResponse *response) {
                // error handling
                [SVProgressHUD dismiss];
                NSLog(@"error: %@", response.error);
            }];
        } errorBlock:^(QBResponse *response) {
            // error handling
            NSLog(@"error: %@", response.error);
            [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
                // Success, do something
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userQB = user1;
                [self logInChatWithDoctorUser:user1];
                [SVProgressHUD dismiss];
            } errorBlock:^(QBResponse *response) {
                // error handling
                [SVProgressHUD dismiss];
                NSLog(@"error: %@", response.error);
            }];
        }];
        
    } errorBlock:^(QBResponse *response) {
        // error handling
        NSLog(@"error: %@", response.error);
    }];*/
}


- (void)logInChatWithDoctorUser:(QBUUser *)user {
    
    
    QBUUser *user1 = [QBUUser user];
    user1.ID = user.ID;
    user1.login = user.login;
    user1.fullName = user.fullName;
    user1.password = [NSString stringWithFormat:@"passwordmyfidem"];
    
    __weak __typeof(self)weakSelf = self;
    [QBRTCClient.instance addDelegate:self];
    [[ConnectionManager instance] logInWithUser:user1
                                     completion:^(BOOL error)
     {
         if (!error) {
             
             
             

         }
         else {
             
             [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Login chat error!", nil)];
         }
     }];
}

- (void)didReceiveNewSession:(QBRTCSession *)session userInfo:(NSDictionary *)userInfo {
    [CallManager.instance incominingCall:session userInfo:userInfo];
}



- (void)sessionDidClose:(QBRTCSession *)session {
    [CallManager.instance closeThisSession:session];
}





- (void)loadVideoChatPatientUser {
    PatientLogin *plogin = [PatientLogin getFromUserDefault];
    
    /*[QBRequest createSessionWithSuccessBlock:^(QBResponse *response, QBASession *session) {
        // Success, You have got Application session, now READ something.
        QBUUser *user = [QBUUser user];
        user.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
        user.password = [NSString stringWithFormat:@"passwordmyfidem"];
        user.email = plogin.email;
        user.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];
        
        [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
            // Success, do something
            [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
                // Success, do something
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userQB = user1;
                [self logInChatWithPatientUser:user1];
            } errorBlock:^(QBResponse *response) {
                // error handling
                NSLog(@"error: %@", response.error);
            }];
        } errorBlock:^(QBResponse *response) {
            // error handling
            NSLog(@"error: %@", response.error);
            [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
                // Success, do something
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userQB = user1;
                
                [self logInChatWithPatientUser:user1];
            } errorBlock:^(QBResponse *response) {
                // error handling
                NSLog(@"error: %@", response.error);
            }];
        }];
        
    } errorBlock:^(QBResponse *response) {
        // error handling
        NSLog(@"error: %@", response.error);
    }];*/
    
    QBUUser *user = [QBUUser user];
    user.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
    user.password = [NSString stringWithFormat:@"passwordmyfidem"];
    user.email = plogin.email;
    user.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];
    
    [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
        // Success, do something
        [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
            // Success, do something
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.userQB = user1;
            [self logInChatWithPatientUser:user1];
        } errorBlock:^(QBResponse *response) {
            // error handling
            NSLog(@"error: %@", response.error);
        }];
    } errorBlock:^(QBResponse *response) {
        // error handling
        NSLog(@"error: %@", response.error);
        [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
            // Success, do something
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.userQB = user1;
            
            [self logInChatWithPatientUser:user1];
        } errorBlock:^(QBResponse *response) {
            // error handling
            NSLog(@"error: %@", response.error);
        }];
    }];

    
}


- (void)logInChatWithPatientUser:(QBUUser *)user {
    
    
    QBUUser *user1 = [QBUUser user];
    user1.ID = (int)user.ID;
    user1.login = user.login;
    user1.fullName = user.fullName;
    user1.password = [NSString stringWithFormat:@"passwordmyfidem"];
    
      [QBRTCClient.instance addDelegate:self];
    
    
    __weak __typeof(self)weakSelf = self;
    [[ConnectionManager instance] logInWithUser:user1
                                     completion:^(BOOL error)
     {
         if (!error) {
             
        
         }
         else {
             
             [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Login chat error!", nil)];
         }
     }];
}




#pragma mark - Action

- (IBAction)onLoginAction:(id)sender
{
    [Flurry logEvent:@"LoginDoctor"];
    NSString * strEmail = _emailField.text;
    NSString * strPwd = _passwordField.text;
    
    if ( [strEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        
        [[[AFViewShaker alloc] initWithView:_emailField] shake];
        
    } else if ([strPwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
         [[[AFViewShaker alloc] initWithView:_passwordField] shake];
        
    } else {
        
     //   [SVProgressHUD showWithStatus:@"Checking..."];
        actIndicator.hidden = false;
    [[AppController sharedInstance] getLoginTypePassword:_passwordField.text Email:_emailField.text Completion:^(BOOL success, NSString *message, NSString *profileType) {
        if (success)
        {
            if ([profileType intValue] == 1) {
                [[AppController sharedInstance] loginDoctorWithPassword:_passwordField.text Email:_emailField.text Completion:^(BOOL success, NSString *message) {
                    // [SVProgressHUD dismiss];
                    actIndicator.hidden = true;
                    if (success)
                    {
                        
                        _emailField.text = @"";
                        _passwordField.text = @"";
                        self.navigationController.navigationBarHidden = true;
                      // [self performSegueWithIdentifier:@"showDashboardSegue" sender:nil];
                        [AppDelegate sharedInstance].dashVC = [[DashboardV2ViewController alloc] init];
                        
                      //  [self.navigationController pushViewController:vc animated:YES];
                        
                        
                       [AppDelegate sharedInstance].rearVC = [[RearViewController alloc] init];
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:[AppDelegate sharedInstance].dashVC];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:[AppDelegate sharedInstance].rearVC];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        //revealController.delegate = self;
                        
                        
                        
                       // revealController.rightViewController = vc;
                        
                          [self.navigationController pushViewController:revealController animated:YES];
                        
                        [self loadVideoChatDoctorUser];
                        
                    }
                    else
                    {
                        [self showAlertViewWithMessage:message withTag:1 withTitle:@"" andViewController:self isCancelButton:NO];
                        [[[AFViewShaker alloc] initWithView:loginButton] shake];
                    }
                }];
            } else {
                
                [[AppController sharedInstance] loginPatientWithPassword:_passwordField.text Email:_emailField.text Completion:^(BOOL success, NSString *message) {
                    // [SVProgressHUD dismiss];
                    actIndicator.hidden = true;
                    if (success)
                    {
                        
                        
                        _emailField.text = @"";
                        _passwordField.text = @"";
                       
                        
                        self.navigationController.navigationBarHidden = true;
                        // [self performSegueWithIdentifier:@"showDashboardSegue" sender:nil];
                        DashboardPatientViewController *vc = [[DashboardPatientViewController alloc] initWithNibName:@"DashboardPatientViewController" bundle:nil];
                        
                        RearViewPatientViewController *rearViewController = [[RearViewPatientViewController alloc] init];
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        
                        
                        [self.navigationController pushViewController:revealController animated:YES];
                        
                        [self loadVideoChatPatientUser];
                    }
                    else
                    {
                        [self showAlertViewWithMessage:message withTag:1 withTitle:@"" andViewController:self isCancelButton:NO];
                        [[[AFViewShaker alloc] initWithView:loginButton] shake];
                    }
                }];

            }
            
        }else
        {
            // [SVProgressHUD dismiss];
            actIndicator.hidden = true;
            [self showAlertViewWithMessage:message withTag:1 withTitle:@"" andViewController:self isCancelButton:NO];
            [[[AFViewShaker alloc] initWithView:loginButton] shake];
        }
    }];
        
        
        
    }

}

- (IBAction)onSignUpAction:(id)sender
{
    [Flurry logEvent:@"SignupDoctor"];
    self.navigationController.navigationBarHidden = false;
    [self performSegueWithIdentifier:@"showRegisPerInforSegue" sender:nil];
}

- (IBAction)onDoctorLoginAction:(id)sender
{
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
       

   
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
    ForgotPasswordNewViewController *vc = (ForgotPasswordNewViewController *)[sb instantiateViewControllerWithIdentifier:@"ForgotPasswordNewViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (isDoctorPassCode == true) {
        isDoctorPassCode = false;
        if (buttonIndex == 1) {
            
            
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
           // [SVProgressHUD showWithStatus:@"Checking..."];
            actIndicator.hidden = false;
            [[AppController sharedInstance] checkDoctorPasscode:passcodeString completion:^(BOOL success, NSString *message) {
                //[SVProgressHUD dismiss];
                actIndicator.hidden = true;
                if (success) {
                  /*  self.navigationController.navigationBarHidden = false;
                    [self performSegueWithIdentifier:@"showDashboardSegue" sender:nil];*/
                    self.navigationController.navigationBarHidden = true;
                    // [self performSegueWithIdentifier:@"showDashboardSegue" sender:nil];
                    [AppDelegate sharedInstance].dashVC = [[DashboardV2ViewController alloc] init];
                    
                    [AppDelegate sharedInstance].rearVC = [[RearViewController alloc] init];
                    
                    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:[AppDelegate sharedInstance].dashVC];
                    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:[AppDelegate sharedInstance].rearVC];
                    
                    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                    
                    
                    [self.navigationController pushViewController:revealController animated:YES];
                    [self loadVideoChatDoctorUser];
                    
                } else {
                  //  tryAgainPasscode  = true;
                    isDoctorPassCode = true;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Invalid passcode. Try again."
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"Done", nil];
                    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                    [alert show];
                }
                
            }];
            
            
            
        } else {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDoctorUserDefault];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    } else if (tryAgainPasscode == true) {
        tryAgainPasscode = false;
        if (buttonIndex == 1) {
            isDoctorPassCode = true;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode"
                                                            message:@"Enter your passcode login"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Done", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
            
        } else {
            //[[NSUserDefaults standardUserDefaults] removeObjectForKey:kDoctorUserDefault];
            //[[NSUserDefaults standardUserDefaults] synchronize];
        }
    } else if (isPatientPassCode == true) {
        isPatientPassCode =false;
        
        if (buttonIndex == 1) {
            
            
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
           // [SVProgressHUD showWithStatus:@"Checking..."];
            actIndicator.hidden = false;
            [[AppController sharedInstance] checkPMasterPasscode:passcodeString completion:^(BOOL success, NSString *message) {
                
               // [SVProgressHUD dismiss];
                actIndicator.hidden = true;
                if (success) {
                    self.navigationController.navigationBarHidden = true;
                    // [self performSegueWithIdentifier:@"showDashboardSegue" sender:nil];
                    DashboardPatientViewController *vc = [[DashboardPatientViewController alloc] initWithNibName:@"DashboardPatientViewController" bundle:nil];
                    
                    RearViewPatientViewController *rearViewController = [[RearViewPatientViewController alloc] init];
                    
                    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
                    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                    
                    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                    
                    
                    [self.navigationController pushViewController:revealController animated:YES];
                    
                      [self loadVideoChatPatientUser];
                    
                    
                } else {
                    isPatientPassCode =true;
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Invalid passcode. Try again."
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"Done", nil];
                    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                    [alert show];
                }
                
            }];
            
            
            
        } else {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientRegisterUserDefault];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientUserDefault];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([_emailField isFirstResponder]) {
        isOffSet = true;
    } else if ([_passwordField isFirstResponder]) {
        isOffSet = true;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([_emailField isFirstResponder]) {
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

        
    } else if ([_passwordField isFirstResponder]) {
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
