//
//  MSGPPharmacyViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/21/16.
//  Copyright © 2016 askpi. All rights reserved.
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


@interface MSGPPharmacyViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> { IBOutlet UIImageView *profileIMG;
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
@property (nonatomic, strong) NSString *patientID;


@end
