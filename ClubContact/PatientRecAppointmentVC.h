//
//  PatientRecAppointmentVC.h
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
#import "Condition.h"
#import "Allergen.h"
#import "Appointments.h"
#import "CalendarDetailViewController.h"
#import "FFEvent.h"
#import "AppointmentDetailViewController.h"
#import "ConditionsTableViewCell.h"
@interface PatientRecAppointmentVC : BaseViewController <UITableViewDataSource, UITableViewDelegate, AppointmentDetailProtocol> {
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    
    
    IBOutlet UITableView *menuTable;
    UIPopoverController *popover2;
    
    IBOutlet UIView *menuButton;
    
}

@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) PatientLinks *patientInfo;
@property (nonatomic, retain) Patient *profPatient;



@end
