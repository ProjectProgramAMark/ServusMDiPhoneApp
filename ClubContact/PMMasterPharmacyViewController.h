//
//  PMMasterPharmacyViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 8/21/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppController.h"
#import "PatientRecordAboutCell.h"
#import "PatientMedication.h"
#import "Condition.h"
#import "AddConditionToPMasterViewController.h"
#import "Pharmacy.h"
#import "PharmacyTableViewCell.h"
#import "PharmacyNewTableViewCell.h"


@interface PMMasterPharmacyViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> { IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    
    
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    
    
}

@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) PatientLinks *patientInfo;
@property (nonatomic, retain) Patient *profPatient;
@property (nonatomic, retain) Pharmacy *pharmacy;


@end
