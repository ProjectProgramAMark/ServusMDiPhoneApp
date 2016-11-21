//
//  TalkDoctorTypeViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "TalkDoctorTypeViewController.h"

@interface TalkDoctorTypeViewController ()

@end

@implementation TalkDoctorTypeViewController


@synthesize allergenClient;
@synthesize selectedConditions;
//@synthesize patient;
//@synthesize delegate;
@synthesize conditionsArray;
@synthesize addedConditionsArray;
@synthesize allergenArray;
@synthesize pharmacy;
@synthesize arraySearchResults;
@synthesize bottomTab;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isSearchInProgress = false;
    arraySearchResults = [NSMutableArray array];
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    conditionsArray = [NSMutableArray array];
    addedConditionsArray = [NSMutableArray array];
     conditionsArray = [NSMutableArray arrayWithObjects:@"Addiction psychiatrist",@"Adolescent medicine specialist",@"Allergist (immunologist)",@"Anesthesiologist",@"Cardiac electrophysiologist",@"Cardiologist",@"Cardiovascular surgeon",@"Colon and rectal surgeon",@"Critical care medicine specialist",@"Dentist", @"Dermatologist",@"Developmental pediatrician",@"Emergency medicine specialist",@"Endocrinologist",@"Family medicine physician",@"Forensic pathologist",@"Gastroenterologist",@"Geriatric medicine specialist",@"Gynecologist",@"Gynecologic oncologist",@"Hand surgeon",@"Hematologist",@"Hepatologist",@"Hospitalist",@"Hospice and palliative medicine specialist",@"Hyperbaric physician",@"Infectious disease specialist",@"Internist",@"Interventional cardiologist",@"Medical examiner",@"Medical geneticist",@"Neonatologist",@"Nephrologist",@"Neurological surgeon",@"Neurologist",@"Nuclear medicine specialist",@"Nurse Practitioner",  @"Obstetrician",@"Occupational medicine specialist",@"Oncologist",@"Ophthalmologist",@"Optometrist", @"Oral surgeon (maxillofacial surgeon)", @"Orthodontist", @"Orthopedic surgeon",@"Otolaryngologist (ear, nose, and throat specialist)",@"Pain management specialist",@"Pathologist",@"Pediatrician",@"Perinatologist",@"Physiatrist",@"Physical Assistant Speciality", @"Plastic surgeon",@"Psychiatrist",@"Pulmonologist",@"Radiation oncologist",@"Radiologist",@"Reproductive endocrinologist",@"Rheumatologist",@"Sleep disorders specialist",@"Spinal cord injury specialist",@"Sports medicine specialist",@"Surgeon",@"Thoracic surgeon",@"Urologist",@"Vascular surgeon", @"Veterinary Specialist", nil];
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
     target:self
     action:@selector(cancelPrescription)];
     self.navigationItem.leftBarButtonItem = cancelButton;*/
    
   /* UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(goToPharmacy)];
    self.navigationItem.rightBarButtonItem = nextButton;*/
    
    /*UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"nextarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goToPharmacy)];*/
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
    
    self.allergenClient = [[AllergenSearchAPIClient alloc] init];
    
    searchCondition.delegate = self;
    

    
    [conditionTable registerNib:[UINib nibWithNibName:@"ConditionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    currentPage = 0;
    
    self.title = @"SELECT SPECIALIZATION";
    
    searchCondition.delegate = self;
    
    searchCondition.placeholder = @"";
    
    /* if (IS_IPHONE) {
     if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
     [self setEdgesForExtendedLayout:UIRectEdgeNone];
     
     searchCondition.frame = CGRectMake(0, 0, searchCondition.frame.size.width, searchCondition.frame.size.height);
     conditionTable.frame =CGRectMake(0, searchCondition.frame.size.height, windowWidth,self.view.frame.size.height);
     }*/
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
    [bottomTab setSelectedItem:[bottomTab.items objectAtIndex:4]];
    if ([self.conditionsArray count] == 0)
    {
      //  [self requestConditionsDataByPage:1 keyword:searchCondition.text];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}


- (void)cancelPrescription {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToPharmacy:(id)sender {
    /*  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
     DrugsViewController *vc = (DrugsViewController *)[sb instantiateViewControllerWithIdentifier:@"DrugsViewController"];
     vc.selectedConditions = selectedConditions;
     vc.selectedAllergens = _addedConditionsArray;
     vc.patient = patient;
     vc.delegate = self;
     [self.navigationController pushViewController:vc animated:YES];*/
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    TalkDoctorViewController *vc = [[TalkDoctorViewController alloc] initWithNibName:@"TalkDoctorViewController" bundle:nil];
    vc.selectedConditions = selectedConditions;
    vc.selectedAllergens = allergenArray;
    vc.pharmacy = pharmacy;
    vc.docSpecial = @"";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestConditionsDataByPage:(int)page keyword:(NSString *)keyword
{
    /*[[AppController sharedInstance] getAllConditionByPage:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
     if (success)
     {
     currentPage = page;
     if(currentPage == 1)
     {
     [_conditionsArray removeAllObjects];
     }
     [_conditionsArray addObjectsFromArray:patients];
     [conditionTable reloadData];
     }
     
     [conditionTable.footer endRefreshing];
     [conditionTable.header endRefreshing];
     }];*/
    
    if (keyword.length == 0) {
        keyword = @"a";
    }
    
    [self.allergenClient searchForAllergen:keyword
                                completion:^(NSArray *results, NSError *error) {
                                    //   self.searchButton.enabled = YES;
                                    
                                    //NSTimeInterval duration = [NSDate date].timeIntervalSinceReferenceDate - start;
                                    if(!error){
                                        //self.durationLabel.text = [NSString stringWithFormat:@"%f secs", duration];
                                        //self.successLabel.text = [self statusString:YES];
                                        conditionsArray = [NSMutableArray array];
                                        conditionsArray  = [results copy];
                                        [conditionTable reloadData];
                                        
                                        //[self.searchField resignFirstResponder];
                                    }else{
                                        /*self.successLabel.text = [self statusString:NO];
                                         self.medications = @[];
                                         [self.tableView reloadData];*/
                                    }
                                    
                                }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}


#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //  if (_addedConditionsArray.count > 0) {
   /* if (section == 0) {
        
        return [_addedConditionsArray count];
        
    } else   if (section == 1)  {
        return [_conditionsArray count];
    } else {
        return 0;
    }*/
   // return conditionsArray.count;
    /*} else {
     return [_conditionsArray count];
     }*/
    if(isSearchInProgress){
        return [self.arraySearchResults count];
    }else{
        
        return [conditionsArray count];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
     return @"";
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConditionsTableViewCell    *cell = (ConditionsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    NSString *conditionText = @"";
    
    if (isSearchInProgress) {
        conditionText = [arraySearchResults objectAtIndex:indexPath.row];
    } else {
        conditionText = [conditionsArray objectAtIndex:indexPath.row];
    }
    
   // cell.cellImageView.image = [UIImage imageNamed:@"medical-cap-icon.png"];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", conditionText];
    //cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    cell.clipsToBounds = YES;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
     UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
     PatientDetailViewController *vc = (PatientDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDetailViewController"];
     vc.patient = patientInfo;
     
     [self.navigationController pushViewController:vc animated:YES];*/
    // if (_addedConditionsArray.count > 0) {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *docSpecial = @"";
    
    if (isSearchInProgress) {
        docSpecial = [arraySearchResults objectAtIndex:indexPath.row];
    } else {
        docSpecial = [conditionsArray objectAtIndex:indexPath.row];
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    TalkDoctorViewController *vc = [[TalkDoctorViewController alloc] initWithNibName:@"TalkDoctorViewController" bundle:nil];
    vc.selectedConditions = selectedConditions;
    vc.selectedAllergens = allergenArray;
    vc.pharmacy = pharmacy;
    vc.docSpecial = docSpecial;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        if (addedConditionsArray.count > 0) {
            if (indexPath.section == 0) {
                [addedConditionsArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }
        
    }
    
    
}


#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //[self requestConditionsDataByPage:1 keyword : searchCondition.text];
    NSString *strText = searchBar.text;
    
    [self.arraySearchResults removeAllObjects];
    
    if ([strText length]) {
        
        isSearchInProgress = YES;
        
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"(SELF contains[cd] %@)",[strText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        NSArray *filtered  = [conditionsArray filteredArrayUsingPredicate:searchPredicate];
        [self.arraySearchResults addObjectsFromArray:filtered];
        
    }else{
        isSearchInProgress = NO;
    }
    
    [conditionTable reloadData];

    [searchBar resignFirstResponder];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  {
    //[self requestConditionsDataByPage:1 keyword : searchText];
    
    NSString *strText = searchBar.text;
    
    [self.arraySearchResults removeAllObjects];
    
    if ([strText length]) {
        
        isSearchInProgress = YES;
        
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"(SELF contains[cd] %@)",[strText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        NSArray *filtered  = [conditionsArray filteredArrayUsingPredicate:searchPredicate];
        [self.arraySearchResults addObjectsFromArray:filtered];
        
    }else{
        isSearchInProgress = NO;
    }
    
    [conditionTable reloadData];
    
   // [searchBar resignFirstResponder];
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
        return;
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
                    
                    if ([viewController isKindOfClass:[TalkPharmcyViewController class]] ) {
                        if (viewContains != true) {
                            [self.navigationController popToViewController:viewController  animated:YES];
                        }
                         viewContains = true;
                        
                    } else {
                        
                    }
                }
                
                if (viewContains == false) {
                    TalkDoctorTypeViewController *vc = [[TalkDoctorTypeViewController alloc] initWithNibName:@"TalkDoctorTypeViewController" bundle:nil];
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
                    
                    if ([viewController isKindOfClass:[TalkPharmcyViewController class]] ) {
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
