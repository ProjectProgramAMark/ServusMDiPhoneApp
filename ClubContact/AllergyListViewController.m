//
//  AllergyListViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AllergyListViewController.h"

@interface AllergyListViewController () <DrugsListDelegate>

@end

@implementation AllergyListViewController

@synthesize allergenClient;
@synthesize selectedConditions;
@synthesize patient;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    _conditionsArray = [NSMutableArray array];
    _addedConditionsArray = [NSMutableArray array];
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                     target:self
                                     action:@selector(cancelPrescription)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
    /*UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(goToDrugs)];
    self.navigationItem.rightBarButtonItem = nextButton;*/
    
   /*UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"nextarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goToDrugs)];*/
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
    
     [conditionTable registerNib:[UINib nibWithNibName:@"NewGreenTableViewCell" bundle:nil] forCellReuseIdentifier:kPatientsCellID];
    currentPage = 0;
    
    self.title = @"SELECT ALLERGIES";
    
    searchCondition.delegate = self;
    
    searchCondition.placeholder = @"Search";
    
   // if (IS_IPHONE) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        
    //    searchCondition.frame = CGRectMake(0, 0, searchCondition.frame.size.width, searchCondition.frame.size.height);
     //   conditionTable.frame =CGRectMake(0, searchCondition.frame.size.height, windowWidth,self.view.frame.size.height);
    //}
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
    if ([self.conditionsArray count] == 0)
    {
        [self requestConditionsDataByPage:1 keyword:searchCondition.text];
    }
}


- (void)cancelPrescription {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToDrugs:(id)sender {
    DrugsViewController *vc = [[DrugsViewController alloc] initWithNibName:@"DrugsViewController" bundle:nil];
    vc.selectedConditions = selectedConditions;
    vc.selectedAllergens = _addedConditionsArray;
    vc.patient = patient;
    vc.delegate = self;
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
       NewGreenTableViewCell  *cell = (NewGreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
   // if (_addedConditionsArray.count > 0) {
        if (indexPath.section == 0) {
            Allergen *patientInfo = [_addedConditionsArray objectAtIndex:indexPath.row];
            //cell.cellImageView.image = [UIImage imageNamed:@"human-brain-icon.png"];
            
            cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.PicklistDesc];
            //cell.nameLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.nameLabel.numberOfLines = 0;
            cell.imgView.image = [UIImage imageNamed:@"fruits11"];
        } else {
            Allergen *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
            //cell.cellImageView.image = [UIImage imageNamed:@"human-brain-icon.png"];
            
            cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.PicklistDesc];
            //cell.nameLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.nameLabel.numberOfLines = 0;
            cell.imgView.image = [UIImage imageNamed:@"fruits11"];
        }
   /* } else {
        Allergen *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
        cell.allergen = patientInfo;
    }*/
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 1) {
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
                [_addedConditionsArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

- (void)refreshMedicationAdd {
    [self.delegate refreshMedicationAdd];
}

@end
