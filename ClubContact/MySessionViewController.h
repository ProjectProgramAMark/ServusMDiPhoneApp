//
//  MySessionViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/13/15.
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
#import "DoctorListViewController.h"
#import "DocMSGSessionViewController.h"
#import "DocChatViewViewController.h"
#import "MSGPatientGridCelliPhone.h"
#import "DocMSGSessioniPhone.h"
#import "DashboardPatientTableViewCell.h"
@interface MySessionViewController : UIViewController
<UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    IBOutlet UISegmentedControl *msgSelect;
    
    BOOL isMySessions;
    
    IBOutlet UITableView *menuTable;
}

@property (nonatomic) BOOL shouldPatientSelect;


@end
