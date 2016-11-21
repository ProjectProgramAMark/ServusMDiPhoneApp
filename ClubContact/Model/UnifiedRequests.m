//
//  UnifiedRequests.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/4/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "UnifiedRequests.h"

@implementation UnifiedRequests

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"id"])
        {
            _nid = [dic objectForKey:@"id"];
        }
        else
        {
            _nid = @"";
        }
        
        if ([dic objectForKey:@"created"])
        {
            _created = [dic objectForKey:@"created"];
        }
        else
        {
            _created = @"";
        }
        if ([dic objectForKey:@"patientid"])
        {
            _patientid = [dic objectForKey:@"patientid"];
        }
        else
        {
            _patientid = @"";
        }
        
        if ([dic objectForKey:@"to"])
        {
            _to = [dic objectForKey:@"to"];
        }
        else
        {
            _to = @"";
        }
        
        if ([dic objectForKey:@"from"])
        {
            _from = [dic objectForKey:@"from"];
        }
        else
        {
            _from = @"";
        }
        
        if ([dic objectForKey:@"lastname"])
        {
            _lastname = [dic objectForKey:@"lastname"];
        }
        else
        {
            _lastname = @"";
        }
        
        if ([dic objectForKey:@"firstname"])
        {
            _firstname = [dic objectForKey:@"firstname"];
        }
        else
        {
            _firstname = @"";
        }
        
        if ([dic objectForKey:@"status"])
        {
            _status = [dic objectForKey:@"status"];
        }
        else
        {
            _status = @"";
        }
        
        if ([dic objectForKey:@"profilepic"])
        {
            _profilepic = [dic objectForKey:@"profilepic"];
        }
        else
        {
            _profilepic = @"";
        }
        
        if ([dic objectForKey:@"type"])
        {
            _type = [dic objectForKey:@"type"];
        }
        else
        {
            _type = @"";
        }

        
               
    }
    
    return self;
}

@end
