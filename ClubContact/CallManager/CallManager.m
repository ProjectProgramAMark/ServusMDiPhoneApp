//
//  CallManager.m
//  QBRTCChatSemple
//
//  Created by Andrey Ivanov on 17.12.14.
//  Copyright (c) 2014 QuickBlox Team. All rights reserved.
//

#import "CallManager.h"
#import "IncomingCallViewController.h"
#import "Call2ViewController.h"
#import "ContainerViewController.h"
#import "ConnectionManager.h"
#import "QMSoundManager.h"
#import "SVProgressHUD.h"
#import "IncomingCall2ViewController.h"

NSString *const kCallViewControllerID = @"CallViewController";
NSString *const kIncomingCallViewControllerID = @"IncomingCallViewController";
NSString *const kContainerViewControllerID = @"ContainerViewController";

@interface CallManager () <IncomingCall2ViewControllerDelegate> {
    
}

@property (weak, nonatomic, readonly) UIViewController *rootViewController;
@property (strong, nonatomic, readonly) UIStoryboard *mainStoryboard;
@property (strong, nonatomic) ContainerViewController *containerVC;
@property (strong, nonatomic) QBRTCSession *session;
@property (nonatomic, strong) Call2ViewController *callVC2;
@property (nonatomic, strong) IncomingCallViewController *incomingVC2;
@end

@implementation CallManager

@dynamic rootViewController;

+ (instancetype)instance {
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _mainStoryboard =
        [UIStoryboard storyboardWithName:@"iPad"
                                  bundle:[NSBundle mainBundle]];
    }
    
    return self;
}

#pragma mark - RootViewController

- (UIViewController *)rootViewController {
    
    return UIApplication.sharedApplication.delegate.window.rootViewController;
}

#pragma mark - Public methods


- (void)callToUsers:(NSArray *)users withConferenceType:(QBRTCConferenceType)conferenceType {
    
    if (self.session) {
        //return;
         self.session = nil;
        //[self.session hangUp:nil];
    }
       [QBRTCClient.instance addDelegate:self];
    
    
    [QBRTCSoundRouter.instance initialize];
   
    
    NSArray *opponentsIDs = [ConnectionManager.instance idsWithUsers:users];
    
    QBRTCSession *session =
    [QBRTCClient.instance createNewSessionWithOpponents:opponentsIDs  withConferenceType:conferenceType];
    
    if (session) {
        NSLog(@"Called ID %@", session.initiatorID);
        self.session = session;
        
        
       
        Call2ViewController *callVC =
        [[Call2ViewController alloc] init];
        
        self.initiatedUser = ConnectionManager.instance.me;
        
        callVC.initiatedUser = self.initiatedUser;
        callVC.session = self.session;
        callVC.otherUser = [users objectAtIndex:0];
      
        [self.rootViewController presentViewController:callVC animated:NO completion:nil];
    }
    else {
        
        [SVProgressHUD showErrorWithStatus:@"Creating new session - Failure"];
    }
}

/*- (void)callToUsers:(NSArray *)users withConferenceType:(QBConferenceType)conferenceType {
    
    if (self.session) {
        return;
       // self.session = nil;
        //[self.session hangUp:nil];
    }
 //   [QBRTCClient.instance addDelegate:self];
    
    
    [QBSoundRouter.instance initialize];
    
    NSArray *opponentsIDs = [ConnectionManager.instance idsWithUsers:users];
    
    QBRTCSession *session =
    [QBRTCClient.instance createNewSessionWithOpponents:opponentsIDs  withConferenceType:conferenceType];
    
    if (session) {
        NSLog(@"Called ID %@", session.callerID);
        self.session = session;
        
 
        CallViewController *callVC =
        [self.mainStoryboard instantiateViewControllerWithIdentifier:kCallViewControllerID];
        
        callVC.session = self.session;
      //  NSAssert(!self.containerVC, @"Muste be nil");
       // self.containerVC = nil;
       // self.containerVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:kContainerViewControllerID];
       // self.containerVC.viewControllers = @[callVC];
        //self.containerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
       
        [self.rootViewController presentViewController:callVC animated:NO completion:nil];
    }
    else {
        
        [SVProgressHUD showErrorWithStatus:@"Creating new session - Failure"];
    }
}*/


- (void)callToUsers:(NSArray *)users {
    
  
}


- (void)incominingCall:(QBRTCSession *)session userInfo:(NSDictionary *)userInfo {
    if (self.session.initiatorID != nil) {
        
        //[session rejectCall:@{@"reject" : @"busy"}];
        return;
    }
    
    self.session = session;
    
       [QBRTCSoundRouter.instance initialize];
/*
#warning Test bg mode for p2p
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        
        [self.session acceptCall:nil];
    }
    else {*/
    NSLog(@"Initiated User %li", (long)[self.session.initiatorID  integerValue] );
    
    [QBRequest  userWithID:[self.session.initiatorID  integerValue]  successBlock:^(QBResponse *response, QBUUser *user) {
        
        [QMSoundManager playRingtoneSound];
        
        IncomingCall2ViewController *incomingVC = [[IncomingCall2ViewController alloc] init];;
        
        
        
        incomingVC.session = session;
        incomingVC.delegate = self;
        incomingVC.initiatedUser = user;
        self.initiatedUser = user;
        
        [self.rootViewController presentViewController:incomingVC
                                              animated:YES
                                            completion:nil];
        
   
    
       
        
    } errorBlock:^(QBResponse *response) {
        
        
    }];
    
  //  [QMSoundManager playRingtoneSound];
    
/*    IncomingCall2ViewController *incomingVC = [[IncomingCall2ViewController alloc] init];;
    
    
    
    incomingVC.session = session;
    incomingVC.delegate = self;
    incomingVC.initiatedUser = ConnectionManager.instance.me;
    
    [self.rootViewController presentViewController:incomingVC
                                          animated:YES
                                        completion:nil];*/
    
    
    
    
     /*   [QMSoundManager playRingtoneSound];
        
        IncomingCall2ViewController *incomingVC = [[IncomingCall2ViewController alloc] init];;
    
  
        
       incomingVC.session = session;
    incomingVC.delegate = self;
    
    [self.rootViewController presentViewController:incomingVC
                                          animated:YES
                                        completion:nil];*/
    //}

}

#pragma mark - QBWebRTCChatDelegate

- (void)didReceiveNewSession:(QBRTCSession *)session userInfo:(NSDictionary *)userInfo {
    
    
    if (self.session) {
        
        [session rejectCall:@{@"reject" : @"busy"}];
        return;
    }
    
    self.session = session;
    
      [QBRTCSoundRouter.instance initialize];
    
#warning Test bg mode for p2p
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        
        [self.session acceptCall:nil];
    }
    else {
        
        [QMSoundManager playRingtoneSound];
        
        
           NSLog(@"Receive call");
        
     /*   IncomingCallViewController *incomingVC =
        [self.mainStoryboard instantiateViewControllerWithIdentifier:kIncomingCallViewControllerID];
        
        CallViewController *callVC =
        [self.mainStoryboard instantiateViewControllerWithIdentifier:kCallViewControllerID];
        
        NSAssert(!self.containerVC, @"Muste be nil");
        self.containerVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:kContainerViewControllerID];
        self.containerVC.viewControllers = @[incomingVC, callVC];
        
        incomingVC.session = session;
        callVC.session = session;
        
        [self.rootViewController presentViewController:self.containerVC
                                              animated:YES
                                            completion:nil];*/
       /* IncomingCallViewController *incomingVC =
        [self.mainStoryboard instantiateViewControllerWithIdentifier:kIncomingCallViewControllerID];
        
        
        //NSAssert(!self.containerVC, @"Muste be nil");
        // self.containerVC = [self.mainStoryboard instantiateViewControllerWithIdentifier:kContainerViewControllerID];
        // self.containerVC.viewControllers = @[incomingVC2, callVC2];
        
        incomingVC.session = session;
        
        
        [self.rootViewController presentViewController:incomingVC
                                              animated:YES
                                            completion:nil];*/
    }
}

- (void)openCallScreen {
    Call2ViewController *callVC =
    [[Call2ViewController alloc] init];
    callVC.session = self.session;
    callVC.initiatedUser = self.initiatedUser;
    
    [self.rootViewController presentViewController:callVC
                                          animated:YES
                                        completion:nil];
}


- (void)incomingCallViewController:(IncomingCall2ViewController *)vc didAcceptSession:(QBRTCSession *)session {
    Call2ViewController *callVC =
    [[Call2ViewController alloc] init];
    callVC.session = session;
    callVC.initiatedUser = self.initiatedUser;
    
    [self.rootViewController presentViewController:callVC
                                          animated:YES
                                        completion:nil];
}

- (void)incomingCallViewController:(IncomingCall2ViewController *)vc didRejectSession:(QBRTCSession *)session {
     [self.session rejectCall:@{@"reject" : @"busy"}];
    self.session = nil;
}

- (void)sessionWillClose:(QBRTCSession *)session {
    
    NSLog(@"session will close");
}

- (void)sessionDidClose:(QBRTCSession *)session {
       //  self.session = nil;
    if (session == self.session ) {

       /* dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [QBSoundRouter.instance deinitialize];
            self.session = nil;
            [self.containerVC dismissViewControllerAnimated:NO completion:nil];
            self.containerVC = nil;
            NSLog(@"Closing Sucks!!");
        });*/
          //  [QBRTCSoundRouter.instance initialize];
        /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [QBRTCSoundRouter.instance deinitialize];
            self.session = nil;
      
            NSLog(@"Closing Yeah!!");
        });*/
        [QBRTCSoundRouter.instance deinitialize];
        self.session = nil;
       
       // NSLog(@"Closing Sucks!!");
    }
}


- (void)closeThisSession:(QBRTCSession *)session {
    if (session == self.session ) {
        
      /*  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      
            [QBSoundRouter.instance deinitialize];
            self.session = nil;
            [self.containerVC dismissViewControllerAnimated:NO completion:nil];
            self.containerVC = nil;
            NSLog(@"Closing Yeah!!");
        });*/
        [QBRTCSoundRouter.instance deinitialize];
        self.session = nil;
        /*[self.rootViewController dismissViewControllerAnimated:NO completion:^{
         //  self.callVC2 = nil;
         }];*/
        NSLog(@"Closing Yeah!!");
       
       
       /* dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [QBRTCSoundRouter.instance deinitialize];
            self.session = nil;
        
            NSLog(@"Closing Yeah!!");
        });*/
        
        
        
    }

}

- (void)makeContainerNil {
   // EAGLContext* previousContext = [EAGLContext currentContext];
    //self.containerVC = nil;
    //[EAGLContext setCurrentContext: previousContext];
}

@end
