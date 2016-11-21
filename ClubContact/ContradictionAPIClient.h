//
//  ContradictionAPIClient.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contradiction.h"

@interface ContradictionAPIClient : NSObject

@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;

typedef void (^ContradictionResponseBlock)(NSArray*, NSError*);

- (void)searchForContradiction:(NSString*) drugText completion:(ContradictionResponseBlock)completion;


@end
