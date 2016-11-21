//
//  PMasterEditViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "DashboardDoctorCell.h"
#import "DoctorProfilePatientViC.h"
#import "MyProfilePatientViewController.h"
#import "LinkPatientsViewController.h"
#import "PatientRecordsViewController.h"
#import "SelectDocRefillViewController.h"
#import "CalendarRecViewController.h"
#import "DashboardCollectionCelliPhone.h"
#import "DashboardCollectionCell.h"
#import "PMaster.h"
#import "PaymentsPageViewController.h"
#import "CountryPicker.h"


@interface PMasterEditViewController : BaseViewController <CountryPickerDelegate, UITextFieldDelegate> {
    IBOutlet UITextField *addressText;
    IBOutlet UITextField *cityText;
    IBOutlet UITextField *stateText;
    IBOutlet UITextField *zipText;
    IBOutlet UITextField *emailText;
    IBOutlet UITextField *phoneText;
    IBOutlet UITextField *countryText;
    IBOutlet UITextField *dobText;
     UIPickerView *countryPicker;
    IBOutlet UIView *datePickerContainer;
    IBOutlet UIDatePicker *datePick;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
     IBOutlet UISegmentedControl *genderSegment;
    
    
}

@property (nonatomic, retain) PMaster *pmaster;

@end
