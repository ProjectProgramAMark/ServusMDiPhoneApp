//
//  PatientMedication.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/16/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientMedication : NSObject


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *postid;

@property (nonatomic, retain) NSString *medname;
@property (nonatomic, retain) NSString *medid;
@property (nonatomic, retain) NSString *patientid;
@property (nonatomic, retain) NSString *dose;    //Patients dob in unix time
@property (nonatomic, retain) NSString *doseunit;    //Patients occupation

@property (nonatomic, retain) NSString *pharmacy;
@property (nonatomic, retain) NSString *pharmaddress;
@property (nonatomic, retain) NSString *refills;
@property (nonatomic, retain) NSString *component;
@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSString *requests;
@property (nonatomic, retain) NSString *prescribedDate;

@property (nonatomic, retain) NSString *docfname;
@property (nonatomic, retain) NSString *doclname;
@property (nonatomic, retain) NSString *docid;
@property (nonatomic, retain) NSString *docsuffix;
@property (nonatomic, retain) NSString *dspeciality;
@property (nonatomic, retain) NSString *docprof;




@property (nonatomic, retain) NSMutableArray *allergy;
@property (nonatomic, retain) NSMutableArray *conditions;
@property (nonatomic, retain) NSMutableArray *refillArray;

- (id)initWithDic:(NSDictionary *)dic;

@end
