//
//  SharedDocuments.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/7/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedDocuments : NSObject

@property (nonatomic, retain) NSString *fromdoc;
@property (nonatomic, retain) NSString *todoc;
@property (nonatomic, retain) NSString *postid;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *patientid;
@property (nonatomic, retain) NSString *read;
@property (nonatomic, retain) NSString *nid;
@property (nonatomic, retain) NSString *toprofimg;
@property (nonatomic, retain) NSString *tofirstname;
@property (nonatomic, retain) NSString *tolastname;
@property (nonatomic, retain) NSString *fromprofimg;
@property (nonatomic, retain) NSString *fromfirstname;
@property (nonatomic, retain) NSString *fromlastname;



- (id)initWithDic:(NSDictionary *)dic;

@end
