//
//  RegOther2ViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 2/15/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PatientRegister.h"
#import "SubscriptionPlanViewController.h"

@interface RegOther2ViewController : BaseViewController <UIImagePickerControllerDelegate> {
    IBOutlet UIButton *myDOBButton;
    IBOutlet UIButton *myIDButton;
    
    NSString *myDOBString;
    
    UIImage *myID;
    
    BOOL isParentPhoto;
    BOOL isParentDOB;
    
    IBOutlet UIView *datePickerContainer;
    IBOutlet UIDatePicker *datePick;
}

@property (nonatomic, retain) Account *account;


@end
