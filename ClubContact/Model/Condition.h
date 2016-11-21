//
//  Condition.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 3/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Condition : NSObject

@property (nonatomic, retain) NSString *conditionName;
@property (nonatomic, retain) NSString *conditionCode;
@property (nonatomic, retain) NSString *nodeID;
@property (nonatomic, retain) NSString *isDisease;

- (id)initWithDic:(NSDictionary *)dic;

@end
