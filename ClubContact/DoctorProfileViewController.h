//
//  DoctorProfileViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
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
#import "DoctorEditNewViewController.h" 

@interface DoctorProfileViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, DoctorTableViewCellDelegate, UIImagePickerControllerDelegate, EditDoctorDelegate, UIAlertViewDelegate, EditDoctoriPhoneDelegate, UITextFieldDelegate, CountryPickerDelegate>


@property (strong, nonatomic) Doctors *doctor;

@end
