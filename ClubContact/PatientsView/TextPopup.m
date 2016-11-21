//
//  TextPopup.m
//  ClubContact
//
//  Created by wangkun on 15/4/5.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import "TextPopup.h"

@implementation TextPopup
{
    UIView *grayBackView;
    UITextView *textView;
}

+ (TextPopup *)popUpViewText:(NSString *)text
{
    float scale = 1.0;
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.size.width *= scale;
    frame.size.height *= scale;
    
    TextPopup *tp = [[TextPopup alloc] initWithFrame:frame andText:text];
    tp.center = [UIApplication sharedApplication].keyWindow.center;
    
    return tp;
}

- (id)initWithFrame:(CGRect)frame andText:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _text = text;
        self.backgroundColor = [UIColor clearColor];
        grayBackView = [[UIView alloc] initWithFrame:self.frame];
        grayBackView.backgroundColor = [UIColor blackColor];
        grayBackView.alpha = 1.0;
        [self addSubview:grayBackView];
        
        textView = [UITextView new];
        textView.text = text;
        textView.font = [UIFont systemFontOfSize:20];
        textView.userInteractionEnabled = FALSE;
        textView.editable = FALSE;
        [self addSubview:textView];

        UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInOtherArea)];
        [self addGestureRecognizer:tapRec];
    }
    return self;
}

- (void)tapInOtherArea
{
    [self dismiss];
}

- (void)showInKeyWindow
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float textScale = 0.8;
    
    grayBackView.frame = self.bounds;
    
    textView.frame = CGRectMake(0, 0, self.frame.size.width * textScale, self.frame.size.height * textScale);
    textView.center = [UIApplication sharedApplication].keyWindow.center;
}

@end
