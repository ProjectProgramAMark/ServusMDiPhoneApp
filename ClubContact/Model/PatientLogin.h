//
//  PatientLogin.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientLogin : NSObject

@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *profileimage;

+ (PatientLogin *)getFromUserDefault;
- (void)saveToUserDefault;

@end
