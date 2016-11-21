//
//  ConsultationListView.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestAppointments.h"
#import "BaseViewController.h"
#import "Chameleon.h"
#import "UIImageView+WebCache.h"
#import "RequestGridCell.h"
#import "AppRequestDetail.h"
#import "Consulatation.h"
#import "MSGConsultationGridCell.h"
#import "ConsultationPatientList.h"
#import "MSGConsultationCelliPhone.h"
#import "ConsultationDetailiPhone.h"
#import "DashboardPatientTableViewCell.h"

@interface ConsultationListView : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, AppRequestDetailDelegate, ConsultationDetailiPhoneDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UICollectionView *patientsGrid;
    
    int currentPage;
    
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (strong, nonatomic) NSMutableArray *requestsArray;



@end
