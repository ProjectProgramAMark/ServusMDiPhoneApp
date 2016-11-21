//
//  ConsultationDetailViewController.h
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

@class ConsultationDetailViewController;             //define class, so protocol can see MyClass
@protocol ConsultationDetailDelegate <NSObject>   //define delegate protocol
- (void) refreshPationInfo;  //define delegate method to be implemented within another class
@end //end

@interface ConsultationDetailViewController : UIViewController




@property (nonatomic, retain) IBOutlet UILabel *nameLabel1;
@property (nonatomic, retain) IBOutlet UILabel *fromTimeLabel1;
@property (nonatomic, retain) IBOutlet UILabel *toTimeLabel1;
@property (nonatomic, retain) IBOutlet UILabel *monthLabel1;
@property (nonatomic, retain) IBOutlet UILabel *dayLabel1;
@property (nonatomic, retain) IBOutlet UILabel *cStatus;

@property (nonatomic, retain) IBOutlet UILabel *emailLabel;
@property (nonatomic, retain) IBOutlet UILabel *costLabel;
@property (nonatomic, retain) IBOutlet UILabel *linkLabel;
@property (nonatomic, retain) IBOutlet UIButton *linkButton;
@property (nonatomic, retain) IBOutlet UIButton *acceptButton;
@property (nonatomic, retain) IBOutlet UIButton *declineButton;
@property (nonatomic, retain) IBOutlet UITextView *noteText;
@property (nonatomic, retain) IBOutlet UIImageView *profIMG;
@property (nonatomic, retain) IBOutlet UIVisualEffectView *profBlurEffect;

@property (nonatomic, retain) Consulatation *consultation;
@property (nonatomic, weak) id <ConsultationDetailDelegate> delegate;

@end
