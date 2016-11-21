//
//  DocMSGSessioniPhone.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/22/15.
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
#import "Doctors.h"
@class DocMSGSessioniPhone;             //define class, so protocol can see MyClass
@protocol DocMSGSessioniPhoneDelegate <NSObject>   //define delegate protocol
- (void) refreshPationInfo2;  //define delegate method to be implemented within another class
- (void) declinedSession;
- (void) acceptedSession:(MSGSession *)patientInfo;
- (void) visitSession:(MSGSession *)patientInfo;
@end

@interface DocMSGSessioniPhone : BaseViewController <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *profileIMG;
     IBOutlet UIImageView *profileIMG2;
    IBOutlet UILabel *noteText;
    IBOutlet UILabel *emailText;
    IBOutlet UILabel *sessionStatus;
    
    IBOutlet UIButton *acceptButton;
    IBOutlet UIButton *declineButton;
    IBOutlet UIButton *visitButton;
     IBOutlet UITableView *menuTable;
    
    Doctors *doc;
}

@property (nonatomic, retain) MSGSession *msgSession;
@property (nonatomic, weak) id <DocMSGSessioniPhoneDelegate> delegate;
@property (nonatomic) BOOL isMySession;





@end
