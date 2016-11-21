//
//  TalkAllergyViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "TalkAllergyViewController.h"

@interface TalkAllergyViewController ()

@end

@implementation TalkAllergyViewController


@synthesize allergenClient;
@synthesize selectedConditions;
//@synthesize patient;
//@synthesize delegate;
@synthesize messageField;
@synthesize msgInPutView;
@synthesize sendChatBtn;
@synthesize bottomTab;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    _conditionsArray = [NSMutableArray array];
    _addedConditionsArray = [NSMutableArray array];
    
   
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
    
    [conditionTable addLegendFooterWithRefreshingBlock:^{
        [self requestConditionsDataByPage:currentPage + 1 keyword :  searchCondition.text];
    }];
    
    [conditionTable addLegendHeaderWithRefreshingBlock:^{
        [self requestConditionsDataByPage:1 keyword :  searchCondition.text];
    }];
    
       [conditionTable registerNib:[UINib nibWithNibName:@"ConditionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    currentPage = 0;
    
    self.title = @"SELECT ALLERGIES";
    
    searchCondition.delegate = self;
    
    searchCondition.placeholder = @"";
    
   /* if (IS_IPHONE) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        
        searchCondition.frame = CGRectMake(0, 0, searchCondition.frame.size.width, searchCondition.frame.size.height);
        conditionTable.frame =CGRectMake(0, searchCondition.frame.size.height, windowWidth,self.view.frame.size.height);
    }*/
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:)
                   name:UIKeyboardWillChangeFrameNotification object:nil];
    
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
      [bottomTab setSelectedItem:[bottomTab.items objectAtIndex:2]];
    [super viewWillAppear:animated];
    if ([self.conditionsArray count] == 0)
    {
        [self requestConditionsDataByPage:1 keyword:searchCondition.text];
        [self loadAddedAllergies];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}


- (void)cancelPrescription {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)keyboardDidShow:(NSNotification *)notification
{
    // keyboard frame is in window coordinates
    NSDictionary *userInfo = [notification userInfo];
    keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // convert own frame to window coordinates, frame is in superview's coordinates
    CGRect ownFrame = [self.view.window convertRect:self.view.frame fromView:self.view.superview];
    
    // calculate the area of own frame that is covered by keyboard
    CGRect coveredFrame = CGRectIntersection(ownFrame, keyboardFrame);
    
    // now this might be rotated, so convert it back
    coveredFrame = [self.view.window convertRect:coveredFrame toView:self.view.superview];
    
    // set inset to make up for covered array at bottom
    //  self.contentInset = UIEdgeInsetsMake(0, 0, coveredFrame.size.height, 0);
    //self.scrollIndicatorInsets = self.contentInset;
    offSetKeyboard = keyboardFrame.size.height;
    int commentOffset = (windowHeight - 100) - offSetKeyboard;
    
    if (isOffSet == true) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             //  commentContainerView.frame = CGRectMake(0, (windowHeight - 42) - offSetKeyboard, commentContainerView.frame.size.width, commentContainerView.frame.size.height);
             if ([messageField isFirstResponder]) {
                 
                 
                 self.msgInPutView.frame = CGRectMake(0, commentOffset, self.msgInPutView.frame.size.width, self.msgInPutView.frame.size.height);
                 
             }
             
         }     completion:^(BOOL finished)
         {
         }];
        
    }
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
    TalkPharmcyViewController *vc = [[TalkPharmcyViewController alloc] initWithNibName:@"TalkPharmcyViewController" bundle:nil];
    vc.selectedConditions = selectedConditions;
    vc.selectedAllergens = _addedConditionsArray;
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
                                        _conditionsArray = [NSMutableArray array];
                                        _conditionsArray  = [results copy];
                                        [conditionTable reloadData];
                                        
                                        //[self.searchField resignFirstResponder];
                                    }else{
                                        /*self.successLabel.text = [self statusString:NO];
                                         self.medications = @[];
                                         [self.tableView reloadData];*/
                                    }
                                    
                                }];
}



- (void)loadAddedAllergies {
    [[AppController sharedInstance] getAllAllergenByPMMaster:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        [SVProgressHUD dismiss];
        if (success)
        {
            
            [_addedConditionsArray removeAllObjects];
            
            [_addedConditionsArray addObjectsFromArray:conditions];
            [conditionTable reloadData];
        }
        
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    if (_addedConditionsArray.count > 0) {
        return 2;
    } else {
        return 2;
    }
}


#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //  if (_addedConditionsArray.count > 0) {
    if (section == 0) {
        
        return [_addedConditionsArray count];
        
    } else   if (section == 1)  {
        return [_conditionsArray count];
    } else {
        return 0;
    }
    /*} else {
     return [_conditionsArray count];
     }*/
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_addedConditionsArray.count > 0) {
        
        if (section == 0) {
            
            return @"Added Allergens";
            
        } else if (section == 1)  {
            return @"All Allergens";
        } else {
            return @"";
        }
    } else {
        if (section == 0) {
            
            return @"";
            
        } else if (section == 1)  {
            return @"All Allergens";
        } else {
            return @"";
        }
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_addedConditionsArray.count > 0) {
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
    ConditionsTableViewCell    *cell = (ConditionsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    // if (_addedConditionsArray.count > 0) {
    if (indexPath.section == 0) {
        Allergen *patientInfo = [_addedConditionsArray objectAtIndex:indexPath.row];
      //  cell.allergen = patientInfo;
       // cell.cellImageView.image = [UIImage imageNamed:@"human-brain-icon.png"];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.PicklistDesc];
        //cell.nameLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        // cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
        
        
    } else {
        Allergen *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
      //  cell.allergen = patientInfo;
      //  cell.cellImageView.image = [UIImage imageNamed:@"human-brain-icon.png"];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.PicklistDesc];
      //  cell.nameLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
    }
    /* } else {
     Allergen *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
     cell.allergen = patientInfo;
     }*/
    
    
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
    if (indexPath.section == 1) {
           Allergen *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
        [[AppController sharedInstance] addAllergenToPMaster:@"" name:patientInfo.PicklistDesc pickid:patientInfo.PicklistID type:patientInfo.PicklistConceptType h7id:patientInfo.HL7ObjectIdentifier htype:patientInfo.HL7ObjectIdentifierType WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            if (success) {
                
            }
        }];
        
        [_addedConditionsArray addObject:[_conditionsArray objectAtIndex:indexPath.row]];
    }
    
    /* } else {
     if (indexPath.section == 0) {
     [_addedConditionsArray addObject:[_conditionsArray objectAtIndex:indexPath.row]];
     }
     }*/
    
    [conditionTable reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        if (_addedConditionsArray.count > 0) {
            if (indexPath.section == 0) {
                   Allergen *patientInfo = [_addedConditionsArray objectAtIndex:indexPath.row];
                [_addedConditionsArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                [[AppController sharedInstance] deletePMasterAllergen:patientInfo.postid completion:^(BOOL success, NSString *message) {
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
    [self requestConditionsDataByPage:1 keyword : searchCondition.text];
    [searchBar resignFirstResponder];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  {
    [self requestConditionsDataByPage:1 keyword : searchText];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    isOffSet = true;
    
    return  true;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    isOffSet = true;
    
    
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         if (isOffSet == true) {
             
             
             isOffSet = false;
             
             self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-(40+bottomTab.frame.size.height),  self.view.frame.size.width, 40);
         }
         
         
     }
     
                     completion:^(BOOL finished)
     {
     }];
    
    
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    isOffSet = false;
    
    
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)sendMessageNow:(id)sender {
    if (messageField.text.length > 0) {
        
        [SVProgressHUD showWithStatus:@"Adding..."];
        [[AppController sharedInstance] addAllergenToPMaster:@"" name:messageField.text pickid:@"" type:@"" h7id:@"" htype:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            if (success) {
                
            }
        }];

        messageField.text = @"";
        
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
                TalkConditionsViewController *vc = [[TalkConditionsViewController alloc] initWithNibName:@"TalkConditionsViewController" bundle:nil];
                
                [self.navigationController pushViewController:vc animated:YES];
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
        
        

        
    } else if ([bottomTab.items objectAtIndex:2] == item) {
        
        
        
        
        
    } else if ([bottomTab.items objectAtIndex:3] == item) {
        
        
        
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            TalkPharmcyViewController *vc = [[TalkPharmcyViewController alloc] initWithNibName:@"TalkPharmcyViewController" bundle:nil];
            vc.selectedConditions = _addedConditionsArray;
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
                vc.selectedConditions = _addedConditionsArray;
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
                TalkDoctorViewController *vc = [[TalkDoctorViewController alloc] initWithNibName:@"TalkDoctorViewController" bundle:nil];
                vc.selectedConditions = _addedConditionsArray;
                vc.selectedAllergens = [[NSMutableArray alloc] init];
                vc.pharmacy = pharmacy2;
                vc.docSpecial = @"";
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Pharmacy" message:@"You have not selected your prefered pharmacy" preferredStyle:UIAlertControllerStyleAlert];
                
                
                
                
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
