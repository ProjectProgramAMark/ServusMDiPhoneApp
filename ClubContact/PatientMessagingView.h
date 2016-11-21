//
//  PatientMessagingView.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Messages.h"
#import "UIImageView+WebCache.h"
#import "Doctors.h"

@class PatientMessagingView;             //define class, so protocol can see MyClass
@protocol PatientMessagingDelegate <NSObject>   //define delegate protocol
- (void) refreshPatientsInfo3;  //define delegate method to be implemented within another class
@end

@interface PatientMessagingView : BaseViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, UITextViewDelegate> {
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    BOOL isClosedShow;
}

@property (weak, nonatomic) IBOutlet UITableView *chattable;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIView *msgInPutView;
@property (weak, nonatomic) IBOutlet UIButton *sendChatBtn;
@property (weak, nonatomic) IBOutlet UITextView *messageField2;

@property (nonatomic) NSString *patientID;
@property (nonatomic, weak) id <PatientMessagingDelegate> delegate;
@property (nonatomic, retain) MSGSession *msgSession;
@property (nonatomic) BOOL isClosedSessionOpen;

- (IBAction)sendMessageNow:(id)sender;
@property (nonatomic, retain) Doctors *doctorV2;

@end
