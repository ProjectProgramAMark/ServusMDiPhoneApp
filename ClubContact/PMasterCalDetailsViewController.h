//
//  PMasterCalDetailsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppController.h"
#import "PatientRecordAboutCell.h"
#import "Appointments.h"


@interface PMasterCalDetailsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> { IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    
    
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UILabel *docName;
    IBOutlet UILabel *patientName;
    IBOutlet UILabel *docPhone;
    IBOutlet UILabel *docAddress;
    IBOutlet UILabel *docEmail;
    IBOutlet UILabel *fromLabel;
    IBOutlet UILabel *toLabel;
    IBOutlet UILabel *specializationLabel;
    
}

@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) PatientLinks *patientInfo;
@property (nonatomic, retain) Patient *profPatient;
@property (nonatomic, retain) Appointments *appointment;



@end
