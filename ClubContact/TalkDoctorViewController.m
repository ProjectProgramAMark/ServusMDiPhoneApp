//
//  TalkDoctorViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "TalkDoctorViewController.h"
#import "Patient.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "Doctors.h"


@interface TalkDoctorViewController () <SpecialitySelectorDelegate>

@end

@implementation TalkDoctorViewController
@synthesize patientsArray;
@synthesize conditionsArray;
@synthesize addedConditionsArray;
@synthesize selectedAllergens;
@synthesize selectedConditions;
@synthesize pharmacy;
@synthesize docSpecial;
@synthesize bottomTab;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     patientsArray = [[NSMutableArray alloc] init];
    currentPage = 1;
    [doctorsTable addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :docSpecial];
    }];
    
    [doctorsTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : docSpecial];
    }];
    
    [doctorsTable registerNib:[UINib nibWithNibName:@"DoctorCellV2" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
   
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;

    self.title = @"SELECT DOCTOR";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [bottomTab setSelectedItem:[bottomTab.items objectAtIndex:5]];
    if ([self.patientsArray count] == 0)
    {
        doctorSearch.text = docSpecial;
        [self requestPatientsDataByPage:1 keyword : docSpecial];
    }
   
}


- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    /*[[AppController sharedInstance] getAllPatiensByPage:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
     if (success)
     {
     currentPage = page;
     if(currentPage == 1)
     {
     [_patientsArray removeAllObjects];
     }
     [_patientsArray addObjectsFromArray:patients];
     [patientsGrid reloadData];
     }
     
     [patientsGrid.footer endRefreshing];
     [patientsGrid.header endRefreshing];
     }];*/
    
    [[AppController sharedInstance] getAllDoctors2:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [patientsArray removeAllObjects];
            }
            [patientsArray addObjectsFromArray:conditions];
            [doctorsTable reloadData];
        }
        
        [doctorsTable.footer endRefreshing];
        [doctorsTable.header endRefreshing];
        
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [patientsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoctorCellV2 *cell = (DoctorCellV2 *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    Doctors *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
   /* NSString *isOnline = @"Offline";
    if ([patientInfo.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Available";
        cell.onlineLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = true;
        cell.messageIcon.selected = true;
    } else if ([patientInfo.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Unavailable";
        cell.onlineLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = false;
        cell.messageIcon.selected = false;
    }
    
    cell.facetimeIcon.tag = indexPath.row;
    cell.messageIcon.tag = indexPath.row;
    [cell.facetimeIcon addTarget:self action:@selector(openVideoChat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageIcon addTarget:self action:@selector(openMessaging:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.firstname, patientInfo.lastname];
    cell.specialityLabel.text = patientInfo.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
    // cell.nameLabel.text = imageName;
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    
    cell.clipsToBounds = YES;*/
    
    
    
    NSString *isOnline = @"Offline";
    if ([patientInfo.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Available";
        cell.onlineLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = true;
        cell.messageIcon.selected = true;
    } else if ([patientInfo.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Unavailable";
        cell.onlineLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        
        
        cell.facetimeIcon.selected = false;
        cell.messageIcon.selected = false;
    }
    
    cell.facetimeIcon.tag = indexPath.row;
    cell.messageIcon.tag = indexPath.row;
    [cell.facetimeIcon addTarget:self action:@selector(openVideoChat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageIcon addTarget:self action:@selector(openMessaging:) forControlEvents:UIControlEventTouchUpInside];
    cell.facetimeIcon.hidden = true;
    cell.messageIcon.hidden = true;
    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.firstname, patientInfo.lastname];
    cell.specialityLabel.text = patientInfo.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
    // cell.nameLabel.text = imageName;
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    cell.cellImageView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.cellImageView.layer.borderWidth = 1.0f;
    cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
    cell.clipsToBounds = YES;
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Doctors *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
  
    [Flurry logEvent:@"DoctorView" withParameters:[NSDictionary dictionaryWithObject:patientInfo.username forKey:@"searchKey"]];
    TalkDoctorProfileViewController *vc = [[TalkDoctorProfileViewController alloc] initWithNibName:@"TalkDoctorProfileViewController" bundle:nil];
    vc.doctor = patientInfo;
    vc.pharmacy = pharmacy;
    vc.selectedConditions = selectedConditions;
    vc.allergenArray = selectedAllergens;
    
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     [Flurry logEvent:@"DoctorSearch" withParameters:[NSDictionary dictionaryWithObject:searchBar.text forKey:@"searchKey"]];
    [self requestPatientsDataByPage:1 keyword:searchBar.text];
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  {
    [Flurry logEvent:@"DoctorSearch" withParameters:[NSDictionary dictionaryWithObject:searchBar.text forKey:@"searchKey"]];
    
    [self requestPatientsDataByPage:1 keyword:searchBar.text];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self inialiseToolbar];
     doctorSearch.inputAccessoryView = toolbar;
    return true;
}


- (IBAction)openVideoChat:(UIButton *)sender {
    
     Doctors *patientInfo = [patientsArray objectAtIndex:sender.tag];
    
    NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
    
    if (patientChose) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        
        //Pharmacy *pharmacy = [[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyObj"];
        TalkCreateViewController *vc = (TalkCreateViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkCreateViewController"];
        vc.doctor =patientInfo;
        vc.allergenArray = [NSMutableArray array];
        vc.selectedConditions = [NSMutableArray array];
        vc.pharmacy = pharmacy;
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Set Up Profile" message:@"You have not completed your profile yet" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *accessAction = [UIAlertAction actionWithTitle:@"Complete Profile" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            ShortQuestViewController *vc = (ShortQuestViewController  *)[sb instantiateViewControllerWithIdentifier:@"ShortQuestViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }];
        
        
        
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //  [self dismissViewControllerAnimated:self completion:nil];
            
        }];
        
        [actionSheet addAction:accessAction];
        
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

- (IBAction)openMessaging:(UIButton *)sender {
    Doctors *patientInfo = [patientsArray objectAtIndex:sender.tag];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    MesDocProfileViewController *vc = (MesDocProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"MesDocProfileViewController"];
    vc.doctor = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}







- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([bottomTab.items objectAtIndex:0] == item) {
       /* for (UIViewController* viewController in self.navigationController.viewControllers) {
            
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
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            TalkPharmcyViewController *vc = [[TalkPharmcyViewController alloc] initWithNibName:@"TalkPharmcyViewController" bundle:nil];
            vc.selectedConditions = selectedConditions;
            vc.selectedAllergens = selectedAllergens;
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
                    TalkDoctorTypeViewController *vc = [[TalkDoctorTypeViewController alloc] initWithNibName:@"TalkDoctorTypeViewController" bundle:nil];
                    vc.selectedConditions = selectedConditions;
                    vc.allergenArray = selectedAllergens;
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
                    vc.selectedAllergens = selectedAllergens;
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

-(void)inialiseToolbar{
    
    CGFloat _width = self.view.frame.size.width;
    CGFloat _height = 40.0;
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -_height, _width, _height)];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButtonItemSubmit = [[UIBarButtonItem alloc] initWithTitle:@"Speciality" style:UIBarButtonItemStyleBordered target:self action:@selector(specialitySelect:)];
    [toolbar setItems:[[NSArray alloc] initWithObjects:flexibleSpace,barButtonItemSubmit,  nil]];
}


- (IBAction)specialitySelect:(id)sender {
    SpecialitySelectorViewController *vc = [[SpecialitySelectorViewController alloc] init];
    vc.delegate = self;
   // isSpecilitySelect = true;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)specialitySelectDone:(NSString *)speciality {
    doctorSearch.text = speciality;
     [self requestPatientsDataByPage:1 keyword:speciality];
    
}

@end
