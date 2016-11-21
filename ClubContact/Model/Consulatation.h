//
//  Consulatation.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consulatation : NSObject

@property (nonatomic, retain) NSString *postid;
@property (nonatomic, retain) NSString *pid;
@property (nonatomic, retain) NSString *did;
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
@property (nonatomic, retain) NSString *dprofileimg;
@property (nonatomic, retain) NSString *pmail;
@property (nonatomic, retain) NSString *consultedtele;
@property (nonatomic, retain) NSString *primaryPhysician;
@property (nonatomic, retain) NSString *whatWould;
@property (nonatomic, retain) NSString *pharmname;
@property (nonatomic, retain) NSString *pharmadd;

- (id)initWithDic:(NSDictionary *)dic;

@end
