//
//  AddPatientiPhoneViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AddPatientiPhoneViewController.h"

@interface AddPatientiPhoneViewController () <UITextFieldDelegate> {
    UIPickerView *countryPicker;
    NSArray *countryArray;
}

@end

@implementation AddPatientiPhoneViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = notiButtonItem;

    
    countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    countryPicker.delegate = self;
    countryText.inputView = countryPicker;
    
    
       /* [scrollView addSubview:textEntryView];
        textEntryView.frame = CGRectMake(0, 0, textEntryView.frame.size.width, textEntryView.frame.size.height);
        scrollView.contentSize = CGSizeMake( textEntryView.frame.size.width, textEntryView.frame.size.height);*/
    
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, firstNameText.frame.size.height)];
    leftView.backgroundColor = firstNameText.backgroundColor;
    firstNameText.leftView = leftView;
    firstNameText.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, last4SSN.frame.size.height)];
    leftView2.backgroundColor = last4SSN.backgroundColor;
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, lastnameText.frame.size.height)];
    leftView3.backgroundColor = lastnameText.backgroundColor;
    UIView *leftView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, emailText.frame.size.height)];
    leftView4.backgroundColor = emailText.backgroundColor;
    UIView *leftView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, phoneText.frame.size.height)];
    leftView5.backgroundColor = phoneText.backgroundColor;
    UIView *leftView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, occupationText.frame.size.height)];
    leftView6.backgroundColor = occupationText.backgroundColor;
    UIView *leftView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, street2Text.frame.size.height)];
    leftView7.backgroundColor = street2Text.backgroundColor;
    UIView *leftView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, street1Text.frame.size.height)];
    leftView8.backgroundColor = street1Text.backgroundColor;
    UIView *leftView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, cityText.frame.size.height)];
    leftView9.backgroundColor = cityText.backgroundColor;
    UIView *leftView10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, stateText.frame.size.height)];
    leftView10.backgroundColor = stateText.backgroundColor;
    
    UIView *leftView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, zipText.frame.size.height)];
    leftView11.backgroundColor = zipText.backgroundColor;
    
    UIView *leftView12 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, countryText.frame.size.height)];
    leftView12.backgroundColor = countryText.backgroundColor;
    
    last4SSN.leftView = leftView2;
    last4SSN.leftViewMode = UITextFieldViewModeAlways;
    lastnameText.leftView = leftView3;
    lastnameText.leftViewMode = UITextFieldViewModeAlways;
    emailText.leftView = leftView4;
    emailText.leftViewMode = UITextFieldViewModeAlways;
    phoneText.leftView = leftView5;
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    occupationText.leftView = leftView6;
    occupationText.leftViewMode = UITextFieldViewModeAlways;
    street1Text.leftView = leftView7;
    street1Text.leftViewMode = UITextFieldViewModeAlways;
    street2Text.leftView = leftView8;
    street2Text.leftViewMode = UITextFieldViewModeAlways;
    cityText.leftView = leftView9;
    cityText.leftViewMode = UITextFieldViewModeAlways;
    stateText.leftView = leftView10;
    stateText.leftViewMode = UITextFieldViewModeAlways;
    zipText.leftView = leftView11;
    zipText.leftViewMode = UITextFieldViewModeAlways;
    countryText.leftView = leftView12;
    countryText.leftViewMode = UITextFieldViewModeAlways;
    
    self.title = @"ADD PATIENT";
    
    last4SSN.delegate = self;
    firstNameText.delegate = self;
    lastnameText.delegate = self;
    emailText.delegate = self;
    phoneText.delegate = self;
    occupationText.delegate = self;
    street1Text.delegate = self;
    street2Text.delegate = self;
    cityText.delegate = self;
    stateText.delegate = self;
    zipText.delegate = self;
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
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

- (void)addPatient {
    if (firstNameText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the first name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (lastnameText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the last name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (emailText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the email" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (phoneText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the phone number" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (last4SSN.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the last 4 digits of SSN" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else {
        
        Patient *patient = [self dummyPatientDataForRegister];
        
         [SVProgressHUD showWithStatus:@"Adding..."];
        [[AppController sharedInstance] registerPatient:patient WithCompletion:^(BOOL success, NSString *message) {
            NSString *title = @"succeed";
             [SVProgressHUD dismiss];
            if (success == false)
            {
                title = @"failed";
            }
            [self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
            if (success == true) {
                [self.delegate refreshAddPatient];
                [self.navigationController popViewControllerAnimated:true];
            }
           // [self.delegate refreshAddPatient];
            //[self dismissViewControllerAnimated:YES completion:nil];
        }];
        
    }
}

- (void)cancelPatient {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)savePatinet:(id)sender {
    [self addPatient];
}

- (Patient *)dummyPatientDataForRegister
{
    Patient *dummyPatient = [Patient new];
    
    NSString *gender = @"M";
    
    if (genderSegment.selectedSegmentIndex == 0) {
        gender = @"M";
    } else {
        gender = @"F";
    }
    
    NSTimeInterval t = [datePick.date timeIntervalSince1970];
    
    dummyPatient.email = emailText.text;
    dummyPatient.firstName = firstNameText.text;
    dummyPatient.lastName =  lastnameText.text;
    dummyPatient.dob = [NSString stringWithFormat:@"%i",(int)t];
    dummyPatient.occupation = occupationText.text;
    dummyPatient.gender = gender;
    dummyPatient.telephone = phoneText.text;
    
    dummyPatient.street1 = street1Text.text;
    dummyPatient.street2 = street2Text.text;
    
    dummyPatient.city = cityText.text;
    dummyPatient.state = stateText.text;
    dummyPatient.country = countryText.text;
    dummyPatient.zipcode =zipText.text;
    dummyPatient.ssnDigits = last4SSN.text;
    
    // dummyPatient.occupation = @"Specialist";
    
    
    
    
    return  dummyPatient;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}


#pragma mark - UIPickerViewDataSource
- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    countryText.text = name;
}

@end
