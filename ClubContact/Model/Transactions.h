//
//  Transactions.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transactions : NSObject

@property (nonatomic, retain) NSString *nid;
@property (nonatomic, retain) NSString *paymentid;
@property (nonatomic, retain) NSString *postid;
@property (nonatomic, retain) NSString *profileid;
@property (nonatomic, retain) NSString *credits;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *created;


- (id)initWithDic:(NSDictionary *)dic;

@end
