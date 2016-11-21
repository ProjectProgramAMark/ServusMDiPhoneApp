//
//  Transactions.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Transactions.h"

@implementation Transactions

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"nid"])
        {
            _nid = [dic objectForKey:@"nid"];
        }
        else
        {
            _nid = @"";
        }
        if ([dic objectForKey:@"paymentid"])
        {
            _paymentid = [dic objectForKey:@"paymentid"];
        }
        else
        {
            _paymentid = @"";
        }
        
        if ([dic objectForKey:@"type"])
        {
            _type = [dic objectForKey:@"type"];
        }
        else
        {
            _type = @"";
        }
        if ([dic objectForKey:@"credits"])
        {
            _credits = [dic objectForKey:@"credits"];
        }
        else
        {
            _credits = @"";
        }
        if ([dic objectForKey:@"profileid"])
        {
            _profileid = [dic objectForKey:@"profileid"];
        }
        else
        {
            _profileid = @"";
        }
        if ([dic objectForKey:@"created"])
        {
            _created = [dic objectForKey:@"created"];
        }
        else
        {
            _created = @"";
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
