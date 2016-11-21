//
//  PatientRegister.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientRegister : NSObject

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *me;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *passcode;
@property (nonatomic, retain) NSString *dob;
@property (nonatomic, retain) NSString *parentDob;
@property (nonatomic, retain) UIImage *idCard;
@property (nonatomic, retain) UIImage *parentIDCard;
@property (nonatomic, retain) NSString *parentFirstName;
@property (nonatomic, retain) NSString *parentLastName;
@property (nonatomic, retain) NSString *parentPhone;
@property (nonatomic, retain) NSString *parentEmail;
@property (nonatomic, retain) NSString *parentSSN;
@end
