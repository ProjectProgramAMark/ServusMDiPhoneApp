//
//  SelectRecMedViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppController.h"
#import "PatientRecordAboutCell.h"
#import "PatientMedication.h"
#import "RefillMedInfoViewController.h"
#import "MedRefillTableViewCell.h"
#import "DoctorProfilePatientViC.h"
@class SelectRecMedViewController;             //define class, so protocol can see MyClass
@protocol SelectRecMedDelegate <NSObject>   //define delegate protocol
- (void) refreshRefillMedication;  //define delegate method to be implemented within another class
@end

@interface SelectRecMedViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    
    
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
}

@property (strong, nonatomic) NSMutableArray *doctorArray;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) PatientLinks *patientInfo;
@property (nonatomic, retain) Patient *profPatient;

@property (nonatomic, weak) id <SelectRecMedDelegate> delegate;
@end
