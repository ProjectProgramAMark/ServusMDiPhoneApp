//
//  PatientEdicationAPIClient.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drug.h"
#import "MonoGraph.h"

@interface PatientEdicationAPIClient : NSObject

@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;

typedef void (^PatientEducationResponseBlock)(NSArray*, NSError*);

- (void)searchForPatientEdication:(NSString*) drugText completion:(PatientEducationResponseBlock)completion;

@end
