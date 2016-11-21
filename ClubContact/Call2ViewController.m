//
//  Call2ViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/25/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "Call2ViewController.h"
#import "ConnectionManager.h"
#import "CallManager.h"
#import "CornerView.h"
#import "LocalVideoView.h"
#import "OpponentCollectionViewCell2.h"
#import "OpponentsFlowLayout.h"
#import "QBButton.h"
#import "QBButtonsFactory.h"
#import "QBToolBar.h"
#import "QMSoundManager.h"
#import "Settings.h"
//#import "SharingViewController.h"
#import "SVProgressHUD.h"
#import "UsersDataSource.h"

NSString *const kOpponentCollectionViewCellIdentifier = @"OpponentCollectionViewCellIdentifier";
NSString *const kSharingViewControllerIdentifier = @"SharingViewController";

const NSTimeInterval kRefreshTimeInterval = 1.f;


@interface Call2ViewController ()

<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, QBRTCClientDelegate, LocalVideoViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *opponentsCollectionView;
@property (weak, nonatomic) IBOutlet QBToolBar *toolbar;

@property (strong, nonatomic) NSIndexPath *selectedItemIndexPath;

@property (assign, nonatomic) NSTimeInterval timeDuration;
@property (strong, nonatomic) NSTimer *callTimer;
@property (assign, nonatomic) NSTimer *beepTimer;

@property (strong, nonatomic) QBRTCCameraCapture *cameraCapture;

@property (strong, nonatomic) NSMutableDictionary *videoViews;

@property (assign, nonatomic, readonly) BOOL isOffer;
@property (weak, nonatomic) UIView *zoomedView;

@property (strong, nonatomic) QBButton *videoEnabled;
@property (weak, nonatomic) LocalVideoView *localVideoView;

@end

@implementation Call2ViewController


@synthesize session;

- (void)dealloc {
    
    NSLog(@"%@ - %@",  NSStringFromSelector(_cmd), self);
}

- (NSNumber *)currentUserID {
    
    return @(ConnectionManager.instance.me.ID);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureGUI];
    
    if (self.session.conferenceType == QBRTCConferenceTypeVideo) {
        
        Settings *settings = Settings.instance;
        self.cameraCapture = [[QBRTCCameraCapture alloc] initWithVideoFormat:settings.videoFormat
                                                                    position:settings.preferredCameraPostion];
        [self.cameraCapture startSession];
    }
    
    QBUUser *initiator; //[UsersDataSource.instance userWithID:self.session.initiatorID];
    
     if (ConnectionManager.instance.me.ID == [self.session.initiatorID intValue]) {
         _isOffer = true;
         initiator = ConnectionManager.instance.me;
     } else {
         _isOffer = false;
     }
    
    ///_isOffer = [UsersDataSource.instance.currentUser isEqual:initiator];
    
    self.view.backgroundColor = self.opponentsCollectionView.backgroundColor = [UIColor colorWithRed:0.1465 green:0.1465 blue:0.1465 alpha:1.0];
    
    [QBRTCClient.instance addDelegate:self];
    
    NSMutableArray *users = [NSMutableArray arrayWithCapacity:self.session.opponentsIDs.count + 1];
   
    [users insertObject:ConnectionManager.instance.me atIndex:0];
    
    
    NSMutableArray *opponents = [[NSMutableArray alloc] init];
    
    
    if (self.initiatedUser.ID != ConnectionManager.instance.me .ID) {
        [opponents addObject:self.initiatedUser];
    } else {
        [opponents addObject:self.otherUser];
    }
    
    
    
    [users addObjectsFromArray:opponents];
    
    self.users = users.copy;
    //[ConnectionManager.instance setUsers:self.users];
   // ConnectionManager.instance.users = self.users;
    [QBRTCSoundRouter.instance initialize];
    
    if (self.isOffer) {
        
        [self startCall];
        
    } else {
        [self acceptCall];
    }
    
    if (self.session.conferenceType == QBRTCConferenceTypeAudio) {
        [QBRTCSoundRouter instance].currentSoundRoute = QBRTCSoundRouteReceiver;
    } else {
        [QBRTCSoundRouter instance].currentSoundRoute = QBRTCSoundRouteSpeaker;
    }
   
    [self updateVideoView];
    
   // [self.opponentsCollectionView reloadData];
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.title = @"Connecting...";
}

- (UIView *)videoViewWithOpponentID:(NSNumber *)opponentID {
    
    if (self.session.conferenceType == QBRTCConferenceTypeAudio) {
        return nil;
    }
    
    if (!self.videoViews) {
        self.videoViews = [NSMutableDictionary dictionary];
    }
    
    id result = self.videoViews[opponentID];
    
    if (ConnectionManager.instance.me.ID == opponentID.integerValue) {//Local preview
        
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
      //  QBRTCAudioTrack *remoteAudiooTrak = [self.session remoteVideoTrackWithUserID:<#(NSNumber *)#>];
        
        if (!result && remoteVideoTrak) {
            
            remoteVideoView = [[QBRTCRemoteVideoView alloc] initWithFrame:self.view.bounds];
            self.videoViews[opponentID] = remoteVideoView;
            result = remoteVideoView;
        }
        
        [remoteVideoView setVideoTrack:remoteVideoTrak];
        // [remoteVideoView setVideoTrack:remoteVideoTrak];
        return result;
    }
    
    return result;
}

- (void)startCall {
    //Begin play calling sound
    self.beepTimer = [NSTimer scheduledTimerWithTimeInterval:[QBRTCConfig dialingTimeInterval]
                                                      target:self
                                                    selector:@selector(playCallingSound:)
                                                    userInfo:nil
                                                     repeats:YES];
    [self playCallingSound:nil];
    //Start call
    NSDictionary *userInfo = @{@"startCall" : @"userInfo"};
    [self.session startCall:userInfo];
    
}

- (void)acceptCall {
    
    [QMSysPlayer stopAllSounds];
    //Accept call
    NSDictionary *userInfo = @{@"acceptCall" : @"userInfo"};
    [self.session acceptCall:userInfo];
}

- (void)configureGUI {
    
    __weak __typeof(self)weakSelf = self;
    
  //  [self.opponentsCollectionView registerClass:[OpponentCollectionViewCell2 class] forCellWithReuseIdentifier:kOpponentCollectionViewCellIdentifier];
    
    [self.opponentsCollectionView registerNib:[UINib nibWithNibName:@"OpponentCollectionViewCell2" bundle:nil] forCellWithReuseIdentifier:kOpponentCollectionViewCellIdentifier];
    
    
    if (self.session.conferenceType == QBRTCConferenceTypeVideo) {
        
        self.videoEnabled = [QBButtonsFactory videoEnable];
        [self.toolbar addButton:self.videoEnabled action: ^(UIButton *sender) {
            
            weakSelf.session.localMediaStream.videoTrack.enabled ^=1;
            weakSelf.localVideoView.hidden = !weakSelf.session.localMediaStream.videoTrack.enabled;
        }];
    }
    
    [self.toolbar addButton:[QBButtonsFactory auidoEnable] action: ^(UIButton *sender) {
        
        weakSelf.session.localMediaStream.audioTrack.enabled ^=1;
    }];
    
    [self.toolbar addButton:[QBButtonsFactory dynamicEnable] action:^(UIButton *sender) {
        
        QBRTCSoundRoute route = [QBRTCSoundRouter instance].currentSoundRoute;
        
        [QBRTCSoundRouter instance].currentSoundRoute =
        route == QBRTCSoundRouteSpeaker ? QBRTCSoundRouteReceiver : QBRTCSoundRouteSpeaker;
    }];
    
    if (self.session.conferenceType == QBRTCConferenceTypeVideo) {
        
        [self.toolbar addButton:[QBButtonsFactory screenShare] action: ^(UIButton *sender) {
            
            /*SharingViewController *sharingVC =
            [weakSelf.storyboard instantiateViewControllerWithIdentifier:kSharingViewControllerIdentifier];
            sharingVC.session = weakSelf.session;
            
            [weakSelf.navigationController pushViewController:sharingVC animated:YES];*/
        }];
    }
    
    [self.toolbar addButton:[QBButtonsFactory decline] action: ^(UIButton *sender) {
        
           [QMSysPlayer stopAllSounds];
        [weakSelf.callTimer invalidate];
        weakSelf.callTimer = nil;
        
        [weakSelf.session hangUp:@{@"hangup" : @"hang up"}];
        [self dismissViewControllerAnimated:true completion:nil];
    }];
    
    [self.toolbar updateItems];
}


- (void)updateVideoView {
    QBUUser *user = self.users[0];
    
    //self.videoView2 = [self videoViewWithOpponentID:@(user.ID)];
    
    [self.videoView2 removeFromSuperview];
    self.videoView2 = [self videoViewWithOpponentID:@(ConnectionManager.instance.me.ID)];
    self.videoView2.frame = _videoViewContainer.bounds;
    [_videoViewContainer addSubview:self.videoView2];
    
    //self.videoView2 = [self videoViewWithOpponentID:@(ConnectionManager.instance.me.ID)];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //return self.users.count;
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OpponentCollectionViewCell2 *cell = (OpponentCollectionViewCell2 *)[collectionView dequeueReusableCellWithReuseIdentifier:kOpponentCollectionViewCellIdentifier
                                                                                 forIndexPath:indexPath];
    
    if (!cell) {
       // cell = [[OpponentCollectionViewCell2 alloc] init ];
    }
    
    /*QBUUser *user = self.users[indexPath.row];
    
    [cell setVideoView:[self videoViewWithOpponentID:@(user.ID)]];
    NSString *markerText = [NSString stringWithFormat:@"%lu", (unsigned long)user.index + 1];
    [cell setColorMarkerText:markerText andColor:user.color];*/
    
    
  //  QBUUser *user = self.users[1];
     if (self.initiatedUser.ID != ConnectionManager.instance.me.ID) {
         [cell setVideoView:[self videoViewWithOpponentID:@(self.initiatedUser.ID)]];
         NSString *markerText = [NSString stringWithFormat:@"%lu", (unsigned long)self.initiatedUser.index + 1];
         [cell setColorMarkerText:markerText andColor:self.initiatedUser.color];
         
     } else {
         [cell setVideoView:[self videoViewWithOpponentID:@(self.otherUser.ID)]];
         NSString *markerText = [NSString stringWithFormat:@"%lu", (unsigned long)self.otherUser.index + 1];
         [cell setColorMarkerText:markerText andColor:self.otherUser.color];
     }
    
    return cell;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.opponentsCollectionView performBatchUpdates:nil completion:nil];// Calling -performBatchUpdates:completion: will invalidate the layout and resize the cells with animation
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /*CGRect frame = [OpponentsFlowLayout frameForWithNumberOfItems:self.users.count
                                                              row:indexPath.row
                                                      contentSize:self.opponentsCollectionView.frame.size];*/
    CGRect frame = [OpponentsFlowLayout frameForWithNumberOfItems:1
                                                              row:indexPath.row
                                                      contentSize:self.opponentsCollectionView.frame.size];
    return frame.size;
}

#pragma mark - Transition to size


- (QBUUser *)userWithID:(NSNumber *)userID {
    
    __block QBUUser *resultUser = nil;
    [self.users enumerateObjectsUsingBlock:^(QBUUser *user,
                                             NSUInteger idx,
                                             BOOL *stop) {
        
        if (user.ID == userID.integerValue) {
            
            resultUser =  user;
            *stop = YES;
        }
    }];
    
    return resultUser;
}


- (NSIndexPath *)indexPathAtUserID:(NSNumber *)userID {
    
    QBUUser *user = [self userWithID:userID];
    NSUInteger idx = [self.users indexOfObject:user];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
    
    return indexPath;
}

- (void)performUpdateUserID:(NSNumber *)userID block:(void(^)(OpponentCollectionViewCell2 *cell))block {
    
    NSIndexPath *indexPath = [self indexPathAtUserID:userID];
    OpponentCollectionViewCell2 *cell = (id)[self.opponentsCollectionView cellForItemAtIndexPath:indexPath];
    block(cell);
}

#pragma Statistic

/*NSInteger QBRTCGetCpuUsagePercentage() {
    // Create an array of thread ports for the current task.
    const task_t task = mach_task_self();
    thread_act_array_t thread_array;
    mach_msg_type_number_t thread_count;
    if (task_threads(task, &thread_array, &thread_count) != KERN_SUCCESS) {
        return -1;
    }
    
    // Sum cpu usage from all threads.
    float cpu_usage_percentage = 0;
    thread_basic_info_data_t thread_info_data = {};
    mach_msg_type_number_t thread_info_count;
    for (size_t i = 0; i < thread_count; ++i) {
        thread_info_count = THREAD_BASIC_INFO_COUNT;
        kern_return_t ret = thread_info(thread_array[i],
                                        THREAD_BASIC_INFO,
                                        (thread_info_t)&thread_info_data,
                                        &thread_info_count);
        if (ret == KERN_SUCCESS) {
            cpu_usage_percentage +=
            100.f * (float)thread_info_data.cpu_usage / TH_USAGE_SCALE;
        }
    }
    
    // Dealloc the created array.
    vm_deallocate(task, (vm_address_t)thread_array,
                  sizeof(thread_act_t) * thread_count);
    return lroundf(cpu_usage_percentage);
}*/

#pragma mark - QBRTCClientDelegate

- (void)session:(QBRTCSession *)session updatedStatsReport:(QBRTCStatsReport *)report forUserID:(NSNumber *)userID {
    
  /*  NSMutableString *result = [NSMutableString string];
    NSString *systemStatsFormat = @"(cpu)%ld%%\n";
    [result appendString:[NSString stringWithFormat:systemStatsFormat,
                          (long)QBRTCGetCpuUsagePercentage()]];
    
    // Connection stats.
    NSString *connStatsFormat = @"CN %@ms | %@->%@/%@ | (s)%@ | (r)%@\n";
    [result appendString:[NSString stringWithFormat:connStatsFormat,
                          report.connectionRoundTripTime,
                          report.localCandidateType, report.remoteCandidateType, report.transportType,
                          report.connectionSendBitrate, report.connectionReceivedBitrate]];
    
    if (session.conferenceType == QBRTCConferenceTypeVideo) {
        
        // Video send stats.
        NSString *videoSendFormat = @"VS (input) %@x%@@%@fps | (sent) %@x%@@%@fps\n"
        "VS (enc) %@/%@ | (sent) %@/%@ | %@ms | %@\n";
        [result appendString:[NSString stringWithFormat:videoSendFormat,
                              report.videoSendInputWidth, report.videoSendInputHeight, report.videoSendInputFps,
                              report.videoSendWidth, report.videoSendHeight, report.videoSendFps,
                              report.actualEncodingBitrate, report.targetEncodingBitrate,
                              report.videoSendBitrate, report.availableSendBandwidth,
                              report.videoSendEncodeMs,
                              report.videoSendCodec]];
        
        // Video receive stats.
        NSString *videoReceiveFormat =
        @"VR (recv) %@x%@@%@fps | (decoded)%@ | (output)%@fps | %@/%@ | %@ms\n";
        [result appendString:[NSString stringWithFormat:videoReceiveFormat,
                              report.videoReceivedWidth, report.videoReceivedHeight, report.videoReceivedFps,
                              report.videoReceivedDecodedFps,
                              report.videoReceivedOutputFps,
                              report.videoReceivedBitrate, report.availableReceiveBandwidth,
                              report.videoReceivedDecodeMs]];
    }
    // Audio send stats.
    NSString *audioSendFormat = @"AS %@ | %@\n";
    [result appendString:[NSString stringWithFormat:audioSendFormat,
                          report.audioSendBitrate, report.audioSendCodec]];
    
    // Audio receive stats.
    NSString *audioReceiveFormat = @"AR %@ | %@ | %@ms | (expandrate)%@";
    [result appendString:[NSString stringWithFormat:audioReceiveFormat,
                          report.audioReceivedBitrate, report.audioReceivedCodec, report.audioReceivedCurrentDelay,
                          report.audioReceivedExpandRate]];
    
    NSLog(@"%@", result);*/
}

- (void)session:(QBRTCSession *)session initializedLocalMediaStream:(QBRTCMediaStream *)mediaStream {
    
    self.session.localMediaStream.videoTrack.videoCapture = self.cameraCapture;
}
/**
 * Called in case when you are calling to user, but he hasn't answered
 */
- (void)session:(QBRTCSession *)session userDoesNotRespond:(NSNumber *)userID {
    
    //if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    //}
}

- (void)session:(QBRTCSession *)session acceptedByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo {
    
    //if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
   // }
}

/**
 * Called in case when opponent has rejected you call
 */
- (void)session:(QBRTCSession *)session rejectedByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo {
    
    //if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    //}
}

/**
 *  Called in case when opponent hung up
 */
- (void)session:(QBRTCSession *)session hungUpByUser:(NSNumber *)userID userInfo:(NSDictionary *)userInfo {
    
    //if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
   // }
}

/**
 *  Called in case when receive remote video track from opponent
 */

- (void)session:(QBRTCSession *)session receivedRemoteVideoTrack:(QBRTCVideoTrack *)videoTrack fromUser:(NSNumber *)userID {
    
   // if (session == self.session) {
        
      /*  [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            
            QBRTCRemoteVideoView *opponentVideoView = (id)[self videoViewWithOpponentID:userID];
            [cell setVideoView:opponentVideoView];
        }];*/
    
    OpponentCollectionViewCell2 *cell = (OpponentCollectionViewCell2 *)[self.opponentsCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    QBRTCRemoteVideoView *opponentVideoView = (id)[self videoViewWithOpponentID:userID];
    [cell setVideoView:opponentVideoView];
    //}
}

/**
 *  Called in case when connection initiated
 */
- (void)session:(QBRTCSession *)session startedConnectionToUser:(NSNumber *)userID {
    
   // if (session == self.session) {
    
  
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    //}
}

/**
 *  Called in case when connection is established with opponent
 */
- (void)session:(QBRTCSession *)session connectedToUser:(NSNumber *)userID {
    
  //  NSParameterAssert(self.session == session);
    
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
    
   // if (session == self.session) {
        
        /*[self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
            [self.videoViews removeObjectForKey:userID];
            [cell setVideoView:nil];
        }];*/
    
      OpponentCollectionViewCell2 *cell = (OpponentCollectionViewCell2 *)[self.opponentsCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.connectionState = [self.session connectionStateForUser:userID];
    [self.videoViews removeObjectForKey:userID];
    [cell setVideoView:nil];
    //}
}

/**
 *  Called in case when disconnected from opponent
 */
- (void)session:(QBRTCSession *)session disconnectedFromUser:(NSNumber *)userID {
    
  //  if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    //}
}

/**
 *  Called in case when disconnected by timeout
 */
- (void)session:(QBRTCSession *)session disconnectedByTimeoutFromUser:(NSNumber *)userID {
    
 //   if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
   // }
}

/**
 *  Called in case when connection failed with user
 */
- (void)session:(QBRTCSession *)session connectionFailedWithUser:(NSNumber *)userID {
  
  //  if (session == self.session) {
        
        [self performUpdateUserID:userID block:^(OpponentCollectionViewCell2 *cell) {
            cell.connectionState = [self.session connectionStateForUser:userID];
        }];
    //}
}

/**
 *  Called in case when session will close
 */
- (void)sessionDidClose:(QBRTCSession *)session {
    
   // if (session == self.session) {
        
        [QBRTCSoundRouter.instance deinitialize];
        
        if (self.beepTimer) {
            
            [self.beepTimer invalidate];
            self.beepTimer = nil;
            [QMSysPlayer stopAllSounds];
        }
        
        [self.callTimer invalidate];
        self.callTimer = nil;
        
        self.toolbar.userInteractionEnabled = NO;
        //        self.localVideoView.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            
            self.toolbar.alpha = 0.4;
        }];
        
        self.title = [NSString stringWithFormat:@"End - %@", [self stringWithTimeDuration:self.timeDuration]];
        
        
        [self dismissViewControllerAnimated:true completion:nil];
   // }
}

#pragma mark - Timers actions

- (void)playCallingSound:(id)sender {
    
        [QMSoundManager playCallingSound];
}

- (void)refreshCallTime:(NSTimer *)sender {
    
    self.timeDuration += kRefreshTimeInterval;
    self.title = [NSString stringWithFormat:@"Call time - %@", [self stringWithTimeDuration:self.timeDuration]];
}

- (NSString *)stringWithTimeDuration:(NSTimeInterval )timeDuration {
    
    NSInteger minutes = timeDuration / 60;
    NSInteger seconds = (NSInteger)timeDuration % 60;
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld:%02ld", (long)minutes, (long)seconds];
    
    return timeStr;
}

- (void)localVideoView:(LocalVideoView *)localVideoView pressedSwitchButton:(UIButton *)sender {
    
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
        
        [localVideoView.superview.layer addAnimation:animation forKey:nil];
        
        [self.cameraCapture selectCameraPosition:newPosition];
    }
}

@end
