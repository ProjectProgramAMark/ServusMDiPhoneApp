//
//  Rating.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Rating.h"

@implementation Rating




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
        
        if ([dic objectForKey:@"street1"])
        {
            _street1 = [dic objectForKey:@"street1"];
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
        if ([dic objectForKey:@"city"])
        {
            _city = [dic objectForKey:@"city"];
        }
        else
        {
            _city = @"";
        }
        
        if ([dic objectForKey:@"state"])
        {
            _state = [dic objectForKey:@"state"];
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
        
        if ([dic objectForKey:@"country"])
        {
            _country = [dic objectForKey:@"country"];
        }
        else
        {
            _country = @"";
        }
        
        if ([dic objectForKey:@"zipcode"])
        {
            _zipcode = [dic objectForKey:@"zipcode"];
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
        
        if ([dic objectForKey:@"profilepic"])
        {
            _profileimage = [dic objectForKey:@"profilepic"];
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
        
        if ([dic objectForKey:@"postid"])
        {
            _postid = [dic objectForKey:@"postid"];
        }
        else
        {
            _postid = @"";
        }
        
        if ([dic objectForKey:@"stars"])
        {
            _stars = [dic objectForKey:@"stars"];
        }
        else
        {
            _stars = @"";
        }
        
        if ([dic objectForKey:@"review"])
        {
            _review = [dic objectForKey:@"review"];
        }
        else
        {
            _review = @"";
        }
        
        if ([dic objectForKey:@"created"])
        {
            _created = [dic objectForKey:@"created"];
        }
        else
        {
            _created = @"";
        }
        
        if ([dic objectForKey:@"uid"])
        {
            _uid = [dic objectForKey:@"uid"];
        }
        else
        {
            _uid = @"";
        }


        
    }
    
    return self;
}


@end
