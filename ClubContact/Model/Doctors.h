//
//  Doctors.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctors : NSObject {
    
}

@property (nonatomic, retain) NSString *signature;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *profileimage;
@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, retain) NSString *officename;
@property (nonatomic, retain) NSString *officeaddress;
@property (nonatomic, retain) NSString *officecity;
@property (nonatomic, retain) NSString *officestate;
@property (nonatomic, retain) NSString *officezip;
@property (nonatomic, retain) NSString *officecountry;
@property (nonatomic, retain) NSString *suffix;
@property (nonatomic, retain) NSString *patients;
@property (nonatomic, retain) NSString *fullname;
@property (nonatomic, retain) NSString *mi;
@property (nonatomic, retain) NSString *me;
@property (nonatomic, retain) NSString *npi;
@property (nonatomic, retain) NSString *dea;
@property (nonatomic, retain) NSString *requestCount;
@property (nonatomic, retain) NSString *refillCount;
@property (nonatomic, retain) NSString *messageCount;
@property (nonatomic, retain) NSString *consultationCount;
@property (nonatomic, retain) NSString *documentCount;
@property (nonatomic, retain) NSString *speciality;
@property (nonatomic, retain) NSString *ccost;
@property (nonatomic, retain) NSString *tokens;
@property (nonatomic, retain) NSString *isOnline;
@property (nonatomic, retain) NSString *patientCount;

@property (nonatomic, retain) NSString *yearsExperience;
@property (nonatomic, retain) NSString *residency;
@property (nonatomic, retain) NSString *school;

@property (nonatomic, retain) NSString *subscriptionplan;
@property (nonatomic, retain) NSString *subscriptionpaid;



- (id)initWithDic:(NSDictionary *)dic;

@end
