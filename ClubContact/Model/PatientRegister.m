//
//  PatientRegister.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PatientRegister.h"

@implementation PatientRegister


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_firstName forKey:@"firstName"];
    [encoder encodeObject:_lastName forKey:@"lastName"];
       [encoder encodeObject:_email forKey:@"email"];
    [encoder encodeObject:_password forKey:@"password"];
    [encoder encodeObject:_username forKey:@"username"];
    [encoder encodeObject:_gender forKey:@"gender"];
    
 [encoder encodeObject:_passcode forKey:@"passcode"];
    // [encoder encodeObject:_comCountry forKey:@"comCountry"];
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil ) {
        _firstName = [decoder decodeObjectForKey:@"firstName"];
        _lastName = [decoder decodeObjectForKey:@"lastName"];
        _email = [decoder decodeObjectForKey:@"email"];
        _password = [decoder decodeObjectForKey:@"password"];
        _username = [decoder decodeObjectForKey:@"username"];
        _gender =[decoder decodeObjectForKey:@"gender"];
        _passcode =[decoder decodeObjectForKey:@"passcode"];
       
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *) zone
{
    PatientRegister *accountCopy = [[PatientRegister allocWithZone: zone] init];
    accountCopy.firstName = _firstName;
    accountCopy.lastName = _lastName;
       accountCopy.email = _email;
    accountCopy.password = _password;
    accountCopy.username =  _username;
     accountCopy.gender =  _gender;
      accountCopy.passcode =  _passcode;
    
    
    
    return accountCopy;
}



@end
