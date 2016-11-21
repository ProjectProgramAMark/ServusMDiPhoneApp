//
//  MyProfilePatientViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
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
#import "PMasterEditViewController.h"
#import "MyProfileConditionsViewController.h"
#import "MyProfileAllergyViewController.h"
#import "MyProfileConsultationHistory.h"
#import "MyProfileMessageHistory.h"
#import "PMMasterPharmacyViewController.h"
#import "EXPhotoViewer.h"
#import "UIAlertView+Blocks.h"
#import "ParentDetailsEditViewController.h"

@interface MyProfilePatientViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate> {
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *tokenLabel;
    IBOutlet UILabel *fromLabel;
    
    IBOutlet UICollectionView *menuCollection;
    IBOutlet UITableView *menuTable;
    BOOL isPasscodeUpdate;
    BOOL isPasswordUpdate;
    IBOutlet UIView *statView;
    BOOL isInsuranceUpdate;
     BOOL isInsuranceUpdateBack;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UILabel *notificationCountLabel;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    
    
    IBOutlet UIView *pharmContainer1;
    IBOutlet UILabel *pharmNameL1;
    IBOutlet UILabel *pharmAddressL1;
    
    IBOutlet UIView *pharmContainer2;
    IBOutlet UILabel *pharmNameL2;
    IBOutlet UILabel *pharmAddressL2;
    
    IBOutlet UIView *pharmContainer3;
    IBOutlet UILabel *pharmNameL3;
    IBOutlet UILabel *pharmAddressL3;
    
    IBOutlet UIView *pharmContainer4;
    IBOutlet UILabel *pharmNameL4;
    IBOutlet UILabel *pharmAddressL4;
    
    BOOL isIDCardUpate;
    
   
}

@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (strong, nonatomic) NSMutableArray *pharmacyArray;
@property (nonatomic, retain) PMaster *pmaster;

@end
