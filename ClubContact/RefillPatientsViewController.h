//
//  RefillPatientsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/17/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MSGPatientGridCell.h"
#import "Chameleon.h"
#import "UIImageView+WebCache.h"
#import "MSGPatientGridCelliPhone.h"

@interface RefillPatientsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    
     IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}


@end
