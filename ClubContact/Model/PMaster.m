//
//  PMaster.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PMaster.h"

@implementation PMaster

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        
        if ([dic objectForKey:@"firstname"])
        {
            _firstname= [dic objectForKey:@"firstname"];
        }
        else
        {
            _firstname = @"";
        }
        
        if ([dic objectForKey:@"lastname"])
        {
            _lastname = [dic objectForKey:@"lastname"];
        }
        else
        {
            _lastname = @"";
        }
        
        if ([dic objectForKey:@"dob"])
        {
            _dob = [dic objectForKey:@"dob"];
        }
        else
        {
            _dob = @"";
        }
        
        if ([dic objectForKey:@"occupation"])
        {
            _occupation = [dic objectForKey:@"occupation"];
        }
        else
        {
            _occupation = @"";
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
        
        
        
        if ([dic objectForKey:@"email"])
        {
            _email = [dic objectForKey:@"email"];
        }
        else
        {
            _email = @"";
        }
        
        if ([dic objectForKey:@"ssn"])
        {
            _ssn = [dic objectForKey:@"ssn"];
        }
        else
        {
            _ssn = @"";
        }
        
        if ([dic objectForKey:@"gender"])
        {
            _gender = [dic objectForKey:@"gender"];
        }
        else
        {
            _gender = @"";
        }
        
        
        
        if ([dic objectForKey:@"requestCount"])
        {
            _requestCount = [dic objectForKey:@"requestCount"];
        }
        else
        {
            _requestCount = @"";
        }
        
        if ([dic objectForKey:@"refillCount"])
        {
            _refillCount= [dic objectForKey:@"refillCount"];
        }
        else
        {
            _refillCount = @"";
        }
        
        if ([dic objectForKey:@"messageCount"])
        {
            _messageCount = [dic objectForKey:@"messageCount"];
        }
        else
        {
            _messageCount = @"";
        }
        
        if ([dic objectForKey:@"docfname"])
        {
            _docfname  = [dic objectForKey:@"docfname"];
        }
        else
        {
            _docfname = @"";
        }
        
        if ([dic objectForKey:@"doclname"])
        {
            _doclname = [dic objectForKey:@"doclname"];
        }
        else
        {
            _doclname = @"";
        }
        
        if ([dic objectForKey:@"dspeciality"])
        {
            _speciality = [dic objectForKey:@"dspeciality"];
        }
        else
        {
            _speciality = @"";
        }
        
        if ([dic objectForKey:@"profileimage"])
        {
            _profileimage = [dic objectForKey:@"profileimage"];
        }
        else
        {
            _profileimage = @"";
        }
        
        if ([dic objectForKey:@"docprof"])
        {
            _docprof = [dic objectForKey:@"docprof"];
        }
        else
        {
            _docprof = @"";
        }
        
        if ([dic objectForKey:@"docid"])
        {
            _docid = [dic objectForKey:@"docid"];
        }
        else
        {
            _docid = @"";
        }
        
        if ([dic objectForKey:@"docsuffix"])
        {
            _docsuffix = [dic objectForKey:@"docsuffix"];
        }
        else
        {
            _docsuffix = @"";
        }
        
        
        
        if ([dic objectForKey:@"donline"])
        {
            _isOnline = [dic objectForKey:@"donline"];
        }
        else
        {
            _isOnline = @"";
        }
        
        if ([dic objectForKey:@"uid"])
        {
            _postid = [dic objectForKey:@"uid"];
        }
        else
        {
            _postid = @"";
        }
        if ([dic objectForKey:@"userName"])
        {
            _username = [dic objectForKey:@"userName"];
        }
        else
        {
            _username = @"";
        }
        
        if ([dic objectForKey:@"credits"])
        {
            _tokens = [dic objectForKey:@"credits"];
        }
        else
        {
            _tokens = @"";
        }
        
        
        if ([dic objectForKey:@"insurancecard"])
        {
            _insurancecard = [dic objectForKey:@"insurancecard"];
        }
        else
        {
            _insurancecard = @"";
        }
        
        if ([dic objectForKey:@"insurancecardback"])
        {
            _insurancecardback = [dic objectForKey:@"insurancecardback"];
        }
        else
        {
            _insurancecardback = @"";
        }
        
        if ([dic objectForKey:@"idcard"])
        {
            _idcard = [dic objectForKey:@"idcard"];
        }
        else
        {
            _idcard = @"";
        }
        
        if ([dic objectForKey:@"parentid"])
        {
            _parentidcard = [dic objectForKey:@"parentid"];
        }
        else
        {
            _parentidcard = @"";
        }
        
        if ([dic objectForKey:@"parentfirstname"])
        {
            _parentfirstname = [dic objectForKey:@"parentfirstname"];
        }
        else
        {
            _parentfirstname = @"";
        }
        
        if ([dic objectForKey:@"parentlastname"])
        {
            _parentlastname = [dic objectForKey:@"parentlastname"];
        }
        else
        {
            _parentlastname = @"";
        }
        
        if ([dic objectForKey:@"parentphone"])
        {
            _parentphone = [dic objectForKey:@"parentphone"];
        }
        else
        {
            _parentphone = @"";
        }
        
        if ([dic objectForKey:@"parentemail"])
        {
            _parentemail = [dic objectForKey:@"parentemail"];
        }
        else
        {
            _parentemail = @"";
        }
        
        if ([dic objectForKey:@"parentssn"])
        {
            _parentssn = [dic objectForKey:@"parentssn"];
        }
        else
        {
            _parentssn = @"";
        }
        
        if ([dic objectForKey:@"parentdob"])
        {
            _parentdob = [dic objectForKey:@"parentdob"];
        }
        else
        {
            _parentdob = @"";
        }
    }
    
    return self;
}




@end
