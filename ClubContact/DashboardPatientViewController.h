//
//  DashboardPatientViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "BaseViewController.h"
#import "AppController.h"
#import "DashboardDoctorCell.h"
#import "DoctorProfilePatientViC.h"
#import "MyProfilePatientViewController.h"
#import "LinkPatientsViewController.h"
#import "PatientRecordsViewController.h"
#import "SelectDocRefillViewController.h"
#import "CalendarRecViewController.h"
#import "DashboardCollectionCelliPhone.h"
#import "DashboardCollectionCell.h"
#import "PMaster.h"
#import "PaymentsPageViewController.h"
#import "MyProfilePatientViewController.h"
#import "ShortQuestViewController.h"
#import "MesRecDoctorViewController.h"
#import "ConnectionManager.h"
#import "CallManager.h"
#import "CalendarPatientViewController.h"
#import "IVAViewController.h"
#import "NotificationsViewController.h"
#import "Notifications.h"
#import "SWRevealViewController.h"
#import "Consulatation.h"
@interface DashboardPatientViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CNPGridMenuDelegate, UICollectionViewDataSource, UICollectionViewDelegate, QBRTCClientDelegate> {
    IBOutlet UITableView *doctorsTable;
    IBOutlet UISearchBar *doctorSearch;
    IBOutlet UICollectionView *menuCollection;
    int currentPage;
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *tokenLabel;
    IBOutlet UILabel *randomFactLabel;

    NSMutableArray *randomFacts;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
        IBOutlet UILabel *notificationCountLabel;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    
    IBOutlet UIView *apptContainer1;
    IBOutlet UILabel *apptNameL1;
    IBOutlet UILabel *aptTimeL1;
    
    IBOutlet UIView *apptContainer2;
    IBOutlet UILabel *apptNameL2;
    IBOutlet UILabel *aptTimeL2;
    
    IBOutlet UIView *apptContainer3;
    IBOutlet UILabel *apptNameL3;
    IBOutlet UILabel *aptTimeL3;
    
    IBOutlet UIView *consulContainer1;
    IBOutlet UILabel *consultNameL1;
    IBOutlet UILabel *consulStatusL1;
    
    IBOutlet UIView *consulContainer2;
    IBOutlet UILabel *consultNameL2;
    IBOutlet UILabel *consulStatusL2;
    
    IBOutlet UIView *consulContainer3;
    IBOutlet UILabel *consultNameL3;
    IBOutlet UILabel *consulStatusL3;
    
    
    IBOutlet UIView *medContainer1;
    IBOutlet UILabel *medNameL1;
    IBOutlet UILabel *medDocL1;
    
    IBOutlet UIView *medContainer2;
    IBOutlet UILabel *medNameL2;
    IBOutlet UILabel *medDocL2;
    
    IBOutlet UIView *medContainer3;
    IBOutlet UILabel *medNameL3;
    IBOutlet UILabel *medDocL3;
    
    NSMutableArray *consultationArray;
    NSMutableArray *medicationArray;
    NSMutableArray *appointmentArray;
    
    IBOutlet UIView *consultationBox;
    IBOutlet UIView *medicineBox;
    IBOutlet UIView *appointmentBox;
    
    float consultationHeight;
    float appointmentHeight;
    float medicineHeight;
    
    
}

@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (strong, nonatomic) NSMutableArray *notificationsArray;
@property (nonatomic, strong) CNPGridMenu *gridMenu;
@property (nonatomic, retain) PMaster *pmaster;


@end
