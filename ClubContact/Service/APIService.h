//
//  APIService.h
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIConfig.h"
#import "AFHTTPRequestOperationManager.h"
#import "Account.h"

typedef void (^APICompletion)(NSDictionary *responseDict);

@interface APIService : AFHTTPRequestOperationManager

+ (APIService *)sharedInstance;

- (void)checkPhysciansWithLastname:(NSString *)lastName andNPI:(NSString *)npi completion:(APICompletion)block;
- (void)registerData:(NSDictionary *)Datadic completion:(APICompletion)block;

@end
