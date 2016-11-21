//
//  MSGSessioniPhoneViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddPatientViewController.h"
#import "MessagingViewController.h"
#import "MessagingTableViewCell.h"
#import "MSGPatientGridCell.h"
#import "MSGSession.h"
#import "Chameleon.h"
#import "PatientRecordAboutCell.h"

@class MSGSessioniPhoneViewController;             //define class, so protocol can see MyClass
@protocol MSGSessioniPhoneDelegate <NSObject>   //define delegate protocol
- (void) refreshPationInfo2;  //define delegate method to be implemented within another class
- (void) declinedSession;
- (void) acceptedSession:(MSGSession *)patientInfo;
- (void) visitSession:(MSGSession *)patientInfo;
- (void) visitClosedSession:(MSGSession *)patientInfo;
@end



@interface MSGSessioniPhoneViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *profileIMG;
    IBOutlet UILabel *noteText;
    IBOutlet UILabel *emailText;
    IBOutlet UILabel *sessionStatus;
    IBOutlet UILabel *fromLabel;
    
    IBOutlet UIButton *acceptButton;
    IBOutlet UIButton *declineButton;
    IBOutlet UIButton *visitButton;
    
    IBOutlet UITableView *menuTable;
    
}

@property (nonatomic, retain) MSGSession *msgSession;
@property (nonatomic, weak) id <MSGSessioniPhoneDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *profIMG2;

@end
