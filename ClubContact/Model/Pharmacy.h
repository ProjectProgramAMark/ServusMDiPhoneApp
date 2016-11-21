//
//  Pharmacy.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pharmacy : NSObject

@property (nonatomic, retain) NSString *icon;
@property (nonatomic, retain) NSString *pharmName;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *postid;

- (id)initWithDic:(NSDictionary *)dic;
- (id)initWithDic2:(NSDictionary *)dic;

@end
