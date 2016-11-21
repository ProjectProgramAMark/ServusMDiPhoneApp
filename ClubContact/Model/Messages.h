//
//  Messages.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/3/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Messages : NSObject

@property (nonatomic, retain) NSString *messageid;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *toid;
@property (nonatomic, retain) NSString *fromid;
@property (nonatomic, retain) NSString *sentdate;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *seen;
@property (nonatomic, retain) NSString *seendate;
@property (nonatomic, retain) NSString *sendertype;
@property (nonatomic, retain) NSString *msgimage;
@property (nonatomic, retain) NSString *msgvideo;
@property (nonatomic, retain) NSString *touid;
@property (nonatomic, retain) NSString *tofirstname;
@property (nonatomic, retain) NSString *tolastname;
@property (nonatomic, retain) NSString *totele;
@property (nonatomic, retain) NSString *toemail;
@property (nonatomic, retain) NSString *toprofilepic;
@property (nonatomic, retain) NSString *fromuid;
@property (nonatomic, retain) NSString *fromfirstname;
@property (nonatomic, retain) NSString *fromlastname;
@property (nonatomic, retain) NSString *fromtele;
@property (nonatomic, retain) NSString *fromemail;
@property (nonatomic, retain) NSString *fromprofilepic;

- (id)initWithDic:(NSDictionary *)dic;

@end
