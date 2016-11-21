//
//  MessageInviteView.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/4/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddConditionsViewController.h"
#import "Chameleon.h"
#import "MSGPatientGridCell.h"
#import "UIImageView+WebCache.h"
#import "MSGPatientGridCelliPhone.h"
#import "DashboardPatientTableViewCell.h"

@interface MessageInviteView : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    
     IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
}

@property (nonatomic) BOOL shouldPatientSelect;




@end
