//
//  MSGSessionViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/28/15.
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

@class MSGSessionViewController;             //define class, so protocol can see MyClass
@protocol MSGSessionDelegate <NSObject>   //define delegate protocol
- (void) refreshPationInfo2;  //define delegate method to be implemented within another class
- (void) declinedSession;
- (void) acceptedSession:(MSGSession *)patientInfo;
- (void) visitSession:(MSGSession *)patientInfo;
- (void) visitClosedSession:(MSGSession *)patientInfo;
@end

@interface MSGSessionViewController : BaseViewController{

    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *profileIMG;
    IBOutlet UITextView *noteText;
    IBOutlet UILabel *emailText;
    IBOutlet UILabel *sessionStatus;
    
    IBOutlet UIButton *acceptButton;
    IBOutlet UIButton *declineButton;
    IBOutlet UIButton *visitButton;
}

@property (nonatomic, retain) MSGSession *msgSession;
@property (nonatomic, weak) id <MSGSessionDelegate> delegate;

@end
