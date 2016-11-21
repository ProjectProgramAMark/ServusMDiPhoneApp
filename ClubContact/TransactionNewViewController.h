//
//  TransactionNewViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/26/15.
//  Copyright © 2015 askpi. All rights reserved.
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
#import "TransactionCellTableViewCell.h"

@interface TransactionNewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RefillMedInfoDelegate> {
    IBOutlet UITableView *conditionTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (strong, nonatomic) NSMutableArray *conditionsArray;

@end
