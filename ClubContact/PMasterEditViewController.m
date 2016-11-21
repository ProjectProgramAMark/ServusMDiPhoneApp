//
//  PMasterEditViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PMasterEditViewController.h"

@interface PMasterEditViewController ()

@end

@implementation PMasterEditViewController
@synthesize pmaster;

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
    
    
    self.title = @"EDIT PROFILE";
    
    countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    countryPicker.delegate = self;
    countryText.inputView = countryPicker;
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [self loadPmaster];
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}

- (void)loadPmaster {
    emailText.text = pmaster.email;
    phoneText.text = pmaster.telephone;
    addressText.text = pmaster.street1;
    cityText.text = pmaster.city;
    stateText.text = pmaster.state;
    zipText.text = pmaster.zipcode;
    countryText.text = pmaster.country;
    
    if (pmaster.dob.length > 0) {
        
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[pmaster.dob integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy"];
        dobText.text = [formatter stringFromDate:dob];
        
    } else {
        dobText.text = @"";
    }
    
    if (pmaster.gender.length == 0 ){
       // genderSegment.selectedSegmentIndex;
    } else {
        
        if ([pmaster.gender isEqual:@"M"]) {
            genderSegment.selectedSegmentIndex = 0;
            
        } else {
          genderSegment.selectedSegmentIndex = 1;
        }
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)saveProfile:(id)sender {
     if (emailText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the email" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (phoneText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the phone number" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    }   else {
        
        
        pmaster.email = emailText.text;
        pmaster.telephone = phoneText.text;
        pmaster.street1 = addressText.text;
        pmaster.city = cityText.text;
        pmaster.state = stateText.text;
        pmaster.zipcode = zipText.text;
        pmaster.country = countryText.text;
        
        if (genderSegment.selectedSegmentIndex == 0) {
            pmaster.gender = @"M";
        } else {
            pmaster.gender = @"F";
        }
       
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [[AppController sharedInstance] updatePMaster:pmaster WithCompletion:^(BOOL success, NSString *message) {
            [SVProgressHUD dismiss];
            if (success == false)
            {
               // title = @"failed";
                [self showAlertViewWithMessage:message withTag:100 withTitle:@"Error" andViewController:self isCancelButton:NO];
            } else {
                // [self.delegate patientEditDone:patient1];
                [self.navigationController popViewControllerAnimated:YES];
                
            }

        }];
      /*  [[AppController sharedInstance] updatePatient:patient1 WithCompletion:^(BOOL success, NSString *message) {
            NSString *title = @"succeed";
            if (success == false)
            {
                title = @"failed";
                [self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
            } else {
               // [self.delegate patientEditDone:patient1];
              
            }
           
        }];*/
        
    }

}

#pragma mark - UIPickerViewDataSource
- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    countryText.text = name;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([dobText isFirstResponder]) {
        datePickerContainer.hidden = false;
        double unixTimeStamp =[pmaster.dob doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
        NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        datePick.date = destinationDate;
        
        [self performSelector:@selector(hideKeyboard) withObject:nil afterDelay:0.2];
        
    }
}

- (void)hideKeyboard {
    [self.view endEditing:true];
}





- (IBAction)cancelDatePick:(id)sender {
    datePickerContainer.hidden = true;
}

- (IBAction)selectDatePick:(id)sender {
    datePickerContainer.hidden = true;
    NSTimeInterval t = [datePick.date timeIntervalSince1970];
    pmaster.dob = [NSString stringWithFormat:@"%i",(int)t];
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[pmaster.dob integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    dobText.text = [formatter stringFromDate:dob];
    
    datePick.hidden = true;
    
}



@end
