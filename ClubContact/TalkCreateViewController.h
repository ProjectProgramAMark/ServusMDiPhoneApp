//
//  TalkCreateViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppController.h"
#import "UIImageView+WebCache.h"
#import "Doctors.h"
#import "Consulatation.h"
@interface TalkCreateViewController : UIViewController <UITextFieldDelegate> {
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
    int textfieldType;
    IBOutlet UIView *dateContainer;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}


- (IBAction)selectPatient:(id)sender;

- (IBAction)datePickerValueChanged:(id)sender;
@property (nonatomic, retain) Doctors *doctor;

@property (nonatomic) Pharmacy *pharmacy;
@property (strong, nonatomic) NSMutableArray *allergenArray;
@property (nonatomic) NSMutableArray *selectedConditions;





@end
