//
//  Settings.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/23/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ListOfUsers) {
    
    ListOfUsersPROD,
    ListOfUsersQA,
    ListOfUsersDEV,
    ListOfUsersWEB
};

@interface Settings : NSObject


@property (strong, nonatomic) QBRTCVideoFormat *videoFormat;

@property (strong, nonatomic) QBRTCMediaStreamConfiguration *mediaConfiguration;

@property (assign, nonatomic) QBRendererType remoteVideoViewRendererType;

@property (assign, nonatomic) AVCaptureDevicePosition preferredCameraPostion;

@property (assign, nonatomic) ListOfUsers listType;

@property (strong, nonatomic) NSArray *stunServers;

+ (instancetype)instance;

- (void)saveToDisk;


@end
