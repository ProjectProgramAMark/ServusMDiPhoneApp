//
//  SignatureView.h
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignatureView;

@protocol SignatureViewDelegate <NSObject>

- (void)didSignature:(SignatureView *)signatureView;

@end

@interface SignatureView : UIView
@property (nonatomic, readonly) BOOL drawnSignature;
@property (nonatomic, assign) id <SignatureViewDelegate> delegate;

- (void)erase;
- (void)setBrushColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
- (UIImage *)getSignatureImage;


@end
