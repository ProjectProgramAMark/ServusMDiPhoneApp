//
//  SharedDocuments.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/7/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SharedDocuments.h"

@implementation SharedDocuments

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"postid"])
        {
            _postid = [dic objectForKey:@"postid"];
        }
        else
        {
            _postid = @"";
        }
        if ([dic objectForKey:@"patientid"])
        {
            _patientid = [dic objectForKey:@"patientid"];
        }
        else
        {
            _patientid = @"";
        }
        
        if ([dic objectForKey:@"nid"])
        {
            _nid = [dic objectForKey:@"nid"];
        }
        else
        {
            _nid = @"";
        }
        if ([dic objectForKey:@"read"])
        {
            _read = [dic objectForKey:@"read"];
        }
        else
        {
            _read = @"";
        }
        if ([dic objectForKey:@"fromdoc"])
        {
            _fromdoc = [dic objectForKey:@"fromdoc"];
        }
        else
        {
            _fromdoc = @"";
        }
        if ([dic objectForKey:@"todoc"])
        {
            _todoc = [dic objectForKey:@"todoc"];
        }
        else
        {
            _todoc = @"";
        }
        if ([dic objectForKey:@"type"])
        {
            _type = [dic objectForKey:@"type"];
        }
        else
        {
            _type = @"";
        }
        
        
        if ([dic objectForKey:@"todocprof"])
        {
            _toprofimg = [dic objectForKey:@"todocprof"];
        }
        else
        {
            _toprofimg = @"";
        }
        
        if ([dic objectForKey:@"tofirstname"])
        {
            _tofirstname = [dic objectForKey:@"tofirstname"];
        }
        else
        {
            _tofirstname = @"";
        }
        
        if ([dic objectForKey:@"tolastname"])
        {
            _tolastname = [dic objectForKey:@"tolastname"];
        }
        else
        {
            _tolastname = @"";
        }
        
        if ([dic objectForKey:@"fromdocprof"])
        {
            _fromprofimg = [dic objectForKey:@"fromdocprof"];
        }
        else
        {
            _fromprofimg = @"";
        }
        
        if ([dic objectForKey:@"fromfirstname"])
        {
            _fromfirstname = [dic objectForKey:@"fromfirstname"];
        }
        else
        {
            _fromfirstname = @"";
        }
        
        if ([dic objectForKey:@"fromlastname"])
        {
            _fromlastname = [dic objectForKey:@"fromlastname"];
        }
        else
        {
            _fromlastname = @"";
        }

        
        
    }
    
    return self;
}

@end
