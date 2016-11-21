//
//  Notifications.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 8/5/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Notifications.h"

@implementation Notifications



- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        
        if ([dic objectForKey:@"ffirstname"])
        {
            _ffirstname = [dic objectForKey:@"ffirstname"];
        }
        else
        {
            _ffirstname = @"";
        }
        
        if ([dic objectForKey:@"flastname"])
        {
            _flastname = [dic objectForKey:@"flastname"];
        }
        else
        {
            _flastname = @"";
        }
        
        if ([dic objectForKey:@"fuid"])
        {
            _fuid = [dic objectForKey:@"fuid"];
        }
        else
        {
            _fuid = @"";
        }
        
        if ([dic objectForKey:@"femail"])
        {
            _fmail = [dic objectForKey:@"femail"];
        }
        else
        {
            _fmail = @"";
        }
        
        if ([dic objectForKey:@"fprofileimage"])
        {
            _fprofImage = [dic objectForKey:@"fprofileimage"];
        }
        else
        {
            _fprofImage  = @"";
        }
        
        if ([dic objectForKey:@"postid"])
        {
            _postid = [dic objectForKey:@"postid"];
        }
        else
        {
            _postid = @"";
        }
        if ([dic objectForKey:@"created"])
        {
            _fcreated = [dic objectForKey:@"created"];
        }
        else
        {
            _fcreated = @"";
        }
        
        if ([dic objectForKey:@"pfirstname"])
        {
            _pfirstname = [dic objectForKey:@"pfirstname"];
        }
        else
        {
            _pfirstname = @"";
        }
        
        if ([dic objectForKey:@"plastname"])
        {
            _plastname = [dic objectForKey:@"plastname"];
        }
        else
        {
            _plastname = @"";
        }
        
        if ([dic objectForKey:@"puid"])
        {
            _puid = [dic objectForKey:@"puid"];
        }
        else
        {
            _puid = @"";
        }
        
        if ([dic objectForKey:@"pprofileimage"])
        {
            _pProfIMG = [dic objectForKey:@"pprofileimage"];
        }
        else
        {
            _pProfIMG = @"";
        }
        
        
        
        if ([dic objectForKey:@"notiid"])
        {
            _notiID = [dic objectForKey:@"notiid"];
        }
        else
        {
            _notiID = @"";
        }
        
        if ([dic objectForKey:@"postid"])
        {
            _postid = [dic objectForKey:@"postid"];
        }
        else
        {
            _postid = @"";
        }
        
        if ([dic objectForKey:@"type"])
        {
            _notiType = [dic objectForKey:@"type"];
        }
        else
        {
            _notiType = @"";
        }
        
        
        
        if ([dic objectForKey:@"isread"])
        {
            _isRead = [dic objectForKey:@"isread"];
        }
        else
        {
            _isRead = @"";
        }
        
              
        
    }
    
    return self;
}



@end
