//
//  DoctorListViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/12/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddPatientViewController.h"
#import "MessagingViewController.h"
#import "MessagingTableViewCell.h"
#import "MSGPatientGridCell.h"
#import "MSGSession.h"
#import "MSGSessionViewController.h"
#import "Doctors.h"
#import "MSGPatientGridCelliPhone.h"
#import "DashboardPatientTableViewCell.h"
#import "DoctorCellV2.h"

@interface DoctorListViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    UIToolbar *toolbar;
}

@end
