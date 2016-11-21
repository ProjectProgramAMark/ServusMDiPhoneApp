//
//  CreateNewEventViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chameleon.h"
#import "AppController.h"
#import "PatientsViewController.h"
#import "PatientListNewViewController.h"

@class CreateNewEventViewController;             //define class, so protocol can see MyClass
@protocol CreateNewEventViewDelegate <NSObject>   //define delegate protocol
- (void) createdNewEvent;  //define delegate method to be implemented within another class
@end

@interface CreateNewEventViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *titleLabel;
    IBOutlet UITextField *noteLabel;
    IBOutlet UITextField *startTimeTextField;
    IBOutlet UITextField *endTimeTextField;
    IBOutlet UITextField *dateTextField;
    IBOutlet UIButton *patientButton;
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
    
    IBOutlet UILabel *dateTypeLabel;
    IBOutlet UILabel *patientNameLabel;
}

@property (nonatomic, weak) id <CreateNewEventViewDelegate> delegate;

@property (nonatomic, strong) NSString *patientFullName;
@property (nonatomic, strong)  NSString *patientID;

- (IBAction)selectPatient:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;

@end
