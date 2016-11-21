//
//  Allergen.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Allergen : NSObject

@property (nonatomic, copy) NSString *postid;

@property (nonatomic, copy) NSString *PicklistID;

@property (nonatomic, copy) NSString *PicklistDesc;

@property (nonatomic, copy) NSString *PicklistConceptType;

@property (nonatomic, copy) NSString *HL7ObjectIdentifier;

@property (nonatomic, copy) NSString *HL7ObjectIdentifierType;

- (id)initWithDic:(NSDictionary *)dic;


@end
