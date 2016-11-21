//
//  PatientMedication.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/16/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PatientMedication.h"

@implementation PatientMedication

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"id"])
        {
            _postid = [dic objectForKey:@"id"];
        }
        else
        {
            _postid = @"";
        }
        
        if ([dic objectForKey:@"medname"])
        {
            _medname = [dic objectForKey:@"medname"];
        }
        else
        {
            _medname = @"";
        }
        if ([dic objectForKey:@"medid"])
        {
            _medid = [dic objectForKey:@"medid"];
        }
        else
        {
            _medid = @"";
        }
        
        if ([dic objectForKey:@"patientid"])
        {
            _patientid = [dic objectForKey:@"patientid"];
        }
        else
        {
            _patientid = @"";
        }
        
        if ([dic objectForKey:@"dose"])
        {
            _dose = [dic objectForKey:@"dose"];
        }
        else
        {
            _dose = @"";
        }
        
        if ([dic objectForKey:@"doseunit"])
        {
            _doseunit = [dic objectForKey:@"doseunit"];
        }
        else
        {
            _doseunit = @"";
        }
        
        if ([dic objectForKey:@"pharmacy"])
        {
            _pharmacy = [dic objectForKey:@"pharmacy"];
        }
        else
        {
            _pharmacy = @"";
        }
        
        if ([dic objectForKey:@"pharmaddress"])
        {
            _pharmaddress = [dic objectForKey:@"pharmaddress"];
        }
        else
        {
            _pharmaddress = @"";
        }
        
        if ([dic objectForKey:@"refills"])
        {
            _refills = [dic objectForKey:@"refills"];
        }
        else
        {
            _refills  = @"";
        }
        
        if ([dic objectForKey:@"component"])
        {
            _component = [dic objectForKey:@"component"];
        }
        else
        {
            _component = @"";
        }
        
        if ([dic objectForKey:@"amount"])
        {
            _amount = [dic objectForKey:@"amount"];
        }
        else
        {
            _amount = @"";
        }
        
        if ([dic objectForKey:@"requests"])
        {
            _requests = [dic objectForKey:@"requests"];
        }
        else
        {
            _requests = @"";
        }
        
        if ([dic objectForKey:@"date"])
        {
            _prescribedDate = [dic objectForKey:@"date"];
        }
        else
        {
            _prescribedDate = @"";
        }
        
        
        
        if ([dic objectForKey:@"docfname"])
        {
            _docfname = [dic objectForKey:@"docfname"];
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
        
        
        if ([dic objectForKey:@"dspeciality"])
        {
            _dspeciality = [dic objectForKey:@"dspeciality"];
        }
        else
        {
            _dspeciality = @"";
        }
        
        if ([dic objectForKey:@"docprof"])
        {
            _docprof = [dic objectForKey:@"docprof"];
        }
        else
        {
            _docprof = @"";
        }
        
        _conditions = [NSMutableArray array];
        _allergy = [NSMutableArray array];
         _refillArray = [NSMutableArray array];
       
        
    }
    
    return self;
}

@end
