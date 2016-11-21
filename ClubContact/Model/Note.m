//
//  Note.m
//  ClubContact
//
//  Created by wangkun on 15/4/5.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import "Note.h"

@implementation Note

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        if ([dic objectForKey:@"id"] != nil)
        {
            _noteID  = [dic objectForKey:@"id"];
        }
        else
        {
            _noteID = @"";
        }
        
        if ([dic objectForKey:@"timestamp"] != nil)
        {
            _timestamp = [dic objectForKey:@"timestamp"];
        }
        else
        {
            _timestamp = @"";
        }
        
        if ([dic objectForKey:@"notetext"] != nil)
        {
            if ([[dic objectForKey:@"notetext"] isKindOfClass:[NSNull class]])
            {
                _notetext = @"";
            }
            else
            {
                _notetext = [dic objectForKey:@"notetext"];
            }
        }
        else
        {
            _notetext = @"";
        }
        
        if ([dic objectForKey:@"noteimage"] != nil)
        {
            _noteimage = [dic objectForKey:@"noteimage"];
        }
        else
        {
            _noteimage = @"";
        }
        
        if ([dic objectForKey:@"noterecording"])
        {
            _noterecording = [dic objectForKey:@"noterecording"];
        }
        else
        {
            _noterecording = @"";
        }
        
        if ([dic objectForKey:@"notetitle"])
        {
            _notetitle = [dic objectForKey:@"notetitle"];
        }
        else
        {
            _notetitle = @"";
        }
        
    }
    
    return self;
}

@end
