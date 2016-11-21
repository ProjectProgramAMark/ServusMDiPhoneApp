//
//  Refills.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/18/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Refills.h"

@implementation Refills

- (id)initWithDic:(NSDictionary *)dic {
    
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"refillid"])
        {
            _refillid = [dic objectForKey:@"refillid"];
        }
        else
        {
            _refillid = @"";
        }
        
        if ([dic objectForKey:@"sentdate"])
        {
            _sentdate = [dic objectForKey:@"sentdate"];
        }
        else
        {
            _sentdate = @"";
        }
        if ([dic objectForKey:@"refillmed"])
        {
            _refillmed = [dic objectForKey:@"refillmed"];
        }
        else
        {
            _refillmed = @"";
        }
        
        if ([dic objectForKey:@"refillstatus"])
        {
            _refillstatus = [dic objectForKey:@"refillstatus"];
        }
        else
        {
            _refillstatus = @"";
        }
        
        if ([dic objectForKey:@"refillupdate"])
        {
            _refillupdate = [dic objectForKey:@"refillupdate"];
        }
        else
        {
            _refillupdate = @"";
        }
        
               
        
        
    }
    
       return self;
}

@end
