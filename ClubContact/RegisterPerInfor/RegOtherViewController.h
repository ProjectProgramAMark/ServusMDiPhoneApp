//
//  RegOtherViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 2/15/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PatientRegister.h"
@interface RegOtherViewController : BaseViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate> {
    IBOutlet UIView *parentInfoView;
    IBOutlet UITextField *parentFirstName;
    IBOutlet UITextField *parentLastName;
    IBOutlet UITextField *parentPhonNumber;
    IBOutlet UITextField *parentEmail;
    IBOutlet UITextField *parentLast4SSN;
    IBOutlet UIButton *myDOBButton;
    IBOutlet UIButton *myIDButton;
    IBOutlet UIButton *parentDOBButton;
    IBOutlet UIButton *parentIDButton;
    
    
    NSString *myDOBString;
    NSString *parentDOBString;
    
    UIImage *myID;
    UIImage *parentID;
    
    BOOL isParentPhoto;
    BOOL isParentDOB;
    
    IBOutlet UIView *datePickerContainer;
    IBOutlet UIDatePicker *datePick;
    
}

@property (nonatomic, retain) PatientRegister *patient;

@end
