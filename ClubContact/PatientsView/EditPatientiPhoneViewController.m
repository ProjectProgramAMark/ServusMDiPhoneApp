//
//  EditPatientiPhoneViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "EditPatientiPhoneViewController.h"

@interface EditPatientiPhoneViewController ()

@end

@implementation EditPatientiPhoneViewController

@synthesize patient;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self
                                   action:@selector(addPatient)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
 /*  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                     target:self
                                     action:@selector(cancelPatient)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPatient)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPatient)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    countryPicker.delegate = self;
    countryText.inputView = countryPicker;
    
    firstNameText.delegate = self;
    lastnameText.delegate = self;
    occupationText.delegate = self;
    street1Text.delegate = self;
    street2Text.delegate = self;
    stateText.delegate = self;
    cityText.delegate = self;
    last4SSN.delegate = self;
    zipText.delegate = self;
    phoneText.delegate = self;
    emailText.delegate = self;
    occupationText.delegate = self;
    
    [scrollView addSubview:textEntryView];
    textEntryView.frame = CGRectMake(0, 0, textEntryView.frame.size.width, textEntryView.frame.size.height);
    scrollView.contentSize = CGSizeMake( textEntryView.frame.size.width, textEntryView.frame.size.height);
    
    
    self.title = @"EDIT PATIENT";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
    if (patient != nil) {
        emailText.text = patient.email;
        phoneText.text = patient.telephone;
        firstNameText.text = patient.firstName;
        lastnameText.text = patient.lastName;
        
        double unixTimeStamp =[patient.dob doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
        NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        datePick.date = destinationDate;
        
        if ([patient.gender isEqual:@"M"]) {
            genderSegment.selectedSegmentIndex = 0;
        } else {
            genderSegment.selectedSegmentIndex = 1;
        }
        
        occupationText.text = patient.occupation;
        street1Text.text = patient.street1;
        street2Text.text = patient.street2;
        cityText.text = patient.city;
        stateText.text = patient.state;
        countryText.text = patient.country;
        zipText.text = patient.zipcode;
        patientID = patient.postid;
        last4SSN.text = patient.ssnDigits;
        
        
        
    }
}


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
        
        Patient *patient1 = [self dummyPatientDataForRegister];
        
        [[AppController sharedInstance] updatePatient:patient1 WithCompletion:^(BOOL success, NSString *message) {
            NSString *title = @"succeed";
            if (success == false)
            {
                title = @"failed";
            } else {
                [self.delegate patientEditDone:patient1];
            }
            
            
            //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
            [self dismissViewControllerAnimated:YES completion:nil];
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
    dummyPatient.postid = patientID;
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
