//
//  MSGSession.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSGSession : NSObject


@property (nonatomic, retain) NSString *cdate;
@property (nonatomic, retain) NSString *postid;
@property (nonatomic, retain) NSString *mstatus;
@property (nonatomic, retain) NSString *whoclose;
@property (nonatomic, retain) NSString *mnote;
@property (nonatomic, retain) NSString *closetime;
@property (nonatomic, retain) NSString *pmsgcount;
@property (nonatomic, retain) NSString *dmsgcount;
@property (nonatomic, retain) NSString *ptokens;
@property (nonatomic, retain) NSString *did;
@property (nonatomic, retain) NSString *pid;
@property (nonatomic, retain) NSString *ctype;
@property (nonatomic, retain) NSString *ccost;
@property (nonatomic, retain) NSString *clink;
@property (nonatomic, retain) NSString *cnotes;
@property (nonatomic, retain) NSString *consultime;
@property (nonatomic, retain) NSString *acceptedtime;
@property (nonatomic, retain) NSString *pfirstname;
@property (nonatomic, retain) NSString *plastname;
@property (nonatomic, retain) NSString *profileimg;
@property (nonatomic, retain) NSString *dfirstname;
@property (nonatomic, retain) NSString *dlastname;
@property (nonatomic, retain) NSString *dspeciality;
@property (nonatomic, retain) NSString *dprofileimg;
@property (nonatomic, retain) NSString *pmail;
@property (nonatomic, retain) NSString *dmail;
@property (nonatomic, retain) NSString *street1;
@property (nonatomic, retain) NSString *street2;
@property (nonatomic, retain) NSString *zipcode;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, retain) NSString *createdago;
@property (nonatomic, retain) NSString *lastmessage;
@property (nonatomic, retain) NSString *chattype;
@property (nonatomic, retain) NSString *ismine;
- (id)initWithDic:(NSDictionary *)dic;

@end
