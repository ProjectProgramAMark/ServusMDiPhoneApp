//
//  Refills.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/18/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Refills : NSObject

@property (nonatomic, retain) NSString *refillid;
@property (nonatomic, retain) NSString *sentdate;
@property (nonatomic, retain) NSString *refillmed;
@property (nonatomic, retain) NSString *refillstatus;    //Patients dob in unix time
@property (nonatomic, retain) NSString *refillupdate;

- (id)initWithDic:(NSDictionary *)dic;

@end
