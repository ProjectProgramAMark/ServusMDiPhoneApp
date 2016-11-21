//
//  AllergenSearchAPIClient.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Allergen.h"

@interface AllergenSearchAPIClient : NSObject

@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;

typedef void (^AllergenSearchResponseBlock)(NSArray*, NSError*);

- (void)searchForAllergen:(NSString*) drugText completion:(AllergenSearchResponseBlock)completion;

@end
