//
//  Pharmacy.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Pharmacy.h"



@implementation Pharmacy

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
        if ([dic objectForKey:@"formatted_address"])
        {
            _address = [dic objectForKey:@"formatted_address"];
        }
        else
        {
            _address = @"";
        }
        
        if ([dic objectForKey:@"icon"])
        {
            _icon = [dic objectForKey:@"icon"];
        }
        else
        {
            _icon = @"";
        }
        if ([dic objectForKey:@"name"])
        {
            _pharmName = [dic objectForKey:@"name"];
        }
        else
        {
            _pharmName = @"";
        }
        
        
    }
    
    return self;
}


- (id)initWithDic2:(NSDictionary *)dic
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

        if ([dic objectForKey:@"pharmadd"])
        {
            _address = [dic objectForKey:@"pharmadd"];
        }
        else
        {
            _address = @"";
        }
        
        if ([dic objectForKey:@"icon"])
        {
            _icon = [dic objectForKey:@"icon"];
        }
        else
        {
            _icon = @"";
        }
        if ([dic objectForKey:@"pharmname"])
        {
            _pharmName = [dic objectForKey:@"pharmname"];
        }
        else
        {
            _pharmName = @"";
        }
        
        
    }
    
    return self;
}




- (void)encodeWithCoder:(NSCoder *)encoder {
    
    //Encode properties, other class variables, etc
    [encoder encodeObject:_address forKey:@"formatted_address"];
    [encoder encodeObject:_icon forKey:@"icon"];
    [encoder encodeObject:_pharmName forKey:@"pharmacyName"];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //uid, username, email, firstname, lastname, profileimage & signature
        //decode properties, other class vars
        _address = [decoder decodeObjectForKey:@"formatted_address"];
        _icon = [decoder decodeObjectForKey:@"icon"];
        _pharmName = [decoder decodeObjectForKey:@"pharmacyName"];

        //  self.signature = [decoder decodeObjectForKey:@"signature"];
    }
    return self;
}



@end
