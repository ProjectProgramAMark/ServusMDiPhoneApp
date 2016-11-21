//
//  DrugsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DrugsViewController.h"

@interface DrugsViewController () <DrugDetailListDelegate>

@end

@implementation DrugsViewController

@synthesize drugClient;
@synthesize selectedConditions;
@synthesize selectedAllergens;
@synthesize patient;
@synthesize delegate;
@synthesize isMedPres;
@synthesize drugIndicationsClient;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    drugsTable.delegate = self;
    drugsTable.dataSource = self;
    _conditionsArray = [NSMutableArray array];
    _addedConditionsArray = [NSMutableArray array];
    
  //  isMedPres = false;
    
   
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    //UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    //self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    self.drugClient = [[DrugSearchAPIClient alloc] init];
    self.drugIndicationsClient = [[DrugIndicationsSearchAPIClient alloc] init];
    
    searchDrugs.delegate = self;
    
    [drugsTable addLegendFooterWithRefreshingBlock:^{
        [self requestConditionsDataByPage:currentPage + 1 keyword :  searchDrugs.text];
    }];
    
    [drugsTable addLegendHeaderWithRefreshingBlock:^{
        [self requestConditionsDataByPage:1 keyword :  searchDrugs.text];
    }];
    
    /*[drugsTable registerClass:[DrugListCell class]
           forCellReuseIdentifier:kPatientsCellID];*/
     [drugsTable registerNib:[UINib nibWithNibName:@"NewGreenTableViewCell" bundle:nil] forCellReuseIdentifier:kPatientsCellID];
    currentPage = 0;
    
    self.title = @"SELECT MEDICATION";
    
    searchDrugs.delegate = self;
    
    searchDrugs.placeholder = @"Search";
    
  //  if (IS_IPHONE) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        
    //    searchDrugs.frame = CGRectMake(0, 0, searchDrugs.frame.size.width, searchDrugs.frame.size.height);
    //    drugsTable.frame =CGRectMake(0, searchDrugs.frame.size.height, windowWidth,self.view.frame.size.height);
   // }
    
    
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
    if ([selectedConditions count] == 0)
    {
        [self requestConditionsDataByPage:1 keyword:searchDrugs.text];
    } else {
        [self requestDrugsByConditions];
    }
    
   
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.isMedPres == true) {
       /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                         target:self
                                         action:@selector(cancelPrescription)];
        self.navigationItem.leftBarButtonItem = cancelButton;*/
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view endEditing:true];
}

- (void)goToDrugs {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DrugDetailViewController *vc = (DrugDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"DrugDetailViewController"];
    vc.selectedConditions = selectedConditions;
    vc.selectedAllergens = selectedAllergens;
    //vc.drug = _dru
    
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)cancelPrescription {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)requestDrugsByConditions 
{
    _conditionsArray = [NSMutableArray array];
    for (Condition *dictionary in selectedConditions) {
        [self.drugIndicationsClient searchForDrug:dictionary.conditionCode completion:^(NSArray *results, NSError *error) {
            [_conditionsArray addObjectsFromArray:results];
            [drugsTable reloadData];
        }];
    }
    
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
    
    [self.drugClient searchForDrug:keyword
                                completion:^(NSArray *results, NSError *error) {
                                    //   self.searchButton.enabled = YES;
                                    
                                    //NSTimeInterval duration = [NSDate date].timeIntervalSinceReferenceDate - start;
                                    if(!error){
                                        //self.durationLabel.text = [NSString stringWithFormat:@"%f secs", duration];
                                        //self.successLabel.text = [self statusString:YES];
                                        _conditionsArray = [NSMutableArray array];
                                        _conditionsArray  = [results copy];
                                        [drugsTable reloadData];
                                        
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
        return 1;
    }
}


#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_addedConditionsArray.count > 0) {
        if (section == 0) {
            
            return [_addedConditionsArray count];
            
        } else   if (section == 1)  {
            return [_conditionsArray count];
        } else {
            return 0;
        }
    } else {
        return [_conditionsArray count];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_addedConditionsArray.count > 0) {
        
        if (section == 0) {
            
            return @"Added Medication";
            
        } else if (section == 1)  {
            return @"All Medication";
        } else {
            return @"";
        }
    } else {
        return @"All Medication";
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
        return NO;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewGreenTableViewCell    *cell = (NewGreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
    
  //  cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
    
    //cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    
    // cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
    cell.clipsToBounds = YES;
    
    if (_addedConditionsArray.count > 0) {
        if (indexPath.section == 0) {
            Drug *patientInfo = [_addedConditionsArray objectAtIndex:indexPath.row];
            //cell.drug = patientInfo;
           
            cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.dispensableDrugDesc];
            
        } else {
            Drug *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
            //cell.drug = patientInfo;
            cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.dispensableDrugDesc];
        }
    } else {
        Drug *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
        //cell.drug = patientInfo;
        cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.dispensableDrugDesc];
    }
    
     cell.imgView.image = [UIImage imageNamed:@"fruits11"];
    
    cell.nameLabel.numberOfLines = 0;
    cell.imgView.image = [UIImage imageNamed:@"refillIcon"];
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
     UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
     PatientDetailViewController *vc = (PatientDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDetailViewController"];
     vc.patient = patientInfo;
     
     [self.navigationController pushViewController:vc animated:YES];*/
    if (_addedConditionsArray.count > 0) {
        if (indexPath.section == 1) {
            //[_addedConditionsArray addObject:[_conditionsArray objectAtIndex:indexPath.row]];
        }
        
    } else {
        if (indexPath.section == 0) {
            //[_addedConditionsArray addObject:[_conditionsArray objectAtIndex:indexPath.row]];
             Drug *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
            
            [Flurry logEvent:@"DrugClick" withParameters:[NSDictionary dictionaryWithObject:patientInfo.dispensableDrugDesc forKey:@"searchKey"]];
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            DrugDetailViewController *vc = [[DrugDetailViewController alloc] initWithNibName:@"DrugDetailViewController" bundle:nil];
            vc.selectedConditions = selectedConditions;
            vc.selectedAllergens = selectedAllergens;
            vc.drug = patientInfo;
            vc.patient = patient;
            vc.delegate = self;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    
    [drugsTable reloadData];
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
    [self requestConditionsDataByPage:1 keyword : searchDrugs.text];
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
