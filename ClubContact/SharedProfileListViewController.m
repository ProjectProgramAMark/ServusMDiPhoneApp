//
//  SharedProfileListViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/31/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SharedProfileListViewController.h"
#import "PatientsTableViewCell.h"
#import "PatientDetailViewController.h"
#import "AddPatientViewController.h"
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"

#define kPatientsCellID @"cell"

@interface SharedProfileListViewController ()
{
    int currentPage;
}

@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SharedProfileListViewController


@synthesize shouldPatientSelect;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (self.shouldPatientSelect == false) {
        
        
        
        addButton = [[UIBarButtonItem alloc]
                     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                     target:self
                     action:@selector(addPatient)];
        //self.navigationItem.rightBarButtonItem = addButton;
    }
    
    //_patientsTableView.delegate = self;
    //_patientsTableView.dataSource = self;
    _patientsArray = [NSMutableArray array];
    
    patientsGrid.delegate = self;
    patientsGrid.dataSource = self;
    
    _searchBar.delegate = self;
    
    //  _searchBar.barTintColor = [UIColor flatGreenColor];
    
    /* [_patientsTableView addLegendFooterWithRefreshingBlock:^{
     [self requestPatientsDataByPage:currentPage + 1 keyword : _searchBar.text];
     }];
     
     [_patientsTableView addLegendHeaderWithRefreshingBlock:^{
     [self requestPatientsDataByPage:1 keyword : _searchBar.text];
     }];
     
     [_patientsTableView registerClass:[PatientsTableViewCell class]
     forCellReuseIdentifier:kPatientsCellID];*/
    currentPage = 0;
    
    [menuTable addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];
    
    [menuTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    
      [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatientTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"SHARED RECORDS";
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.patientsArray count] == 0)
    {
        [self requestPatientsDataByPage:1 keyword : @""];
    }
    
    if (IS_IPHONE) {
        if (self.shouldPatientSelect == true) {
            
            
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                           target:self
                                           action:@selector(cancelPatientSelect)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
        
    }
}

- (void)cancelPatientSelect {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    [[AppController sharedInstance] getAllSharedPatiensByPage:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [_patientsArray removeAllObjects];
            }
            [_patientsArray addObjectsFromArray:patients];
            [menuTable reloadData];
        }
        
        [menuTable.footer endRefreshing];
        [menuTable.header endRefreshing];
    }];
}

- (void)addPatient
{
    if (!IS_IPHONE) {
        
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
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        
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
        SharedPatientProfileViewController *vc = (SharedPatientProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"SharedPatientProfileViewController"];
        vc.patient = patientInfo;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
       // [self.delegate patientAppointmentAdded:[NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName] patientid:patientInfo.postid];
        //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
    [formatter setDateFormat:@"dd MMMM yyyy"];
    
    
    NSString *street1 = @"";
    
    //  cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",patientInfo.firstName, patientInfo.lastName];
   cell.specialityLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", patientInfo.street1, patientInfo.street2, patientInfo.city, patientInfo.state, patientInfo.zipcode, patientInfo.country];  [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profilepic]];
    cell.costLabel.text = [NSString stringWithFormat:@"Born %@", [formatter stringFromDate:dob]];
    // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.shouldPatientSelect == false) {
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        SharedPatientProfileViewController *vc = (SharedPatientProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"SharedPatientProfileViewController"];
        vc.patient = patientInfo;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        // [self.delegate patientAppointmentAdded:[NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName] patientid:patientInfo.postid];
        //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
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


@end
