//
//  Doctors.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Doctors.h"

@implementation Doctors


- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"officecity"])
        {
            _officecity = [dic objectForKey:@"officecity"];
        }
        else
        {
            _officecity = @"";
        }
        
        if ([dic objectForKey:@"officestate"])
        {
            _officestate = [dic objectForKey:@"officestate"];
        }
        else
        {
            _officestate = @"";
        }
        if ([dic objectForKey:@"officezip"])
        {
            _officezip = [dic objectForKey:@"officezip"];
        }
        else
        {
            _officezip = @"";
        }
        
        if ([dic objectForKey:@"officecountry"])
        {
            _officecountry = [dic objectForKey:@"officecountry"];
        }
        else
        {
            _officecountry = @"";
        }
        
        if ([dic objectForKey:@"officename"])
        {
            _officename = [dic objectForKey:@"officename"];
        }
        else
        {
            _officename = @"";
        }
        
        if ([dic objectForKey:@"officeaddress"])
        {
            _officeaddress = [dic objectForKey:@"officeaddress"];
        }
        else
        {
            _officeaddress = @"";
        }
        
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
        
        if ([dic objectForKey:@"mi"])
        {
            _mi = [dic objectForKey:@"mi"];
        }
        else
        {
            _mi = @"";
        }
        
        if ([dic objectForKey:@"dea"])
        {
            _dea = [dic objectForKey:@"dea"];
        }
        else
        {
            _dea = @"";
        }
        
        if ([dic objectForKey:@"npi"])
        {
            _npi = [dic objectForKey:@"npi"];
        }
        else
        {
            _npi  = @"";
        }
        
        if ([dic objectForKey:@"me"])
        {
            _me = [dic objectForKey:@"me"];
        }
        else
        {
            _me = @"";
        }
        
        if ([dic objectForKey:@"telephone"])
        {
            _telephone = [dic objectForKey:@"telephone"];
        }
        else
        {
            _telephone = @"";
        }
        
        if ([dic objectForKey:@"userfullName"])
        {
            _fullname = [dic objectForKey:@"userfullName"];
        }
        else
        {
            _fullname = @"";
        }
        
        if ([dic objectForKey:@"userName"])
        {
            _username = [dic objectForKey:@"userName"];
        }
        else
        {
            _username = @"";
        }
        
        if ([dic objectForKey:@"email"])
        {
            _email = [dic objectForKey:@"email"];
        }
        else
        {
            _email = @"";
        }
        
        if ([dic objectForKey:@"suffix"])
        {
            _suffix = [dic objectForKey:@"suffix"];
        }
        else
        {
            _suffix = @"";
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
        
        if ([dic objectForKey:@"ccost"])
        {
            _ccost = [dic objectForKey:@"ccost"];
        }
        else
        {
            _ccost = @"";
        }
        
        if ([dic objectForKey:@"tokens"])
        {
            _tokens = [dic objectForKey:@"tokens"];
        }
        else
        {
            _tokens = @"";
        }
        
        if ([dic objectForKey:@"speciality"])
        {
            _speciality = [dic objectForKey:@"speciality"];
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
        
        if ([dic objectForKey:@"signature"])
        {
            _signature = [dic objectForKey:@"signature"];
        }
        else
        {
            _signature = @"";
        }
        
        if ([dic objectForKey:@"online"])
        {
            _isOnline = [dic objectForKey:@"online"];
        }
        else
        {
            _isOnline = @"";
        }
      
        if ([dic objectForKey:@"uid"])
        {
            _uid = [dic objectForKey:@"uid"];
        }
        else
        {
            _uid = @"";
        }
        
        if ([dic objectForKey:@"years"])
        {
            _yearsExperience = [dic objectForKey:@"years"];
        }
        else
        {
            _yearsExperience = @"";
        }
        
        if ([dic objectForKey:@"school"])
        {
            _school = [dic objectForKey:@"school"];
        }
        else
        {
            _school = @"";
        }
        
        if ([dic objectForKey:@"residency"])
        {
            _residency = [dic objectForKey:@"residency"];
        }
        else
        {
            _residency = @"";
        }
        
        if ([dic objectForKey:@"subscriptionpaid"])
        {
            _subscriptionpaid = [dic objectForKey:@"subscriptionpaid"];
        }
        else
        {
            _subscriptionpaid = @"";
        }
        
        if ([dic objectForKey:@"subscriptionplan"])
        {
            _subscriptionplan = [dic objectForKey:@"subscriptionplan"];
        }
        else
        {
            _subscriptionplan = @"";
        }
        
        if ([dic objectForKey:@"patientCount"])
        {
            _patientCount = [dic objectForKey:@"patientCount"];
        }
        else
        {
            _patientCount = @"";
        }
        
        
        if ([dic objectForKey:@"documentCount"])
        {
            _documentCount = [dic objectForKey:@"documentCount"];
        }
        else
        {
            _documentCount = @"";
        }
        
        if ([dic objectForKey:@"consulationCount"])
        {
            _consultationCount = [dic objectForKey:@"consulationCount"];
        }
        else
        {
            _consultationCount = @"";
        }
        
        

        
    }
    
    return self;
}


@end
