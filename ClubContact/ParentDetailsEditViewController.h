//
//  ParentDetailsEditViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 2/16/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "BaseViewController.h"
#import "EXPhotoViewer.h"
#import "UIAlertView+Blocks.h"

@interface ParentDetailsEditViewController : BaseViewController <UITextFieldDelegate, UIImagePickerControllerDelegate> {
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
    
    
    NSString *parentDOBString;
    
    UIImage *myID;
    UIImage *parentID;
    
    BOOL isParentPhoto;
    BOOL isParentDOB;
    
    IBOutlet UIView *datePickerContainer;
    IBOutlet UIDatePicker *datePick;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (nonatomic, strong) PMaster *pmaster;

@end
