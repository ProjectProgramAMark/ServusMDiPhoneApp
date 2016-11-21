//
//  RegOtherViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 2/15/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "RegOtherViewController.h"

@interface RegOtherViewController ()

@end

@implementation RegOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    
    self.title = @"More Information";
    
    isParentPhoto = false;
    isParentDOB = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (IBAction)showParentPhotoSelect:(id)sender {
    
   // if (myID == nil) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Parent ID" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
             isParentPhoto = true;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
            
            
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            isParentPhoto = true;
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
            popPresenter.sourceView = self.navigationController.view;
            popPresenter.sourceRect = CGRectMake(windowWidth/2 - 150.0f, 0, 300, 400);
            [self presentViewController:actionSheet animated:YES completion:nil];
        }
        
    //}
    
}


- (IBAction)showMyIDPhotoSelect:(id)sender {
    
    // if (myID == nil) {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"My photo ID" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isParentPhoto = false;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        isParentPhoto = false;
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
        popPresenter.sourceView = self.navigationController.view;
        popPresenter.sourceRect = CGRectMake(windowWidth/2 - 150.0f, 0, 300, 400);
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
    
    //}
    
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (isParentPhoto == false) {
       
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        myID = chosenImage;
        [myIDButton setTitle:@"Edit ID" forState:UIControlStateNormal];
        
        
    } else {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        parentID = chosenImage;
         [parentIDButton setTitle:@"Edit ID" forState:UIControlStateNormal];
    }
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:true completion:^{
    
    }];
}



- (IBAction)showMyDOBPicker:(id)sender {
    datePickerContainer.hidden = false;
    isParentDOB = false;
    datePickerContainer.frame = CGRectMake(0, 0, windowWidth, windowHeight);
    [self.view addSubview:datePickerContainer];
}


- (IBAction)showParentDOBPicker:(id)sender {
    datePickerContainer.hidden = false;
    isParentDOB = true;
    datePickerContainer.frame = CGRectMake(0, 0, windowWidth, windowHeight);
    [self.view addSubview:datePickerContainer];
}



- (IBAction)cancelDatePick:(id)sender {
    datePickerContainer.hidden = true;
      [datePickerContainer removeFromSuperview];
}

- (IBAction)selectDatePick:(id)sender {
    datePickerContainer.hidden = true;
    [datePickerContainer removeFromSuperview];
    if (isParentDOB == false) {
        
    
    NSTimeInterval t = [datePick.date timeIntervalSince1970];
    myDOBString = [NSString stringWithFormat:@"%i",(int)t];
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[myDOBString integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
        [myDOBButton setTitle:[formatter stringFromDate:dob] forState:UIControlStateNormal];
  //  datePick.hidden = true;
        
        NSLog(@"%li", [self daysFromDate:datePick.date]);
        
        if ([self daysFromDate:datePick.date] > -6574) {
            parentInfoView.hidden = false;
        } else {
            parentInfoView.hidden = true;
        }
        
    } else {
        NSTimeInterval t = [datePick.date timeIntervalSince1970];
        parentDOBString = [NSString stringWithFormat:@"%i",(int)t];
        
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[parentDOBString integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy"];
        [parentDOBButton setTitle:[formatter stringFromDate:dob] forState:UIControlStateNormal];
    }
    
    
    
}


// returns number of days (absolute value) from another date (as number of midnights beween these dates)
- (long)daysFromDate:(NSDate *)pDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger startDay=[calendar ordinalityOfUnit:NSCalendarUnitDay                                           inUnit:NSCalendarUnitEra
                                          forDate:[NSDate date]];
    NSInteger endDay=[calendar ordinalityOfUnit:NSCalendarUnitDay                                           inUnit:NSCalendarUnitEra
                                        forDate:pDate];
    //[calendar release];
    return endDay-startDay;
}


- (IBAction)finishRegistration:(id)sender {
    
    if (myID == nil) {
        [self showAlertViewWithMessage:@"Please add your photo ID" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        return;
    } else if (myDOBString.length == 0) {
        [self showAlertViewWithMessage:@"Please select your date of birth" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
         return;
        
    }
    
    if (parentInfoView.hidden == false) {
        if (parentFirstName.text.length == 0) {
            [self showAlertViewWithMessage:@"Please enter your parent's first name" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            return;
        }
        
        if (parentLastName.text.length == 0) {
            [self showAlertViewWithMessage:@"Please enter your parent's last name" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            return;
        }
        
        if (parentEmail.text.length == 0) {
            [self showAlertViewWithMessage:@"Please enter your parent's email" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            return;
        }
        
        if (parentPhonNumber.text.length == 0) {
            [self showAlertViewWithMessage:@"Please enter your parent's phone number" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            return;
        }
        
        if (parentLast4SSN.text.length == 0) {
            [self showAlertViewWithMessage:@"Please enter your parent's last 4 digits of SSN" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            return;
        }
        
        if (parentID == nil) {
            [self showAlertViewWithMessage:@"Please add your parent's photo ID" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            return;
        } else if (parentDOBString.length == 0) {
            [self showAlertViewWithMessage:@"Please select your parent's date of birth" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            return;
            
        }
        
        self.patient.parentDob = parentDOBString;
        self.patient.parentIDCard = parentID;
        self.patient.parentFirstName = parentFirstName.text;
        self.patient.parentLastName = parentLastName.text;
        self.patient.parentPhone = parentPhonNumber.text;
        self.patient.parentEmail = parentEmail.text;
        self.patient.parentSSN = parentLast4SSN.text;
    }
    
    self.patient.dob = myDOBString;
    self.patient.idCard = myID;
    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance] registerPatientMaster:self.patient WithCompletion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [self showAlertViewWithMessage:message withTag:1 withTitle:@"Registration" andViewController:self isCancelButton:NO];
            [self.navigationController popToRootViewControllerAnimated:true];
        }
        else
        {
            [self showAlertViewWithMessage:message withTag:1 withTitle:@"Register Failed." andViewController:self isCancelButton:NO];
        }
        
        
    }];
}




@end
