//
//  ConsultationPatientList.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddConditionsViewController.h"
#import "Chameleon.h"
#import "MSGPatientGridCell.h"
#import "UIImageView+WebCache.h"
#import "DashboardPatientTableViewCell.h"

@interface ConsultationPatientList : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    
    IBOutlet UITableView *menuTable;
}

@property (nonatomic) BOOL shouldPatientSelect;


@end
