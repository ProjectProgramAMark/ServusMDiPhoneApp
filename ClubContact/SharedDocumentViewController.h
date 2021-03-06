//
//  SharedDocumentViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/7/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "UIImageView+WebCache.h"
#import "PatientsTableViewCell.h"
#import "PatientDetailViewController.h"
#import "AddPatientViewController.h"
#import "Patient.h"
#import "MJRefresh.h"
#import "SharedDocuments.h"
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
#import "EyeExamImageViewController.h"
#import "EyeExam2VC.h"
#import "NotificationsDoctorViewController.h"

@interface SharedDocumentViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    
    IBOutlet UITableView *menuTable;
    
    int currentPage;
    
    int sharedDocumentUnread;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
}

@property (nonatomic) NSString *eyeExamID;
@property (nonatomic) NSString *patientID;

@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;



@end
