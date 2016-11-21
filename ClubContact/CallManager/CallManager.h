//
//  CallManager.h
//  QBRTCChatSemple
//
//  Created by Andrey Ivanov on 17.12.14.
//  Copyright (c) 2014 QuickBlox Team. All rights reserved.
//

#import "BaseViewController.h"
#import "IncomingCallViewController.h"
#import "Call2ViewController.h"
#import "ContainerViewController.h"

@interface CallManager : NSObject

<QBRTCClientDelegate>



@property (strong, nonatomic) QBUUser *initiatedUser;


+ (instancetype)instance;

//- (void)callToUsers:(NSArray *)users withConferenceType:(QBConferenceType)conferenceType;
- (void)callToUsers:(NSArray *)users withConferenceType:(QBRTCConferenceType)conferenceType;;

- (void)incominingCall:(QBRTCSession *)session userInfo:(NSDictionary *)userInfo;

- (void)closeThisSession:(QBRTCSession *)session;

//- (void)closeThisSession:(QBRTCSession *)session;
- (void)openCallScreen;


@end
