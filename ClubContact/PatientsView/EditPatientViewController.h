//
//  EditPatientViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/31/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryPicker.h"
#import "BaseViewController.h"

@class EditPatientNewViewController;             //define class, so protocol can see MyClass
@protocol EditPatientNewDelegate <NSObject>   //define delegate protocol
- (void) patientEditDone:(Patient *)patientinfo;  //define delegate method to be implemented within another class
@end


@interface EditPatientViewController : BaseViewController <UITextFieldDelegate, UIImagePickerControllerDelegate> {
    
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
    
    IBOutlet UILabel *nameLabel2;
    IBOutlet UILabel *jobLabel2;
    
    UIPickerView *countryPicker;
    IBOutlet UIImageView *profileIMGView2;

    
}

@property (strong, nonatomic) Patient *patient;
@property (nonatomic, weak) id <EditPatientNewDelegate> delegate;


@end
