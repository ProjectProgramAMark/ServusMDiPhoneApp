//
//  DeviceInfo.m
//  ClubContact
//
//  Created by wangkun on 15/3/12.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import "DeviceInfo.h"
#import "Constant.h"

@implementation DeviceInfo

+ (void)updateDeviceInfo
{
    NSURL *iPURL = [NSURL URLWithString:@"http://www.geoplugin.net/json.gp"];
    NSString *theIpHtml;
    if (iPURL) {
        NSError *error = nil;
        theIpHtml = [NSString stringWithContentsOfURL:iPURL encoding:NSUTF8StringEncoding error:&error];
        if (!error)
        {
            NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [theIpHtml dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: nil];
            
            if (JSON != nil)
            {                
                DeviceInfo *deviceInfo = [DeviceInfo new];
                deviceInfo.city =  [JSON objectForKey:@"geoplugin_city"];
                deviceInfo.state =  [JSON objectForKey:@"geoplugin_region"];
                deviceInfo.country =  [JSON objectForKey:@"geoplugin_countryCode"];
                deviceInfo.version =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                deviceInfo.ipaddress =  [JSON objectForKey:@"geoplugin_request"];
                
                [deviceInfo saveToUserDefault];
            }
        }
        else
        {
            NSLog(@"Oops... g %d, %@", [error code], [error localizedDescription]);
        }
    }
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.state forKey:@"state"];
    [encoder encodeObject:self.country forKey:@"country"];
    [encoder encodeObject:self.version forKey:@"version"];
    [encoder encodeObject:self.ipaddress forKey:@"ipaddress"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.city = [decoder decodeObjectForKey:@"city"];
        self.state = [decoder decodeObjectForKey:@"state"];
        self.country = [decoder decodeObjectForKey:@"country"];
        self.version = [decoder decodeObjectForKey:@"version"];
        self.ipaddress = [decoder decodeObjectForKey:@"ipaddress"];
    }
    return self;
}

- (void)saveToUserDefault
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [defaults setObject:data forKey:kDeviceUserDefault];
    [defaults synchronize];
}

+ (DeviceInfo *)getFromUserDefault
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:kDeviceUserDefault];
    DeviceInfo *deviceInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [defaults synchronize];
    
    return deviceInfo;
}

@end
