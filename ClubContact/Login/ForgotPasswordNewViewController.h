//
//  ForgotPasswordNewViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/17/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AFViewShaker.h"
#import "Chameleon.h"


@interface ForgotPasswordNewViewController : BaseViewController {
    IBOutlet UIImageView *backgroundImageView;
    IBOutlet UIImageView *logoImageView;
    IBOutlet UIView *loginView;
    
    IBOutlet UIActivityIndicatorView *actIndicator;
    
    int offSetKeyboard;
    CGRect keyboardFrame;
    BOOL isOffSet;
    int commentOffset2;
    
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) AFViewShaker * viewShaker;
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray * allTextFields;

@end
