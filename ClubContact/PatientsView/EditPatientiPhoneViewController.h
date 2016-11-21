//
//  EditPatientiPhoneViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "BaseViewController.h"
#import "CountryPicker.h"



@class EditPatientViewController;             //define class, so protocol can see MyClass
@protocol EditPatientDelegate <NSObject>   //define delegate protocol
- (void) patientEditDone:(Patient *)patientinfo;  //define delegate method to be implemented within another class
@end


@interface EditPatientiPhoneViewController : BaseViewController<CountryPickerDelegate, UITextFieldDelegate> {
    IBOutlet  UITextField *firstNameText;
    IBOutlet UITextField *lastnameText;
    IBOutlet UITextField *occupationText;
    IBOutlet UITextField *street1Text;
    IBOutlet UITextField *emailText;
    IBOutlet UITextField *phoneText;
    IBOutlet UITextField *street2Text;
    IBOutlet UITextField *cityText;
    IBOutlet UITextField *countryText;
    IBOutlet UITextField *stateText;
    IBOutlet UITextField *zipText;
    IBOutlet UITextField *last4SSN;
    IBOutlet UISegmentedControl *genderSegment;
    IBOutlet UIDatePicker *datePick;
    UIPickerView *countryPicker;
    NSArray *countryArray;
    
    Patient *patient;
    NSString *patientID;
    
    IBOutlet UIView *textEntryView;
    IBOutlet UIScrollView *scrollView;
    
    
}

@property (nonatomic, retain) Patient *patient;
@property (nonatomic, weak) id <EditPatientDelegate> delegate;

@end
