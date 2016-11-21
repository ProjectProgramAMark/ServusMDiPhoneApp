//
//  ParentDetailsEditViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 2/16/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "ParentDetailsEditViewController.h"

@interface ParentDetailsEditViewController ()

@end

@implementation ParentDetailsEditViewController

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
    
    
    self.title = @"PARENT DETAILS";
    
    if (self.pmaster.parentdob.length > 0) {
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[self.pmaster.parentdob integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy"];
        [parentDOBButton setTitle:[formatter stringFromDate:dob] forState:UIControlStateNormal];
        parentDOBString = self.pmaster.parentdob;
    }
    parentFirstName.text = self.pmaster.parentfirstname;
    parentLastName.text = self.pmaster.parentlastname;
    parentPhonNumber.text = self.pmaster.parentphone;
    parentEmail.text = self.pmaster.parentemail;
    parentLast4SSN.text = self.pmaster.parentssn;
    
    if (self.pmaster.parentdob.length > 0) {
        double unixTimeStamp =[self.pmaster.dob doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
        NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        datePick.date = destinationDate;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)viewWillAppear:(BOOL)animated {
   
    
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    parentID = chosenImage;
    
   // [parentIDButton setTitle:@"Edit ID" forState:UIControlStateNormal];
    [self updateIDCard:chosenImage];
    
    
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
    
    NSTimeInterval t = [datePick.date timeIntervalSince1970];
    parentDOBString = [NSString stringWithFormat:@"%i",(int)t];
    self.pmaster.parentdob = parentDOBString;
    
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[parentDOBString integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    [parentDOBButton setTitle:[formatter stringFromDate:dob] forState:UIControlStateNormal];
    
    
    
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
        
        if (self.pmaster.parentdob.length == 0) {
            [self showAlertViewWithMessage:@"Please select your parent's date of birth" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
            return;
        
        }
    
    self.pmaster.parentfirstname = parentFirstName.text;
    self.pmaster.parentlastname = parentLastName.text;
    self.pmaster.parentphone = parentPhonNumber.text;
    self.pmaster.parentemail = parentEmail.text;
    self.pmaster.parentssn = parentLast4SSN.text;

    
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance] updateParent:self.pmaster WithCompletion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        if (success == false)
        {
            // title = @"failed";
            [self showAlertViewWithMessage:message withTag:100 withTitle:@"Error" andViewController:self isCancelButton:NO];
        } else {
            // [self.delegate patientEditDone:patient1];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }];

    
        /*self.patient.parentDob = parentDOBString;
        self.patient.parentIDCard = parentID;
        self.patient.parentFirstName = parentFirstName.text;
        self.patient.parentLastName = parentLastName.text;
        self.patient.parentPhone = parentPhonNumber.text;
        self.patient.parentEmail = parentEmail.text;
        self.patient.parentSSN = parentLast4SSN.text;*/
   
}


- (IBAction)openMyID:(id)sender {
    if (self.pmaster.parentidcard.length > 0) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"View ID" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self showRemoteImage:self.pmaster.idcard];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Update ID" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self showIDCardUpdate];
            
            
            
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
        
        
    } else {
        [self showIDCardUpdate];
        
    }
    
    
}


- (void)showIDCardUpdate {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Insurance Card Back" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
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


- (void)updateIDCard:(UIImage *)img
{
    [SVProgressHUD showWithStatus:@"Uploading..."];
    [[AppController sharedInstance] updateParentID:self.pmaster.postid img:img WithCompletion:^(BOOL success, NSString *message)  {
        
        [SVProgressHUD dismiss];
        NSString *title = @"succeed";
        if (success == false)
        {
            title = @"failed";
        } else {
            //[self.delegate refreshPatientList];
           // [self loadPMaster];
            //[self.navigationController popViewControllerAnimated:YES];
        }
        
        
        //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}



- (void)showRemoteImage:(NSString *)imageLink
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    imageLink = [imageLink stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
    NSURL *imageURL = [NSURL URLWithString:imageLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    requestOperation.securityPolicy = securityPolicy;
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.center = self.view.center;
        imageView.backgroundColor = [UIColor redColor];
        imageView.image = responseObject;
        [EXPhotoViewer showImageFrom:imageView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [UIAlertView showWithTitle:@"Failed"
                           message:@"Image download failed."
                 cancelButtonTitle:@"Ok"
                 otherButtonTitles:nil tapBlock:nil];
    }];
    [requestOperation start];
    
    
    
}



- (NSString *)imageToString:(UIImage *)avatarImage
{
    //UIImage *avatarImage =[UIImage imageNamed:imageName];
    return [self base64EncodeDataWithImage:avatarImage];
}

- (NSString *)base64EncodeDataWithImage:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}


@end
