//
//  Doctor.m
//  ClubContact
//
//  Created by wangkun on 15/3/14.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.firstname forKey:@"firstname"];
    [encoder encodeObject:self.lastname forKey:@"lastname"];
    [encoder encodeObject:self.profileimage forKey:@"profileimage"];
    [encoder encodeObject:self.signature forKey:@"signature"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
    //uid, username, email, firstname, lastname, profileimage & signature
        //decode properties, other class vars
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.firstname = [decoder decodeObjectForKey:@"firstname"];
        self.lastname = [decoder decodeObjectForKey:@"lastname"];
        self.profileimage = [decoder decodeObjectForKey:@"profileimage"];
        self.signature = [decoder decodeObjectForKey:@"signature"];
    }
    return self;
}

- (void)saveToUserDefault
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [defaults setObject:data forKey:kDoctorUserDefault];
    [defaults synchronize];
}

+ (Doctor *)getFromUserDefault
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kDoctorUserDefault];
    Doctor *doctorInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [defaults synchronize];
    
    return doctorInfo;
}


@end
