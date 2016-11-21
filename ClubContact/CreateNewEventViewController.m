//
//  CreateNewEventViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "CreateNewEventViewController.h"

@interface CreateNewEventViewController () <PatientListNewViewControllerDelegate>

@end

@implementation CreateNewEventViewController

@synthesize delegate;

@synthesize patientFullName;
@synthesize patientID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    
    titleLabel.delegate = self;
    noteLabel.delegate = self;
    startTimeTextField.delegate = self;
    endTimeTextField.delegate = self;
    dateTextField.delegate = self;
    
    dateTimePicker.hidden = true;
    
     //  [patientButton setBackgroundColor:[UIColor whiteColor]];
    
    self.title = @"NEW APPOINTMENT";
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
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
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, titleLabel.frame.size.height)];
    leftView.backgroundColor = titleLabel.backgroundColor;
    titleLabel.leftView = leftView;
    titleLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, noteLabel.frame.size.height)];
    leftView2.backgroundColor = noteLabel.backgroundColor;
    noteLabel.leftView = leftView2;
    noteLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, startTimeTextField.frame.size.height)];
    leftView3.backgroundColor = startTimeTextField.backgroundColor;
    startTimeTextField.leftView = leftView3;
    startTimeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, endTimeTextField.frame.size.height)];
    leftView4.backgroundColor = endTimeTextField.backgroundColor;
    endTimeTextField.leftView = leftView4;
    endTimeTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, dateTextField.frame.size.height)];
    leftView5.backgroundColor = dateTextField.backgroundColor;
    dateTextField.leftView = leftView5;
    dateTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidAppear:(BOOL)animated {
    if (patientID.length > 0) {
        // [patientButton setTitle:patientFullName forState:UIControlStateNormal];
        patientNameLabel.text = patientFullName;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    if ([dateTextField isFirstResponder]) {
        dateTimePicker.datePickerMode = UIDatePickerModeDate;
        dateTimePicker.hidden = false;
        dateContainer.hidden = false;
        textFieldType = 1;
        
        dateTypeLabel.text = @"Select Date";
         [self.view endEditing:true];
    } else if ([startTimeTextField isFirstResponder]) {
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
        dateTimePicker.hidden = false;
        dateContainer.hidden = false;
        textFieldType = 2;
        [textField resignFirstResponder];
        [titleLabel resignFirstResponder];
        dateTypeLabel.text = @"Select Start Time";
         [self.view endEditing:true];
    } else if ([endTimeTextField isFirstResponder]) {
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
        dateTimePicker.hidden = false;
        dateContainer.hidden = false;
        textFieldType = 3;
        [textField resignFirstResponder];
        [titleLabel resignFirstResponder];
        dateTypeLabel.text = @"Select End Time";
         [self.view endEditing:true];
    }
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([titleLabel isFirstResponder]) {
             [self.view endEditing:true];
    }
    return true;
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textFieldType == 1) {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        dateTextField.text = dateString;
        
        dateDate = dateTimePicker.date;
    } else if (textFieldType == 2) {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startTimeTextField.text = dateString;
        
        startTime = dateTimePicker.date;
        
    } else if ([endTimeTextField isFirstResponder]) {
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
        dateTextField.text = dateString;
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
        dateTextField.text = dateString;
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
        dateTextField.text = dateString;
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

- (void)selectPatient:(id)sender {
    
    PatientListNewViewController *vc = [[PatientListNewViewController  alloc] init];

   // patientsVC.view.frame = CGRectMake(0, 0, 300, 500);
    vc.shouldPatientSelect = true;
    vc.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)datePickerValueChanged:(id)sender {
    if (textFieldType == 1) {
        dateDate = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        dateTextField.text = dateString;
        
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


- (void)patientAppointmentAdded:(NSString *)paitentname patientid:(NSString *)patientid {
    patientFullName = paitentname;
    patientID = patientid;
    //[patientButton setTitle:patientFullName forState:UIControlStateNormal];
     patientNameLabel.text = patientFullName;
}

- (IBAction)saveAppointNow:(id)sender {
    
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
    } else if (titleLabel.text.length == 0) {
        stringError = @"Please enter a title for the appointment";
    }
    
    if (stringError) {
        [[[UIAlertView alloc] initWithTitle:nil message:stringError delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        //        [SVProgressHUD showErrorWithStatus:stringError];
    } else {
        // [protocol addNewEvent:eventNew];
        // [self buttonCancelAction:nil];
        
         [SVProgressHUD showWithStatus:@"Please wait..."];
        [[AppController sharedInstance] addAppointment:patientID fromdate:fromdate todate:todate titletext:titleLabel.text notetext:noteLabel.text completion:^(BOOL success, NSString *message) {
            [SVProgressHUD dismiss];
            [self.delegate createdNewEvent];
            [self.navigationController popViewControllerAnimated:YES];
           
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
