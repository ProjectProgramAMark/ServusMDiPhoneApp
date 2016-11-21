//
//  TextPopup.h
//  ClubContact
//
//  Created by wangkun on 15/4/5.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextPopup : UIView
{

}


@property (nonatomic, strong) NSString *text;

+ (TextPopup *)popUpViewText:(NSString *)text;
- (void)showInKeyWindow;
- (void)dismiss;
@end
