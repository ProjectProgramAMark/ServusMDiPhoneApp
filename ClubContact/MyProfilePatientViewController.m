//
//  MyProfilePatientViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MyProfilePatientViewController.h"
#import "UIImageView+WebCache.h"

@interface MyProfilePatientViewController ()

@end

@implementation MyProfilePatientViewController

@synthesize pharmacyArray;
@synthesize pmaster;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
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
    
    if (IS_IPHONE) {
        [menuTable registerNib:[UINib nibWithNibName:@"DocMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    } else {
        [menuTable registerNib:[UINib nibWithNibName:@"DashboardDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    }
    self.title = @"MY PROFILE";
    
   // menuTable.tableHeaderView = statView;
    pharmacyArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadPMaster];
    [self loadPharmacy];
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (IBAction)goBackToChose:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController  popViewControllerAnimated:YES];
}


- (IBAction)goToEditProfile:(id)sender {
   
    PMasterEditViewController *vc =  [[PMasterEditViewController alloc] initWithNibName:@"PMasterEditViewController" bundle:nil];
    vc.pmaster = pmaster;
    //  vc.patientInfo = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadPMaster {
      [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getPMasterByID:@"" WithCompletion:^(BOOL success, NSString *message, PMaster *msgsession) {
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
            fromLabel.text = [NSString stringWithFormat:@"From: %@ %@ %@ %@ %@", pmaster.street1, pmaster.city, pmaster.state, pmaster.zipcode, pmaster.country];
            
            
        }
    }];
}


- (void)loadPharmacy {
       [[AppController sharedInstance] getAllPharmacyByPMMaster:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
     
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
    MyProfileConditionsViewController *vc = [[MyProfileConditionsViewController alloc] initWithNibName:@"MyProfileConditionsViewController" bundle:nil];
    //  vc.patientInfo = patientInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToAllergy:(id)sender {
    MyProfileAllergyViewController *vc = [[MyProfileAllergyViewController alloc] initWithNibName:@"MyProfileAllergyViewController" bundle:nil];
    //  vc.patientInfo = patientInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToPharmacy:(id)sender {
    PMMasterPharmacyViewController *vc = [[PMMasterPharmacyViewController alloc] initWithNibName:@"PMMasterPharmacyViewController" bundle:nil];
    //  vc.patientInfo = patientInfo;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)openCardFront:(id)sender {
    
    if (pmaster.insurancecard.length > 0) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"View Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self showRemoteImage:pmaster.insurancecard];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Update Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self showInsuranceCardUpdate];
            
            
            
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
        [self showInsuranceCardUpdate];
        
    }

}

- (IBAction)openCardBack:(id)sender {
    if (pmaster.insurancecardback.length > 0) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"View Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self showRemoteImage:pmaster.insurancecardback];
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Update Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self showInsuranceCardUpdateBack];
            
            
            
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
        [self showInsuranceCardUpdateBack];
        
    }
    

}



- (IBAction)openPasswordChange:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Password"
                                                    message:@"Enter your new password"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Done", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    isPasswordUpdate= true;
}


- (IBAction)openPasscodeChange:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Passcode"
                                                    message:@"Enter your new passcode"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Done", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    isPasscodeUpdate = true;
}


- (IBAction)openMyID:(id)sender {
    if (pmaster.idcard.length > 0) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"View ID" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            [self showRemoteImage:pmaster.idcard];
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
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Photo ID" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isIDCardUpate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isIDCardUpate = true;
        
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


- (IBAction)showParentDetails:(id)sender {
    ParentDetailsEditViewController *vc = [[ParentDetailsEditViewController alloc] init];
    vc.pmaster = self.pmaster;
    [self.navigationController pushViewController:vc animated:true];
    
}


#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE) {
        
        DocMenuTableViewCell    *cell = (DocMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
        
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"Edit Profile";
            cell.nameLabel.textColor = [UIColor colorWithRed:146.0f/255.0f green:163.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"document-edit-icon.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Update Passcode";
            cell.nameLabel.textColor = [UIColor colorWithRed:146.0f/255.0f green:163.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"document-edit-icon.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Change Password";
            cell.nameLabel.textColor = [UIColor colorWithRed:146.0f/255.0f green:163.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"document-edit-icon.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Insurance Card Front";
            cell.nameLabel.textColor = [UIColor colorWithRed:183.0f/255.0f green:158.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"shieldinsurance"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Insurance Card Back";
            cell.nameLabel.textColor = [UIColor colorWithRed:183.0f/255.0f green:158.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"shieldinsurance"];
        }  else if (indexPath.row == 5) {
            cell.nameLabel.text = @"Conditions";
            cell.nameLabel.textColor = [UIColor colorWithRed:241.0f/255.0f green:201.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-box-icon.png"];
        } else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Allergies";
            cell.nameLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"human-brain-icon.png"];
        }  else if (indexPath.row == 7) {
            cell.nameLabel.text = @"Pharmacies";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];
        } else if (indexPath.row == 8) {
            cell.nameLabel.text = @"Previous Consultations";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
        } else if (indexPath.row == 9) {
            cell.nameLabel.text = @"Previous Sessions";
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
        }
        
        cell.clipsToBounds = YES;
        
        return cell;
        
    } else {
        DashboardDocTableViewCell  *cell = (DashboardDocTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"Edit Profile";
            cell.nameLabel.textColor = [UIColor colorWithRed:146.0f/255.0f green:163.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"document-edit-icon.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Update Passcode";
            cell.nameLabel.textColor = [UIColor colorWithRed:146.0f/255.0f green:163.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"document-edit-icon.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Change Password";
            cell.nameLabel.textColor = [UIColor colorWithRed:146.0f/255.0f green:163.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"document-edit-icon.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Insurance Card";
            cell.nameLabel.textColor = [UIColor colorWithRed:183.0f/255.0f green:158.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"shieldinsurance"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Insurance Card Back";
            cell.nameLabel.textColor = [UIColor colorWithRed:183.0f/255.0f green:158.0f/255.0f blue:60.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"shieldinsurance"];
        }  else if (indexPath.row == 5) {
            cell.nameLabel.text = @"Conditions";
            cell.nameLabel.textColor = [UIColor colorWithRed:241.0f/255.0f green:201.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-box-icon.png"];
        } else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Allergies";
            cell.nameLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"human-brain-icon.png"];
        }  else if (indexPath.row == 7) {
            cell.nameLabel.text = @"Pharmacies";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];
        } else if (indexPath.row == 8) {
            cell.nameLabel.text = @"Previous Consultations";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
        } else if (indexPath.row == 9) {
            cell.nameLabel.text = @"Previous Sessions";
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
        }
        
        
        
        cell.clipsToBounds = YES;
        
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        return 60.0f;
    } else {
        return 150.0f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PMasterEditViewController *vc = (PMasterEditViewController *)[sb instantiateViewControllerWithIdentifier:@"PMasterEditViewController"];
        vc.pmaster = pmaster;
      //  vc.patientInfo = patientInfo;
        
        [self.navigationController pushViewController:vc animated:YES];
    }  else if (indexPath.row == 1) {
      
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Passcode"
                                                        message:@"Enter your new passcode"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Done", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        isPasscodeUpdate = true;
        
    }  else if (indexPath.row == 2) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Password"
                                                        message:@"Enter your new password"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Done", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        isPasswordUpdate= true;
        
    }  else if (indexPath.row == 3) {
        
        if (pmaster.insurancecard.length > 0) {
            
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"View Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                [self showRemoteImage:pmaster.insurancecard];
            }];
            
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Update Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
              
                 [self showInsuranceCardUpdate];
                
                
                
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
            [self showInsuranceCardUpdate];

        }
      
        
    }   else if (indexPath.row == 4) {
        
        if (pmaster.insurancecardback.length > 0) {
            
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            
            UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"View Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                [self showRemoteImage:pmaster.insurancecardback];
            }];
            
            UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Update Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self showInsuranceCardUpdateBack];
                
                
                
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
            [self showInsuranceCardUpdateBack];
            
        }
        
        
    } else if (indexPath.row == 5) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MyProfileConditionsViewController *vc = (MyProfileConditionsViewController *)[sb instantiateViewControllerWithIdentifier:@"MyProfileConditionsViewController"];
        //  vc.patientInfo = patientInfo;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 6) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MyProfileAllergyViewController *vc = (MyProfileAllergyViewController *)[sb instantiateViewControllerWithIdentifier:@"MyProfileAllergyViewController"];
        //  vc.patientInfo = patientInfo;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 7) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PMMasterPharmacyViewController *vc = (PMMasterPharmacyViewController *)[sb instantiateViewControllerWithIdentifier:@"PMMasterPharmacyViewController"];
        //  vc.patientInfo = patientInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }  else if (indexPath.row == 8) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MyProfileConsultationHistory *vc = (MyProfileConsultationHistory *)[sb instantiateViewControllerWithIdentifier:@"MyProfileConsultationHistory"];
        //  vc.patientInfo = patientInfo;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 9) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MyProfileMessageHistory *vc = (MyProfileMessageHistory *)[sb instantiateViewControllerWithIdentifier:@"MyProfileMessageHistory"];
        //  vc.patientInfo = patientInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showInsuranceCardUpdate {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Insurance Card Front" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isInsuranceUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isInsuranceUpdate = true;
        
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



- (void)showInsuranceCardUpdateBack {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Insurance Card Back" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isInsuranceUpdateBack = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isInsuranceUpdateBack = true;
        
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



- (IBAction)updateNewProfilePic:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Update Patient Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
     //   isProfileUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
      //  isProfileUpdate = true;
        
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
    
  //  [self presentViewController:actionSheet animated:YES completion:nil];
    
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


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (isInsuranceUpdate == true) {
        isInsuranceUpdate = false;
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        [self updateInsuranceCard:chosenImage];
        
    } else if (isInsuranceUpdateBack == true) {
        isInsuranceUpdateBack = false;
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        [self updateInsuranceCardBack:chosenImage];
    } else if (isIDCardUpate == true) {
        isIDCardUpate = false;
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        [self updateIDCard:chosenImage];
    } else {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        [self updateProfileImage:chosenImage];
    }
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
 
    [self dismissViewControllerAnimated:true completion:^{
           isInsuranceUpdate = false;
        isIDCardUpate = false;
    }];
}


- (void)updateProfileImage:(UIImage *)img
{
    [SVProgressHUD showWithStatus:@"Uploading..."];
    [[AppController sharedInstance] updatePMasterIMG:pmaster.postid img:img WithCompletion:^(BOOL success, NSString *message) {
         [SVProgressHUD dismiss];
        NSString *title = @"succeed";
        if (success == false)
        {
            title = @"failed";
        } else {
            //[self.delegate refreshPatientList];
            [self loadPMaster];
            //[self.navigationController popViewControllerAnimated:YES];
        }
        
        
        //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}


- (void)updateInsuranceCard:(UIImage *)img
{
    [SVProgressHUD showWithStatus:@"Uploading..."];
    [[AppController sharedInstance] updatePMasterInsurance:pmaster.postid img:img WithCompletion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        NSString *title = @"succeed";
        if (success == false)
        {
            title = @"failed";
        } else {
            //[self.delegate refreshPatientList];
            [self loadPMaster];
            //[self.navigationController popViewControllerAnimated:YES];
        }
        
        
        //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}





- (void)updateInsuranceCardBack:(UIImage *)img
{
    [SVProgressHUD showWithStatus:@"Uploading..."];
    [[AppController sharedInstance] updatePMasterInsuranceBack:pmaster.postid img:img WithCompletion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        NSString *title = @"succeed";
        if (success == false)
        {
            title = @"failed";
        } else {
            //[self.delegate refreshPatientList];
            [self loadPMaster];
            //[self.navigationController popViewControllerAnimated:YES];
        }
        
        
        //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}



- (void)updateIDCard:(UIImage *)img
{
    [SVProgressHUD showWithStatus:@"Uploading..."];
    [[AppController sharedInstance] updatePMasterID:pmaster.postid img:img WithCompletion:^(BOOL success, NSString *message)  {
        
        [SVProgressHUD dismiss];
        NSString *title = @"succeed";
        if (success == false)
        {
            title = @"failed";
        } else {
            //[self.delegate refreshPatientList];
            [self loadPMaster];
            //[self.navigationController popViewControllerAnimated:YES];
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
            [[AppController sharedInstance] updatePMasterPasscode:passcodeString completion:^(BOOL success, NSString *message) {
                if (success) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Passcode succesfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        }
    } else if (isPasswordUpdate == true) {
        isPasswordUpdate = false;
        if (buttonIndex == 1) {
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
            [[AppController sharedInstance] changePasswordForUser:@"" password:passcodeString WithCompletion:
             ^(BOOL success, NSString *message) {
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



@end
