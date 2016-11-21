//
//  LinkPatientsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "BaseViewController.h"
#import "AFViewShaker.h"

@interface LinkPatientsViewController : BaseViewController <UITextFieldDelegate> {
    IBOutlet UITextField *passcode;
    IBOutlet UIView *passcodeSeperator;
    IBOutlet UIView *patientIDSeperator;
    IBOutlet UITextField *patientID;
    IBOutlet UIButton *linkButton;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray * allTextFields;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray * allButtons;

@property (nonatomic, strong) AFViewShaker * viewShaker;

@end
