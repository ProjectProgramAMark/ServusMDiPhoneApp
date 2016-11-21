//
//  SearchPharmacyAPIClient.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/15/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pharmacy.h"

@interface SearchPharmacyAPIClient : NSObject

@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;

typedef void (^SearchPharmacyResponseBlock)(NSArray*, NSError*);

- (void)searchForPharmacy:(NSString*) drugText completion:(SearchPharmacyResponseBlock)completion;


@end
