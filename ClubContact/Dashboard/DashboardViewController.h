//
//  DashboardViewController.h
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DoctorProfileViewController.h"
#import "MessagePatientsList.h"
#import "Chameleon.h"
#import "UIImageView+WebCache.h"
#import "Doctor.h"
#import "CNPGridMenu.h"
#import "Patient.h"
#import "MSGPatientGridCell.h"
#import "RequestsViewController.h"
#import "PatientDetailViewController.h"
#import "RefillPatientsViewController.h"
#import "ConsultationListView.h"
#import "DoctorListViewController.h"
#import "MySessionViewController.h"
#import "MSGPatientGridCelliPhone.h"
#import "iPhoneCalendarViewController.h"
#import "DashboardDocTableViewCell.h"
#import "DocMenuTableViewCell.h"
#import "DashboardCollectionCell.h"
#import "DashboardCollectionCelliPhone.h"
#import "CallManager.h"
#import "DoctorReviewViewController.h"
#import "SharedProfileListViewController.h"
#import "SharedDocuments.h"
#import "SharedDocumentViewController.h"
#import "DoctorPaymentViewController.h"

@interface DashboardViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegate, CNPGridMenuDelegate, PatientsDetailDelegate, UITableViewDataSource, UITableViewDelegate, QBRTCClientDelegate> {
    IBOutlet UIImageView *profileIMGView;
    IBOutlet UILabel *refillNOLabel;
    IBOutlet UILabel *messageNOLabel;
    IBOutlet UILabel *appointmentNOLabel;
    IBOutlet UILabel *nameLabel;
    
    IBOutlet UIImageView *profileIMGView2;
    IBOutlet UIImageView *profileIMGBack;
    IBOutlet UILabel *refillNOLabel2;
    IBOutlet UILabel *messageNOLabel2;
    IBOutlet UILabel *appointmentNOLabel2;
    IBOutlet UILabel *nameLabel2;
    
    NSTimer *repeatTimer;
    IBOutlet UICollectionView *patientsGrid;
    
     int currentPage;
    
    IBOutlet UIView *statView;
    IBOutlet UIView *statView2;
    IBOutlet UIView *buttonViewiPad;
    IBOutlet UIView *buttowViewiPhone;
    
    IBOutlet UITableView *doctorsTable;
    
    int sharedDocumentUnread;
}


@property (strong, nonatomic) Doctors *doctor;
@property (nonatomic, strong) CNPGridMenu *gridMenu;
@property (strong, nonatomic) NSMutableArray *patientsArray;

@end
