//
//  BankDetails.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankDetails : NSObject


@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *bankname;
@property (nonatomic, retain) NSString *bankaddress;
@property (nonatomic, retain) NSString *accno;
@property (nonatomic, retain) NSString *accname;
@property (nonatomic, retain) NSString *routeno;
@property (nonatomic, retain) NSString *credits;
@property (nonatomic, retain) NSString *withdraw;

- (id)initWithDic:(NSDictionary *)dic;

@end
