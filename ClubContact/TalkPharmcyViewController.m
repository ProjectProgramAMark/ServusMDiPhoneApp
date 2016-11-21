//
//  TalkPharmcyViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "TalkPharmcyViewController.h"

@interface TalkPharmcyViewController ()

@end

@implementation TalkPharmcyViewController

@synthesize delegate;
@synthesize pharmacyClient;
@synthesize locationManager;
@synthesize selectedAllergens;
@synthesize selectedConditions;
@synthesize bottomTab;
@synthesize pharmacySelectedArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    _conditionsArray = [NSMutableArray array];
    _addedConditionsArray = [NSMutableArray array];
    pharmacySelectedArray = [NSMutableArray array];
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
     target:self
     action:@selector(cancelPrescription)];
     self.navigationItem.leftBarButtonItem = cancelButton;*/
    
    isNotLoaded = false;
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(goToDrugs)];
    // self.navigationItem.rightBarButtonItem = nextButton;

    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
   // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    self.pharmacyClient = [[SearchPharmacyAPIClient alloc] init];
    
    
    searchCondition.delegate = self;
    
    //  [conditionTable addLegendFooterWithRefreshingBlock:^{
    //     [self requestConditionsDataByPage:currentPage + 1 keyword :  searchCondition.text];
    // }];
    
    [conditionTable addLegendHeaderWithRefreshingBlock:^{
        [self requestConditionsDataByPage:1 keyword :  searchCondition.text];
    }];
    
          [conditionTable registerNib:[UINib nibWithNibName:@"PharmacyNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    currentPage = 0;
    
    self.title = @"SELECT PHARMACY";
    
    searchCondition.delegate = self;
    
    searchCondition.placeholder = @"Search by location";
    
    //if ([CLLocationManager locationServicesEnabled]) {
   /* self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];*/
    //} else {
    //   NSLog(@"Location services are not enabled");
    // }k
    
    if (IS_IPHONE) {
       
        
    }
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [bottomTab setSelectedItem:[bottomTab.items objectAtIndex:3]];
    if ([self.conditionsArray count] == 0)
    {
        //[self requestConditionsDataByPage:1 keyword:searchCondition.text];
        
    }
    [self loadAddedPharmacies];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    if ([CLLocationManager locationServicesEnabled]) {
        
    } else {
        
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.locationManager stopUpdatingLocation];
}


- (void)cancelPrescription {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goToDrugs {
    
}

- (void)requestConditionsDataByPage:(int)page keyword:(NSString *)keyword
{
    
    DeviceInfo *device = [DeviceInfo getFromUserDefault];
    
    if (keyword.length == 0) {
        keyword = [NSString stringWithFormat:@"Pharmacy in %@", device.city];
    } else {
        keyword = [NSString stringWithFormat:@"Pharmacy in %@", keyword];
    }
    
    
    
    keyword = [keyword stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    /*[[AppController sharedInstance] getSearchPharmacy:[NSString stringWithFormat:@"in %@", keyword] WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
     
     
     if (success)
     {
     
     [_conditionsArray removeAllObjects];
     [_conditionsArray addObjectsFromArray:conditions];
     [conditionTable reloadData];
     
     [conditionTable.footer endRefreshing];
     [conditionTable.header endRefreshing];
     
     }
     }];*/
    
    [self.pharmacyClient searchForPharmacy:keyword completion:^(NSArray *results, NSError *error) {
        _conditionsArray = [NSMutableArray array];
        _conditionsArray  = [results copy];
        [conditionTable reloadData];
        
        [conditionTable.footer endRefreshing];
        [conditionTable.header endRefreshing];
    }];
    
    
    
    
}



- (void)loadAddedPharmacies {
    [[AppController sharedInstance] getAllPharmacyByPMMaster:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        [SVProgressHUD dismiss];
        if (success)
        {
            
            [pharmacySelectedArray removeAllObjects];
            
            [pharmacySelectedArray addObjectsFromArray:conditions];
            [conditionTable reloadData];
        }
        
        
    }];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 2;
    
}


#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   // return [_conditionsArray count];
    
    if (section == 0) {
        
        return [pharmacySelectedArray count];
        
    } else   if (section == 1)  {
        return [_conditionsArray count];
    } else {
        return 0;
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
  //  return @"All Pharmacies";
    if (pharmacySelectedArray.count > 0) {
        
        if (section == 0) {
            
            return @"My Pharmacies";
            
        } else if (section == 1)  {
            return @"All Pharmacies";
        } else {
            return @"";
        }
    } else {
        if (section == 0) {
            
            return @"";
            
        } else if (section == 1)  {
            return @"All Pharmacies";
        } else {
            return @"";
        }
    }

    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   /* if (_addedConditionsArray.count > 0) {
        if (indexPath.section == 0) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }*/
    if (pharmacySelectedArray.count > 0) {
        if (indexPath.section == 0) {
            return YES;
        } else {
            return NO;
        }
    } else {
        if (indexPath.section == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // PharmacyListCell *cell = [tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
    
    
      PharmacyNewTableViewCell  *cell = (PharmacyNewTableViewCell  *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    if (indexPath.section == 0) {
        Pharmacy *patientInfo = [pharmacySelectedArray objectAtIndex:indexPath.row];
        cell.nameLabel.text = patientInfo.pharmName;
        cell.addressLabel.text = patientInfo.address;
        
        //cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        //cell.addressLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
       // cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];
    } else {
    Pharmacy *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = patientInfo.pharmName;
    cell.addressLabel.text = patientInfo.address;
    
    //cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    //cell.addressLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    //cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];
        
    }
    
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        Pharmacy *patientInfo = [pharmacySelectedArray objectAtIndex:indexPath.row];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:patientInfo] forKey:@"pharmacyObj"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        TalkDoctorTypeViewController *vc = [[TalkDoctorTypeViewController alloc] initWithNibName:@"TalkDoctorTypeViewController" bundle:nil];
        vc.selectedConditions = selectedConditions;
        vc.allergenArray = _addedConditionsArray;
        vc.pharmacy = patientInfo;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
     Pharmacy *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
        
       // [[SVProgressHUD sho]]
         [SVProgressHUD showWithStatus:@"Adding..."];
        [[AppController sharedInstance] addPharmacyToPMaster:@"" pharmname:patientInfo.pharmName pharmaddress:patientInfo.address WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
           [SVProgressHUD dismiss];
            if (success) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:patientInfo] forKey:@"pharmacyObj"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                
               
                TalkDoctorTypeViewController *vc = [[TalkDoctorTypeViewController alloc] initWithNibName:@"TalkDoctorTypeViewController" bundle:nil];
                vc.selectedConditions = selectedConditions;
                vc.allergenArray = _addedConditionsArray;
                vc.pharmacy = patientInfo;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        
                [pharmacySelectedArray addObject:[_conditionsArray objectAtIndex:indexPath.row]];
        
           [conditionTable reloadData];
 
 /*   [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:patientInfo] forKey:@"pharmacyObj"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    TalkDoctorTypeViewController *vc = (TalkDoctorTypeViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkDoctorTypeViewController"];
    vc.selectedConditions = selectedConditions;
    vc.allergenArray = _addedConditionsArray;
    vc.pharmacy = patientInfo;
    [self.navigationController pushViewController:vc animated:YES]; */
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        if (pharmacySelectedArray.count > 0) {
            if (indexPath.section == 0) {
                Pharmacy *patientInfo = [pharmacySelectedArray objectAtIndex:indexPath.row];
                [pharmacySelectedArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                [[AppController sharedInstance] deletePMasterPharmacy:patientInfo.postid completion:^(BOOL success, NSString *message) {
                    if (success) {
                        
                    }
                }];
            }
            
        }
        
    }
    
}


#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self requestConditionsDataByPage:1 keyword : searchCondition.text];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  {
    // [self requestConditionsDataByPage:1 keyword : searchText];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    location = [locations lastObject];
    // self.latitudeValue.text = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    // self.longtitudeValue.text = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
    CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
    
    [reverseGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         
         if (error){
             //DDLogError(@"Geocode failed with error: %@", error);
             return;
         }
         
         //DDLogVerbose(@"Received placemarks: %@", placemarks);
         
         
         CLPlacemark *myPlacemark = [placemarks objectAtIndex:0];
         NSString *countryCode = myPlacemark.ISOcountryCode;
         cityText = myPlacemark.locality;
         countryText = myPlacemark.country;
         NSString *subCityText = myPlacemark.thoroughfare;
         
         if (!subCityText) {
             subCityText = @"";
         }
         
         if (!cityText) {
             cityText = @"";
         }
         
         
         
         if (isNotLoaded == false) {
             if ([self.conditionsArray count] == 0)
             {
                 searchCondition.text = [NSString stringWithFormat:@"%@ %@ %@",subCityText, cityText, countryText];
                 isNotLoaded = true;
                 [self requestConditionsDataByPage:1 keyword:searchCondition.text];
             }
             
         }
         
     }];
    
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
                TalkAllergyViewController *vc = [[TalkAllergyViewController alloc] initWithNibName:@"TalkAllergyViewController" bundle:nil];
                vc.selectedConditions = selectedConditions;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
        
        

        
        
        
    } else if ([bottomTab.items objectAtIndex:3] == item) {
        
        
        
        
        
        
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




@end
