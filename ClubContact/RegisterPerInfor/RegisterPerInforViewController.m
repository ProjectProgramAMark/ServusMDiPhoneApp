//
//  RegisterPerInforViewController.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "RegisterPerInforViewController.h"
#import "RegisterComInforViewController.h"

@interface RegisterPerInforViewController ()

@end

@implementation RegisterPerInforViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   // _regisFormPerInforScrollView.layer.cornerRadius = 10.0f;
    //_backgroundView.layer.cornerRadius = 10.0f;
    if (kInputDummyDataForDebug) {
     // [self inputDummyDataForDebug];
    }
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    
    [dataTableView registerNib:[UINib nibWithNibName:@"RegisterTableViewCell" bundle:nil] forCellReuseIdentifier:@"registerCell"];
    
     _account = [[Account alloc] init];
    
    
   // self.navigationController.navigationBar.barTintColor = [UIColor flatGreenColor];
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    
    for (UIButton * button in self.allButtons) {
      //  button.layer.borderColor = [[UIColor whiteColor] CGColor];
       // button.layer.borderWidth = 1;
       // button.layer.cornerRadius = 5;
    }
    
   /* UIColor *color = [UIColor lightGrayColor];
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
    
    */
    if (IS_IPHONE) {
        /*[iphoneBackScroll addSubview:textEnterView];
        textEnterView.frame = CGRectMake(0, 0, textEnterView.frame.size.width, textEnterView.frame.size.height);
        iphoneBackScroll.contentSize = CGSizeMake(textEnterView.frame.size.width, textEnterView.frame.size.height + 200);
        iphoneBackScroll.hidden = false;
        nextButton.hidden = true;
        fidemLogoIMG.hidden = true;
        poweredLabel.hidden = true;
        UIBarButtonItem *nextAButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(onNextAction:)];
        self.navigationItem.rightBarButtonItem = nextAButton;*/
       // [iphoneBackScroll addSubview:textEnterView];
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
      //  textEnterView.frame = CGRectMake(10, 0, self.view.frame.size.width, self.view.frame.size.height - 60);
       // iphoneBackScroll.contentSize = CGSizeMake(textEnterView.frame.size.width, textEnterView.frame.size.height + 200);
       // iphoneBackScroll.hidden = false;
        nextButton.hidden = true;
        fidemLogoIMG.hidden = true;
        poweredLabel.hidden = true;
       /* UIBarButtonItem *nextAButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(onNextAction:)];
        self.navigationItem.rightBarButtonItem = nextAButton;*/
    }
    
    backgroundImageView.frame = CGRectMake(backgroundImageView.frame.origin.x, -60, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);
    logoImageView.frame = CGRectMake(logoImageView.frame.origin.x, 70, logoImageView.frame.size.width, logoImageView.frame.size.height);
    
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _usernameTextField.frame.size.height)];
    leftView.backgroundColor = _usernameTextField.backgroundColor;
    _usernameTextField.leftView = leftView;
    _usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _passwordTextField.frame.size.height)];
    leftView2.backgroundColor = _passwordTextField.backgroundColor;
    _passwordTextField.leftView = leftView2;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _firstNameTextField.frame.size.height)];
    leftView3.backgroundColor = _firstNameTextField.backgroundColor;
    _firstNameTextField.leftView = leftView3;
    _firstNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _lastNameTextField.frame.size.height)];
    leftView4.backgroundColor = _lastNameTextField.backgroundColor;
    _lastNameTextField.leftView = leftView4;
    _lastNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _emailTextField.frame.size.height)];
    leftView5.backgroundColor = _emailTextField.backgroundColor;
    _emailTextField.leftView = leftView5;
    _emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _passcodetextField.frame.size.height)];
    leftView6.backgroundColor = _passcodetextField.backgroundColor;
    _passcodetextField.leftView = leftView6;
    _passcodetextField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)inputDummyDataForDebug
{
    _firstNameTextField.text = @"David";
    _lastNameTextField.text = @"James";
    _mlTextField.text = @"M";
    _suffixTextField.text = @"test suffix";
    _deaTextField.text = @"13323434";
    _npiTextField.text = @"1417060336";
    _meTextField.text = @"13323434";
    _emailTextField.text = @"testdoc@myfidem.com";
    _passwordTextField.text = @"kalanaj";
}

#pragma mark - Action

- (IBAction)onNextAction:(id)sender
{
    [self.view endEditing:YES];
    
    if (_doctorSegement.selectedSegmentIndex == 0) {
        _account.username = _usernameTextField.text;
        _account.firstName = _firstNameTextField.text;
        _account.lastName = _lastNameTextField.text;
        _account.email = _emailTextField.text;
        _account.password = _passwordTextField.text;
        _account.passcode = _passcodetextField.text;
        
        NSString *genderString;
        if (_genderSegement.selectedSegmentIndex == 0) {
            genderString = @"M";
        } else {
            genderString = @"F";
        }
        
        
        _account.gender = genderString;
        
        if (_account.username.length == 0) {
           
            [self showAlertViewWithMessage:@"Please enter your username" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        } else if (_account.firstName.length == 0) {
            
            [self showAlertViewWithMessage:@"Please enter your first name" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        } else if (_account.lastName.length == 0) {
           
            [self showAlertViewWithMessage:@"Please enter your last name" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            
        } else if (_account.email.length == 0) {
            
            [self showAlertViewWithMessage:@"Please enter your email" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }  else if (_account.password.length == 0) {
            
            [self showAlertViewWithMessage:@"Please enter your password" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }  else if (_account.passcode.length == 0) {
            
            [self showAlertViewWithMessage:@"Please enter your passcode" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        } else {
                 
            if (termsAgreeButton.selected != true) {
                [self showAlertViewWithMessage:@"You have to agree to terms of service to continue." withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
                     return;
            }
            
            [self showPersonalSignatureView:^{
                [self removeBlurView];
                _personalSignatureView.hidden = YES;
                
                _account.signature =  UIImagePNGRepresentation([_personalSignatureView.signatureView getSignatureImage]);
               
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                RegisterComInforViewController *vc = (RegisterComInforViewController  *)[sb instantiateViewControllerWithIdentifier:@"RegisterComInforViewController"];
                vc.account = _account;
                
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
        }
        
    } else {
        if (_usernameTextField.text.length == 0) {
             [self showAlertViewWithMessage:@"Please enter your username" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        } else if (_firstNameTextField.text.length == 0) {
            [self showAlertViewWithMessage:@"Please enter your first name" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        } else if (_lastNameTextField.text.length == 0) {
            [self showAlertViewWithMessage:@"Please enter your last name" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            
        } else if (_emailTextField.text.length == 0) {
          [self showAlertViewWithMessage:@"Please enter your email" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            
        }   else if (_passwordTextField.text.length == 0) {
            [self showAlertViewWithMessage:@"Please enter your password" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }    else if (_passcodetextField.text.length == 0) {
            [self showAlertViewWithMessage:@"Please enter your passcode" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];

        }else {
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
            patient.username = _usernameTextField.text;
            patient.passcode = _passcodetextField.text;
            
            [[AppController sharedInstance] storePatientToUserDefault:patient];
            /* [SVProgressHUD showWithStatus:@"Please wait..."];
            [[AppController sharedInstance] registerPatientMaster:patient WithCompletion:^(BOOL success, NSString *message) {
                [SVProgressHUD dismiss];
                if (success)
                {
                    [self showAlertViewWithMessage:message withTag:1 withTitle:@"Registration" andViewController:self isCancelButton:NO];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    [self showAlertViewWithMessage:message withTag:1 withTitle:@"Register Failed." andViewController:self isCancelButton:NO];
                }
    
                
            }];*/
            
            RegOtherViewController *regVC = [[RegOtherViewController alloc] init];
            regVC.patient = patient;
            [self.navigationController pushViewController:regVC animated:true];
            
            
            
            
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField.tag == 100) {
        _account.username = textField.text;
    } else if (textField.tag == 101) {
        _account.firstName = textField.text;
    } else if (textField.tag == 102) {
        _account.lastName = textField.text;
    } else if (textField.tag == 103) {
        _account.ml = textField.text;
    } else if (textField.tag == 104) {
        _account.suffix = textField.text;
    } else if (textField.tag == 105) {
        _account.dea = textField.text;
    } else if (textField.tag == 106) {
        _account.npi = textField.text;
    } else if (textField.tag == 107) {
        _account.me = textField.text;
    } else if (textField.tag == 108) {
        _account.speciality = textField.text;
    } else if (textField.tag == 109) {
        _account.email = textField.text;
    } else if (textField.tag == 110) {
        _account.password = textField.text;
    }
    
    return true;
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


#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
  
    // return 10;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNumber = 11;
    
    return rowNumber;
}


- (NSString *)registerTableValue:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = _account.username;
            break;
        }
        case 1:
        {
            title = _account.firstName;
            break;
        }
        case 2:
        {
            title = _account.lastName;
            break;
        }
        case 3:
        {
            title = _account.ml;
            break;
        }
        case 4:
        {
            title = _account.suffix;
            break;
        }
        case 5:
        {
            title = _account.dea;
            break;
        }
        case 6:
        {
            title = _account.npi;
            break;
        }
        case 7:
        {
            title = _account.me;
            break;
        }
        case 8:
        {
            title = _account.speciality;
            break;
        }
        case 9:
        {
            title = _account.email;
            break;
        }
        case 10:
        {
            title = _account.password;
            break;
        }
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)registerTableTitle:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Username";
            break;
        }
        case 1:
        {
            title = @"First Name";
            break;
        }
        case 2:
        {
            title = @"Last Name";
            break;
        }
        case 3:
        {
            title = @"M.I.";
            break;
        }
        case 4:
        {
            title = @"Suffix";
            break;
        }
        case 5:
        {
            title = @"D.E.A.";
            break;
        }
        case 6:
        {
            title = @"N.P.I.";
            break;
        }
        case 7:
        {
            title = @"M.E.";
            break;
        }
        case 8:
        {
            title = @"Speciality";
            break;
        }
        case 9:
        {
            title = @"E-Mail";
            break;
        }
        case 10:
        {
            title = @"Password";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegisterTableViewCell   *cell = (RegisterTableViewCell  *)[tableView dequeueReusableCellWithIdentifier:@"registerCell"];
    
    // cell.valueLabel.borderStyle = UITextBorderStyleBezel;
    cell.valueText.enabled = true;
    cell.valueText.delegate = self;
    
    
    if (indexPath.row == 10) {
        cell.valueText.secureTextEntry = true;
    } else {
          cell.valueText.secureTextEntry = false;
    }
   
            cell.valueText.placeholder = [self registerTableTitle:indexPath.row];
            cell.valueText.text = [self registerTableValue:indexPath.row];
            cell.valueText.tag = indexPath.row + 100;
   
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


@end
