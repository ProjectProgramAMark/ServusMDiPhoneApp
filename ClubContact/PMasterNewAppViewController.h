//
//  PMasterNewAppViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "AppController.h"
#import "Chameleon.h"
#import "PatientLinks.h"
#import "Appointments.h"
#import "BaseViewController.h"
@interface PMasterNewAppViewController : BaseViewController {
    IBOutlet UITextField *startDateText;
    IBOutlet UITextField *startTimeTextField;
    IBOutlet UITextField *endTimeTextField;
    IBOutlet UITextField *noteText;
    IBOutlet UIDatePicker *dateTimePicker;
    
    
    NSDate *dateDate;
    NSDate *startTime;
    NSDate *endTime;
    
    NSString *patientFullName;
    NSString *patientID;
    
    NSString *fromdate;
    NSString *todate;
    
    int textFieldType;
    
    IBOutlet UIView *dateContainer;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;

    
}

@property (nonatomic, retain) Appointments *appointment;
@property (nonatomic, retain) PatientLinks *patientLink;

@end
