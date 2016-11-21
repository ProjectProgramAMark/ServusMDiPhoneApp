//
//  Drug.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Drug : NSObject

@property (nonatomic, copy) NSString *dispensableDrugDesc;

@property (nonatomic, copy) NSString *doseFormDesc;

@property (nonatomic, copy) NSString *DefaultETCDesc;

@property (nonatomic, copy) NSString *DispensableDrugID;

@property (nonatomic, copy) NSString *StatusCodeDesc;

@property (nonatomic, copy) NSString *NameTypeCode;

@property (nonatomic, copy) NSString *NameTypeCodeDesc;

@property (nonatomic, copy) NSString *RouteDesc;

@property (nonatomic, copy) NSString *RouteID;

@property (nonatomic, copy) NSString *DoseFormID;

//@property (nonatomic, copy) NSString *DoseFormDesc;

@property (nonatomic, copy) NSString *GenericDispensableDrugID;

@property (nonatomic, copy) NSString *GenericDispensableDrugDesc;

@property (nonatomic, copy) NSString *MedStrength;

@property (nonatomic, copy) NSString *MedStrengthUnit;

@property (nonatomic, copy) NSMutableArray *Ingredients;

@end
