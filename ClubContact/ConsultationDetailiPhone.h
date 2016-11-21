//
//  ConsultationDetailiPhone.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/22/15.
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
#import "DocMenuTableViewCell.h"
#import "DashboardDocTableViewCell.h"
#import "PatientRecordAboutCell.h"
#import "ConsulDetailAllergyViewController.h"
#import "ConsulDetailConditionsViewController.h"
#import "CallManager.h"
@class ConsultationDetailiPhone;             //define class, so protocol can see MyClass
@protocol ConsultationDetailiPhoneDelegate <NSObject>   //define delegate protocol
- (void) refreshPationInfo;  //define delegate method to be implemented within another class
@end //end

@interface ConsultationDetailiPhone : UIViewController <UITableViewDataSource, UITableViewDelegate> {
     IBOutlet UITableView *menuTable;
     QBUUser *docQB;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}




@property (nonatomic, retain) IBOutlet UILabel *nameLabel1;
@property (nonatomic, retain) IBOutlet UILabel *fromTimeLabel1;
@property (nonatomic, retain) IBOutlet UILabel *toTimeLabel1;
@property (nonatomic, retain) IBOutlet UILabel *monthLabel1;
@property (nonatomic, retain) IBOutlet UILabel *dayLabel1;
@property (nonatomic, retain) IBOutlet UILabel *cStatus;

@property (nonatomic, retain) IBOutlet UILabel *emailLabel;
@property (nonatomic, retain) IBOutlet UILabel *costLabel;
@property (nonatomic, retain) IBOutlet UILabel *linkLabel;
@property (nonatomic, retain) IBOutlet UILabel *phoneLabel;
@property (nonatomic, retain) IBOutlet UILabel *pharmnameLabel;
@property (nonatomic, retain) IBOutlet UILabel *pharmAddressLabel;
@property (nonatomic, retain) IBOutlet UIButton *linkButton;
@property (nonatomic, retain) IBOutlet UIButton *acceptButton;
@property (nonatomic, retain) IBOutlet UIButton *declineButton;
@property (nonatomic, retain) IBOutlet UILabel*noteText;
@property (nonatomic, retain) IBOutlet UIImageView *profIMG;
@property (nonatomic, retain) IBOutlet UIImageView *profIMG2;
@property (nonatomic, retain) IBOutlet UIVisualEffectView *profBlurEffect;

@property (nonatomic, retain) Consulatation *consultation;
@property (nonatomic, weak) id <ConsultationDetailiPhoneDelegate> delegate;

@end
