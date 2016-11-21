//
//  MSGSession.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MSGSession.h"

@implementation MSGSession

- (id)initWithDic:(NSDictionary *)dic {
    
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
        
        if ([dic objectForKey:@"cdate"])
        {
            _cdate = [dic objectForKey:@"cdate"];
        }
        else
        {
            _cdate = @"";
        }
        if ([dic objectForKey:@"mstatus"])
        {
            _mstatus = [dic objectForKey:@"mstatus"];
        }
        else
        {
            _mstatus = @"";
        }
        
        if ([dic objectForKey:@"mnote"])
        {
            _mnote = [dic objectForKey:@"mnote"];
        }
        else
        {
            _mnote = @"";
        }
        
        if ([dic objectForKey:@"closetime"])
        {
            _closetime = [dic objectForKey:@"closetime"];
        }
        else
        {
            _closetime = @"";
        }
        
        if ([dic objectForKey:@"pmsgcount"])
        {
            _pmsgcount = [dic objectForKey:@"pmsgcount"];
        }
        else
        {
            _pmsgcount = @"";
        }
        
        if ([dic objectForKey:@"dmsgcount"])
        {
            _dmsgcount = [dic objectForKey:@"dmsgcount"];
        }
        else
        {
            _dmsgcount = @"";
        }
        
        if ([dic objectForKey:@"dfirstname"])
        {
            _dfirstname = [dic objectForKey:@"dfirstname"];
        }
        else
        {
            _dfirstname = @"";
        }
        
        if ([dic objectForKey:@"dlastname"])
        {
            _dlastname = [dic objectForKey:@"dlastname"];
        }
        else
        {
            _dlastname = @"";
        }
        
        if ([dic objectForKey:@"duid"])
        {
            _did = [dic objectForKey:@"duid"];
        }
        else
        {
            _did = @"";
        }
        
        if ([dic objectForKey:@"dprofileimage"])
        {
            _dprofileimg = [dic objectForKey:@"dprofileimage"];
        }
        else
        {
            _dprofileimg  = @"";
        }
        
        if ([dic objectForKey:@"pfirstname"])
        {
            _pfirstname = [dic objectForKey:@"pfirstname"];
        }
        else
        {
            _pfirstname  = @"";
        }
        
        if ([dic objectForKey:@"plastname"])
        {
            _plastname = [dic objectForKey:@"plastname"];
        }
        else
        {
            _plastname  = @"";
        }
        
        if ([dic objectForKey:@"puid"])
        {
            _pid = [dic objectForKey:@"puid"];
        }
        else
        {
            _pid  = @"";
        }
        
        if ([dic objectForKey:@"pprofileimage"])
        {
            _profileimg = [dic objectForKey:@"pprofileimage"];
        }
        else
        {
            _profileimg  = @"";
        }
        
        if ([dic objectForKey:@"whoclose"])
        {
            _whoclose = [dic objectForKey:@"whoclose"];
        }
        else
        {
            _whoclose  = @"";
        }
        
        if ([dic objectForKey:@"pmail"])
        {
            _pmail = [dic objectForKey:@"pmail"];
        }
        else
        {
            _pmail  = @"";
        }
        
        if ([dic objectForKey:@"dmail"])
        {
            _dmail = [dic objectForKey:@"dmail"];
        }
        else
        {
            _dmail  = @"";
        }
        
       
        
        if ([dic objectForKey:@"officeaddress"])
        {
            _street1 = [dic objectForKey:@"officeaddress"];
        }
        else
        {
            _street1  = @"";
        }
        
        if ([dic objectForKey:@"street2"])
        {
            _street2 = [dic objectForKey:@"street2"];
        }
        else
        {
            _street2 = @"";
        }
        if ([dic objectForKey:@"officecity"])
        {
            _city = [dic objectForKey:@"officecity"];
        }
        else
        {
            _city = @"";
        }
        
        if ([dic objectForKey:@"officestate"])
        {
            _state = [dic objectForKey:@"officestate"];
        }
        else
        {
            _state = @"";
        }
        
        if ([dic objectForKey:@"telephone"])
        {
            _telephone = [dic objectForKey:@"telephone"];
        }
        else
        {
            _telephone = @"";
        }
        
        if ([dic objectForKey:@"officecountry"])
        {
            _country = [dic objectForKey:@"officecountry"];
        }
        else
        {
            _country = @"";
        }
        
        if ([dic objectForKey:@"officezip"])
        {
            _zipcode = [dic objectForKey:@"officezip"];
        }
        else
        {
            _zipcode = @"";
        }
        
        if ([dic objectForKey:@"created"])
        {
            _created = [dic objectForKey:@"created"];
        }
        else
        {
            _created = @"";
        }
        
        
        if ([dic objectForKey:@"createdago"])
        {
            _createdago = [dic objectForKey:@"createdago"];
        }
        else
        {
            _createdago = @"";
        }
        
        if ([dic objectForKey:@"lastmessage"])
        {
            _lastmessage= [dic objectForKey:@"lastmessage"];
        }
        else
        {
            _lastmessage = @"";
        }
        

        
        
        if ([dic objectForKey:@"chattype"])
        {
            _chattype = [dic objectForKey:@"chattype"];
        }
        else
        {
            _chattype = @"";
        }
        
        
        if ([dic objectForKey:@"ismine"])
        {
            _ismine = [dic objectForKey:@"ismine"];
        }
        else
        {
            _ismine = @"";
        }
        
        if ([dic objectForKey:@"dspeciality"])
        {
            _dspeciality = [dic objectForKey:@"dspeciality"];
        }
        else
        {
            _dspeciality = @"";
        }
        
        
        
    }
    
    return self;
}

@end
