//
//  Patient.m
//  ClubContact
//
//  Created by wangkun on 15/3/11.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import "Patient.h"

@implementation Patient

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"city"])
        {
            _city = [dic objectForKey:@"city"];
        }
        else
        {
            _city = @"";
        }
        
        if ([dic objectForKey:@"city"])
        {
            _city = [dic objectForKey:@"city"];
        }
        else
        {
            _city = @"";
        }
        if ([dic objectForKey:@"country"])
        {
            _country = [dic objectForKey:@"country"];
        }
        else
        {
            _country = @"";
        }

        if ([dic objectForKey:@"dob"])
        {
            _dob = [dic objectForKey:@"dob"];
        }
        else
        {
            _dob = @"";
        }

        if ([dic objectForKey:@"email"])
        {
            _email = [dic objectForKey:@"email"];
        }
        else
        {
            _email = @"";
        }

        if ([dic objectForKey:@"firstname"])
        {
            _firstName = [dic objectForKey:@"firstname"];
        }
        else
        {
            _firstName = @"";
        }
        
        if ([dic objectForKey:@"gender"])
        {
            _gender = [dic objectForKey:@"gender"];
        }
        else
        {
            _gender = @"";
        }

        if ([dic objectForKey:@"lastname"])
        {
            _lastName = [dic objectForKey:@"lastname"];
        }
        else
        {
            _lastName = @"";
        }

        if ([dic objectForKey:@"occupation"])
        {
            _occupation = [dic objectForKey:@"occupation"];
        }
        else
        {
            _occupation = @"";
        }

        if ([dic objectForKey:@"postid"])
        {
            _postid = [dic objectForKey:@"postid"];
        }
        else
        {
            _postid = @"";
        }
        
        if ([dic objectForKey:@"profilepic"])
        {
            _profilepic = [dic objectForKey:@"profilepic"];
        }
        else
        {
            _profilepic = @"";
        }

        if ([dic objectForKey:@"state"])
        {
            _state = [dic objectForKey:@"state"];
        }
        else
        {
            _state = @"";
        }

        if ([dic objectForKey:@"street1"])
        {
            _street1 = [dic objectForKey:@"street1"];
        }
        else
        {
            _street1 = @"";
        }
        
        if ([dic objectForKey:@"street2"])
        {
            _street2 = [dic objectForKey:@"street2"];
        }
        else
        {
            _street2 = @"";
        }
        
        if ([dic objectForKey:@"telephone"])
        {
            _telephone = [dic objectForKey:@"telephone"];
        }
        else
        {
            _telephone = @"";
        }

        if ([dic objectForKey:@"title"])
        {
            _title = [dic objectForKey:@"title"];
        }
        else
        {
            _title = @"";
        }

        if ([dic objectForKey:@"zipcode"])
        {
            _zipcode = [dic objectForKey:@"zipcode"];
        }
        else
        {
            _zipcode = @"";
        }
        
        if ([dic objectForKey:@"messageCount"])
        {
            _msgCount = [dic objectForKey:@"messageCount"];
        }
        else
        {
            _msgCount = @"";
        }
        if ([dic objectForKey:@"ssn"])
        {
            _ssnDigits = [dic objectForKey:@"ssn"];
        }
        else
        {
            _ssnDigits = @"";
        }
        
        if ([dic objectForKey:@"docid"])
        {
            _docid = [dic objectForKey:@"docid"];
        }
        else
        {
            _docid = @"";
        }
        
        _conditions = [NSMutableArray array];
        _notes = [NSMutableArray array];
        _allergies = [NSMutableArray array];
        _appointments = [NSMutableArray array];
        _medications = [NSMutableArray array];
        _eyeexam = [NSMutableArray array];
        
    }
    
    return self;
}

@end
