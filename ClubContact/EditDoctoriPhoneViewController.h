//
//  EditDoctoriPhoneViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctors.h"
#import "BaseViewController.h"
#import "CountryPicker.h"

@class EditDoctoriPhoneViewController;             //define class, so protocol can see MyClass
@protocol EditDoctoriPhoneDelegate <NSObject>   //define delegate protocol
- (void) doctorEditDone:(Doctors *)patientinfo;  //define delegate method to be implemented within another class
@end


@interface EditDoctoriPhoneViewController : BaseViewController<CountryPickerDelegate, UITextFieldDelegate> {
    IBOutlet  UITextField *firstNameText;
    IBOutlet UITextField *lastnameText;
    IBOutlet UITextField *meText;
    IBOutlet UITextField *suffixText;
    IBOutlet UITextField *miText;
    IBOutlet UITextField *npiText;
    IBOutlet UITextField *deaText;
    IBOutlet UITextField *officeNameText;
    IBOutlet UITextField *addressText;
    IBOutlet UITextField *cityText;
    IBOutlet UITextField *countryText;
    IBOutlet UITextField *stateText;
    IBOutlet UITextField *zipText;
    IBOutlet UITextField *phoneText;
    IBOutlet UIDatePicker *datePick;
    IBOutlet UITextField *speciality;
    UIPickerView *countryPicker;
    NSArray *countryArray;
    
    Doctors *doctor;
    NSString *doctorID;
    
    IBOutlet UIView *textEntryView;
    IBOutlet UIScrollView *scrollView;
    
    
}

@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, weak) id <EditDoctoriPhoneDelegate> delegate;


@end
