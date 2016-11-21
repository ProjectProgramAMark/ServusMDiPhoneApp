//
//  PersonalSignatureView.h
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureView.h"

typedef void (^PersonalSignatureViewBlock)();

@interface PersonalSignatureView : UIView <SignatureViewDelegate>

@property (strong, nonatomic) IBOutlet SignatureView *signatureView;

@property (nonatomic, copy) PersonalSignatureViewBlock acceptPersonalSignatureViewBlock;

@end
