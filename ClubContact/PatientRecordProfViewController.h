//
//  PatientRecordProfViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BaseViewController.h"
#import "Doctors.h"
#import "DocMenuTableViewCell.h"
#import "DashboardDocTableViewCell.h"
#import "Patient.h"
#import "Condition.h"
#import "PatientRecAboutViewController.h"
#import "PatientRecMedicationViewController.h"
#import "PatientRecConditionsVC.h"
#import "PatientRecAllergyViewController.h"
#import "PaitentRecNotesViewController.h"
#import "PatientRecAppointmentVC.h"
#import "SendPatientRecViewController.h"

@interface PatientRecordProfViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> { IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *docName;
    IBOutlet UILabel *docFrom;
    IBOutlet UILabel *docSpeciality;
    IBOutlet UILabel *docOnline;
    IBOutlet UILabel *pDob;
    
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *statView;
    
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
}

@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) PatientLinks *patientInfo;
@property (nonatomic, retain) Patient *profPatient;

@end
