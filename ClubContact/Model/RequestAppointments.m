//
//  RequestAppointments.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "RequestAppointments.h"

@implementation RequestAppointments

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"id"])
        {
            _appid = [dic objectForKey:@"id"];
        }
        else
        {
            _appid = @"";
        }
        
        if ([dic objectForKey:@"patientid"])
        {
            _patientid = [dic objectForKey:@"patientid"];
        }
        else
        {
            _patientid = @"";
        }
        if ([dic objectForKey:@"from"])
        {
            _fromdate = [dic objectForKey:@"from"];
        }
        else
        {
            _fromdate = @"";
        }
        
        if ([dic objectForKey:@"to"])
        {
            _todate = [dic objectForKey:@"to"];
        }
        else
        {
            _todate = @"";
        }
        
        if ([dic objectForKey:@"aptitle"])
        {
            _apptitle = [dic objectForKey:@"aptitle"];
        }
        else
        {
            _apptitle = @"";
        }
        
        if ([dic objectForKey:@"apnotes"])
        {
            _appnotes = [dic objectForKey:@"apnotes"];
        }
        else
        {
            _appnotes = @"";
        }
        
        if ([dic objectForKey:@"firstname"])
        {
            _firstname = [dic objectForKey:@"firstname"];
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
        
        if ([dic objectForKey:@"telephone"])
        {
            _patienttele = [dic objectForKey:@"telephone"];
        }
        else
        {
            _patienttele = @"";
        }
        
        if ([dic objectForKey:@"email"])
        {
            _patientemail = [dic objectForKey:@"email"];
        }
        else
        {
            _patientemail = @"";
        }
        
        if ([dic objectForKey:@"profilepic"])
        {
            _patientProfIMG = [dic objectForKey:@"profilepic"];
        }
        else
        {
            _patientProfIMG = @"";
        }
        
        if ([dic objectForKey:@"occupation"])
        {
            _occupation = [dic objectForKey:@"occupation"];
        }
        else
        {
            _occupation = @"";
        }

        
        
    }
    
    return self;
}

@end
