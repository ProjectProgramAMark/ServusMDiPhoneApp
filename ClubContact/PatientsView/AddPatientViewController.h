//
//  AddPatientViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 3/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CountryPicker.h"

@interface AddPatientViewController : BaseViewController<CountryPickerDelegate> {
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
    
}

@end
