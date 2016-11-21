//
//  PatientListNewViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/24/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import "PatientListNewViewController.h"
#import "PatientsTableViewCell.h"
#import "PatientDetailViewController.h"
#import "AddPatientViewController.h"
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"
#import "SWRevealViewController.h"

@interface PatientListNewViewController ()<PatientsDetailDelegate, AddPatientiPhoneDelegate, EditPatientNewDelegate>
{
    int currentPage;
}

@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation PatientListNewViewController


@synthesize shouldPatientSelect;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (self.shouldPatientSelect == false) {
        
        
        
       
    }
    
    isRefresshing = false;
    isMaxLimit = false;
    
    /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
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
    
    self.title = @"DASHBOARD";
    
    
    //_patientsTableView.delegate = self;
    //_patientsTableView.dataSource = self;
    _patientsArray = [NSMutableArray array];
    
    patientsGrid.delegate = self;
    patientsGrid.dataSource = self;
    
    _searchBar.delegate = self;
    
    currentPage = 0;
    
    
    /*[menuTable addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];
    
    [menuTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];*/
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    
    [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatientTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"PATIENTS";
    
    SWRevealViewController *revealController = [self revealViewController];
    
    
    //[revealController panGestureRecognizer];
    //[revealController tapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    isMaxLimit = false;
    [super viewWillAppear:animated];
    if ([self.patientsArray count] == 0)
    {
        [self requestPatientsDataByPage:1 keyword : @""];
    }
    
    
        if (self.shouldPatientSelect == true) {
            
            
            UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton2];
            
            UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
            
            
            self.navigationItem.leftBarButtonItem = menuButtonItem;
            self.navigationItem.rightBarButtonItem = nil;
           
          
        }
        
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}

- (IBAction)goBackToChose:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
    [self.revealViewController revealToggle:sender];
}

- (IBAction)goBackToChose2:(id)sender {
    // [self.navigationController popViewControllerAnimated:YES];
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelPatientSelect {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToAddPatient:(id)sender {
    [self addPatient];
}

- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    isRefresshing = true;
    [[AppController sharedInstance] getAllPatiensByPage:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [_patientsArray removeAllObjects];
            }
            [_patientsArray addObjectsFromArray:patients];
            //[patientsGrid reloadData];
            if (patients.count == 0) {
                isMaxLimit = true;
            }
            [menuTable reloadData];
            [self performSelector:@selector(hideTableViewCells) withObject:nil afterDelay:0.02];
        }
        
        isRefresshing = false;
        
        // [patientsGrid.footer endRefreshing];
        //[patientsGrid.header endRefreshing];
        [menuTable.footer endRefreshing];
        [menuTable.header endRefreshing];
    }];
}

- (void)addPatient
{
    /*if (!IS_IPHONE) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        AddPatientViewController *vc = (AddPatientViewController *)[sb instantiateViewControllerWithIdentifier:@"AddPatientViewController"];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
        
        [popVC presentPopoverFromBarButtonItem:addButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
    } else {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        AddPatientiPhoneViewController *vc = (AddPatientiPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"AddPatientiPhoneViewController"];
        vc.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:nil];
        
        
    }*/
    
    AddPatientiPhoneViewController *vc = [[AddPatientiPhoneViewController alloc] init];
    vc.delegate = self;

    [self.navigationController pushViewController:vc animated:YES];

}



- (void)hideTableViewCells {
    for (int i = 0; i <= _patientsArray.count; i++)
    {
        NSLog(@"%d", i);
        NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
         DashboardPatientTableViewCell *cell = (DashboardPatientTableViewCell *)[menuTable cellForRowAtIndexPath:cellIndexPath];
             [cell hideUtilityButtonsAnimated:NO];

    }
}

- (Patient *)dummyPatientDataForRegister
{
    Patient *dummyPatient = [Patient new];
    dummyPatient.email = @"kalanajayathilaka@yahoo.com";
    dummyPatient.firstName = @"Kalana";
    dummyPatient.lastName =  @"Jayatilake";
    dummyPatient.dob = @"1324234234";
    dummyPatient.occupation = @"Developer";
    dummyPatient.gender = @"M";
    dummyPatient.telephone = @"234234234";
    
    dummyPatient.street1 = @"6612 Clyboung";
    dummyPatient.street2 = @"Unit 95";
    
    dummyPatient.city = @"Hollywood";
    dummyPatient.state = @"CA";
    dummyPatient.country = @"United States";
    dummyPatient.zipcode = @"91606";
    
    dummyPatient.occupation = @"Specialist";
    
    return  dummyPatient;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

/*
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return [_patientsArray count];
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 PatientsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
 
 if (cell == nil)
 {
 cell = [[PatientsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
 reuseIdentifier:kPatientsCellID] ;
 
 }
 
 Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
 cell.patient = patientInfo;
 
 return cell;
 
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return kPatientsTableViewCellHeight;
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 if (self.shouldPatientSelect == false) {
 Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
 UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
 PatientDetailViewController *vc = (PatientDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDetailViewController"];
 vc.patient = patientInfo;
 vc.delegate = self;
 [self.navigationController pushViewController:vc animated:YES];
 
 } else {
 Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
 [self.delegate patientAppointmentAdded:[NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName] patientid:patientInfo.postid];
 [self.navigationController dismissViewControllerAnimated:YES completion:nil];
 }
 }
 
 */




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _patientsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        MSGPatientGridCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        
        [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profilepic]];
        
        cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
        cell.profileIMG.layer.masksToBounds = YES;
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName];
        cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        cell.messageCountLabel.text = patientInfo.msgCount;
        cell.smallCircleIMG.hidden = true;
        cell.messageCountLabel.hidden = true;
        
        
        
        return cell;
    } else {
        
        MSGPatientGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        
        [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profilepic]];
        
        cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
        cell.profileIMG.layer.masksToBounds = YES;
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName];
        cell.messageCountLabel.text = patientInfo.msgCount;
        cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        
        cell.smallCircleIMG.hidden = true;
        cell.messageCountLabel.hidden = true;
        
        
        
        return cell;
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.shouldPatientSelect == false) {
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientDetailViewController *vc = (PatientDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDetailViewController"];
        vc.patient = patientInfo;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        [self.delegate patientAppointmentAdded:[NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName] patientid:patientInfo.postid];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // CGSize retval = CGSizeMake(200, 200);
    CGSize retval;
    if (IS_IPHONE) {
        retval = CGSizeMake(140, 140);
    } else {
        retval = CGSizeMake(200, 200);
    }
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (IS_IPHONE) {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    } else {
        return UIEdgeInsetsMake(50, 20, 50, 20);
        
    }
}






#pragma mark - TableView





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_patientsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardPatientTableViewCell *cell = (DashboardPatientTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    cell.cellImageView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.cellImageView.layer.borderWidth = 1.0f;
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[patientInfo.dob integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, yyyy"];
    
    
    //  cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",patientInfo.firstName, patientInfo.lastName];
    cell.specialityLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", patientInfo.street1, patientInfo.street2, patientInfo.city, patientInfo.state, patientInfo.zipcode, patientInfo.country];
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profilepic]];
    cell.costLabel.text = [NSString stringWithFormat:@"DOB %@", [formatter stringFromDate:dob]];
    // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    cell.delegate = self;
    
    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
    
      [cell hideUtilityButtonsAnimated:NO];
    
    if (indexPath.row == ([_patientsArray count] - 1)) {
        if (isMaxLimit == false && isRefresshing == false) {
           [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
        }
     
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.shouldPatientSelect == false) {
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
       // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientDetailViewController *vc = [[PatientDetailViewController alloc] initWithNibName:@"PatientDetailViewController" bundle:nil];
        vc.patient = patientInfo;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        [self.delegate patientAppointmentAdded:[NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName] patientid:patientInfo.postid];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}




- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    /*[rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];*/
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:239.0f/255.0f green:92.0f/255.0f blue:95.0f/255.0f alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:83.0f/255.0f green:184.0f/255.0f blue:195.0f/255.0f alpha:1.0]
                                                icon:[UIImage imageNamed:@"editIconGray"]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:83.0f/255.0f green:184.0f/255.0f blue:195.0f/255.0f alpha:1.0]
                                                icon:[UIImage imageNamed:@"rxIconGray"]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:83.0f/255.0f green:184.0f/255.0f blue:195.0f/255.0f alpha:1.0]
                                                icon:[UIImage imageNamed:@"calendarIconGray"]];
    
    
    return leftUtilityButtons;
}





#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0: {
            NSLog(@"left button 0 was pressed");
            NSIndexPath *cellIndexPath = [menuTable indexPathForCell:cell];
            Patient *patientInfo = [_patientsArray objectAtIndex:cellIndexPath.row];
            // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            EditPatientViewController *vc = [[EditPatientViewController alloc] initWithNibName:@"EditPatientViewController" bundle:nil];
            vc.patient = patientInfo;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        } break;
        case 1: {
            NSLog(@"left button 1 was pressed");
            NSIndexPath *cellIndexPath = [menuTable indexPathForCell:cell];
            Patient *patientInfo = [_patientsArray objectAtIndex:cellIndexPath.row];
            MedicationPListViewController  *vc = [[MedicationPListViewController alloc] init];
            vc.patient = patientInfo;
            [self.navigationController pushViewController:vc animated:YES];
            
        }break;
        case 2: {
            NSLog(@"left button 2 was pressed");
            NSIndexPath *cellIndexPath = [menuTable indexPathForCell:cell];
            Patient *patientInfo = [_patientsArray objectAtIndex:cellIndexPath.row];
            PatientAppointmentViewController  *vc = [[PatientAppointmentViewController alloc] init];
            vc.patient = patientInfo;
            [self.navigationController pushViewController:vc animated:YES];
        } break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    /*switch (index) {
        case 0:
        {
            NSLog(@"More button was pressed");
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"More more more" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [menuTable indexPathForCell:cell];
            
          //  [_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
            [menuTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }*/
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}






- (void)refreshPatientList {
    [self requestPatientsDataByPage:1 keyword : _searchBar.text];
}

#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestPatientsDataByPage:1 keyword : _searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self requestPatientsDataByPage:1 keyword : searchText];
}

- (void)refreshAddPatient {
    [self requestPatientsDataByPage:1 keyword : @""];
}

- (void)patientEditDone:(Patient *)patientinfo {
    [self requestPatientsDataByPage:1 keyword : @""];
}

@end
