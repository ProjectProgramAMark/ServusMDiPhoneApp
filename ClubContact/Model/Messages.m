//
//  Messages.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/3/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Messages.h"

@implementation Messages


- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"id"])
        {
            _messageid = [dic objectForKey:@"id"];
        }
        else
        {
            _messageid = @"";
        }
        
        if ([dic objectForKey:@"uid"])
        {
            _uid = [dic objectForKey:@"uid"];
        }
        else
        {
            _uid = @"";
        }
        
        if ([dic objectForKey:@"to"])
        {
            _toid = [dic objectForKey:@"to"];
        }
        else
        {
            _toid = @"";
        }
        
        if ([dic objectForKey:@"from"])
        {
            _fromid = [dic objectForKey:@"from"];
        }
        else
        {
            _fromid = @"";
        }
        
        if ([dic objectForKey:@"sent"])
        {
            _sentdate = [dic objectForKey:@"sent"];
        }
        else
        {
            _sentdate = @"";
        }
        
        if ([dic objectForKey:@"message"])
        {
            _message = [dic objectForKey:@"message"];
        }
        else
        {
            _message = @"";
        }
        
        if ([dic objectForKey:@"seen"])
        {
            _seen = [dic objectForKey:@"seen"];
        }
        else
        {
            _seen = @"";
        }
        
        if ([dic objectForKey:@"seentime"])
        {
            _seendate = [dic objectForKey:@"seentime"];
        }
        else
        {
            _seendate = @"";
        }
        
        if ([dic objectForKey:@"sendertype"])
        {
            _sendertype = [dic objectForKey:@"sendertype"];
        }
        else
        {
            _sendertype = @"";
        }
        
        if ([dic objectForKey:@"msgimage"])
        {
            _msgimage = [dic objectForKey:@"msgimage"];
        }
        else
        {
            _msgimage = @"";
        }
        
        if ([dic objectForKey:@"msgvideo"])
        {
            _msgvideo = [dic objectForKey:@"msgvideo"];
        }
        else
        {
            _msgvideo = @"";
        }
        
        if ([dic objectForKey:@"touid"])
        {
            _touid = [dic objectForKey:@"touid"];
        }
        else
        {
            _touid = @"";
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
        
        
        if ([dic objectForKey:@"totele"])
        {
            _totele = [dic objectForKey:@"totele"];
        }
        else
        {
            _totele = @"";
        }
        
        if ([dic objectForKey:@"toemail"])
        {
            _toemail = [dic objectForKey:@"toemail"];
        }
        else
        {
            _toemail = @"";
        }
        
        if ([dic objectForKey:@"toprofilepic"])
        {
            _toprofilepic = [dic objectForKey:@"toprofilepic"];
        }
        else
        {
            _toprofilepic = @"";
        }
        
        
        
        if ([dic objectForKey:@"fromuid"])
        {
            _fromuid = [dic objectForKey:@"fromuid"];
        }
        else
        {
            _fromuid = @"";
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
        
        
        if ([dic objectForKey:@"fromtele"])
        {
            _fromtele = [dic objectForKey:@"fromtele"];
        }
        else
        {
            _fromtele = @"";
        }
        
        if ([dic objectForKey:@"fromemail"])
        {
            _fromemail = [dic objectForKey:@"fromemail"];
        }
        else
        {
            _fromemail = @"";
        }
        
        if ([dic objectForKey:@"fromprofilepic"])
        {
            _fromprofilepic = [dic objectForKey:@"fromprofilepic"];
        }
        else
        {
            _fromprofilepic = @"";
        }
        
        
        
        
    }
    
    return self;
}

@end
