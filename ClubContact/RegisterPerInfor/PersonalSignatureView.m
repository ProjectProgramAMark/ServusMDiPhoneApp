//
//  PersonalSignatureView.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PersonalSignatureView.h"

@implementation PersonalSignatureView

- (void)awakeFromNib
{
    _signatureView.delegate = self;
    [_signatureView erase];
    self.layer.cornerRadius = 10.0;
}

#pragma mark - Signature delegagte

- (void)didSignature:(SignatureView *)signatureView
{

}

- (IBAction)onClearAction:(id)sender
{
   // self.hidden = true;
    [_signatureView erase];
    
}

- (IBAction)onAgreeAction:(id)sender
{
    if (_acceptPersonalSignatureViewBlock) {
        _acceptPersonalSignatureViewBlock();
    }
}

@end
