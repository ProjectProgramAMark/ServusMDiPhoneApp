//
//  Notifications.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 8/5/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notifications : NSObject


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *postid;
@property (nonatomic, retain) NSString *fusername;
@property (nonatomic, retain) NSString *fname;
@property (nonatomic, retain) NSString *fmail;
@property (nonatomic, retain) NSString *ffirstname;
@property (nonatomic, retain) NSString *flastname;
@property (nonatomic, retain) NSString *notiType;
@property (nonatomic, retain) NSString *notiID;
@property (nonatomic, retain) NSString *fprofImage;
@property (nonatomic, retain) NSString *ftype;
@property (nonatomic, retain) NSString *fcreated;
@property (nonatomic, retain) NSString *fuid;
@property (nonatomic, retain) NSString *puid;
@property (nonatomic, retain) NSString *pfirstname;
@property (nonatomic, retain) NSString *plastname;
@property (nonatomic, retain) NSString *pProfIMG;
@property (nonatomic, retain) NSString *isRead;


- (id)initWithDic:(NSDictionary *)dic;
@end
