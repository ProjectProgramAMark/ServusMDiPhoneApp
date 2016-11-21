//
//  SpecialitySelectorViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/30/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "SpecialitySelectorViewController.h"

@interface SpecialitySelectorViewController ()

@end

@implementation SpecialitySelectorViewController

@synthesize conditionsArray;
@synthesize arraySearchResults;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    isSearchInProgress = false;
    arraySearchResults = [NSMutableArray array];
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    
    conditionsArray = [NSMutableArray arrayWithObjects:@"Addiction psychiatrist",@"Adolescent medicine specialist",@"Allergist (immunologist)",@"Anesthesiologist",@"Cardiac electrophysiologist",@"Cardiologist",@"Cardiovascular surgeon",@"Colon and rectal surgeon",@"Critical care medicine specialist",@"Dentist", @"Dermatologist",@"Developmental pediatrician",@"Emergency medicine specialist",@"Endocrinologist",@"Family medicine physician",@"Forensic pathologist",@"Gastroenterologist",@"Geriatric medicine specialist",@"Gynecologist",@"Gynecologic oncologist",@"Hand surgeon",@"Hematologist",@"Hepatologist",@"Hospitalist",@"Hospice and palliative medicine specialist",@"Hyperbaric physician",@"Infectious disease specialist",@"Internist",@"Interventional cardiologist",@"Medical examiner",@"Medical geneticist",@"Neonatologist",@"Nephrologist",@"Neurological surgeon",@"Neurologist",@"Nuclear medicine specialist",@"Nurse Practitioner",  @"Obstetrician",@"Occupational medicine specialist",@"Oncologist",@"Ophthalmologist",@"Optometrist", @"Oral surgeon (maxillofacial surgeon)", @"Orthodontist", @"Orthopedic surgeon",@"Otolaryngologist (ear, nose, and throat specialist)",@"Pain management specialist",@"Pathologist",@"Pediatrician",@"Perinatologist",@"Physiatrist",@"Physical Assistant Speciality", @"Plastic surgeon",@"Psychiatrist",@"Pulmonologist",@"Radiation oncologist",@"Radiologist",@"Reproductive endocrinologist",@"Rheumatologist",@"Sleep disorders specialist",@"Spinal cord injury specialist",@"Sports medicine specialist",@"Surgeon",@"Thoracic surgeon",@"Urologist",@"Vascular surgeon", @"Veterinary Specialist", nil];
   
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    //self.navigationItem.rightBarButtonItem = notiButtonItem;
    
   
    
    searchCondition.delegate = self;
    
    
    
    [conditionTable registerNib:[UINib nibWithNibName:@"ConditionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    currentPage = 0;
    
    self.title = @"SELECT SPECIALIZATION";
    
    searchCondition.delegate = self;
    
    searchCondition.placeholder = @"";
    
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
        //  [self requestConditionsDataByPage:1 keyword:searchCondition.text];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view endEditing:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}


#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
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
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    NSString *conditionText = @"";
    
    if (isSearchInProgress) {
        conditionText = [arraySearchResults objectAtIndex:indexPath.row];
    } else {
        conditionText = [conditionsArray objectAtIndex:indexPath.row];
    }
    [self.delegate specialitySelectDone:conditionText];
    [self.navigationController popViewControllerAnimated:true];
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
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


@end
