//
//  AddPatientViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 3/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AddPatientViewController.h"
#import "Patient.h"
#import "AppController.h"

@interface AddPatientViewController ()
{
    UIPickerView *countryPicker;
    NSArray *countryArray;
}

@end

@implementation AddPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                 target:self
                 action:@selector(addPatient)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                  target:self
                                  action:@selector(cancelPatient)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPatient)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPatient)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    countryPicker.delegate = self;
    countryText.inputView = countryPicker;
    self.title = @"ADD PATIENT";
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
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
        
    }
}

- (void)cancelPatient {
    [self dismissViewControllerAnimated:YES completion:nil];
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
#pragma mark - UIPickerViewDataSource
- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    countryText.text = name;
}
@end
