//
//  EditDoctorViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "EditDoctorViewController.h"

@interface EditDoctorViewController ()

@end

@implementation EditDoctorViewController

@synthesize delegate;
@synthesize doctor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"EDIT PROFILE";
    
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self
                                   action:@selector(addDoctor)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                     target:self
                                     action:@selector(cancelDoctor)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain
                                                                    target:self action:@selector(cancelDoctor)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelDoctor)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    countryPicker.delegate = self;
    countryText.inputView = countryPicker;
    
    firstNameText.delegate =self;
    lastnameText.delegate = self;
    meText.delegate = self;
    miText.delegate = self;
    npiText.delegate = self;
    deaText.delegate = self;
    countryText.delegate = self;
    cityText.delegate = self;
    suffixText.delegate = self;
    officeNameText.delegate = self;
    addressText.delegate = self;
    stateText.delegate = self;
    cityText.delegate  = self;
    zipText.delegate = self;
    phoneText.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
    if (doctor != nil) {
        firstNameText.text = doctor.firstname;
        lastnameText.text = doctor.lastname;
        phoneText.text = doctor.telephone;
        suffixText.text = doctor.suffix;
        meText.text = doctor.me;
        miText.text = doctor.mi;
        npiText.text = doctor.npi;
        deaText.text = doctor.dea;
        officeNameText.text = doctor.officename;
        addressText.text = doctor.officeaddress;
        cityText.text = doctor.officecity;
        stateText.text = doctor.officestate;
        zipText.text = doctor.officezip;
        countryText.text = doctor.officecountry;
        speciality.text = doctor.speciality;
        
        
        
    }
}


- (void)addDoctor {
   if (firstNameText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the first name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (lastnameText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the last name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (miText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the M.I." withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (suffixText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the Suffix" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (deaText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the D.E.A" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    }  else if (npiText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the N.P.I." withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (meText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the M.E." withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (officeNameText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (addressText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office address" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    }  else if (cityText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office city" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (stateText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office state" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (zipText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office zip code" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (countryText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office country" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (phoneText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the telephone number" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (phoneText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the specialty" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    }else {
        
        Doctors *doctor1 = [self dummyPatientDataForRegister];
        
        [[AppController sharedInstance] updateDoctor:doctor1 WithCompletion:^(BOOL success, NSString *message) {
            NSString *title = @"succeed";
            if (success == false)
            {
                title = @"failed";
            } else {
                 [self.delegate doctorEditDone:doctor1];
            }
            
            
            //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        
        
    }
}

- (void)cancelDoctor {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (Doctors *)dummyPatientDataForRegister
{
    Doctors *dummyPatient = [Doctors new];
    
    
    
    
    
    
    
    dummyPatient.email = doctor.email;
    dummyPatient.firstname = firstNameText.text;
    dummyPatient.lastname =  lastnameText.text;
    dummyPatient.telephone = phoneText.text;
    dummyPatient.me = meText.text;
    dummyPatient.mi = miText.text;
    dummyPatient.npi = npiText.text;
    dummyPatient.dea = deaText.text;
    dummyPatient.suffix = suffixText.text;
    dummyPatient.officename = officeNameText.text;
    dummyPatient.officeaddress = addressText.text;
    dummyPatient.officecity = cityText.text;
    dummyPatient.officestate = stateText.text;
    dummyPatient.officezip = zipText.text;
    dummyPatient.officecountry = countryText.text;
    dummyPatient.speciality = speciality.text;
    
    
    
    return  dummyPatient;
    
}
#pragma mark - UIPickerViewDataSource
- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    countryText.text = name;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}


@end
