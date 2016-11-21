//
//  AddConditionToPMasterViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AddConditionToPMasterViewController.h"

@interface AddConditionToPMasterViewController ()

@end

@implementation AddConditionToPMasterViewController


@synthesize messageField;
@synthesize msgInPutView;
@synthesize sendChatBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _conditionsArray = [NSMutableArray array];
    _addedConditionsArray = [NSMutableArray array];
    searchCondition.delegate = self;
    isOffSet = false;
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
   // self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    searchCondition.delegate = self;
    
    [conditionTable addLegendFooterWithRefreshingBlock:^{
        [self requestConditionsDataByPage:currentPage + 1 keyword :  searchCondition.text];
    }];
    
    [conditionTable addLegendHeaderWithRefreshingBlock:^{
        [self requestConditionsDataByPage:1 keyword :  searchCondition.text];
    }];
    
    [conditionTable registerNib:[UINib nibWithNibName:@"ConditionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    currentPage = 0;
    
    self.title = @"SELECT CONDITIONS";
    
    searchCondition.placeholder = @"";
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:)
                   name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}


- (IBAction)goBackToChose:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
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
    int commentOffset = (windowHeight - 105) - offSetKeyboard;
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goToAllergy {
    TalkAllergyViewController *vc = [[TalkAllergyViewController alloc] initWithNibName:@"TalkAllergyViewController" bundle:nil];
    vc.selectedConditions = _addedConditionsArray;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.conditionsArray count] == 0)
    {
        [self requestConditionsDataByPage:1 keyword:searchCondition.text];
           [SVProgressHUD showWithStatus:@"Loading..."];
        [self loadAddedConditions];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view endEditing:true];
}


- (void)requestConditionsDataByPage:(int)page keyword:(NSString *)keyword
{
   //   [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllConditionByPage2:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
        [SVProgressHUD dismiss];
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
    }];
}


- (void)loadAddedConditions {
   //    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllConditionByPMaster:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
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
    /* } else {
     return [_conditionsArray count];
     }*/
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_addedConditionsArray.count > 0) {
        
        if (section == 0) {
            
            return @"Added Conditions";
            
        } else if (section == 1)  {
            return @"All Conditions";
        } else {
            return @"";
        }
    } else {
        if (section == 0) {
            
            return @"";
            
        } else if (section == 1)  {
            return @"All Conditions";
        } else {
            return @"";
        }
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // if (_addedConditionsArray.count > 0) {
    if (indexPath.section == 0) {
        return YES;
    } else {
        return NO;
    }
    /* } else {
     return NO;
     }*/
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* ConditionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
     
     if (cell == nil)
     {
     cell = [[ConditionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
     reuseIdentifier:kPatientsCellID] ;
     
     }*/
    
    
    ConditionsTableViewCell    *cell = (ConditionsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    // cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
    
    
    //if (_addedConditionsArray.count > 0) {
    if (indexPath.section == 0) {
        Condition *patientInfo = [_addedConditionsArray objectAtIndex:indexPath.row];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.conditionName];
       
    } else {
        Condition *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.conditionName];
        
    }
    
    
      cell.backgroundColor = [UIColor clearColor];
    cell.clipsToBounds = YES;
    /*} else {
     Condition *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
     cell.condition = patientInfo;
     }*/
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    //  if (_addedConditionsArray.count > 0) {
    if (indexPath.section == 1) {
        Condition *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
        [_addedConditionsArray addObject:[_conditionsArray objectAtIndex:indexPath.row]];
        [[AppController sharedInstance] addConditionToPMaster:@"" conditionname:patientInfo.conditionName conditioncode:patientInfo.conditionCode WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            if (success) {
                
            }
        }];
    }
    
    /*} else {
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
                Condition *patientInfo = [_addedConditionsArray objectAtIndex:indexPath.row];
                [[AppController sharedInstance] deletePMasterCondition:patientInfo.nodeID completion:^(BOOL success, NSString *message) {
                    if (success) {
                        
                    }
                }];
                
                
                [_addedConditionsArray removeObjectAtIndex:indexPath.row];
                @try {
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    // [conditionTable reloadData];
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                // [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                //  [conditionTable reloadData];
                
                
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


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:true];
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
             
             self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-50,  self.view.frame.size.width, 50);
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
        [[AppController sharedInstance] addConditionToPMaster:@"" conditionname:messageField.text conditioncode:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            [SVProgressHUD dismiss];
            if (success) {
                
                [self loadAddedConditions];
            }
        }];
        messageField.text = @"";
        
    }
}


@end
