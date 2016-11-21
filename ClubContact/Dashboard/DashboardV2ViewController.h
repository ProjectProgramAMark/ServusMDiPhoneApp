//
//  DashboardV2ViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/20/15.
//  Copyright © 2015 askpi. All rights reserved.
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
#import "CallManager.h"
#import "AppointmentDashTableViewCell.h"
#import "iPhoneCalendarViewController.h"
#import "DoctorReviewViewController.h"
#import "DoctorPaymentsNewController.h"
#import "RefillPatientsViewController.h"
#import "ConsultationListView.h"
#import "SharedDocumentViewController.h"
#import "NotificationsDoctorViewController.h"
#import "BaseViewController.h"

@interface DashboardV2ViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UINavigationItem *navigationItem;
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    
    IBOutlet UIImageView *profileIMGView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *hospitalLabel;
    
    IBOutlet UILabel *refillNumLabel;
    IBOutlet UILabel *documentRequestNumLabel;
    IBOutlet UILabel *messageRequestNumLabel;
    IBOutlet UILabel *consultationNumLabel;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UITableView *appointmentTableView;
    
    IBOutlet UILabel *reviewsLabel;
    IBOutlet UILabel *ratingLabel;
    IBOutlet UILabel *notificationCountLabel;
    
    NSMutableArray *appointmentArray;
    
    int consulCount;
    int refillCount;
    int documentCount;
    int msgCount;
    
    IBOutlet UIView *reviewsBox;
    IBOutlet UIView *statsBox;
    IBOutlet UIView *appointmentBox;
}

@property (strong, nonatomic) Doctors *doctor;



- (void)refreshAllDataForNoti;

@end
