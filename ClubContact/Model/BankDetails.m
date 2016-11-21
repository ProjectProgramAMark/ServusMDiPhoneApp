//
//  BankDetails.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "BankDetails.h"

@implementation BankDetails


- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"uid"])
        {
            _uid = [dic objectForKey:@"uid"];
        }
        else
        {
            _uid = @"";
        }
        if ([dic objectForKey:@"bankname"])
        {
            _bankname = [dic objectForKey:@"bankname"];
        }
        else
        {
            _bankname = @"";
        }
        
        if ([dic objectForKey:@"bankaddress"])
        {
            _bankaddress = [dic objectForKey:@"bankaddress"];
        }
        else
        {
            _bankaddress = @"";
        }
        if ([dic objectForKey:@"accno"])
        {
            _accno = [dic objectForKey:@"accno"];
        }
        else
        {
            _accno = @"";
        }
        if ([dic objectForKey:@"accname"])
        {
            _accname = [dic objectForKey:@"accname"];
        }
        else
        {
            _accname = @"";
        }
        if ([dic objectForKey:@"routeno"])
        {
            _routeno = [dic objectForKey:@"routeno"];
        }
        else
        {
            _routeno = @"";
        }
        if ([dic objectForKey:@"credits"])
        {
            _credits = [dic objectForKey:@"credits"];
        }
        else
        {
            _credits = @"";
        }
        
        if ([dic objectForKey:@"withdraw"])
        {
            _withdraw = [dic objectForKey:@"withdraw"];
        }
        else
        {
            _withdraw = @"";
        }
        
    }
    
    return self;
}



@end
