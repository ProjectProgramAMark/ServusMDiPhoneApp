//
//  DrugIndicationsSearchAPIClient.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drug.h"
#import "Ingrediant.h"

@interface DrugIndicationsSearchAPIClient : NSObject


@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;

typedef void (^DrugIndicationsSearchResponseBlock)(NSArray*, NSError*);
typedef void (^DrugIndicationsSearchResponseBlock2)(Drug*, NSError*);

- (void)searchForDrug:(NSString*) drugText completion:(DrugIndicationsSearchResponseBlock)completion;

- (void)searchForDrugByID:(NSString*) drugText completion:(DrugIndicationsSearchResponseBlock2)completion;

@end
