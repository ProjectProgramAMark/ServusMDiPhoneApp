//
//  AddPatientiPhoneViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Patient.h"
#import "AppController.h"
#import "CountryPicker.h"

@class AddPatientiPhoneViewController;
@protocol AddPatientiPhoneDelegate <NSObject>   //define delegate protocol
- (void) refreshAddPatient;  //define delegate method to be implemented within another class
@end

@interface AddPatientiPhoneViewController : BaseViewController <CountryPickerDelegate> {
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
    IBOutlet UISegmentedControl *genderSegment;
    IBOutlet UIDatePicker *datePick;
    IBOutlet UITextField *last4SSN;
    
    IBOutlet UIView *textEntryView;
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;

}

@property (nonatomic, weak) id <AddPatientiPhoneDelegate> delegate;

@end
