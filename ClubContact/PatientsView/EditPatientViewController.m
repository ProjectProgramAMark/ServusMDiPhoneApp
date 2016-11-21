//
//  EditPatientViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/31/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import "EditPatientViewController.h"
#import "AboutTableViewCell.h"

#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"

@interface EditPatientViewController ()

@end

@implementation EditPatientViewController

@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    
    countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    countryPicker.delegate = self;
    countryText.inputView = countryPicker;
    
    
    /* [scrollView addSubview:textEntryView];
     textEntryView.frame = CGRectMake(0, 0, textEntryView.frame.size.width, textEntryView.frame.size.height);
     scrollView.contentSize = CGSizeMake( textEntryView.frame.size.width, textEntryView.frame.size.height);*/
    
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, firstNameText.frame.size.height)];
    leftView.backgroundColor = firstNameText.backgroundColor;
    firstNameText.leftView = leftView;
    firstNameText.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, last4SSN.frame.size.height)];
    leftView2.backgroundColor = last4SSN.backgroundColor;
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, lastnameText.frame.size.height)];
    leftView3.backgroundColor = lastnameText.backgroundColor;
    UIView *leftView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, emailText.frame.size.height)];
    leftView4.backgroundColor = emailText.backgroundColor;
    UIView *leftView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, phoneText.frame.size.height)];
    leftView5.backgroundColor = phoneText.backgroundColor;
    UIView *leftView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, occupationText.frame.size.height)];
    leftView6.backgroundColor = occupationText.backgroundColor;
    UIView *leftView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, street2Text.frame.size.height)];
    leftView7.backgroundColor = street2Text.backgroundColor;
    UIView *leftView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, street1Text.frame.size.height)];
    leftView8.backgroundColor = street1Text.backgroundColor;
    UIView *leftView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, cityText.frame.size.height)];
    leftView9.backgroundColor = cityText.backgroundColor;
    UIView *leftView10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, stateText.frame.size.height)];
    leftView10.backgroundColor = stateText.backgroundColor;
    UIView *leftView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, zipText.frame.size.height)];
    leftView11.backgroundColor = zipText.backgroundColor;
    UIView *leftView12 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, countryText.frame.size.height)];
    leftView12.backgroundColor = countryText.backgroundColor;
    
    last4SSN.leftView = leftView2;
    last4SSN.leftViewMode = UITextFieldViewModeAlways;
    lastnameText.leftView = leftView3;
    lastnameText.leftViewMode = UITextFieldViewModeAlways;
    emailText.leftView = leftView4;
    emailText.leftViewMode = UITextFieldViewModeAlways;
    phoneText.leftView = leftView5;
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    occupationText.leftView = leftView6;
    occupationText.leftViewMode = UITextFieldViewModeAlways;
    street1Text.leftView = leftView7;
    street1Text.leftViewMode = UITextFieldViewModeAlways;
    street2Text.leftView = leftView8;
    street2Text.leftViewMode = UITextFieldViewModeAlways;
    cityText.leftView = leftView9;
    cityText.leftViewMode = UITextFieldViewModeAlways;
    stateText.leftView = leftView10;
    stateText.leftViewMode = UITextFieldViewModeAlways;
    zipText.leftView = leftView11;
    zipText.leftViewMode = UITextFieldViewModeAlways;
    zipText.leftView = leftView11;
    zipText.leftViewMode = UITextFieldViewModeAlways;
    countryText.leftView = leftView12;
    countryText.leftViewMode = UITextFieldViewModeAlways;
    
    self.title = @"ADD PATIENT";
    
    last4SSN.delegate = self;
    firstNameText.delegate = self;
    lastnameText.delegate = self;
    emailText.delegate = self;
    phoneText.delegate = self;
    occupationText.delegate = self;
    street1Text.delegate = self;
    street2Text.delegate = self;
    cityText.delegate = self;
    stateText.delegate = self;
    zipText.delegate = self;
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self refreshAllData];
    
    profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
    profileIMGView2.layer.masksToBounds = YES;
    profileIMGView2.layer.borderColor = [UIColor blackColor].CGColor;
    profileIMGView2.layer.borderWidth = 1.0;
    
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
    jobLabel2.text = [NSString stringWithFormat:@"%@", _patient.occupation];
    
    street1Text.text = _patient.street1;
    street2Text.text = _patient.street2;
    countryText.text = _patient.country;
    stateText.text = _patient.state;
    cityText.text = _patient.city;
    phoneText.text = _patient.telephone;
    firstNameText.text = _patient.firstName;
    lastnameText.text = _patient.lastName;
    last4SSN.text = _patient.ssnDigits;
    emailText.text = _patient.email;
    zipText.text = _patient.zipcode;
    occupationText.text = _patient.occupation;
    
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[_patient.dob integerValue]];
    datePick.date = dob;
    
    if ([_patient.gender isEqual:@"M"]) {
        genderSegment.selectedSegmentIndex = 0;
        
    } else {
       genderSegment.selectedSegmentIndex = 1;
    }
    

    
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}


- (IBAction)editProfileSave:(id)sender {
    if (firstNameText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the first name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (lastnameText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the last name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (emailText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the email" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (phoneText.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the phone number" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else if (last4SSN.text.length == 0) {
        [self showAlertViewWithMessage:@"Please enter the last 4 digits of SSN" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
    } else {
        
        if (genderSegment.selectedSegmentIndex == 0) {
           _patient.gender = @"M";
        } else {
            _patient.gender = @"F";
        }
        
        NSTimeInterval t = [datePick.date timeIntervalSince1970];
        
        _patient.email = emailText.text;
        _patient.firstName = firstNameText.text;
        _patient.lastName =  lastnameText.text;
        _patient.dob = [NSString stringWithFormat:@"%i",(int)t];
        _patient.occupation = occupationText.text;
        _patient.zipcode = zipText.text;
        _patient.telephone = phoneText.text;
        _patient.city = cityText.text;
        _patient.country = countryText.text;
        _patient.ssnDigits = last4SSN.text;
        _patient.street1 = street1Text.text;
        _patient.street2 = street2Text.text;


         [SVProgressHUD showWithStatus:@"Saving..."];
        [[AppController sharedInstance] updatePatient:_patient WithCompletion:^(BOOL success, NSString *message) {
            NSString *title = @"succeed";
            [SVProgressHUD dismiss];
            if (success == false)
            {
                title = @"failed";
            } else {
                     [self.delegate patientEditDone:_patient];
                 [self.navigationController popViewControllerAnimated:YES];
            }
            
            
            //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
            //   [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
    }
}

- (IBAction)goBack:(id)sender {
      [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)changeProfilePicture:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Update Patient Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        

        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
       
        
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
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    profileIMGView2.image = chosenImage;
    [self updateProfileImage:chosenImage];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)updateProfileImage:(UIImage *)img {
    [[AppController sharedInstance] updatePatientIMG:_patient.postid img:img WithCompletion:^(BOOL success, NSString *message) {
        NSString *title = @"succeed";
        [self.view endEditing:true];
        if (success == false)
        {
            title = @"failed";
        } else {
           // [self.delegate refreshPatientList];
           // [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}


@end
