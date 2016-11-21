//
//  SharedProfileListViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/31/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddConditionsViewController.h"
#import "Chameleon.h"
#import "MSGPatientGridCell.h"
#import "UIImageView+WebCache.h"
#import "MSGPatientGridCelliPhone.h"
#import "AddPatientiPhoneViewController.h"
#import "SharedPatientProfileViewController.h"



@interface SharedProfileListViewController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, SharedPatientProfileViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    
    IBOutlet UITableView *menuTable;
}

@property (nonatomic) BOOL shouldPatientSelect;

@end
