//
//  Consulatation.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Consulatation.h"

@implementation Consulatation

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
        
        if ([dic objectForKey:@"consulttime"])
        {
            _consultime = [dic objectForKey:@"consulttime"];
        }
        else
        {
            _consultime = @"";
        }
        if ([dic objectForKey:@"type"])
        {
            _ctype = [dic objectForKey:@"type"];
        }
        else
        {
            _ctype = @"";
        }
        
        if ([dic objectForKey:@"notes"])
        {
            _cnotes = [dic objectForKey:@"notes"];
        }
        else
        {
            _cnotes = @"";
        }
        
        if ([dic objectForKey:@"link"])
        {
            _clink= [dic objectForKey:@"link"];
        }
        else
        {
            _clink = @"";
        }
        
        if ([dic objectForKey:@"ccost"])
        {
            _ccost = [dic objectForKey:@"ccost"];
        }
        else
        {
            _ccost = @"";
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
        
        if ([dic objectForKey:@"acceptedtime"])
        {
            _acceptedtime = [dic objectForKey:@"acceptedtime"];
        }
        else
        {
            _acceptedtime  = @"";
        }
        
        if ([dic objectForKey:@"pmail"])
        {
            _pmail = [dic objectForKey:@"pmail"];
        }
        else
        {
            _pmail  = @"";
        }
        
        if ([dic objectForKey:@"consultedtele"])
        {
            _consultedtele = [dic objectForKey:@"consultedtele"];
        }
        else
        {
            _consultedtele  = @"";
        }
        
        if ([dic objectForKey:@"whatWould"])
        {
            _whatWould = [dic objectForKey:@"whatWould"];
        }
        else
        {
            _whatWould  = @"";
        }
        
        if ([dic objectForKey:@"primaryPhysician"])
        {
            _primaryPhysician = [dic objectForKey:@"primaryPhysician"];
        }
        else
        {
            _primaryPhysician  = @"";
        }
        
        if ([dic objectForKey:@"pharmname"])
        {
            _pharmname = [dic objectForKey:@"pharmname"];
        }
        else
        {
            _pharmname  = @"";
        }
        if ([dic objectForKey:@"pharmadd"])
        {
            _pharmadd = [dic objectForKey:@"pharmadd"];
        }
        else
        {
            _pharmadd  = @"";
        }
        
        
    }
    
    return self;
}


@end
