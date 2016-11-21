//
//  DocChatViewViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/13/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Messages.h"
#import "UIImageView+WebCache.h"
#import "Doctor.h"

@class DocChatViewViewController;             //define class, so protocol can see MyClass
@protocol DocChatViewDelegate <NSObject>   //define delegate protocol
- (void) refreshPatientsInfo3;  //define delegate method to be implemented within another class
@end

@interface DocChatViewViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chattable;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIView *msgInPutView;
@property (weak, nonatomic) IBOutlet UIButton *sendChatBtn;
@property (weak, nonatomic) IBOutlet UITextView *messageField2;

@property (nonatomic) NSString *patientID;
@property (nonatomic, weak) id <DocChatViewDelegate> delegate;
@property (nonatomic, retain) MSGSession *msgSession;

- (IBAction)sendMessageNow:(id)sender;


@end
