//
//  RegisterComInforViewController.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "RegisterComInforViewController.h"

@interface RegisterComInforViewController () <SpecialitySelectorDelegate>

@end

@implementation RegisterComInforViewController

@synthesize viewShaker;
@synthesize allButtons;
@synthesize allTextFields;

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *nextAButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(onDoneAction:)];
    self.navigationItem.rightBarButtonItem = nextAButton;
    
     [dataTableView registerNib:[UINib nibWithNibName:@"RegisterTableViewCell" bundle:nil] forCellReuseIdentifier:@"registerCell"];
    
    
    if (kInputDummyDataForDebug)
    {
        
         //  [self inputDummyDataForDebug];
    }
    
    //self.navigationController.navigationBar.barTintColor = [UIColor flatGreenColor];
    self.title = @"DOCTOR INFORMATION";
    
    
    countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    countryPicker.delegate = self;
   // _countryText.inputView = countryPicker;
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    
    for (UIButton * button in self.allButtons) {
        button.layer.borderColor = [[UIColor whiteColor] CGColor];
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5;
    }
   /*
    UIColor *color = [UIColor lightGrayColor];
    _comNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Office Name" attributes:@{NSForegroundColorAttributeName: color}];
    _comAddressTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Address" attributes:@{NSForegroundColorAttributeName: color}];
    _comCityTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City" attributes:@{NSForegroundColorAttributeName: color}];
    _comStateTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"State" attributes:@{NSForegroundColorAttributeName: color}];
    _comZipCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Zip Code" attributes:@{NSForegroundColorAttributeName: color}];
    _comPhoneNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number" attributes:@{NSForegroundColorAttributeName: color}];
    _countryText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Country" attributes:@{NSForegroundColorAttributeName: color}];*/
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWillShow:(NSNotification *)sender
{
    CGSize kbSize = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
        [dataTableView setContentInset:edgeInsets];
        [dataTableView setScrollIndicatorInsets:edgeInsets];
    }];
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        [dataTableView setContentInset:edgeInsets];
        [dataTableView setScrollIndicatorInsets:edgeInsets];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)inputDummyDataForDebug
{
    _comNameTextField.text = @"David Office";
    _comAddressTextField.text = @"785 RUSSEL STREET";
    _comCityTextField.text = @"Craig";
    _comStateTextField.text = @"CO";
    _comZipCodeTextField.text = @"91606";
    _comPhoneNumberTextField.text = @"916332406";
    _countryText.text = @"United States";
}

#pragma mark - Action

- (IBAction)onDoneAction:(id)sender
{
    
    [self.view endEditing:YES];
    
    
    if (_account.npi.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your N.P.I." withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    }  else if (_account.speciality.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your specialization" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    }  else if (_account.comName.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your office name" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (_account.comAddress.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your office address" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (_account.comCity.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your office city" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (_account.comState.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your office state" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (_account.comZipCode.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your office zip code" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (_account.comCountry.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your office country" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (_account.comPhoneNumber.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your phone number" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else {
    
                [self.view endEditing:true];
    [self showProgressWithMessage:@"Please wait..."];
    [_appController checkPhysciansWithLastname:_account.lastName andNPI:_account.npi completion:^(BOOL success, NSString *message) {
        
       // [self dismissProgress];
       // [self dismissProgress];
          [self dismissProgress];
        if (success) {
            [self dismissProgress];
    
            RegOther2ViewController *regVC = [[RegOther2ViewController alloc] init];
            regVC.account = _account;
            [self.navigationController pushViewController:regVC animated:true];
         
            /*[[AppController sharedInstance] storePhysicianToUserDefault:_account];
            
            //You should only call this api after verifying the doctor from the doctor verification api I sent you earlier.
            [[AppController sharedInstance] registerWithAccoutCompletion:^(BOOL success, NSString *message, NSString *userid) {
          
                if (success)
                {
                     [self dismissProgress];
                   //   [self.navigationController popToRootViewControllerAnimated:YES];
                    [self showAlertViewWithMessage:message withTag:1 withTitle:@"Register successfull. Please wait till your account has been approved." andViewController:self isCancelButton:NO];
                    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                    SubscriptionPlanViewController *vc = [[SubscriptionPlanViewController alloc] initWithNibName:@"SubcriptionPlanViewController" bundle:nil];
                    vc.docID = userid;
                    vc.isRegisteredUser = true;
                    vc.delegate = self;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                   // [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else
                {
                    [self showAlertViewWithMessage:message withTag:1 withTitle:@"Register Failed." andViewController:self isCancelButton:NO];
                }
                
                   [self dismissProgress];
               // [self.navigationController popViewControllerAnimated:YES];
            }];*/

        } else {
           // [self.navigationController popViewControllerAnimated:YES];
               [self dismissProgress];
            [self showAlertViewWithMessage:message withTag:1 withTitle:@"Register Failed." andViewController:self isCancelButton:NO];
        }
    }];
        
    }
}

- (void)paymentComplated:(NSString *)sender {
      [self.navigationController popToRootViewControllerAnimated:YES];
}



#pragma mark - UIPickerViewDataSource
- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
   // _countryText.text = name;
    _account.comCountry = name;
   // [dataTableView reloadData];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
      [dataTableView reloadData];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        _account.ml = textField.text;
    } else if (textField.tag == 101) {
        _account.suffix = textField.text;
    } else if (textField.tag == 102) {
        _account.dea = textField.text;
    } else if (textField.tag == 103) {
        _account.npi = textField.text;
    } else if (textField.tag == 104) {
        _account.me = textField.text;
    } else if (textField.tag == 105) {
        _account.speciality = textField.text;
    } else if (textField.tag == 106) {
        _account.comName = textField.text;
    } else if (textField.tag == 107) {
        _account.comAddress = textField.text;
    } else if (textField.tag == 108) {
        _account.comCity = textField.text;
    } else if (textField.tag == 109) {
        _account.comState = textField.text;
    } else if (textField.tag == 110) {
        _account.comZipCode = textField.text;
    } else if (textField.tag == 111) {
      //  _account.comCountry = textField.text;
    } else if (textField.tag == 112) {
        _account.comPhoneNumber = textField.text;
    } 

    return true;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        //  [textField resignFirstResponder];
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    } else if (textField.tag == 101) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 102) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 103) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 104) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 105) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 106) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 107) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 108) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 109) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 110) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 111) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:11 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 112) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:12 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 113) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:13 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 114) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:14 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 115) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:15 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 116) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:16 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 105) {
        
        [textField resignFirstResponder];
        SpecialitySelectorViewController *vc = [[SpecialitySelectorViewController alloc] init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:true];
        
        
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
    int rowNumber = 13;
    
    return rowNumber;
}


- (NSString *)registerTableValue:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = _account.ml;
            break;
        }
        case 1:
        {
            title = _account.suffix;
            break;
        }
        case 2:
        {
            title = _account.dea;
            break;
        }
        case 3:
        {
            title = _account.npi;
            break;
        }
        case 4:
        {
            title = _account.me;
            break;
        }
        case 5:
        {
            title = _account.speciality;
            break;
        }case 6:
        {
            title = _account.comName;
            break;
        }
        case 7:
        {
            title = _account.comAddress;
            break;
        }
        case 8:
        {
            title = _account.comCity;
            break;
        }
        case 9:
        {
            title = _account.comState;
            break;
        }
        case 10:
        {
            title = _account.comZipCode;
            break;
        }
        case 11:
        {
            title = _account.comCountry;
            break;
        }
        case 12:
        {
            title = _account.comPhoneNumber;
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
            title = @"M.I.";
            break;
        }
        case 1:
        {
            title = @"Suffix";
            break;
        }
        case 2:
        {
            title = @"D.E.A.";
            break;
        }
        case 3:
        {
            title = @"N.P.I.";
            break;
        }
        case 4:
        {
            title = @"M.E.";
            break;
        }
        case 5:
        {
            title = @"Speciality";
            break;
        }
        case 6:
        {
            title = @"Office Name";
            break;
        }
        case 7:
        {
            title = @"Address";
            break;
        }
        case 8:
        {
            title = @"City";
            break;
        }
        case 9:
        {
            title = @"State";
            break;
        }
        case 10:
        {
            title = @"Zip Code";
            break;
        }
        case 11:
        {
            title = @"Country";
            break;
        }
        case 12:
        {
            title = @"Phone Number.";
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
    
    cell.valueText.placeholder = [self registerTableTitle:indexPath.row];
    cell.valueText.text = [self registerTableValue:indexPath.row];
    cell.valueText.tag = indexPath.row + 100;
    
    if (indexPath.row == 11) {
        cell.valueText.inputView = countryPicker;
    }
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, cell.valueText.frame.size.height)];
    leftView.backgroundColor = cell.valueText.backgroundColor;
    cell.valueText.leftView = leftView;
    cell.valueText.leftViewMode = UITextFieldViewModeAlways;
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)specialitySelectDone:(NSString *)speciality {
    _account.speciality = speciality;
    [dataTableView reloadData];
    //   isSpecilitySelect = false;
}



@end
