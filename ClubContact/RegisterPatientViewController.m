//
//  RegisterPatientViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "RegisterPatientViewController.h"

@implementation RegisterPatientViewController


- (void)viewDidLoad {
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    
    for (UIButton * button in self.allButtons) {
        //  button.layer.borderColor = [[UIColor whiteColor] CGColor];
        // button.layer.borderWidth = 1;
        // button.layer.cornerRadius = 5;
    }
    
    UIColor *color = [UIColor lightGrayColor];
    _userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    _firstNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    _lastNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    _mlTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"M.I." attributes:@{NSForegroundColorAttributeName: color}];
    _suffixTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Suffix" attributes:@{NSForegroundColorAttributeName: color}];
    _deaTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"D.E.A." attributes:@{NSForegroundColorAttributeName: color}];
    _npiTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"N.P.I." attributes:@{NSForegroundColorAttributeName: color}];
    _meTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"M.E." attributes:@{NSForegroundColorAttributeName: color}];
    
    _emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-Mail" attributes:@{NSForegroundColorAttributeName: color}];
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    _specialityTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Speciality" attributes:@{NSForegroundColorAttributeName: color}];
    
    if (IS_IPHONE) {
        [iphoneBackScroll addSubview:textEnterView];
        textEnterView.frame = CGRectMake(0, 0, windowWidth, textEnterView.frame.size.height);
        iphoneBackScroll.contentSize = CGSizeMake(windowWidth, textEnterView.frame.size.height + 200);
        iphoneBackScroll.hidden = false;
        nextButton.hidden = true;
        fidemLogoIMG.hidden = true;
        poweredLabel.hidden = true;
        UIBarButtonItem *nextAButton = [[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStylePlain target:self action:@selector(onNextAction:)];
        self.navigationItem.rightBarButtonItem = nextAButton;
    }

}

- (IBAction)goBackToChose:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}

- (IBAction)onNextAction:(id)sender
{
    if (_userNameTextField.text.length == 0) {
        [[[AFViewShaker alloc] initWithView:_userNameTextField] shake];
    } else if (_firstNameTextField.text.length == 0) {
        [[[AFViewShaker alloc] initWithView:_firstNameTextField] shake];
    } else if (_lastNameTextField.text.length == 0) {
        [[[AFViewShaker alloc] initWithView:_lastNameTextField] shake];
        
    } else if (_emailTextField.text.length == 0) {
        [[[AFViewShaker alloc] initWithView:_emailTextField] shake];
    }   else if (_passwordTextField.text.length == 0) {
        [[[AFViewShaker alloc] initWithView:_passwordTextField] shake];
    } else {
        if (termsAgreeButton.selected != true) {
             [self showAlertViewWithMessage:@"You have to agree to terms of service to continue." withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            return;
        }
        
        NSString *genderString;
        if (_genderSegement.selectedSegmentIndex == 0) {
            genderString = @"M";
        } else {
            genderString = @"F";
        }
        
        PatientRegister *patient = [[PatientRegister alloc] init];
        patient.firstName = _firstNameTextField.text;
        patient.lastName = _lastNameTextField.text;
        patient.password = _passwordTextField.text;
        patient.gender = genderString;
        patient.email = _emailTextField.text;
        patient.username = _userNameTextField.text;
        
         [[AppController sharedInstance] storePatientToUserDefault:patient];
        [[AppController sharedInstance] registerPatientMaster:patient WithCompletion:^(BOOL success, NSString *message) {
            if (success)
            {
                [self showAlertViewWithMessage:message withTag:1 withTitle:@"Registration" andViewController:self isCancelButton:NO];
                 [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self showAlertViewWithMessage:message withTag:1 withTitle:@"Register Failed." andViewController:self isCancelButton:NO];
            }
            
          //  [self.navigationController popViewControllerAnimated:YES];
            
        }];
      /*  [_appController registerPatientWithAccoutCompletion:^(BOOL success, NSString *message) {
        
            if (success)
            {
                [self showAlertViewWithMessage:message withTag:1 withTitle:@"Registration" andViewController:self isCancelButton:NO];
            }
            else
            {
                [self showAlertViewWithMessage:message withTag:1 withTitle:@"Register Failed." andViewController:self isCancelButton:NO];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        */

        
       /* [self showPersonalSignatureView:^{
            [self removeBlurView];
            _personalSignatureView.hidden = YES;
            _account = [[Account alloc] init];
            _account.firstName = _firstNameTextField.text;
            _account.lastName = _lastNameTextField.text;
            _account.ml = _mlTextField.text;
            _account.suffix = _suffixTextField.text;
            _account.dea = _deaTextField.text;
            _account.npi = _npiTextField.text;
            _account.me = _meTextField.text;
            _account.email = _emailTextField.text;
            _account.password = _passwordTextField.text;
            _account.username = _userNameTextField.text;
            _account.speciality = _specialityTextField.text;
            _account.signature =  UIImagePNGRepresentation([_personalSignatureView.signatureView getSignatureImage]);
            [_appController storePhysicianToUserDefault:_account];
            
            [self performSegueWithIdentifier:@"showRegisComInforSegue" sender:nil];
        }];*/
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

- (void)showTerms:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    TermsViewController *vc = (TermsViewController *)[sb instantiateViewControllerWithIdentifier:@"TermsViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)agreeToTerms:(id)sender {
    if (termsAgreeButton.selected == true) {
        termsAgreeButton.selected = false;
    } else {
        termsAgreeButton.selected = true;
    }
}


@end
