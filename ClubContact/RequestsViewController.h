//
//  RequestsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestAppointments.h"
#import "BaseViewController.h"
#import "Chameleon.h"
#import "UIImageView+WebCache.h"
#import "RequestGridCell.h"
#import "AppRequestDetail.h"
#import "AppRequestiPhoneViewController.h"
#import "RequestGridCelliPhone.h"
#import "DashboardPatientTableViewCell.h"

@interface RequestsViewController: BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, AppRequestDetailDelegate, AppRequestDetailiPhoneDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UICollectionView *patientsGrid;
    
     int currentPage;
    
    IBOutlet UITableView *menuTable;
}

@property (strong, nonatomic) NSMutableArray *requestsArray;

@end
