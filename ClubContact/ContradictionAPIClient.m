//
//  ContradictionAPIClient.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "ContradictionAPIClient.h"

@implementation ContradictionAPIClient


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

- (void)searchForContradiction:(NSString *)drugText completion:(ContradictionResponseBlock)completion{
    NSString *urlString = [NSString stringWithFormat:@"%@/ICD10CM/%@/DrugDiseaseContraindications?callSystemName=Demo", BASE_URL, drugText];
    
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
                           NSArray *meds = dictionary[@"Items"];
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
        Contradiction *contra = [[Contradiction alloc] init];
        contra.DrugDesc = dictionary[@"DrugDesc"];
        contra.DrugID = dictionary[@"DrugID"];
        contra.DrugConceptType = dictionary[@"DrugConceptType"];
        contra.HitConditionDesc = dictionary[@"HitConditionDesc"];
        contra.HitConditionID = dictionary[@"HitConditionID"];
        contra.Severity = dictionary[@"Severity"];
        contra.SeverityDesc = dictionary[@"SeverityDesc"];
        
        
        // drug.dispensableDrugDesc = dictionary[@"DispensableDrugDesc"];
        // drug.doseFormDesc = dictionary[@"DoseFormDesc"];
        [allergens addObject:contra];
    }
    return allergens;
}


@end
