//
//  DoctorEditNewViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/4/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "DoctorEditNewViewController.h"
#import "AboutTableViewCell.h"

#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"
#import "SWRevealViewController.h"

#define kDetailPatientsCellID   @"patientCell"
#define kAboutCellID            @"aboutCell"
#define kNormalCellID           @"normalCell"
#define kDetailNoteCellID       @"noteCell"

@interface DoctorEditNewViewController () <SpecialitySelectorDelegate>

@end

@implementation DoctorEditNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, firstnameLabel.frame.size.height)];
    leftView.backgroundColor = firstnameLabel.backgroundColor;
    firstnameLabel.leftView = leftView;
    firstnameLabel.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, lastnameLabel.frame.size.height)];
    leftView2.backgroundColor = firstnameLabel.backgroundColor;
    lastnameLabel.leftView = leftView2;
    lastnameLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, emailLabel.frame.size.height)];
    leftView3.backgroundColor = emailLabel.backgroundColor;
    emailLabel.leftView = leftView3;
    emailLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, chargeLabel.frame.size.height)];
    leftView4.backgroundColor = chargeLabel.backgroundColor;
    chargeLabel.leftView = leftView4;
    chargeLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, residencyLabel.frame.size.height)];
    leftView5.backgroundColor = residencyLabel.backgroundColor;
    residencyLabel.leftView = leftView5;
    residencyLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, schoolLabel.frame.size.height)];
    leftView6.backgroundColor = schoolLabel.backgroundColor;
    schoolLabel.leftView = leftView6;
    schoolLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, miLabel.frame.size.height)];
    leftView7.backgroundColor = miLabel.backgroundColor;
    miLabel.leftView = leftView7;
    miLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, suffixLabel.frame.size.height)];
    leftView8.backgroundColor = suffixLabel.backgroundColor;
    suffixLabel.leftView = leftView8;
    suffixLabel.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, deaLabel.frame.size.height)];
    leftView9.backgroundColor = deaLabel.backgroundColor;
    deaLabel.leftView = leftView9;
    deaLabel.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftView10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, specialityLabel.frame.size.height)];
    leftView10.backgroundColor = specialityLabel.backgroundColor;
    specialityLabel.leftView = leftView10;
    specialityLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, meLabel.frame.size.height)];
    leftView11.backgroundColor = meLabel.backgroundColor;
    meLabel.leftView = leftView11;
    meLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView12 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, officeNameLabel.frame.size.height)];
    leftView12.backgroundColor = officeNameLabel.backgroundColor;
    officeNameLabel.leftView = leftView12;
    officeNameLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView13 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, officeAddressLabel.frame.size.height)];
    leftView13.backgroundColor = officeAddressLabel.backgroundColor;
    officeAddressLabel.leftView = leftView13;
    officeAddressLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView14 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, officeCityLabel.frame.size.height)];
    leftView14.backgroundColor = officeCityLabel.backgroundColor;
    officeCityLabel.leftView = leftView14;
    officeCityLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView15 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, officeStateLabel.frame.size.height)];
    leftView15.backgroundColor = officeZipLabel.backgroundColor;
    officeZipLabel.leftView = leftView15;
    officeZipLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView16 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, officeCountryLabel.frame.size.height)];
    leftView16.backgroundColor = officeCountryLabel.backgroundColor;
    officeCountryLabel.leftView = leftView16;
    officeCountryLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView17 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, yearsLabel.frame.size.height)];
    leftView17.backgroundColor = yearsLabel.backgroundColor;
    yearsLabel.leftView = leftView17;
    yearsLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView18 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, officeTelephoneLabel.frame.size.height)];
    leftView18.backgroundColor = officeTelephoneLabel.backgroundColor;
    officeTelephoneLabel.leftView = leftView18;
    officeTelephoneLabel.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView19 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, officeStateLabel.frame.size.height)];
    leftView19.backgroundColor = officeStateLabel.backgroundColor;
    officeStateLabel.leftView = leftView19;
    officeStateLabel.leftViewMode = UITextFieldViewModeAlways;
    
    countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    countryPicker.delegate = self;
    officeCountryLabel.inputView = countryPicker;
    
    self.title = @"EDIT PROFILE";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    if (isSpecilitySelect == false) {
            [self refreshAllData];
    }

}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)saveBack:(id)sender {
    
    _doctor.firstname = firstnameLabel.text;
    _doctor.lastname = lastnameLabel.text;
    _doctor.email = emailLabel.text;
    _doctor.dea = deaLabel.text;
    _doctor.me = meLabel.text;
    _doctor.mi = miLabel.text;
    _doctor.telephone = officeTelephoneLabel.text;
    _doctor.ccost = chargeLabel.text;
    _doctor.speciality = specialityLabel.text;
    _doctor.residency = residencyLabel.text;
    _doctor.yearsExperience = [NSString stringWithFormat:@"%i", [yearsLabel.text intValue]];
    _doctor.school = schoolLabel.text;
    _doctor.suffix = suffixLabel.text;
    _doctor.officename = officeNameLabel.text;
    _doctor.officeaddress = officeAddressLabel.text;
    _doctor.officecity  = officeCityLabel.text;
    _doctor.officestate = officeStateLabel.text;
    _doctor.officezip = officeZipLabel.text;
    _doctor.officecountry = officeCountryLabel.text;
    
    if (_doctor.firstname.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the first name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.lastname.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the last name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.mi.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the M.I." withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.suffix.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the Suffix" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.dea.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the D.E.A" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    }  else if (_doctor.npi.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the N.P.I." withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.me.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the M.E." withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.officename.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.officeaddress.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office address" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    }  else if (_doctor.officecity.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office city" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.officestate.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office state" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.officezip.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office zip code" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.officecountry.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the office country" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.telephone.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the telephone number" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (_doctor.speciality.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the speciality" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    }else {
        
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [[AppController sharedInstance] updateDoctor:_doctor WithCompletion:^(BOOL success, NSString *message) {
            NSString *title = @"succeed";
            [SVProgressHUD dismiss];
            if (success == false)
            {
                title = @"failed";
            } else {
                // [self.delegate doctorEditDone:doctor1];
            }
            
            
            //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
            // [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        
        
    }

    
    
}

- (void)refreshAllData {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getDoctorProfile:@"" WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success)
        {
            _doctor = doctorProfile;
            [profileIMGView2 setImageWithURL:[NSURL URLWithString:_doctor.profileimage]];
            profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
            profileIMGView2.layer.masksToBounds = YES;
            profileIMGView2.layer.borderColor = [UIColor blackColor].CGColor;
            profileIMGView2.layer.borderWidth = 1.0;
            //[profileIMGView3 setImageWithURL:[NSURL URLWithString:_doctor.profileimage]];
            nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@", _doctor.firstname, _doctor.lastname];
            firstnameLabel.text = _doctor.firstname;
            lastnameLabel.text = _doctor.lastname;
            residencyLabel.text = _doctor.residency;
            hospitalLabel.text = _doctor.residency;
          
            emailLabel.text = [NSString stringWithFormat:@"%@", _doctor.email];
            miLabel.text = [NSString stringWithFormat:@"%@", _doctor.mi];
            suffixLabel.text = [NSString stringWithFormat:@"%@", _doctor.suffix];
            deaLabel.text = [NSString stringWithFormat:@"%@", _doctor.dea];
            npiLabel.text = [NSString stringWithFormat:@"%@", _doctor.npi];
            meLabel.text = [NSString stringWithFormat:@"%@", _doctor.me];
            schoolLabel.text = [NSString stringWithFormat:@"%@", _doctor.school];
            specialityLabel.text = [NSString stringWithFormat:@"%@", _doctor.speciality];
            chargeLabel.text = [NSString stringWithFormat:@"%@", _doctor.ccost];
            yearsLabel.text = [NSString stringWithFormat:@"%@", _doctor.yearsExperience];
            
           /* if ([_doctor.isOnline intValue] == 1) {
                
                availabilityLabel.text = [NSString stringWithFormat:@"Availability: On"];
            } else {
                availabilityLabel.text = [NSString stringWithFormat:@"Availability: Off"];
            }*/
            
            officeNameLabel.text = [NSString stringWithFormat:@"%@", _doctor.officename];
            officeAddressLabel.text = [NSString stringWithFormat:@"%@", _doctor.officeaddress];
            officeCityLabel.text = [NSString stringWithFormat:@"%@", _doctor.officecity];
            officeCountryLabel.text = [NSString stringWithFormat:@"%@", _doctor.officecountry];
            officeZipLabel.text = [NSString stringWithFormat:@"%@", _doctor.officezip];
            officeStateLabel.text = [NSString stringWithFormat:@"%@", _doctor.officestate];
            officeTelephoneLabel.text = [NSString stringWithFormat:@"%@", _doctor.telephone];
            
            
            [signatureImageView setImageWithURL:[NSURL URLWithString:_doctor.signature]];
            //  [_tableView reloadData];
        }
    }];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([specialityLabel isFirstResponder]) {
        [specialityLabel resignFirstResponder];
        SpecialitySelectorViewController *vc = [[SpecialitySelectorViewController alloc] init];
        vc.delegate = self;
        isSpecilitySelect = true;
        [self.navigationController pushViewController:vc animated:true];
        
    }
}


#pragma mark - UIPickerViewDataSource
- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    officeCountryLabel.text = name;
}


- (IBAction)setAvailabilityForDoc:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Availability" message:@"Set your availability" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *avAction = [UIAlertAction actionWithTitle:@"On" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[AppController sharedInstance] updateDocAvailability:@"1" completion:^(BOOL success, NSString *message) {
            if (success) {
                [self refreshAllData];
            }
        }];
        
        
    }];
    
    UIAlertAction *unAction = [UIAlertAction actionWithTitle:@"Off" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[AppController sharedInstance] updateDocAvailability:@"0" completion:^(BOOL success, NSString *message) {
            if (success) {
                [self refreshAllData];
            }
        }];
        
        
        
    }];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //  [self dismissViewControllerAnimated:self completion:nil];
    }];
    
    [actionSheet addAction:avAction];
    [actionSheet addAction:unAction];
    [actionSheet addAction:cancelAction];
    
    if (IS_IPHONE) {
        [self presentViewController:actionSheet animated:YES completion:nil];
    } else {
        UIPopoverPresentationController *popPresenter = [actionSheet
                                                         popoverPresentationController];
        popPresenter.sourceView = self.navigationController.view;
        popPresenter.sourceRect = CGRectMake(windowWidth/2 - 150.0f, 0, 300, 400);
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }
}

- (IBAction)updatePasswordClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Password"
                                                    message:@"Enter your old password"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Next", nil];
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alert show];
    
    isPasscodeUpdate3 = true;

}


- (IBAction)updatePasscodeClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Passcode"
                                                    message:@"Enter your old passcode (Leave blank if you do not have one)"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Next", nil];
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alert show];
    
    isPasscodeUpdate = true;
}

- (IBAction)updateSignature:(id)sender {
    [self showPersonalSignatureView:^{
        [self removeBlurView];
        _personalSignatureView.hidden = YES;
        
        UIImage *signature = [_personalSignatureView.signatureView getSignatureImage];
        signatureImageView.image = signature;
        
        [[AppController sharedInstance] updateDoctorSig:@"" img:signature WithCompletion:^(BOOL success, NSString *message) {
            [self refreshAllData];
        }];
    }];
}


- (IBAction)changeProfilePick:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Update Profile Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isProfileUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isProfileUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        
        
        
        
    }];
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //  [self dismissViewControllerAnimated:self completion:nil];
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    
    if (IS_IPHONE) {
        [self presentViewController:actionSheet animated:YES completion:nil];
    } else {
        UIPopoverPresentationController *popPresenter = [actionSheet
                                                         popoverPresentationController];
        popPresenter.sourceView = profileIMGView2;
        popPresenter.sourceRect = profileIMGView2.bounds;
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
    
    
}




#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (isProfileUpdate == false) {
        
        
    } else {
        isProfileUpdate = false;
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        profileIMGView2.image = chosenImage;
        [picker dismissViewControllerAnimated:YES completion:NULL];
        [self updateProfileImage:chosenImage];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)updateProfileImage:(UIImage *)img
{
    [[AppController sharedInstance] updateDoctorIMG:@"" img:img WithCompletion:^(BOOL success, NSString *message) {
        NSString *title = @"succeed";
        if (success == false)
        {
            title = @"failed";
        } else {
            [self refreshAllData];
        }
        
        
        //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (isPasscodeUpdate == true) {
        isPasscodeUpdate = false;
        if (buttonIndex == 1) {
            
            
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
            [SVProgressHUD showWithStatus:@"Checking..."];
            [[AppController sharedInstance] checkDoctorPasscode:passcodeString completion:^(BOOL success, NSString *message) {
                [SVProgressHUD dismiss];
                if (success) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Passcode"
                                                                    message:@"Enter your new passcode"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"Done", nil];
                    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                    [alert show];
                    
                    isPasscodeUpdate2 = true;
                    
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid passcode" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                
                
            }];
            
        } else {
            isPasscodeUpdate = false;
        }
    } else if (isPasscodeUpdate2 == true) {
        isPasscodeUpdate2 = false;
        if (buttonIndex == 1) {
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
            [SVProgressHUD showWithStatus:@"Updating..."];
            [[AppController sharedInstance] updateDoctorPasscode:passcodeString completion:^(BOOL success, NSString *message) {
                [SVProgressHUD dismiss];
                if (success) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Passcode succesfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        }
        
    }else if (isPasscodeUpdate3 == true) {
        isPasscodeUpdate3 = false;
        if (buttonIndex == 1) {
            oldPassword = [alertView textFieldAtIndex:0].text;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Password"
                                                            message:@"Enter your new password"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Done", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
            
            isPasscodeUpdate4 = true;
        }
    }else if (isPasscodeUpdate4 == true) {
        isPasscodeUpdate4 = false;
        if (buttonIndex == 1) {
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
            [SVProgressHUD showWithStatus:@"Updating..."];
            [[AppController sharedInstance] changePasswordForDoctor:@"" password:passcodeString oldpassword:oldPassword WithCompletion:^(BOOL success, NSString *message) {
                
                [SVProgressHUD dismiss];
                if (success) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Password succesfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];
            
        }
        
    }
    
}


- (void)specialitySelectDone:(NSString *)speciality {
    specialityLabel.text = speciality;
 //   isSpecilitySelect = false;
}


@end
