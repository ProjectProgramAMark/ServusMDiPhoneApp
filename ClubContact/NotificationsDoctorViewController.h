//
//  NotificationsDoctorViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/5/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PharmacyListCell.h"
#import "AppController.h"
#import "MJRefresh.h"
#import "PharmacyTableViewCell.h"
#import "PatientRecordAboutCell.h"
#import "Appointments.h"
#import "Doctors.h"
#import "PMasterCalDetailsViewController.h"
#import "TalkConPreviousViewController.h"
#import "RefillMedInfoViewController.h"
#import "MSGSession.h"
#import "PatientMessagingView.h"
#import "UnifiedReqTableViewCell.h"
#import "Doctor.h"
#import "MessagingViewController.h"
#import "AppRequestiPhoneViewController.h"
#import "MessagePatientsList.h"
#import "SWRevealViewController.h"
#import "ConsultationDetailiPhone.h"
#import "RefillPatientsViewController.h"
#import "PatientDetailViewController.h"


@interface NotificationsDoctorViewController :  BaseViewController <UITableViewDataSource, UITableViewDelegate, RefillMedInfoDelegate> {
    IBOutlet UITableView *conditionTable;
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    IBOutlet UILabel *notificationCountLabel;
}

@property (strong, nonatomic) NSMutableArray *conditionsArray;


@end
