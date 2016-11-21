//
//  DeviceInfo.h
//  ClubContact
//
//  Created by wangkun on 15/3/12.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject

//This should be the ipaddress that the doctor registers from.
@property (nonatomic, retain) NSString *ipaddress;
//This should be the city of the device which he registers from.
@property (nonatomic, retain) NSString *city;
//This should be the state of the device which he registers from.
@property (nonatomic, retain) NSString *state;
//This should be the country of the device which he registers from.
@property (nonatomic, retain) NSString *country;
//This should be the app version which the doctor is running
@property (nonatomic, retain) NSString *version;

+ (void)updateDeviceInfo;
+ (DeviceInfo *)getFromUserDefault;

@end
