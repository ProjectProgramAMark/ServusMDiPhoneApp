//
//  PatientRecordsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "BaseViewController.h"
#import "AppController.h"
#import "DashboardDoctorCell.h"
#import "PatientRecordProfViewController.h"
#import "DoctorCellV2.h"
#import "LinkPatientsViewController.h"

@interface PatientRecordsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, SWTableViewCellDelegate> {
    IBOutlet UITableView *doctorsTable;
    
    
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;

    
    
}

@property (strong, nonatomic) NSMutableArray *patientsArray;

@end
