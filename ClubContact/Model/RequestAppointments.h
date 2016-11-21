//
//  RequestAppointments.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestAppointments : NSObject

@property (nonatomic, retain) NSString *appid;
@property (nonatomic, retain) NSString *patientid;
@property (nonatomic, retain) NSString *fromdate;
@property (nonatomic, retain) NSString *todate;
@property (nonatomic, retain) NSString *apptitle;
@property (nonatomic, retain) NSString *appnotes;
@property (nonatomic, retain) NSString *firstname;
@property (nonatomic, retain) NSString *lastname;
@property (nonatomic, retain) NSString *patientemail;
@property (nonatomic, retain) NSString *patienttele;
@property (nonatomic, retain) NSString *patientProfIMG;
@property (nonatomic, retain) NSString *occupation;

- (id)initWithDic:(NSDictionary *)dic;

@end
