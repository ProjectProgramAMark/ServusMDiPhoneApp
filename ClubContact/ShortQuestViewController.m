//
//  ShortQuestViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "ShortQuestViewController.h"

@interface ShortQuestViewController ()

@end

@implementation ShortQuestViewController
@synthesize pmaster;
@synthesize bottomTab;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   /* UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(goTonextPage:)];*/
    
    /*UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"nextarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goTonextPage:)];*/
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
    
    self.title = @"BASIC INFO";
  //  bottomTab.selected
    [bottomTab setSelectedItem:[bottomTab.items objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBackToChose:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}


- (void)viewWillAppear:(BOOL)animated {
      [bottomTab setSelectedItem:[bottomTab.items objectAtIndex:0]];
    [self loadPMaster];
}


- (void)loadPMaster {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getPMasterByID:@"" WithCompletion:^(BOOL success, NSString *message, PMaster *msgsession) {
        [SVProgressHUD dismiss];
        if (success) {
            pmaster = msgsession;
            
            patientName.text = [NSString stringWithFormat:@"%@ %@", pmaster.firstname, pmaster.lastname];
            patientLocation.text = pmaster.state;
            patientTele.text = pmaster.telephone;
            
            
        }
    }];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([choseText isFirstResponder]) {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select an option" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction *emAction = [UIAlertAction actionWithTitle:@"Gone to the Emergency Room" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            //   isProfileUpdate = true;
          
            choseText.text = @"Gone to the Emergency Room";
            [choseText resignFirstResponder];
            
        }];
        
        UIAlertAction *ugAction = [UIAlertAction actionWithTitle:@"Used Urgent Care / Retail Clinic" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        
            choseText.text = @"Used Urgent Care / Retail Clinic";
            [choseText resignFirstResponder];
            
        }];
        
        UIAlertAction *ppAction = [UIAlertAction actionWithTitle:@"Seen my doctor in person" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            choseText.text = @"Seen my doctor in person";
            [choseText resignFirstResponder];
            
        }];
        
        UIAlertAction *nothAction = [UIAlertAction actionWithTitle:@"Done Nothing" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            choseText.text = @"Done Nothing";
             [choseText resignFirstResponder];
            
        }];
        
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //  [self dismissViewControllerAnimated:self completion:nil];
            [choseText resignFirstResponder];
        }];
        
        [actionSheet addAction:emAction];
        [actionSheet addAction:ugAction];
        [actionSheet addAction:ppAction];
        [actionSheet addAction:nothAction];
        [actionSheet addAction:cancelAction];
         [choseText resignFirstResponder];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return true;
}

- (IBAction)goTonextPage:(id)sender {
    [self.view endEditing:YES];
    if (patientTele.text.length == 0) {
         [self showAlertViewWithMessage:@"Enter your telephone number" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else  if (choseText.text.length == 0) {
        [self showAlertViewWithMessage:@"Select an option for what would you have done today" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else {
        NSString *whatText = @"";
        if (primaryPhysician.selectedSegmentIndex == 0) {
            whatText = @"Yes";
        } else if (primaryPhysician.selectedSegmentIndex == 1) {
             whatText = @"No";
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:whatText forKey:@"primaryPhysician"];
        [[NSUserDefaults standardUserDefaults] setValue:patientTele.text forKey:@"patientTele"];
        [[NSUserDefaults standardUserDefaults] setValue:choseText.text forKey:@"whatChose"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    TalkConditionsViewController *vc = [[TalkConditionsViewController alloc] initWithNibName:@"TalkConditionsViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([bottomTab.items objectAtIndex:0] == item) {
      /*  DashboardPatientViewController *vc = [[DashboardPatientViewController alloc] initWithNibName:@"DashboardPatientViewController" bundle:nil];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.revealViewController pushFrontViewController:navigationController animated:YES];*/
        
    } else if ([bottomTab.items objectAtIndex:1] == item) {
        
        
        
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            TalkConditionsViewController *vc = [[TalkConditionsViewController alloc] initWithNibName:@"TalkConditionsViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
           /* [UIView animateWithDuration:0.75
                             animations:^{
                                 [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                                 [self.navigationController pushViewController:vc animated:YES];
                                 [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
                             }];*/
            
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
        
        
        
        
    } else if ([bottomTab.items objectAtIndex:2] == item) {
        
        
        
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            TalkAllergyViewController *vc = [[TalkAllergyViewController alloc] initWithNibName:@"TalkAllergyViewController" bundle:nil];
            vc.selectedConditions = [[NSMutableArray alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
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
        
        
        
        
    } else if ([bottomTab.items objectAtIndex:3] == item) {
        
        
        
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            TalkPharmcyViewController *vc = [[TalkPharmcyViewController alloc] initWithNibName:@"TalkPharmcyViewController" bundle:nil];
            vc.selectedConditions = [[NSMutableArray alloc] init];
            vc.selectedAllergens = [[NSMutableArray alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
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
        
        
        
        
    } else if ([bottomTab.items objectAtIndex:4] == item) {
        
        
        
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
             Pharmacy *pharmacy2 = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyObj"]];
            
            if (pharmacy2) {
                TalkDoctorTypeViewController *vc = [[TalkDoctorTypeViewController alloc] initWithNibName:@"TalkDoctorTypeViewController" bundle:nil];
                vc.selectedConditions = [[NSMutableArray alloc] init];
                vc.allergenArray = [[NSMutableArray alloc] init];
                vc.pharmacy = pharmacy2;
                [self.navigationController pushViewController:vc animated:YES];
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
        
        
        
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            Pharmacy *pharmacy2 = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyObj"]];
            
            if (pharmacy2) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                TalkDoctorViewController *vc = [[TalkDoctorViewController alloc] initWithNibName:@"TalkDoctorViewController" bundle:nil];
                vc.selectedConditions = [[NSMutableArray alloc] init];
                vc.selectedAllergens = [[NSMutableArray alloc] init];
                vc.pharmacy = pharmacy2;
                vc.docSpecial = @"";
                [self.navigationController pushViewController:vc animated:YES];
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
        
        
        
        
    }




}


- (void)showTerms:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    TermsViewController *vc = (TermsViewController *)[sb instantiateViewControllerWithIdentifier:@"TermsViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
