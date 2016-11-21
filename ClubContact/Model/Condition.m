//
//  Condition.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 3/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Condition.h"

@implementation Condition



- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"conditionname"])
        {
           _conditionName  = [dic objectForKey:@"conditionname"];
        }
        else
        {
            _conditionName = @"";
        }
        
        if ([dic objectForKey:@"conditioncode"])
        {
            _conditionCode = [dic objectForKey:@"conditioncode"];
        }
        else
        {
            _conditionCode = @"";
        }
       
        if ([dic objectForKey:@"id"])
        {
            _nodeID = [dic objectForKey:@"id"];
        }
        else
        {
            _nodeID = @"";
        }
        

        
    }
    
    return self;
}
@end
