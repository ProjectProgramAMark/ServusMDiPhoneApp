//
//  TransactionViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
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
#import "TransactionCellTableViewCell.h"


@interface TransactionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RefillMedInfoDelegate> {
    IBOutlet UITableView *conditionTable;
}

@property (strong, nonatomic) NSMutableArray *conditionsArray;


@end
