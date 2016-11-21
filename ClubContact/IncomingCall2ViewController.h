//
//  IncomingCall2ViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/25/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol IncomingCall2ViewControllerDelegate;

@interface IncomingCall2ViewController : BaseViewController

@property (weak, nonatomic) id <IncomingCall2ViewControllerDelegate> delegate;

@property (strong, nonatomic) QBRTCSession *session;
@property (strong, nonatomic) QBUUser *initiatedUser;

@end

@protocol IncomingCall2ViewControllerDelegate <NSObject>

- (void)incomingCallViewController:(IncomingCall2ViewController *)vc didAcceptSession:(QBRTCSession *)session;
- (void)incomingCallViewController:(IncomingCall2ViewController *)vc didRejectSession:(QBRTCSession *)session;

@end
