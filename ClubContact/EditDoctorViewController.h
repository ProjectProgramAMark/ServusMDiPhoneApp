//
//  EditDoctorViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctors.h"
#import "BaseViewController.h"
#import "CountryPicker.h"

@class EditDoctorViewController;             //define class, so protocol can see MyClass
@protocol EditDoctorDelegate <NSObject>   //define delegate protocol
- (void) doctorEditDone:(Doctors *)patientinfo;  //define delegate method to be implemented within another class
@end


@interface EditDoctorViewController : BaseViewController<CountryPickerDelegate, UITextFieldDelegate> {
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
    
    
}

@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, weak) id <EditDoctorDelegate> delegate;



@end
