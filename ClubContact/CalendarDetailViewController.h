//
//  CalendarDetailViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/19/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Appointments.h"
#import "CalendarKit.h"
#import "PatientRecordAboutCell.h"
#import "SharedPatientProfileViewController.h"
#import "Doctor.h"  
#import "PatientDetailViewController.h"
@interface CalendarDetailViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UIButton *acceptButton;
    IBOutlet UIButton *declineButton;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *teleLabel;
    IBOutlet UILabel *emailLabel;
    
    IBOutlet UILabel *noteText;
    
    IBOutlet UILabel *nameLabel1;
    IBOutlet UILabel *fromTimeLabel1;
    IBOutlet UILabel *toTimeLabel1;
    IBOutlet UILabel *monthLabel1;
    IBOutlet UILabel *dayLabel1;
    IBOutlet UIImageView *profIMG;
    IBOutlet UIVisualEffectView *profBlurEffect;
    IBOutlet UIImageView *profIMG2;

    
    IBOutlet UITableView *menuTable;
    
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (nonatomic) CKCalendarEvent *ckEvent;
@property (nonatomic) Appointments *appointment;

@end
