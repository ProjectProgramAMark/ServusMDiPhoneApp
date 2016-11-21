//
//  DoctorEditNewViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/4/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "Doctors.h"
#import "DoctorTableViewCell.h"
#import "EditDoctorViewController.h"
#import "SignatureTableViewCell.h"
#import "BaseViewController.h"
#import "EditDoctoriPhoneViewController.h"
#import "CountryPicker.h"
#import "SpecialitySelectorViewController.h"

@interface DoctorEditNewViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, DoctorTableViewCellDelegate, UIImagePickerControllerDelegate, EditDoctorDelegate, UIAlertViewDelegate, EditDoctoriPhoneDelegate, UITextFieldDelegate, CountryPickerDelegate> {
    UIPopoverController *popover2;
    BOOL isProfileUpdate;
    BOOL isPasscodeUpdate;
    BOOL isPasscodeUpdate2;
    BOOL isPasscodeUpdate3;
    BOOL isPasscodeUpdate4;
    IBOutlet UIView *statView;
    IBOutlet UIImageView *profileIMGView2;
    
    UIPickerView *countryPicker;
    IBOutlet UILabel *nameLabel;
     IBOutlet UILabel *hospitalLabel;
    
    IBOutlet UITextField *usernameLabel;
    IBOutlet UITextField *emailLabel;
    IBOutlet UITextField *miLabel;
    IBOutlet UITextField *suffixLabel;
    IBOutlet UITextField *npiLabel;
    IBOutlet UITextField *deaLabel;
    IBOutlet UITextField *meLabel;
    IBOutlet UITextField *schoolLabel;
    IBOutlet UITextField *specialityLabel;
    IBOutlet UITextField *chargeLabel;
    IBOutlet UITextField *tokensLabel;
    IBOutlet UITextField *availabilityLabel;
    IBOutlet UITextField *firstnameLabel;
    IBOutlet UITextField *lastnameLabel;
    IBOutlet UITextField *residencyLabel;
    IBOutlet UITextField *yearsLabel;
    
    IBOutlet UITextField *officeNameLabel;
    IBOutlet UITextField *officeAddressLabel;
    IBOutlet UITextField *officeCityLabel;
    IBOutlet UITextField *officeCountryLabel;
    IBOutlet UITextField *officeStateLabel;
    IBOutlet UITextField *officeZipLabel;
    IBOutlet UITextField *officeTelephoneLabel;
    
    IBOutlet UIImageView *signatureImageView;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;

    NSString *oldPassword;
    
    BOOL isSpecilitySelect;
}


@property (strong, nonatomic) Doctors *doctor;

@end
