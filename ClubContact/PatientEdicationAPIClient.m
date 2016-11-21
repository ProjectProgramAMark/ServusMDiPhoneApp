//
//  PatientEdicationAPIClient.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PatientEdicationAPIClient.h"

@implementation PatientEdicationAPIClient

static const NSString *AUTH_SCHEME = @"SHAREDKEY";
static const NSString *CLIENT_ID = @"1062";
static const NSString *SECRET = @"cKMtNnvwAAuMG9hALjEySV3CggLAPFuV6xM0MR8/lSU=";
static const NSString *BASE_URL = @"https://api.fdbcloudconnector.com/cc/api/v1_3";

- (instancetype)init{
    self = [super init];
    if (self) {
        self.sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSString *authString = [NSString stringWithFormat:@"%@ %@:%@", AUTH_SCHEME, CLIENT_ID, SECRET];
        
        [self.sessionConfig setHTTPAdditionalHeaders:@{ @"Content-Type" : @"applicationjson;charset=UTF-8", @"Authorization" : authString, @"Accept" : @"application/json"}];
    }
    return self;
}

- (void)searchForPatientEdication:(NSString *)drugText completion:(PatientEducationResponseBlock)completion{
    NSString *urlString = [NSString stringWithFormat:@"%@/DispensableDrugs/%@/PatientEducationMonographs?callSystemName=Demo&language=English&useLegacyFormatting=false", BASE_URL, drugText];
    
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
                           NSDictionary *meds = dictionary[@"Monograph"];
                           //NSDictionary *menograph= [meds objectAtIndex:0];
                           NSArray *meds2 = meds[@"Sections"];
                           NSArray *drugArray = [self parseDictionaryArrayToDrugArray:meds2];
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
    NSMutableArray *drugs = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        MonoGraph *mono = [[MonoGraph alloc] init];
        mono.descText = dictionary[@"Text"];
        mono.titleText = dictionary[@"Title"];
        mono.SectionCode = dictionary[@"SectionCode"];
        mono.Sequence = dictionary[@"Sequence"];
        
        [drugs addObject:mono];
    }
    return drugs;
}

@end
