//
//  MSGPatientProfileViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/21/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "MSGPatientProfileViewController.h"

@interface MSGPatientProfileViewController ()

@end

@implementation MSGPatientProfileViewController

@synthesize patientID;
@synthesize pharmacyArray;
@synthesize pmaster;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     pharmacyArray = [[NSMutableArray alloc] init];
    
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
    
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    self.title = @"PROFILE";
}

- (IBAction)goBackToChose:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController  popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated   {
    [self loadPMaster];
    [self loadPharmacy];
}


- (IBAction)transferPatient:(id)sender {
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance] transferPatientRecord:patientID Completion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        if (success) {
            [UIAlertView showWithTitle:@"Transfered"
                               message:@"Patient record transfered"
                     cancelButtonTitle:@"Ok"
                     otherButtonTitles:nil tapBlock:nil];
        }
        
    }];
}


- (void)loadPMaster {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getPMasterByID2:patientID WithCompletion:^(BOOL success, NSString *message, PMaster *msgsession) {
        [SVProgressHUD dismiss];
        if (success) {
            pmaster = msgsession;
            
            [profileIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            [profileBackIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            
            
            profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
            profileIMG.layer.masksToBounds = YES;
            profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
            profileIMG.layer.borderWidth = 3.0;
            
            
            
            
            nameLabel.text = [NSString stringWithFormat:@"%@ %@", pmaster.firstname, pmaster.lastname];
            tokenLabel.text = [NSString stringWithFormat:@"Tokens: %@", pmaster.tokens];
            fromLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", pmaster.street1, pmaster.city, pmaster.state, pmaster.zipcode, pmaster.country];
            
            emailText.text = pmaster.email;
            phoneText.text = pmaster.telephone;
            
            
            if (pmaster.dob.length > 0) {
                
                NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[pmaster.dob integerValue]];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd MMMM yyyy"];
                dobText.text = [formatter stringFromDate:dob];
                
            } else {
                dobText.text = @"";
            }
            
            
        }
    }];
}


- (void)loadPharmacy {
    [[AppController sharedInstance] getAllPharmacyByPMMaster2:patientID WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        if (success)
        {
            
            [pharmacyArray removeAllObjects];
            
            [pharmacyArray addObjectsFromArray:conditions];
            
            if (pharmacyArray.count > 0) {
                Pharmacy *pharm = [pharmacyArray objectAtIndex:0];
                
                pharmNameL1.text = pharm.pharmName;
                pharmAddressL1.text = pharm.address;
                
                pharmContainer1.hidden = false;
                
                if (pharmacyArray.count > 1) {
                    Pharmacy *pharm = [pharmacyArray objectAtIndex:1];
                    
                    pharmNameL2.text = pharm.pharmName;
                    pharmAddressL2.text = pharm.address;
                    
                    pharmContainer2.hidden = false;
                    
                    
                    if (pharmacyArray.count > 2) {
                        Pharmacy *pharm = [pharmacyArray objectAtIndex:2];
                        
                        pharmNameL3.text = pharm.pharmName;
                        pharmAddressL3.text = pharm.address;
                        
                        pharmContainer3.hidden = false;
                        
                        
                        if (pharmacyArray.count > 3) {
                            Pharmacy *pharm = [pharmacyArray objectAtIndex:3];
                            
                            pharmNameL4.text = pharm.pharmName;
                            pharmAddressL4.text = pharm.address;
                            
                            pharmContainer4.hidden = false;
                            
                            
                        } else {
                            pharmContainer4.hidden = true;
                        }
                        
                        
                    } else {
                        
                        pharmContainer3.hidden = true;
                        pharmContainer4.hidden = true;
                    }
                    
                    
                    
                    
                    
                    
                } else {
                    pharmContainer2.hidden = true;
                    pharmContainer3.hidden = true;
                    pharmContainer4.hidden = true;
                }
                
                
            } else {
                pharmContainer1.hidden = true;
                pharmContainer2.hidden = true;
                pharmContainer3.hidden = true;
                pharmContainer4.hidden = true;
            }
        }
        
        
    }];
    
}


- (IBAction)goToConditions:(id)sender {
    MSGPConditionViewController *vc = [[MSGPConditionViewController alloc] initWithNibName:@"MSGPConditionViewController" bundle:nil];
    vc.patientID = patientID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToAllergy:(id)sender {
    MSGPAllergyViewController *vc = [[MSGPAllergyViewController alloc] initWithNibName:@"MSGPAllergyViewController" bundle:nil];
    vc.patientID = patientID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToPharmacy:(id)sender {
    MSGPPharmacyViewController *vc = [[MSGPPharmacyViewController alloc] initWithNibName:@"MSGPPharmacyViewController" bundle:nil];
    vc.patientID = patientID;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)openCardFront:(id)sender {
    
    if (pmaster.insurancecard.length > 0) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"View Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self showRemoteImage:pmaster.insurancecard];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Update Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
          //  [self showInsuranceCardUpdate];
            
            
            
        }];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //  [self dismissViewControllerAnimated:self completion:nil];
        }];
        
        [actionSheet addAction:cameraAction];
        //[actionSheet addAction:photoAction];
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
      //  [self showInsuranceCardUpdate];
        
    }
    
}

- (IBAction)openCardBack:(id)sender {
    if (pmaster.insurancecardback.length > 0) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"View Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self showRemoteImage:pmaster.insurancecardback];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Update Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
         //   [self showInsuranceCardUpdateBack];
            
            
            
        }];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //  [self dismissViewControllerAnimated:self completion:nil];
        }];
        
        [actionSheet addAction:cameraAction];
        //[actionSheet addAction:photoAction];
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
     //   [self showInsuranceCardUpdateBack];
        
    }
    
    
}



- (void)showRemoteImage:(NSString *)imageLink
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    imageLink = [imageLink stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
    NSURL *imageURL = [NSURL URLWithString:imageLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
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




@end
