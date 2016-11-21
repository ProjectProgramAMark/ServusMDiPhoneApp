//
//  DrugSearchAPIClient.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drug.h"
#import "Ingrediant.h"

@interface DrugSearchAPIClient : NSObject

@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;

typedef void (^DrugSearchResponseBlock)(NSArray*, NSError*);
typedef void (^DrugSearchResponseBlock2)(Drug*, NSError*);

- (void)searchForDrug:(NSString*) drugText completion:(DrugSearchResponseBlock)completion;

- (void)searchForDrugByID:(NSString*) drugText completion:(DrugSearchResponseBlock2)completion;

@end


