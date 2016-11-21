//
//  NotificationsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 8/5/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PharmacyListCell.h"
#import "AppController.h"
#import "MJRefresh.h"
#import "PharmacyTableViewCell.h"
#import "PatientRecordAboutCell.h"
#import "Appointments.h"
#import "Doctors.h"
#import "PMasterCalDetailsViewController.h"
#import "TalkConPreviousViewController.h"
#import "RefillMedInfoViewController.h"
#import "MSGSession.h"
#import "PatientMessagingView.h"
#import "UnifiedReqTableViewCell.h"

@interface NotificationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
     IBOutlet UITableView *conditionTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
     IBOutlet UILabel *notificationCountLabel;
}

@property (strong, nonatomic) NSMutableArray *conditionsArray;

@end
