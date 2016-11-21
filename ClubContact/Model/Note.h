//
//  Note.h
//  ClubContact
//
//  Created by wangkun on 15/4/5.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, retain) NSString *noteID;
@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic, retain) NSString *notetext;
@property (nonatomic, retain) NSString *noteimage;
@property (nonatomic, retain) NSString *noterecording;
@property (nonatomic, retain) NSString *notetitle;

- (id)initWithDic:(NSDictionary *)dic;

@end
