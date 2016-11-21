//
//  Utils.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIView *)viewFromNibNamed:(NSString *)nibName
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    UIView *xibBasedView = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[UIView class]]) {
            xibBasedView = (UIView *)nibItem;
            break;
        }
    }
    return xibBasedView;
}

+ (void)animationShowPopupView:(UIView *)view
{
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
    [UIView animateWithDuration:0.2 animations: ^(void) {
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
        view.alpha = 0.5;
    } completion:^(BOOL finished) {
        [self bounceOutAnimationStoped:view];
    }];
}

+ (void)animationHidenPopupView:(UIView *)view
{
    [UIView animateWithDuration:0.2 animations: ^(void) {
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.3f, 1.3f);
        view.alpha = 0.5;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations: ^(void) {
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
            view.alpha = 0.2;
        } completion:^(BOOL finished) {
            view.alpha = 0.0;
        }];
    }];
}

+ (void)bounceOutAnimationStoped:(UIView *)view
{
    [UIView animateWithDuration:0.1 animations: ^(void) {
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
        view.alpha = 0.8;
    } completion:^(BOOL finished) {
        [self bounceInAnimationStoped:view];
    }];
}

+ (void)bounceInAnimationStoped:(UIView *)view
{
    [UIView animateWithDuration:0.1 animations: ^(void) {
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
        view.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
}

@end
