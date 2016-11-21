//
//  TalkCreateViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "TalkCreateViewController.h"

@interface TalkCreateViewController ()

@end

@implementation TalkCreateViewController

@synthesize doctor;

@synthesize pharmacy;
@synthesize selectedConditions;
@synthesize allergenArray;

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
    
    titleLabel.delegate = self;
    noteLabel.delegate = self;
    startTimeTextField.delegate = self;
    endTimeTextField.delegate = self;
    dateTextField.delegate = self;
    
    dateTimePicker.hidden = true;
    
    
    self.title = @"NEW CONSULTATION";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
  
    if ([dateTextField isFirstResponder]) {
        dateTimePicker.datePickerMode = UIDatePickerModeDate;
        dateTimePicker.hidden = false;
        dateContainer.hidden = false;
        textfieldType = 1;
        [textField resignFirstResponder];
    } else if ([startTimeTextField isFirstResponder]) {
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
        dateTimePicker.hidden = false;
        dateContainer.hidden = false;
        [textField resignFirstResponder];
           textfieldType = 2;
    } else if ([endTimeTextField isFirstResponder]) {
        dateTimePicker.datePickerMode = UIDatePickerModeTime;
        dateTimePicker.hidden = false;
        dateContainer.hidden = false;
           textfieldType = 3;
        [textField resignFirstResponder];
    }
    
    
   
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textfieldType == 1) {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        dateTextField.text = dateString;
        
        dateDate = dateTimePicker.date;
    } else if (textfieldType == 2) {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startTimeTextField.text = dateString;
        
        startTime = dateTimePicker.date;
        
    } else if (textfieldType == 3) {
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


- (void)datePickerValueChanged:(id)sender {
    if (textfieldType == 1) {
        dateDate = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        dateTextField.text = dateString;
    } else if (textfieldType == 2) {
        startTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startTimeTextField.text = dateString;
    }if (textfieldType == 3) {
        endTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        endTimeTextField.text = dateString;
    }
}

- (IBAction)nextTextField:(id)sender {
    if (textfieldType == 1) {
        textfieldType = 2;
        startTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startTimeTextField.text = dateString;
         dateTimePicker.datePickerMode = UIDatePickerModeTime;
    } else if (textfieldType == 2) {
        textfieldType = 1;
        dateDate = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        dateTextField.text = dateString;
         dateTimePicker.datePickerMode = UIDatePickerModeDate;
        
    }
    
    
}



- (IBAction)previousTextField:(id)sender {
    if (textfieldType == 2) {
        textfieldType = 1;
        dateDate = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        dateTextField.text = dateString;
         dateTimePicker.datePickerMode = UIDatePickerModeDate;
    } else if (textfieldType == 1) {
        textfieldType = 2;
        startTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
         dateTimePicker.datePickerMode = UIDatePickerModeTime;
        startTimeTextField.text = dateString;
        
    }
    
    
}


- (IBAction)doneButtonClick:(id)sender {
    if (textfieldType == 1) {
        dateDate = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        dateTextField.text = dateString;
    } else if (textfieldType == 2) {
        startTime = dateTimePicker.date;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dateTimePicker.date
                                                              dateStyle:NSDateFormatterNoStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        startTimeTextField.text = dateString;
    }if (textfieldType == 3) {
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
    [patientButton setTitle:patientFullName forState:UIControlStateNormal];
}

- (IBAction)saveAddPatient:(id)sender {
    
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
   // todate = [NSString stringWithFormat:@"%i", Timestamp1];
    
    NSString *stringError;
    
    if (dateTextField.text.length == 0) {
        stringError = @"Select a start date";
    }else if (startTimeTextField.text.length == 0) {
        stringError = @"Select a start time";
    }
    
    if (stringError) {
        [[[UIAlertView alloc] initWithTitle:nil message:stringError delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        //        [SVProgressHUD showErrorWithStatus:stringError];
    } else {
        // [protocol addNewEvent:eventNew];
        // [self buttonCancelAction:nil];
        NSString *strcomment= noteLabel.text;
        
        NSData *data = [strcomment dataUsingEncoding:NSNonLossyASCIIStringEncoding];
        strcomment = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
     /*   [[AppController sharedInstance] addConsultation:doctor.uid fromdate:fromdate tnotetext:strcomment  completion:^(BOOL success, NSString *message) {
         //   [self.delegate createdNewEvent];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];*/
        
         [SVProgressHUD showWithStatus:@"Please wait..."];
        
        [[AppController sharedInstance] addConsultation2:doctor.uid fromdate:fromdate tnotetext:strcomment pharmcyname:pharmacy.pharmName pharmancyaddress:pharmacy.address completion:^(BOOL success, NSString *message) {
            [SVProgressHUD dismiss];
            if (success) {
              [self.navigationController popViewControllerAnimated:YES];
            } else {
                 [[[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
               
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
