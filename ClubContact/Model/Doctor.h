//
//  Doctor.h
//  ClubContact
//
//  Created by wangkun on 15/3/14.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor : NSObject

@property (nonatomic, retain) NSString *signature;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *profileimage;

@property (nonatomic, retain) NSString *subscriptionplan;
@property (nonatomic, retain) NSString *subscriptionpaid;

+ (Doctor *)getFromUserDefault;
- (void)saveToUserDefault;

@end
