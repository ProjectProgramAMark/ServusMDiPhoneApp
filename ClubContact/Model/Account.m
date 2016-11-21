//
//  Account.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Account.h"

@implementation Account

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_firstName forKey:@"firstName"];
    [encoder encodeObject:_lastName forKey:@"lastName"];
    [encoder encodeObject:_ml forKey:@"ml"];
    [encoder encodeObject:_suffix forKey:@"suffix"];
    [encoder encodeObject:_dea forKey:@"dea"];
    [encoder encodeObject:_npi forKey:@"npi"];
    [encoder encodeObject:_me forKey:@"me"];
    [encoder encodeObject:_email forKey:@"email"];
    [encoder encodeObject:_password forKey:@"password"];
    [encoder encodeObject:_signature forKey:@"signature"];
    
    [encoder encodeObject:_comName forKey:@"comName"];
    [encoder encodeObject:_comAddress forKey:@"comAddress"];
    [encoder encodeObject:_comCity forKey:@"comCity"];
    [encoder encodeObject:_comState forKey:@"comState"];
    [encoder encodeObject:_comZipCode forKey:@"comZipCode"];
    [encoder encodeObject:_comPhoneNumber forKey:@"comPhoneNumber"];
    // [encoder encodeObject:_comCountry forKey:@"comCountry"];
    [encoder encodeObject:_username forKey:@"username"];
    [encoder encodeObject:_comCountry forKey:@"country"];
    [encoder encodeObject:_speciality forKey:@"speciality"];
    [encoder encodeObject:_passcode forKey:@"passcode"];
    [encoder encodeObject:_gender forKey:@"gender"];
    [encoder encodeObject:_dob forKey:@"dob"];
    [encoder encodeObject:_idcard forKey:@"idcard"];

}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil ) {
        _firstName = [decoder decodeObjectForKey:@"firstName"];
        _lastName = [decoder decodeObjectForKey:@"lastName"];
        _ml = [decoder decodeObjectForKey:@"ml"];
        _suffix = [decoder decodeObjectForKey:@"suffix"];
        _dea = [decoder decodeObjectForKey:@"dea"];
        _npi = [decoder decodeObjectForKey:@"npi"];
        _me = [decoder decodeObjectForKey:@"me"];
        _email = [decoder decodeObjectForKey:@"email"];
        _password = [decoder decodeObjectForKey:@"password"];
        _signature = [decoder decodeObjectForKey:@"signature"];
        
        _comName = [decoder decodeObjectForKey:@"comName"];
        _comAddress = [decoder decodeObjectForKey:@"comAddress"];
        _comCity = [decoder decodeObjectForKey:@"comCity"];
        _comState = [decoder decodeObjectForKey:@"comState"];
        _comZipCode = [decoder decodeObjectForKey:@"comZipCode"];
        _comPhoneNumber = [decoder decodeObjectForKey:@"comPhoneNumber"];
     //   _comCountry = [decoder decodeObjectForKey:@"comPhoneNumber"];
        _username = [decoder decodeObjectForKey:@"username"];
        _comCountry = [decoder decodeObjectForKey:@"country"];
        _speciality = [decoder decodeObjectForKey:@"speciality"];
        _passcode = [decoder decodeObjectForKey:@"passcode"];
        _gender = [decoder decodeObjectForKey:@"gender"];
        _dob = [decoder decodeObjectForKey:@"dob"];
        _idcard = [decoder decodeObjectForKey:@"idcard"];

    }
    return self;
}

- (id)copyWithZone:(NSZone *) zone
{
    Account *accountCopy = [[Account allocWithZone: zone] init];
    accountCopy.firstName = _firstName;
    accountCopy.lastName = _lastName;
    accountCopy.ml = _ml;
    accountCopy.suffix = _suffix;
    accountCopy.dea = _dea;
    accountCopy.npi = _npi;
    accountCopy.me = _me;
    accountCopy.email = _email;
    accountCopy.password = _password;
    accountCopy.signature =  _signature;
    
    accountCopy.comName = _comName;
    accountCopy.comAddress = _comAddress;
    accountCopy.comCity = _comCity;
    accountCopy.comState = _comState;
    accountCopy.comZipCode = _comZipCode;
    accountCopy.comPhoneNumber = _comPhoneNumber;
    accountCopy.username = _username;
    accountCopy.comCountry = _comCountry;
    accountCopy.speciality = _speciality;
    accountCopy.passcode = _passcode;
    accountCopy.gender = _gender;
    accountCopy.dob = _dob;
    accountCopy.idcard = _idcard;
    
    return accountCopy;
}

@end
