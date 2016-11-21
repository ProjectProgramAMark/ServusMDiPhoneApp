//
//  MessagePatientsList.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/3/15.
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
#import "MessageInviteView.h"
#import "MSGPatientGridCelliPhone.h"
#import "MSGSessioniPhoneViewController.h"
#import "DashboardPatient2TableViewCell.h"
#import "SWTableViewCell.h"
#import "MSGPatientProfileViewController.h"
#import "DoctorListViewController.h"
#import "DocChatViewViewController.h"

@interface MessagePatientsList : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UISearchBar *contactSearchBar;
    
    
   
}

@property (nonatomic) BOOL shouldPatientSelect;
@end
