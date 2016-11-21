//
//  Allergen.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Allergen.h"

@implementation Allergen

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"id"])
        {
            _postid  = [dic objectForKey:@"id"];
        }
        else
        {
            _postid = @"";
        }
        
        if ([dic objectForKey:@"allergyid"])
        {
            _PicklistID = [dic objectForKey:@"allergyid"];
        }
        else
        {
            _PicklistID = @"";
        }
        
        if ([dic objectForKey:@"allergyname"])
        {
            _PicklistDesc = [dic objectForKey:@"allergyname"];
        }
        else
        {
            _PicklistDesc = @"";
        }
        
        
        if ([dic objectForKey:@"allergytype"])
        {
            _PicklistConceptType = [dic objectForKey:@"allergytype"];
        }
        else
        {
            _PicklistConceptType = @"";
        }
        
        if ([dic objectForKey:@"hl7id"])
        {
            _HL7ObjectIdentifier = [dic objectForKey:@"hl7id"];
        }
        else
        {
            _HL7ObjectIdentifier = @"";
        }
        
        if ([dic objectForKey:@"hl7idtype"])
        {
            _HL7ObjectIdentifierType = [dic objectForKey:@"hl7idtype"];
        }
        else
        {
            _HL7ObjectIdentifierType = @"";
        }
        
        
    }
    
    return self;
}

@end
