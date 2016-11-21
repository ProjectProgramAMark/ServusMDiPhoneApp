//
//  Patient.h
//  ClubContact
//
//  Created by wangkun on 15/3/11.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Patient : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *postid;

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *dob;    //Patients dob in unix time
@property (nonatomic, retain) NSString *occupation;    //Patients occupation

@property (nonatomic, retain) NSString *street1;
@property (nonatomic, retain) NSString *street2;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *zipcode;

@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *msgCount;
@property (nonatomic, retain) NSString *ssnDigits;
@property (nonatomic, retain) NSString *docid;

@property (nonatomic, retain) NSMutableArray *medications;
@property (nonatomic, retain) NSMutableArray *conditions;
@property (nonatomic, retain) NSMutableArray *allergies;
@property (nonatomic, retain) NSMutableArray *notes;
@property (nonatomic, retain) NSMutableArray *appointments;
@property (nonatomic, retain) NSMutableArray *eyeexam;

@property (nonatomic, retain) NSString *profilepic;

- (id)initWithDic:(NSDictionary *)dic;

@end
