//
//  UnifiedRequests.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/4/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnifiedRequests : NSObject

@property (nonatomic, retain) NSString *nid;
@property (nonatomic, retain) NSString *created;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *from;
@property (nonatomic, retain) NSString *to;
@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *patientid;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *profilepic;


- (id)initWithDic:(NSDictionary *)dic;

@end
