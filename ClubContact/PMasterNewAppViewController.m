//
//  PMasterNewAppViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PMasterNewAppViewController.h"

@interface PMasterNewAppViewController ()

@end

@implementation PMasterNewAppViewController


@synthesize patientLink;
@synthesize appointment;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAddPatient)];
    self.navigationItem.rightBarButtonItem = addButton;
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
        noteText.delegate = self;
    startTimeTextField.delegate = self;
    endTimeTextField.delegate = self;
    startDateText.delegate = self;
    
    dateTimePicker.hidden = true;
    
    //  [patientButton setBackgroundColor:[UIColor whiteColor]];
    
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
    
    self.title = @"NEW APPOINTMENT";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    patientID = patientLink.postid;
}

- (IBAction)savePatientNow:(id)sender {
    [self saveAddPatient];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([startDateText isFirstResponder]) {
        dateTimePicker.datePickerMode = UIDatePickerModeDate;
        dateTimePicker.hidden = false;
         dateContainer.hidden = false;
        textFieldType = 1;
         [textField resignFirstResponder];
    } else if ([startTimeTextField isFirstResponder]) {
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
        dateTimePicker.hidden = false;
         dateContainer.hidden = false;
        textFieldType = 2;
         [textField resignFirstResponder];
    } else if ([endTimeTextField isFirstResponder]) {
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
        dateTimePicker.hidden = false;
         dateContainer.hidden = false;
        textFieldType = 3;
         [textField resignFirstResponder];
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([noteText isFirstResponder]) {
        [self.view endEditing:true];
    }
    return true;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textFieldType == 1) {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startDateText.text = dateString;
        
        dateDate = dateTimePicker.date;
    } else if (textFieldType == 2) {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startTimeTextField.text = dateString;
        
        startTime = dateTimePicker.date;
        
    } else if (textFieldType == 3) {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        endTimeTextField.text = dateString;
        
        endTime = dateTimePicker.date;
        
    }
    [textField resignFirstResponder];
    dateTimePicker.hidden = true;
    dateContainer.hidden = true;
    
    return true;
}

- (void)selectPatient:(id)sender {
   /* UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    PatientsViewController *patientsVC = (PatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientsViewController"];
    // patientsVC.view.frame = CGRectMake(0, 0, 300, 500);
    patientsVC.shouldPatientSelect = true;
    patientsVC.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:patientsVC];
    [self presentViewController:nav animated:YES completion:nil];*/
}




- (IBAction)datePickerValueChanged:(id)sender {
    if (textFieldType == 1) {
        dateDate = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startDateText.text = dateString;
    } else if (textFieldType == 2) {
        startTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startTimeTextField.text = dateString;
    }if (textFieldType == 3) {
        endTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        endTimeTextField.text = dateString;
    }
}



- (IBAction)nextTextField:(id)sender {
    if (textFieldType == 1) {
        textFieldType = 2;
        startTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startTimeTextField.text = dateString;
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
    } else if (textFieldType == 2) {
        textFieldType = 3;
        endTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        endTimeTextField.text = dateString;
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
        
    } else if (textFieldType == 3) {
        textFieldType = 1;
        dateDate = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startDateText.text = dateString;
        dateTimePicker.datePickerMode = UIDatePickerModeDate;
        
    }
    
    
}



- (IBAction)previousTextField:(id)sender {
    if (textFieldType == 2) {
        textFieldType = 1;
        dateDate = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startDateText.text = dateString;
        dateTimePicker.datePickerMode = UIDatePickerModeDate;
    } else if (textFieldType == 3) {
        textFieldType = 2;
        startTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
        startTimeTextField.text = dateString;
        
    } else if (textFieldType == 1) {
        textFieldType = 3;
        endTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
        endTimeTextField.text = dateString;
        
    }
    
    
}


- (IBAction)doneButtonClick:(id)sender {
    if (textFieldType == 1) {
        dateDate = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startDateText.text = dateString;
    } else if (textFieldType == 2) {
        startTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startTimeTextField.text = dateString;
    }if (textFieldType == 3) {
        endTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        endTimeTextField.text = dateString;
    }
    dateTimePicker.hidden = true;
    dateContainer.hidden = true;
    
    
}



- (void)patientAppointmentAdded:(NSString *)paitentname patientid:(NSString *)patientid {
    patientFullName = paitentname;
    patientID = patientid;
   // [patientButton setTitle:patientFullName forState:UIControlStateNormal];
}

- (void)saveAddPatient {
    
    NSDateComponents *compDate = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:dateDate];
    NSDateComponents *compDate2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:startTime];
    NSDateComponents *compDate3 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:endTime];
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:compDate.day];
    [comps setMonth:compDate.month];
    [comps setYear:compDate.year];
    [comps setHour:compDate2.hour];
    [comps setMinute:compDate2.minute];
    
    
    NSDate *fromdate1 = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    NSDateComponents *comps2 = [[NSDateComponents alloc] init];
    [comps2 setDay:compDate.day];
    [comps2 setMonth:compDate.month];
    [comps2 setYear:compDate.year];
    [comps2 setHour:compDate3.hour];
    [comps2 setMinute:compDate3.minute];
    
    
    NSDate *todate1 = [[NSCalendar currentCalendar] dateFromComponents:comps2];
    
    // NSDate* referenceDate = [NSDate dateWithTimeIntervalSince1970: 0];
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    int offset = [timeZone secondsFromGMTForDate:todate1];
    int unix_timestamp =  [todate1 timeIntervalSince1970];
    // int Timestamp1 = unix_timestamp - offset;
    int Timestamp1 = unix_timestamp;
    
    NSTimeZone* timeZone2 = [NSTimeZone localTimeZone];
    int offset2 = [timeZone2 secondsFromGMTForDate:fromdate1];
    int unix_timestamp2 =  [fromdate1 timeIntervalSince1970];
    // int Timestamp2 = unix_timestamp2 - offset2;
    int Timestamp2 = unix_timestamp2;
    
    fromdate = [NSString stringWithFormat:@"%i", Timestamp2];
    todate = [NSString stringWithFormat:@"%i", Timestamp1];
    
    NSString *stringError;
    
    if (!patientID) {
        stringError = @"Please select a patient.";
    } else if (![self isTimeBeginEarlier:startTime timeEnd:endTime]) {
        stringError = @"Start time must occur earlier than end time.";
    }
    
    if (stringError) {
        [[[UIAlertView alloc] initWithTitle:nil message:stringError delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        //        [SVProgressHUD showErrorWithStatus:stringError];
    } else {
        // [protocol addNewEvent:eventNew];
        // [self buttonCancelAction:nil];
        
        
     /*   [[AppController sharedInstance] addAppointment:patientID fromdate:fromdate todate:todate titletext:titleLabel.text notetext:noteLabel.text completion:^(BOOL success, NSString *message) {
            [self.delegate createdNewEvent];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];*/
         [SVProgressHUD showWithStatus:@"Please wait..."];
        
        [[AppController sharedInstance] addPMAppointment:patientLink.docid patient:patientLink.postid fromdate:fromdate todate:todate notetext:noteText.text completion:^(BOOL success, NSString *message) {
            [SVProgressHUD dismiss];
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
        
    }
    
}


- (BOOL)isTimeBeginEarlier:(NSDate *)dateBegin timeEnd:(NSDate *)dateEnd {
    
    BOOL boolIsRight = YES;
    
    NSDateComponents *compDateBegin = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:dateBegin];
    NSDateComponents *compDateEnd = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:dateEnd];
    
    if ((compDateBegin.hour > compDateEnd.hour) || (compDateBegin.hour == compDateEnd.hour && compDateBegin.minute >= compDateEnd.minute)) {
        boolIsRight = NO;
    }
    
    return boolIsRight;
}

@end
