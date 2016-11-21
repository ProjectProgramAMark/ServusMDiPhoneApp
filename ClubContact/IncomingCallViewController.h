//
//  IncomingCallViewController.h
//  QBRTCChatSemple
//
//  Created by Andrey Ivanov on 16.12.14.
//  Copyright (c) 2014 QuickBlox Team. All rights reserved.
//

#import "BaseViewController.h"
#import "CallManager.h"
@interface IncomingCallViewController : BaseViewController

@property (strong, nonatomic) QBRTCSession *session;
@property (strong, nonatomic) QBUUser *initiatedUser;

@end

