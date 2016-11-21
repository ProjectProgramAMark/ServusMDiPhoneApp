//
//  LinkPatientsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "LinkPatientsViewController.h"

@interface LinkPatientsViewController ()

@end

@implementation LinkPatientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    
    for (UIButton * button in self.allButtons) {
        //    button.layer.borderColor = [[UIColor whiteColor] CGColor];
        //   button.layer.borderWidth = 1;
        //  button.layer.cornerRadius = 5;
    }
    self.title = @"LINK PATIENT RECORD";
    /*if (IS_IPHONE) {
        patientID.frame = CGRectMake(20, (windowHeight/2) - (patientID.frame.size.height), windowWidth - 40.0, patientID.frame.size.height);
        passcode.frame = CGRectMake(20, (windowHeight/2), windowWidth - 40.0, passcode.frame.size.height);
        patientIDSeperator.frame = CGRectMake(20, (windowHeight/2), windowWidth - 40.0, 1.0f);
        passcodeSeperator.frame = CGRectMake(20, (windowHeight/2) +  passcode.frame.size.height, windowWidth - 40.0, 1.0f);
        // loginButton.frame = CGRectMake(10, loginButton.frame.origin.y, windowWidth - 20.0f, 40);
        linkButton.frame = CGRectMake(20, linkButton.frame.origin.y, windowWidth - 40.0f, 40);
        linkButton.center = CGPointMake(windowWidth/2, windowHeight - 180);
       
    } else {
        
    }*/
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, passcode.frame.size.height)];
    leftView.backgroundColor = passcode.backgroundColor;
    passcode.leftView = leftView;
    passcode.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, patientID.frame.size.height)];
    leftView2.backgroundColor = patientID.backgroundColor;
    patientID.leftView = leftView2;
    patientID.leftViewMode = UITextFieldViewModeAlways;
    
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)linkProfile:(id)sender {
    NSString * strEmail = patientID.text;
    NSString * strPwd = passcode.text;
    
    if ( [strEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        
        [[[AFViewShaker alloc] initWithView:patientID] shake];
        
    } else if ([strPwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
        [[[AFViewShaker alloc] initWithView:passcode] shake];
        
    } else {
        
        
        
        [[AppController sharedInstance] linkPatientRecord:passcode.text patientid:patientID.text Completion:^(BOOL success, NSString *message) {
            
            if (success)
            {
                [self showAlertViewWithMessage:@"Your patient record linked with this profile" withTag:1 withTitle:@"Success" andViewController:self isCancelButton:NO];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self showAlertViewWithMessage:message withTag:1 withTitle:@"Login Failed." andViewController:self isCancelButton:NO];
                [[[AFViewShaker alloc] initWithView:linkButton] shake];
            }
        }];
        
    }
    

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return true;
}



@end
