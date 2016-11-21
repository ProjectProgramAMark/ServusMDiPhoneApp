//
//  CallViewController.m
//  QBRTCChatSemple
//
//  Created by Andrey Ivanov on 11.12.14.
//  Copyright (c) 2014 QuickBlox Team. All rights reserved.
//

#import "CallViewController.h"
#import "OpponentCollectionViewCell2.h"
#import "UserPicView.h"
#import "ConnectionManager.h"
#import "SVProgressHUD.h"
#import "IAButton.h"
#import "QMSoundManager.h"
#import "CornerView.h"
#import "CallManager.h"
#import "LocalVideoView.h"
#import "Settings.h"

NSString *const kOpponentCollectionViewCellIdentifier = @"OpponentCollectionViewCellIdentifier";
const NSTimeInterval kRefreshTimeInterval = 1.f;

@interface CallViewController ()

<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, QBRTCClientDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *opponentsCollectionView;
@property (weak, nonatomic) IBOutlet LocalVideoView *opponentVideoView;
@property (weak, nonatomic) IBOutlet LocalVideoView *localVideoView;

@property (weak, nonatomic) IBOutlet IAButton *microphoneBtn;
@property (weak, nonatomic) IBOutlet IAButton *switchAudioOutputBtn;
@property (weak, nonatomic) IBOutlet IAButton *enableVideoBtn;
@property (weak, nonatomic) IBOutlet IAButton *declineBtn;
@property (weak, nonatomic) IBOutlet CornerView *markerView;

@property (weak, nonatomic) IBOutlet UILabel *callTimeLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *micItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *audioOutputItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *declineItem;

@property (weak, nonatomic) IBOutlet UIButton *switchCameraBtn;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (strong, nonatomic) NSIndexPath *selectedItemIndexPath;

@property (assign, nonatomic) NSTimeInterval timeDuration;
@property (strong, nonatomic) NSTimer *callTimer;
@property (assign, nonatomic) NSTimer *beepTimer;
@property (strong, nonatomic) QBRTCCameraCapture *cameraCapture;
@property (strong, nonatomic) NSMutableDictionary *videoViews;

@end

@implementation CallViewController

@synthesize session;

- (void)dealloc {
    //NSLog(@"%@ - %@",  NSStringFromSelector(_cmd), self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureGUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [QBRTCClient.instance addDelegate:self];
    QBUUser *caller  = [ConnectionManager.instance userWithID:self.session.initiatorID];
   // QBUUser *caller  = [ConnectionManager.instance userWithID:CallManager.session.callerID ];
   // QBUUser *caller  = [AppDelegate sharedInstance].userQB;
    NSLog(@"User %@", self.session.initiatorID );
    NSMutableArray *usersIDS = self.session.opponentsIDs.mutableCopy;
  //  NSNumber *me = @([AppDelegate sharedInstance].userQB.ID);
   // [usersIDS removeObject:me];
   //  NSLog(@"User2 %@", [usersIDS objectAtIndex:0] );
    
    
    
    if (self.session.conferenceType == QBRTCConferenceTypeVideo) {
        
        Settings *settings = Settings.instance;
        self.cameraCapture = [[QBRTCCameraCapture alloc] initWithVideoFormat:settings.videoFormat
                                                                    position:settings.preferredCameraPostion];
        [self.cameraCapture startSession];
    }
    
    
   //  [QBRTCSoundRouter.instance initialize];
    
    
    [QBRequest  userWithID:[self.session.initiatorID integerValue]  successBlock:^(QBResponse *response, QBUUser *user) {
       
    
        if (ConnectionManager.instance.me.ID == user.ID) {
            [self startCall];
            
        } else {
            self.users = [NSMutableArray arrayWithObjects:user, nil];
            [self acceptCall];
        }
        
        
        
       // [[[AppDelegate sharedInstance].userQB.ID ] isEqual:user.ID] ? [self startCall] : [self acceptCall];
        [self.opponentsCollectionView reloadData];

    } errorBlock:^(QBResponse *response) {
        NSLog(@"error: %@", response.error);
        [self.callTimer invalidate];
        self.callTimer = nil;
        
        [self.session hangUp:@{@"hangup" : @"hang up"}];
        
    }];
    
     [QBRTCSoundRouter.instance initialize];
    if (self.session.conferenceType == QBRTCConferenceTypeAudio) {
        [QBRTCSoundRouter instance].currentSoundRoute =  QBRTCSoundRouteReceiver;//QBSoundRouteReceiver;
    }
    
    

  //  [ConnectionManager.instance.me isEqual:caller] ? [self startCall] : [self acceptCall];

 //   [self.opponentsCollectionView reloadData];
}

- (void)startCall {
    
    //self.users = [ConnectionManager.instance usersWithIDS:self.session.opponents];
    //Start call
    
    //Begin play calling sound
    self.beepTimer = [NSTimer scheduledTimerWithTimeInterval:[QBRTCConfig dialingTimeInterval]
                                                      target:self
                                                    selector:@selector(playCallingSound:)
                                                    userInfo:nil
                                                     repeats:YES];
    [self performSelector:@selector(playCallingSound:) withObject:nil];
  //  [self playCallingSound:nil];
    
    
    self.users  = [NSArray arrayWithObject:[AppDelegate sharedInstance].docQB];
     NSDictionary *userInfo = @{@"startCall" : @"userInfo"};
    [self.session startCall:userInfo];

   
    
}

- (void)acceptCall {
    
    [QMSysPlayer stopAllSounds];
    
    NSMutableArray *usersIDS = self.session.opponentsIDs.mutableCopy;
    NSNumber *me = @(ConnectionManager.instance.me.ID);
    [usersIDS removeObject:me];
    [usersIDS addObject:self.session.initiatorID];
    
   //  AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
 //   self.users =  [ConnectionManager.instance usersWithIDS:usersIDS];
   // self.users = [Condition d]
    //self.users =
    
    if (self.session.conferenceType == QBRTCConferenceTypeAudio) {
        [QBRTCSoundRouter instance].currentSoundRoute = QBRTCSoundRouteReceiver;
    }
    
    //Accept call
   // NSDictionary *userInfo = @{@"accept" : @"hello"};
    NSDictionary *userInfo = @{@"acceptCall" : @"userInfo"};
    [self.session acceptCall:userInfo];
}

- (void)configureGUI {
    
    [self configureNavigationBar];
    [self configureLocalVideoView];
    [self configureToolBar];
    
    self.markerView.fontSize = 15;
    self.callTimeLabel.text = @"";
    self.callTimeLabel.hidden = YES;
    self.switchCameraBtn.hidden = YES;
    self.localVideoView.hidden = YES;
   // self.opponentVideoView.skipBlackFrames = YES;
    //Default selection
    self.selectedItemIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self viewWillTransitionToSize:self.view.frame.size];
}

- (void)configureNavigationBar {
    
    self.title = [NSString stringWithFormat:@"Logged in as %@", ConnectionManager.instance.me.fullName];
    
    __weak __typeof(self)weakSelf = self;
    [self setDefaultBackBarButtonItem:^{
        
      /*  [weakSelf.navigationController dismissViewControllerAnimated:YES
                                                          completion:nil];*/
    }];
}

- (void)configureLocalVideoView {
    // drop shadow

    [self.localVideoView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.localVideoView.layer setShadowOpacity:0.5];
    [self.localVideoView.layer setShadowRadius:5.0];
    [self.localVideoView.layer setShadowOffset:CGSizeMake(5.0, 5.0)];
  //  self.localVideoView.skipBlackFrames = YES;
}

- (void)configureToolBar {
    //Configure toolbar
    [self.toolbar setBackgroundImage:[[UIImage alloc] init]
                  forToolbarPosition:UIToolbarPositionAny
                          barMetrics:UIBarMetricsDefault];
    
    [self.toolbar setShadowImage:[[UIImage alloc] init]
              forToolbarPosition:UIToolbarPositionAny];
    
    UIColor *gSelected = [UIColor colorWithWhite:0.502 alpha:0.640];
    UIColor *redBG = [UIColor colorWithRed:0.906 green:0.000 blue:0.191 alpha:0.8];
    UIColor *redSelected = [UIColor colorWithRed:0.916 green:0.668 blue:0.683 alpha:1.f];
    UIColor *bg = [UIColor colorWithWhite:1.000 alpha:0.840];
    //Configure buttons
    [self configureAIButton:self.declineBtn
              withImageName:@"decline"
                    bgColor:redBG
              selectedColor:redSelected];
    
    [self configureAIButton:self.microphoneBtn
              withImageName:@"mute"
                    bgColor:bg
              selectedColor:gSelected];
    self.microphoneBtn.isPushed = YES;
    
    [self configureAIButton:self.switchAudioOutputBtn
              withImageName:@"dynamic"
                    bgColor:bg
              selectedColor:gSelected];
    self.switchAudioOutputBtn.isPushed = YES;
    
    if (self.session.conferenceType == QBRTCConferenceTypeAudio) {
        
        UIBarButtonItem *fs =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                      target:nil
                                                      action:nil];
        //Update tool bar
        NSArray *items = @[fs, self.micItem, fs, self.audioOutputItem, fs, self.declineItem, fs];
        [self.toolbar setItems:items];
    }
    else {
        
        [self configureAIButton:self.enableVideoBtn
                  withImageName:@"video"
                        bgColor:bg
                  selectedColor:gSelected];
        
        self.enableVideoBtn.isPushed = YES;
    }
}

#pragma mark - Actions

- (IBAction)pressMicBtn:(IAButton *)sender {
    
    self.session.localMediaStream.audioTrack.enabled = !self.session.localMediaStream.audioTrack.enabled;
}

- (IBAction)pressEnableVideoBtn:(IAButton *)sender {
    
    self.session.localMediaStream.videoTrack.enabled = !self.session.localMediaStream.videoTrack.enabled;
    self.switchCameraBtn.hidden = !self.session.localMediaStream.videoTrack.enabled;
}

- (IBAction)pressHandUpBtn:(IAButton *)sender {
    
    [self.callTimer invalidate];
    self.callTimer = nil;
    
    [self.session hangUp:@{@"hangup" : @"hang up"}];
    //self.session = nil;
    
  /*  [QBRTCSoundRouter.instance deinitialize];
    QBUUser *user = self.users[0];
    NSNumber *userID = @(user.ID);
    QBRTCVideoTrack *videoTrack = [self.session remoteVideoTrackWithUserID:userID];
    self.opponentVideoView = nil;
    videoTrack  = nil;
    
    OpponentCollectionViewCell *cell = (OpponentCollectionViewCell *)[self.opponentsCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell  stopVideoTrack];
  //  [QBRTCClient deinitializeRTC];*/
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)pressSwitchCameraBtn:(UIButton *)sender {
    
    /*sender.hidden = YES;
    __weak __typeof(self)weakSelf = self;
    [self.session switchCamera:^(BOOL isFrontCamera) {
        
        sender.hidden = NO;
        NSLog(@"%ld", (long) weakSelf.session.currentCaptureDevicePosition);
    }];*/
    
    AVCaptureDevicePosition position = [self.cameraCapture currentPosition];
    AVCaptureDevicePosition newPosition = position == AVCaptureDevicePositionBack ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    
    if ([self.cameraCapture hasCameraForPosition:newPosition]) {
        
        CATransition *animation = [CATransition animation];
        animation.duration = .5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = @"oglFlip";
        
        if (position == AVCaptureDevicePositionFront) {
            
            animation.subtype = kCATransitionFromRight;
        }
        else if(position == AVCaptureDevicePositionBack) {
            
            animation.subtype = kCATransitionFromLeft;
        }
        
        [self.localVideoView.superview.layer addAnimation:animation forKey:nil];
        
        [self.cameraCapture selectCameraPosition:newPosition];
    }
    
}


- (IBAction)pressSwitchAudioOutput:(id)sender {
    
    QBRTCSoundRoute route = [QBRTCSoundRouter instance].currentSoundRoute;
    
    if (route == QBRTCSoundRouteSpeaker ) {

        [QBRTCSoundRouter instance].currentSoundRoute =  QBRTCSoundRouteReceiver;//QBSoundRouteReceiver;
    }
    else {
        
        [QBRTCSoundRouter instance].currentSoundRoute = QBRTCSoundRouteSpeaker;
    }
}



- (UIView *)videoViewWithOpponentID:(NSNumber *)opponentID {
    
    if (self.session.conferenceType == QBRTCConferenceTypeAudio) {
        return nil;
    }
    
    if (!self.videoViews) {
        self.videoViews = [NSMutableDictionary dictionary];
    }
    
    id result = self.videoViews[opponentID];
    
    /*if (UsersDataSource.instance.currentUser.ID == opponentID.integerValue) {//Local preview
        
        if (!result) {
            
            LocalVideoView *localVideoView = [[LocalVideoView alloc] initWithPreviewlayer:self.cameraCapture.previewLayer];
            self.videoViews[opponentID] = localVideoView;
            localVideoView.delegate = self;
            self.localVideoView = localVideoView;
            return localVideoView;
        }
    }
    else {//Opponents
        
        QBRTCRemoteVideoView *remoteVideoView = nil;
        
        QBRTCVideoTrack *remoteVideoTrak = [self.session remoteVideoTrackWithUserID:opponentID];
        
        if (!result && remoteVideoTrak) {
            
            remoteVideoView = [[QBRTCRemoteVideoView alloc] initWithFrame:self.view.bounds];
            self.videoViews[opponentID] = remoteVideoView;
            result = remoteVideoView;
        }
        
        [remoteVideoView setVideoTrack:remoteVideoTrak];
        
        return result;
    }*/
    
    QBRTCRemoteVideoView *remoteVideoView = nil;
    
    QBRTCVideoTrack *remoteVideoTrak = [self.session remoteVideoTrackWithUserID:opponentID];
    
    if (!result && remoteVideoTrak) {
        
        remoteVideoView = [[QBRTCRemoteVideoView alloc] initWithFrame:self.view.bounds];
        self.videoViews[opponentID] = remoteVideoView;
        result = remoteVideoView;
    }
    
    [remoteVideoView setVideoTrack:remoteVideoTrak];
    
    return result;
   
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return self.users.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OpponentCollectionViewCell2 *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:kOpponentCollectionViewCellIdentifier
                                              forIndexPath:indexPath];
    
    QBUUser *user = self.users[indexPath.row];
    
    NSNumber *userID = @(user.ID);
    QBRTCVideoTrack *videoTrack = [self.session remoteVideoTrackWithUserID:userID];
    
    //User connection indicator
    cell.connectionState = [self.session connectionStateForUser:userID];
    
    //User marker
    [cell setColorMarkerText:[NSString stringWithFormat:@"%lu", (unsigned long)user.index + 1]
                    andColor:user.color];
    //Selected
    if (self.selectedItemIndexPath != nil && [indexPath compare:self.selectedItemIndexPath] == NSOrderedSame) {
        
        cell.selected = YES;
       // [self.opponentVideoView setVideoTrack:videoTrack];
            [cell setVideoView:[self videoViewWithOpponentID:@(user.ID)]];
        self.markerView.bgColor = user.color;
        self.markerView.title = user.fullName;
    }
    else {
        
        cell.selected = NO;
        [cell setVideoView:[self videoViewWithOpponentID:@(user.ID)]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithObject:indexPath.copy];
    
    if (self.selectedItemIndexPath) {
        
        if ([indexPath compare:self.selectedItemIndexPath] == NSOrderedSame){
            return;
        }
        else {
            
            [indexPaths addObject:self.selectedItemIndexPath.copy];
            self.selectedItemIndexPath = indexPath.copy;
        }
    }
    else {
        
        self.selectedItemIndexPath = indexPath.copy;
    }
    
    [collectionView reloadItemsAtIndexPaths:indexPaths];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(110, 110);
}

#pragma mark - Transition to size

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        // Place code here to perform animations during the rotation. You can leave this block empty if not necessary.
        
        [self viewWillTransitionToSize:size];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size  {
    
    [self.opponentsCollectionView.collectionViewLayout invalidateLayout];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    if (size.width > size.height) {
        
        self.opponentVideoView.contentMode = UIViewContentModeScaleAspectFit;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    }
    else {
        
        self.opponentVideoView.contentMode = UIViewContentModeScaleAspectFill;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    
    [self.opponentsCollectionView setCollectionViewLayout:flowLayout];
}

- (NSIndexPath *)indexPathAtUserID:(NSNumber *)userID {
    
    QBUUser *user = [ConnectionManager.instance userWithID:userID];
    NSUInteger idx = [self.users indexOfObject:user];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
    
    return indexPath;
}

#pragma mark - QBWebRTCChatDelegate


- (void)session:(QBRTCSession *)session initializedLocalMediaStream:(QBRTCMediaStream *)mediaStream {
    
    session.localMediaStream.videoTrack.videoCapture = self.cameraCapture;
}


/**
 * Called in case when you are calling to user, but he hasn't answered
 */
- (void)session:(QBRTCSession *)session userDoesNotRespond:(NSNumber *)userID {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    }
}

- (void)session:(QBRTCSession *)session acceptedByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    }
}

/**
 * Called in case when opponent has rejected you call
 */
- (void)session:(QBRTCSession *)session rejectedByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    }
}

/**
 *  Called in case when opponent hung up
 */
- (void)session:(QBRTCSession *)session hungUpByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    }
}

/**
 *  Called in case when receive remote video track from opponent
 */

- (void)session:(QBRTCSession *)session receivedRemoteVideoTrack:(QBRTCVideoTrack *)videoTrack fromUser:(NSNumber *)userID {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            
            QBRTCRemoteVideoView *opponentVideoView = (id)[self videoViewWithOpponentID:userID];
            [cell setVideoView:opponentVideoView];
        }];
    }
}

/**
 *  Called in case when connection initiated
 */
- (void)session:(QBRTCSession *)session startedConnectionToUser:(NSNumber *)userID {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    }
}

/**
 *  Called in case when connection is established with opponent
 */
- (void)session:(QBRTCSession *)session connectedToUser:(NSNumber *)userID {
    
    NSParameterAssert(self.session == session);
    
    if (self.beepTimer) {
        
        [self.beepTimer invalidate];
        self.beepTimer = nil;
        [QMSysPlayer stopAllSounds];
    }
    
    if (!self.callTimer) {
        
        self.callTimer = [NSTimer scheduledTimerWithTimeInterval:kRefreshTimeInterval
                                                          target:self
                                                        selector:@selector(refreshCallTime:)
                                                        userInfo:nil
                                                         repeats:YES];
    }
    
    [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
        cell.connectionState = [self.session connectionStateForUser:userID];
    }];
}

/**
 *  Called in case when connection state changed
 */
- (void)session:(QBRTCSession *)session connectionClosedForUser:(NSNumber *)userID {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
            [self.videoViews removeObjectForKey:userID];
            [cell setVideoView:nil];
        }];
    }
}

/**
 *  Called in case when disconnected from opponent
 */
- (void)session:(QBRTCSession *)session disconnectedFromUser:(NSNumber *)userID {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    }
}

/**
 *  Called in case when disconnected by timeout
 */
- (void)session:(QBRTCSession *)session disconnectedByTimeoutFromUser:(NSNumber *)userID {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    }
}

/**
 *  Called in case when connection failed with user
 */
- (void)session:(QBRTCSession *)session connectionFailedWithUser:(NSNumber *)userID {
    
    if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    }
}


/*
- (void)session:(QBRTCSession *)session userDoesNotRespond:(NSNumber *)userID {
    
    if (session == self.session) {
       // [self reloadWithUserID:userID];
    }
}

- (void)session:(QBRTCSession *)session acceptByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo {
    
}


- (void)session:(QBRTCSession *)session rejectedByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo {
    
    if (session == self.session) {

      //  [self reloadWithUserID:userID];
        NSLog(@"%@", userInfo);
    }
}


- (void)session:(QBRTCSession *)session hungUpByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo {
    
    if (self.session == session) {
        
       // [self reloadWithUserID:userID];
        NSLog(@"%@", userInfo);
    }
}


- (void)session:(QBRTCSession *)session didReceiveLocalVideoTrack:(QBRTCVideoTrack *)videoTrack {
    
 //   NSAssert(self.session == session, @"Need update this case");
    self.switchCameraBtn.hidden = NO;
    self.localVideoView.hidden = NO;
   // [self.localVideoView setVideoTrack:videoTrack];
}



- (void)session:(QBRTCSession *)session didReceiveRemoteVideoTrack:(QBRTCVideoTrack *)videoTrack fromUser:(NSNumber *)userID {
    
   // NSAssert(self.session == session, @"Need update this case");
    [self reloadWithUserID:userID];
}



- (void)session:(QBRTCSession *)session startConnectionToUser:(NSNumber *)userID {
    
   // NSAssert(self.session == session, @"Need update this case");
    [self reloadWithUserID:userID];
}



- (void)session:(QBRTCSession *)session connectedToUser:(NSNumber *)userID {
    
 //   NSAssert(self.session == session, @"Need update this case");
   
    if (self.beepTimer) {
        
        [self.beepTimer invalidate];
        self.beepTimer = nil;
        [QMSysPlayer stopAllSounds];
    }
    
    if (!self.callTimer) {
        
        self.callTimeLabel.hidden = NO;
        self.callTimer = [NSTimer scheduledTimerWithTimeInterval:kRefreshTimeInterval
                                                          target:self
                                                        selector:@selector(refreshCallTime:)
                                                        userInfo:nil
                                                         repeats:YES];
    }
    
    [self reloadWithUserID:userID];
}


- (void)session:(QBRTCSession *)session connectionClosedForUser:(NSNumber *)userID {
    
  //  NSAssert(self.session == session, @"Need update this case");
//    [self reloadWithUserID:userID];
}



- (void)session:(QBRTCSession *)session disconnectedFromUser:(NSNumber *)userID {
    
  //  NSAssert(self.session == session, @"Need update this case");
   // [self reloadWithUserID:userID];
}



- (void)session:(QBRTCSession *)session disconnectTimeoutForUser:(NSNumber *)userID {
    
 //   NSAssert(self.session == session, @"Need update this case");
  //  [self reloadWithUserID:userID];
}


- (void)session:(QBRTCSession *)session connectionFailedWithUser:(NSNumber *)userID {
    
//    NSAssert(self.session == session, @"Need update this case");
   // [self reloadWithUserID:userID];
}


- (void)sessionWillClose:(QBRTCSession *)session {
    
    if (session == self.session) {
        
         [QBRTCSoundRouter.instance deinitialize];
        
        if (self.beepTimer) {
            
            [self.beepTimer invalidate];
            self.beepTimer = nil;
            [QMSysPlayer stopAllSounds];
        }
        
        [self.callTimer invalidate];
        self.callTimer = nil;
        
        self.toolbar.userInteractionEnabled = NO;
        self.localVideoView.hidden = YES;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.toolbar.alpha = 0.4;
        }];
        
       // self.toolbar.alpha = 0.4;
        
        self.callTimeLabel.text = [NSString stringWithFormat:@"End - %@", [self stringWithTimeDuration:self.timeDuration]];
      //  [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)reloadWithUserID:(NSNumber *)userID {
    
    @try {
        NSIndexPath *indexPath = [self indexPathAtUserID:userID];
        [self.opponentsCollectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
    @catch (NSException *exception) {
          NSLog(@"User change");
    }
    @finally {
        
    }
    
    
}
*/
#pragma mark - Timers actions

- (void)playCallingSound:(id)sender {
    
    [QMSoundManager playCallingSound];
}

- (void)refreshCallTime:(id)sender {
    
    @try {
        self.timeDuration += kRefreshTimeInterval;
        self.callTimeLabel.text = [NSString stringWithFormat:@"Call time - %@", [self stringWithTimeDuration:self.timeDuration]];
    }
    @catch (NSException *exception) {
        NSLog(@"Loop Exception");
    }
    @finally {
        
    }
   
}

- (NSString *)stringWithTimeDuration:(NSTimeInterval )timeDuration {
    
    NSInteger minutes = timeDuration / 60;
    NSInteger seconds = (NSInteger)timeDuration % 60;
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld:%02ld", (long)minutes, (long)seconds];
    
    return timeStr;
}

- (void)performUpdateUserID:(NSNumber *)userID block:(void(^)(OpponentCollectionViewCell2 *cell))block {
    
    NSIndexPath *indexPath = [self indexPathAtUserID:userID];
    OpponentCollectionViewCell2 *cell = (id)[self.opponentsCollectionView cellForItemAtIndexPath:indexPath];
    block(cell);
}

@end
