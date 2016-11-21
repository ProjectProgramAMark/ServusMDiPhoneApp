//
//  SearchPharmacyAPIClient.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/15/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SearchPharmacyAPIClient.h"

@implementation SearchPharmacyAPIClient


static const NSString *AUTH_SCHEME = @"SHAREDKEY";
static const NSString *CLIENT_ID = @"1062";
static const NSString *SECRET = @"cKMtNnvwAAuMG9hALjEySV3CggLAPFuV6xM0MR8/lSU=";
static const NSString *BASE_URL = @"https://api.fdbcloudconnector.com/cc/api/v1_3";

- (instancetype)init{
    self = [super init];
    if (self) {
        self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSString *authString = [NSString stringWithFormat:@"%@ %@:%@", AUTH_SCHEME, CLIENT_ID, SECRET];
        
       // [self.sessionConfig setHTTPAdditionalHeaders:@{ @"Content-Type" : @"applicationjson;charset=UTF-8", @"Authorization" : authString, @"Accept" : @"application/json"}];
    }
    return self;
}

- (void)searchForPharmacy:(NSString *)drugText completion:(SearchPharmacyResponseBlock)completion{
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&types=pharmacy&key=AIzaSyChQU-HrMF4atknKCG3YLeT-vhM5hRJXkA", drugText];
    
    NSLog(@"URL String %@", urlString);
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:self.sessionConfig];
    
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:[NSURL URLWithString:urlString]
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               
               if(completion){
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                       
                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                       if(httpResponse.statusCode != 200 || error){
                           completion(nil, [NSError errorWithDomain:@"" code:1 userInfo:@{NSLocalizedDescriptionKey: @"Search Failed"}]);
                           return;
                       }
                       
                       NSError *jsonError;
                       NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                       
                       if(data && !jsonError){
                           NSArray *meds = dictionary[@"results"];
                           NSArray *drugArray = [self parseDictionaryArrayToDrugArray:meds];
                           completion(drugArray, nil);
                       }else{
                           completion(nil, [NSError errorWithDomain:@"" code:1 userInfo:@{NSLocalizedDescriptionKey: @"Search Failed"}]);
                       }
                   });
               }
           }];
    [task resume];
}


- (NSArray *) parseDictionaryArrayToDrugArray:(NSArray*)array{
    NSMutableArray *allergens = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        Pharmacy *pharmacy = [[Pharmacy alloc] init];
        pharmacy.address = dictionary[@"formatted_address"];
        pharmacy.pharmName = dictionary[@"name"];
        pharmacy.icon = dictionary[@"icon"];
        
        [allergens addObject:pharmacy];
    }
    return allergens;
}

@end
