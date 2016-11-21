//
//  PatientLinks.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientLinks : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *postid;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *profileimage;
@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, retain) NSString *zipcode;
@property (nonatomic, retain) NSString *ssn;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *docfname;
@property (nonatomic, retain) NSString *doclname;
@property (nonatomic, retain) NSString *docsuffix;
@property (nonatomic, retain) NSString *docid;
@property (nonatomic, retain) NSString *docprof;
@property (nonatomic, retain) NSString *requestCount;
@property (nonatomic, retain) NSString *refillCount;
@property (nonatomic, retain) NSString *messageCount;
@property (nonatomic, retain) NSString *speciality;
@property (nonatomic, retain) NSString *dob;
@property (nonatomic, retain) NSString *occupation;
@property (nonatomic, retain) NSString *street1;
@property (nonatomic, retain) NSString *street2;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *ccost;
@property (nonatomic, retain) NSString *tokens;
@property (nonatomic, retain) NSString *isOnline;


- (id)initWithDic:(NSDictionary *)dic;

@end
