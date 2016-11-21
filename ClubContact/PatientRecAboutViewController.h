//
//  PatientRecAboutViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppController.h"
#import "PatientRecordAboutCell.h"

@interface PatientRecAboutViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> { IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
  
    
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    
    IBOutlet UILabel *occupationLabel;
    IBOutlet UILabel *addressLabel;
    IBOutlet UILabel *dobLabel;
    IBOutlet UILabel *genderLabel;
    IBOutlet UILabel *phoneLabel;
    IBOutlet UILabel *emailLabel;
    IBOutlet UILabel *ssnLabel;
    
}

@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) PatientLinks *patientInfo;
@property (nonatomic, retain) Patient *profPatient;


@end
