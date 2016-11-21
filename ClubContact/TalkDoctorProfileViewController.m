//
//  TalkDoctorProfileViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "TalkDoctorProfileViewController.h"
#import "UIImageView+WebCache.h"

@interface TalkDoctorProfileViewController ()

@end

@implementation TalkDoctorProfileViewController


@synthesize doctor;
@synthesize pharmacy;
@synthesize selectedConditions;
@synthesize allergenArray;
@synthesize bottomTab;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // [menuTable registerNib:[UINib nibWithNibName:@"DocMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    if (IS_IPHONE) {
        [menuTable registerNib:[UINib nibWithNibName:@"DocMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    } else {
        [menuTable registerNib:[UINib nibWithNibName:@"DashboardDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    }
    
  
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    
    self.title = @"DOCTOR PROFILE";
}

- (void)viewWillAppear:(BOOL)animated {
    [bottomTab setSelectedItem:[bottomTab.items objectAtIndex:5]];
    [self loadDoctorData];
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadDoctorData {
    if (doctor) {
        [profileIMG setImageWithURL:[NSURL URLWithString:doctor.profileimage]];
        //[profileBackIMG setImageWithURL:[NSURL URLWithString:doctor.profileimage]];
        
        
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
        profileIMG.layer.masksToBounds = YES;
       // profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        //profileIMG.layer.borderWidth = 3.0;
        
        docName.text = [NSString stringWithFormat:@"Dr. %@ %@", doctor.firstname, doctor.lastname];
        docSpeciality.text = doctor.speciality;
        docFrom.text = [NSString stringWithFormat:@"From %@ %@ %@ %@ %@", doctor.officeaddress, doctor.officecity, doctor.officestate, doctor.officezip, doctor.officecountry];
        docCost.text = [NSString stringWithFormat:@"1 Token/Message"];
        
        if ([doctor.yearsExperience intValue] > 1) {
            docYears.text = [NSString stringWithFormat:@"Experience: %@ years ", doctor.yearsExperience];
        } else {
            docYears.text = [NSString stringWithFormat:@"Experience: %@ year", doctor.yearsExperience];
        }
        
        docResidency.text = [NSString stringWithFormat:@"Residency: %@", doctor.residency];
        docSchool.text = [NSString stringWithFormat:@"School: %@", doctor.school];
        
        NSString *isOnline = @"Offline";
        if ([doctor.isOnline intValue] == 1) {
            //isOnline = @"Online";
            docOnline.text = @"Available";
            docOnline.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
            
        } else if ([doctor.isOnline intValue] == 2) {
            docOnline.text = @"Unavailable";
            docOnline.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            
        }
        
        
    }
}




- (IBAction)goToDoctorProfileInfo:(id)sender {
    DocProfileInfoViewController *vc = [[DocProfileInfoViewController alloc] init];
    vc.doctor = doctor;
    vc.isConsultation = true;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (IBAction)goToReviews:(id)sender {
    ReviewsViewController *vc = [[ReviewsViewController alloc] initWithNibName:@"ReviewsViewController" bundle:nil];
    vc.doctor = doctor;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)createNewSession:(id)sender {
    if ([doctor.isOnline intValue] == 1) {
        
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Consultation" message:@"Select an option" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *accessAction = [UIAlertAction actionWithTitle:@"Right now" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSDate* currentDate = [NSDate date];
            
            NSTimeZone* timeZone = [NSTimeZone localTimeZone];
            int unix_timestamp =  [currentDate timeIntervalSince1970];
            // int Timestamp1 = unix_timestamp - offset;
            int Timestamp1 = unix_timestamp;
            
            NSString *fromdate = [NSString stringWithFormat:@"%i", Timestamp1];
            [SVProgressHUD showWithStatus:@"Please wait..."];
            [[AppController sharedInstance] addConsultation2:doctor.uid fromdate:fromdate tnotetext:@"" pharmcyname:pharmacy.pharmName pharmancyaddress:pharmacy.address completion:^(BOOL success, NSString *message) {
                [SVProgressHUD dismiss];
                if (success) {
                    UIAlertView *alert = [[[UIAlertView alloc] init] initWithTitle:@"Sent" message:@"Consultation request sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                    
                } else {
                    UIAlertView *alert = [[[UIAlertView alloc] init] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                }
            }];
        }];
        
        UIAlertAction *accessAction2 = [UIAlertAction actionWithTitle:@"Schedule one " style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
           
            TalkCreateViewController *vc = [[TalkCreateViewController  alloc] initWithNibName:@"TalkCreateViewController" bundle:nil];
            vc.doctor = doctor;
            vc.allergenArray = allergenArray;
            vc.selectedConditions = selectedConditions;
            vc.pharmacy = pharmacy;
            
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        
        
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //  [self dismissViewControllerAnimated:self completion:nil];
            
        }];
        
        [actionSheet addAction:accessAction];
        [actionSheet addAction:accessAction2];
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
                TalkCreateViewController *vc = [[TalkCreateViewController  alloc] initWithNibName:@"TalkCreateViewController" bundle:nil];
        vc.doctor = doctor;
        vc.allergenArray = allergenArray;
        vc.selectedConditions = selectedConditions;
        vc.pharmacy = pharmacy;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}


- (IBAction)goToConsultationHistory:(id)sender {
    TalkConPreviousViewController *vc = [[TalkConPreviousViewController alloc] initWithNibName:@"TalkConPreviousViewController" bundle:nil];
    vc.doctor = doctor;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE) {
        
        DocMenuTableViewCell    *cell = (DocMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
        
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"New Consultation";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Previous Consultations";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Reviews";
            cell.nameLabel.textColor = [UIColor colorWithRed:140.0f/255.0f green:88.0f/255.0f blue:177.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"perfect1.png"];
        }
        cell.clipsToBounds = YES;
        
        return cell;
        
    } else {
        DashboardDocTableViewCell  *cell = (DashboardDocTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"New Consultations";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Previous Consultations";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Reviews";
            cell.nameLabel.textColor = [UIColor colorWithRed:140.0f/255.0f green:88.0f/255.0f blue:177.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"perfect1.png"];
        }
        cell.clipsToBounds = YES;
        
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        return 80.0f;
    } else {
        return 80.0f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
          if ([doctor.isOnline intValue] == 1) {
              
              
              UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Consultation" message:@"Select an option" preferredStyle:UIAlertControllerStyleAlert];
              
              
              UIAlertAction *accessAction = [UIAlertAction actionWithTitle:@"Right now" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                  NSDate* currentDate = [NSDate date];
                  
                  NSTimeZone* timeZone = [NSTimeZone localTimeZone];
                  int unix_timestamp =  [currentDate timeIntervalSince1970];
                  // int Timestamp1 = unix_timestamp - offset;
                  int Timestamp1 = unix_timestamp;
                  
                  NSString *fromdate = [NSString stringWithFormat:@"%i", Timestamp1];
                  
                  [SVProgressHUD showWithStatus:@"Please wait..."];
                  [[AppController sharedInstance] addConsultation2:doctor.uid fromdate:fromdate tnotetext:@"" pharmcyname:pharmacy.pharmName pharmancyaddress:pharmacy.address completion:^(BOOL success, NSString *message) {
                      [SVProgressHUD dismiss];
                      if (success) {
                          UIAlertView *alert = [[[UIAlertView alloc] init] initWithTitle:@"Sent" message:@"Consultation request sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                          [alert show];
                          
                      } else {
                          UIAlertView *alert = [[[UIAlertView alloc] init] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                          [alert show];
                      }
                  }];
              }];
              
              UIAlertAction *accessAction2 = [UIAlertAction actionWithTitle:@"Schedule one " style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                  
                  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                  TalkCreateViewController *vc = (TalkCreateViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkCreateViewController"];
                  vc.doctor = doctor;
                  vc.allergenArray = allergenArray;
                  vc.selectedConditions = selectedConditions;
                  vc.pharmacy = pharmacy;
                  
                  [self.navigationController pushViewController:vc animated:YES];
              }];
              
              
              
              
              
              UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                  //  [self dismissViewControllerAnimated:self completion:nil];
                  
              }];
              
              [actionSheet addAction:accessAction];
               [actionSheet addAction:accessAction2];
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
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        TalkCreateViewController *vc = (TalkCreateViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkCreateViewController"];
        vc.doctor = doctor;
        vc.allergenArray = allergenArray;
        vc.selectedConditions = selectedConditions;
        vc.pharmacy = pharmacy;
        
        [self.navigationController pushViewController:vc animated:YES];
              
          }
    } else if (indexPath.row == 1) {
    
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        TalkConPreviousViewController *vc = (TalkConPreviousViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkConPreviousViewController"];
        vc.doctor = doctor;
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ReviewsViewController *vc = (ReviewsViewController *)[sb instantiateViewControllerWithIdentifier:@"ReviewsViewController"];
        vc.doctor = doctor;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}





- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([bottomTab.items objectAtIndex:0] == item) {
        /*for (UIViewController* viewController in self.navigationController.viewControllers) {
            
            if ([viewController isKindOfClass:[DashboardPatientViewController class]] ) {
                [self.navigationController popToViewController:viewController  animated:YES];
            }
        }*/
        DashboardPatientViewController *vc = [[DashboardPatientViewController alloc] initWithNibName:@"DashboardPatientViewController" bundle:nil];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.revealViewController pushFrontViewController:navigationController animated:YES];
    } else if ([bottomTab.items objectAtIndex:1] == item) {
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            BOOL viewContains = false;
            for (UIViewController* viewController in self.navigationController.viewControllers) {
                
                if ([viewController isKindOfClass:[TalkConditionsViewController class]] ) {
                    viewContains = true;
                    [self.navigationController popToViewController:viewController  animated:YES];
                    
                    
                } else {
                    
                }
            }
            
            if (viewContains == false) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                TalkConditionsViewController *vc = [[TalkConditionsViewController alloc] initWithNibName:@"TalkConditionsViewController" bundle:nil];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
        
        
        
        
    } else if ([bottomTab.items objectAtIndex:2] == item) {
        
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            BOOL viewContains = false;
            for (UIViewController* viewController in self.navigationController.viewControllers) {
                
                if ([viewController isKindOfClass:[TalkAllergyViewController class]] ) {
                    viewContains = true;
                    [self.navigationController popToViewController:viewController  animated:YES];
                    
                    
                } else {
                    
                }
            }
            
            if (viewContains == false) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                TalkAllergyViewController *vc = [[TalkAllergyViewController alloc] initWithNibName:@"TalkAllergyViewController" bundle:nil];
                vc.selectedConditions = selectedConditions;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
        
        
        
        
        
        
    } else if ([bottomTab.items objectAtIndex:3] == item) {
        
        
        BOOL viewContains = false;
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            
            if ([viewController isKindOfClass:[TalkPharmcyViewController class]] ) {
                viewContains = true;
                [self.navigationController popToViewController:viewController  animated:YES];
                
                
            } else {
                
            }
        }
        
        if (viewContains == false) {
            TalkPharmcyViewController *vc = [[TalkPharmcyViewController alloc] initWithNibName:@"TalkPharmcyViewController" bundle:nil];
            vc.selectedConditions = selectedConditions;
            vc.selectedAllergens = allergenArray;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        
        
        
        
    } else if ([bottomTab.items objectAtIndex:4] == item) {
        
        
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            Pharmacy *pharmacy2 = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyObj"]];
            
            if (pharmacy2) {
                /* UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                 TalkDoctorTypeViewController *vc = (TalkDoctorTypeViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkDoctorTypeViewController"];
                 vc.selectedConditions = _addedConditionsArray;
                 vc.allergenArray = [[NSMutableArray alloc] init];
                 vc.pharmacy = pharmacy2;
                 [self.navigationController pushViewController:vc animated:YES];*/
                BOOL viewContains = false;
                for (UIViewController* viewController in self.navigationController.viewControllers) {
                    
                    if ([viewController isKindOfClass:[TalkDoctorTypeViewController class]] ) {
                        viewContains = true;
                        [self.navigationController popToViewController:viewController  animated:YES];
                        
                        
                    } else {
                        
                    }
                }
                
                if (viewContains == false) {
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                    TalkDoctorTypeViewController *vc =[[TalkDoctorTypeViewController alloc] initWithNibName:@"TalkDoctorTypeViewController" bundle:nil];
                    vc.selectedConditions = selectedConditions;
                    vc.allergenArray = allergenArray;
                    vc.pharmacy = pharmacy2;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                
            } else {
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Pharmacy" message:@"You have not enter your prefered pharmacy before" preferredStyle:UIAlertControllerStyleAlert];
                
                
                
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    //  [self dismissViewControllerAnimated:self completion:nil];
                    
                }];
                
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
            
            
        } else {
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Set Up Profile" message:@"You have not completed this page before" preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                //  [self dismissViewControllerAnimated:self completion:nil];
                
            }];
            
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
        
        
        
        
    } else if ([bottomTab.items objectAtIndex:5] == item) {
        
        return;
        
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            Pharmacy *pharmacy2 = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyObj"]];
            
            if (pharmacy2) {
                /*  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                 TalkDoctorViewController *vc = (TalkDoctorViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkDoctorViewController"];
                 vc.selectedConditions = _addedConditionsArray;
                 vc.selectedAllergens = [[NSMutableArray alloc] init];
                 vc.pharmacy = pharmacy2;
                 vc.docSpecial = @"";
                 [self.navigationController pushViewController:vc animated:YES];*/
                BOOL viewContains = false;
                for (UIViewController* viewController in self.navigationController.viewControllers) {
                    
                    if ([viewController isKindOfClass:[TalkDoctorViewController class]] ) {
                        viewContains = true;
                        [self.navigationController popToViewController:viewController  animated:YES];
                        
                        
                    } else {
                        
                    }
                }
                
                if (viewContains == false) {
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                    TalkDoctorViewController *vc = [[TalkDoctorViewController alloc] initWithNibName:@"TalkDoctorViewController" bundle:nil];
                    vc.selectedConditions = selectedConditions;
                    vc.selectedAllergens = allergenArray;
                    vc.pharmacy = pharmacy2;
                    vc.docSpecial = @"";
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                
            } else {
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Pharmacy" message:@"You have not entered your prefered pharmacy before" preferredStyle:UIAlertControllerStyleAlert];
                
                
                
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    //  [self dismissViewControllerAnimated:self completion:nil];
                    
                }];
                
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
            
            
        } else {
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Set Up Profile" message:@"You have not completed this page before" preferredStyle:UIAlertControllerStyleAlert];
            
            
            
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                //  [self dismissViewControllerAnimated:self completion:nil];
                
            }];
            
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
        
        
        
        
    }
    
    
    
    
}


@end
