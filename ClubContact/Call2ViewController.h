//
//  Call2ViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/25/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class QBRTCSession;

@interface Call2ViewController : BaseViewController

@property (strong, nonatomic) QBRTCSession *session;
@property (strong, nonatomic) QBUUser *initiatedUser;
@property (strong, nonatomic) QBUUser *otherUser;

@property (weak, nonatomic) IBOutlet UIView *videoViewContainer;
@property (weak, nonatomic) IBOutlet UIView *videoView2;
@property (assign, nonatomic) QBRTCConnectionState connectionState2;


@end
