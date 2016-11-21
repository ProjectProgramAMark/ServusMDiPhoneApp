//
//  DrugIndicationsSearchAPIClient.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DrugIndicationsSearchAPIClient.h"

@implementation DrugIndicationsSearchAPIClient


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



- (void)searchForDrug:(NSString *)drugText completion:(DrugIndicationsSearchResponseBlock)completion{
    NSString *urlString = [NSString stringWithFormat:@"%@/ICD10CM/%@/DispensableDrugsToTreat?callSystemName=ClientTesting", BASE_URL, drugText];
    
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


- (void)searchForDrugByID:(NSString *)drugText completion:(DrugIndicationsSearchResponseBlock2)completion {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/DispensableDrugs/%@?callSystemName=Demo", BASE_URL, drugText];
    
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
                           NSDictionary *med = dictionary[@"DispensableDrug"];
                           Drug *drug = [self parseDictionaryArrayToDrugArray2:med];
                           completion(drug, nil);
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
        Drug *drug = [[Drug alloc] init];
        drug.dispensableDrugDesc = dictionary[@"DispensableDrugDesc"];
        drug.doseFormDesc = dictionary[@"DoseFormDesc"];
        drug.DispensableDrugID = dictionary[@"DispensableDrugID"];
        drug.DefaultETCDesc = dictionary[@"DefaultETCDesc"];
        drug.StatusCodeDesc = dictionary[@"StatusCodeDesc"];
        drug.NameTypeCode = dictionary[@"NameTypeCode"];
        drug.NameTypeCodeDesc = dictionary[@"NameTypeCodeDesc"];
        drug.DoseFormID = dictionary[@"DoseFormID"];
        drug.RouteID = dictionary[@"RouteID"];
        drug.RouteDesc = dictionary[@"RouteDesc"];
        drug.GenericDispensableDrugDesc = dictionary[@"GenericDispensableDrugDesc"];
        drug.GenericDispensableDrugID = dictionary[@"GenericDispensableDrugID"];
        drug.MedStrength = dictionary[@"MedStrength"];
        drug.MedStrengthUnit = dictionary[@"MedStrengthUnit"];
        drug.Ingredients = [[NSMutableArray alloc] init];
        NSMutableArray *ingrediantArray = [NSMutableArray array];
        
        for (NSDictionary *dict in dictionary[@"Ingredients"]) {
            Ingrediant *ingr = [[Ingrediant alloc] init];
            ingr.IngredientID = dict[@"IngredientID"];
            ingr.IngredientDesc = dict[@"IngredientDesc"];
            ingr.IngredientType = dict[@"IngredientType "];
            
            [ingrediantArray addObject:ingr];
        }
        
        drug.Ingredients = ingrediantArray;
        [drugs addObject:drug];
    }
    return drugs;
}

- (Drug *) parseDictionaryArrayToDrugArray2:(NSDictionary *)dictionary{
    
    Drug *drug = [[Drug alloc] init];
    drug.dispensableDrugDesc = dictionary[@"DispensableDrugDesc"];
    drug.doseFormDesc = dictionary[@"DoseFormDesc"];
    drug.DispensableDrugID = dictionary[@"DispensableDrugID"];
    drug.DefaultETCDesc = dictionary[@"DefaultETCDesc"];
    drug.StatusCodeDesc = dictionary[@"StatusCodeDesc"];
    drug.NameTypeCode = dictionary[@"NameTypeCode"];
    drug.NameTypeCodeDesc = dictionary[@"NameTypeCodeDesc"];
    drug.DoseFormID = dictionary[@"DoseFormID"];
    drug.RouteID = dictionary[@"RouteID"];
    drug.RouteDesc = dictionary[@"RouteDesc"];
    drug.GenericDispensableDrugDesc = dictionary[@"GenericDispensableDrugDesc"];
    drug.GenericDispensableDrugID = dictionary[@"GenericDispensableDrugID"];
    drug.MedStrength = dictionary[@"MedStrength"];
    drug.MedStrengthUnit = dictionary[@"MedStrengthUnit"];
    drug.Ingredients = [[NSMutableArray alloc] init];
    NSMutableArray *ingrediantArray = [NSMutableArray array];
    
    for (NSDictionary *dict in dictionary[@"Ingredients"]) {
        Ingrediant *ingr = [[Ingrediant alloc] init];
        ingr.IngredientID = dict[@"IngredientID"];
        ingr.IngredientDesc = dict[@"IngredientDesc"];
        ingr.IngredientType = dict[@"IngredientType "];
        
        [ingrediantArray addObject:ingr];
    }
    
    drug.Ingredients = ingrediantArray;
    //[drugs addObject:drug];
    
    return drug;
}



@end
