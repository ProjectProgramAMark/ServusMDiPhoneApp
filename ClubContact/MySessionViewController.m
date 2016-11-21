//
//  MySessionViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/13/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MySessionViewController.h"
//#import "PatientsTableViewCell.h"
#import "PatientDetailViewController.h"
#import "AddPatientViewController.h"
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"

#define kPatientsCellID2 @"cell2"


@interface MySessionViewController () <DocMSGSessionDelegate, DocChatViewDelegate, DocMSGSessioniPhoneDelegate>
{
    int currentPage;
}

@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (strong, nonatomic) NSMutableArray *myArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MySessionViewController

@synthesize shouldPatientSelect;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (self.shouldPatientSelect == false) {
        
        
        
        addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goToInvite)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
    
    patientsGrid.delegate = self;
    patientsGrid.dataSource = self;
    _patientsArray = [NSMutableArray array];
    _myArray = [NSMutableArray array];
    
    _searchBar.delegate = self;
    
    self.title = @"CHAT REQUESTS";
    
    /* [patientsGrid addLegendFooterWithRefreshingBlock:^{
     [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
     }];*/
    
    [menuTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    
      [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatientTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    currentPage = 0;
    
    isMySessions = false;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
  /*  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.patientsArray count] == 0)
    {
        [self requestPatientsDataByPage:1 keyword : @""];
    }
}

- (void)goToInvite {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DoctorListViewController *vc = (DoctorListViewController *)[sb instantiateViewControllerWithIdentifier:@"DoctorListViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    /* [[AppController sharedInstance] getAllPatiensByPage2:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
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
     
     [self.patientsTableView.footer endRefreshing];
     [self.patientsTableView.header endRefreshing];
     }];*/
    
    
    [[AppController sharedInstance] getMyDocMSGSessions:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        currentPage = page;
        if (success)
        {
            [_myArray removeAllObjects];
            [_myArray addObjectsFromArray:conditions];
            [menuTable reloadData];
        }
        
        [menuTable.footer endRefreshing];
        [menuTable.header endRefreshing];
    }];
    
    [[AppController sharedInstance] getDocMSGSessions:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        
        currentPage = page;
        if (success)
        {
            [_patientsArray removeAllObjects];
            [_patientsArray addObjectsFromArray:conditions];
            [menuTable reloadData];
        }
        
        [menuTable.footer endRefreshing];
        [menuTable.header endRefreshing];
    }];
}

- (void)addPatient
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    AddPatientViewController *vc = (AddPatientViewController *)[sb instantiateViewControllerWithIdentifier:@"AddPatientViewController"];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    [popVC presentPopoverFromBarButtonItem:addButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
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
/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return [_patientsArray count];
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 MessagingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPatientsCellID2];
 
 if (cell == nil)
 {
 cell = [[MessagingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
 reuseIdentifier:kPatientsCellID2] ;
 
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
 MessagingViewController *vc = (MessagingViewController *)[sb instantiateViewControllerWithIdentifier:@"MessagingViewController"];
 vc.patientID = patientInfo.postid;
 //  vc.delegate = self;
 [self.navigationController pushViewController:vc animated:YES];
 
 } else {
 // Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
 //  [self.delegate patientAppointmentAdded:[NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName] patientid:patientInfo.postid];
 //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
 }
 }*/

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)changeMySession:(id)sender {
    if (msgSelect.selectedSegmentIndex == 0) {
        isMySessions = false;
        [menuTable reloadData];
        
    } else if (msgSelect.selectedSegmentIndex == 1)  {
        isMySessions = true;
        [menuTable reloadData];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (isMySessions == true) {
        return _myArray.count;
    } else {
    
    return _patientsArray.count;
        
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        MSGPatientGridCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        
        MSGSession *patientInfo;
        
        if (isMySessions == true) {
            patientInfo = [_myArray objectAtIndex:indexPath.row];
            [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.dprofileimg]];
            
            cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
            cell.profileIMG.layer.masksToBounds = YES;
            // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
            // cell.profileIMG.layer.borderWidth = 3.0;
            
            
            
            cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.dfirstname, patientInfo.dlastname];
            cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        } else {
            patientInfo = [_patientsArray objectAtIndex:indexPath.row];
            [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimg]];
            
            cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
            cell.profileIMG.layer.masksToBounds = YES;
            // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
            // cell.profileIMG.layer.borderWidth = 3.0;
            
            
            
            cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.pfirstname, patientInfo.pfirstname];
            cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
            
        }
        
        
        //cell.messageCountLabel.text = patientInfo.msgCount;
        
        if ([patientInfo.mstatus isEqual:@"0"]) {
            cell.messageCountLabel.text = @"P";
            cell.messageCountLabel.textColor = [UIColor flatGrayColor];
        } else if ([patientInfo.mstatus isEqual:@"1"]) {
            cell.messageCountLabel.text = @"A";
            cell.messageCountLabel.textColor = [UIColor flatGreenColor];
        } else if ([patientInfo.mstatus isEqual:@"2"]) {
            cell.messageCountLabel.text = @"D";
            cell.messageCountLabel.textColor = [UIColor flatRedColor];
        } else if ([patientInfo.mstatus isEqual:@"3"]) {
            cell.messageCountLabel.text = @"C";
            cell.messageCountLabel.textColor = [UIColor flatRedColor];
        }
        
        
        
        return cell;

    } else {
    MSGPatientGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
    
    
    
    MSGSession *patientInfo;
    
    if (isMySessions == true) {
       patientInfo = [_myArray objectAtIndex:indexPath.row];
        [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.dprofileimg]];
        
        cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
        cell.profileIMG.layer.masksToBounds = YES;
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        
        
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.dfirstname, patientInfo.dlastname];
        cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
    } else {
      patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimg]];
        
        cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
        cell.profileIMG.layer.masksToBounds = YES;
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        
        
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.pfirstname, patientInfo.pfirstname];
        cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];

    }
    
   
    //cell.messageCountLabel.text = patientInfo.msgCount;
    
    if ([patientInfo.mstatus isEqual:@"0"]) {
        cell.messageCountLabel.text = @"P";
        cell.messageCountLabel.textColor = [UIColor flatGrayColor];
    } else if ([patientInfo.mstatus isEqual:@"1"]) {
        cell.messageCountLabel.text = @"A";
        cell.messageCountLabel.textColor = [UIColor flatGreenColor];
    } else if ([patientInfo.mstatus isEqual:@"2"]) {
        cell.messageCountLabel.text = @"D";
        cell.messageCountLabel.textColor = [UIColor flatRedColor];
    } else if ([patientInfo.mstatus isEqual:@"3"]) {
        cell.messageCountLabel.text = @"C";
        cell.messageCountLabel.textColor = [UIColor flatRedColor];
    }
    
    
    
    return cell;
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        MSGSession *patientInfo;
        
        if (isMySessions == true) {
            patientInfo = [_myArray objectAtIndex:indexPath.row];
            
        } else {
            patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        }
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DocMSGSessioniPhone *vc = (DocMSGSessioniPhone *)[sb instantiateViewControllerWithIdentifier:@"DocMSGSessioniPhone"];
        vc.msgSession = patientInfo;
        vc.delegate = self;
        vc.isMySession = isMySessions;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        [self presentViewController:nav animated:YES completion:nil];
        
        

    } else {
    
    MSGSession *patientInfo;
    
    if (isMySessions == true) {
        patientInfo = [_myArray objectAtIndex:indexPath.row];
        
    } else {
        patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    }
    /*UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DocMSGSessionViewController *vc = (DocMSGSessionViewController *)[sb instantiateViewControllerWithIdentifier:@"DocMSGSessionViewController"];
    vc.msgSession = patientInfo;
    vc.delegate = self;
    vc.isMySession = isMySessions;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];*/
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DocMSGSessioniPhone *vc = (DocMSGSessioniPhone *)[sb instantiateViewControllerWithIdentifier:@"DocMSGSessioniPhone"];
        vc.msgSession = patientInfo;
        vc.delegate = self;
        vc.isMySession = isMySessions;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
        
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval;
    if (IS_IPHONE) {
        retval = CGSizeMake(140, 140);
    } else {
        retval = CGSizeMake(200, 200);
    }
    return retval;}

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
    if (isMySessions == true) {
        return _myArray.count;
    } else {
        
        return _patientsArray.count;
        
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardPatientTableViewCell *cell = (DashboardPatientTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    MSGSession *patientInfo;
    
    if (isMySessions == true) {
        patientInfo = [_myArray objectAtIndex:indexPath.row];
        [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.dprofileimg]];
        
        cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
        cell.cellImageView.layer.masksToBounds = YES;
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        
        
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.dfirstname, patientInfo.dlastname];
        
        cell.specialityLabel.text = [NSString stringWithFormat:@"Email: %@", patientInfo.dmail];
       
    } else {
        patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimg]];
        
        cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
        cell.cellImageView.layer.masksToBounds = YES;
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        
        
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.pfirstname, patientInfo.pfirstname];
    
        
        cell.specialityLabel.text = [NSString stringWithFormat:@"Email: %@", patientInfo.pmail];
    }
    
    

    
   
    
    
    if ([patientInfo.mstatus isEqual:@"0"]) {
        cell.costLabel.text = @"Pending";
        cell.costLabel.textColor = [UIColor flatGrayColor];
    } else if ([patientInfo.mstatus isEqual:@"1"]) {
        cell.costLabel.text = @"Accepted";
        cell.costLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
    } else if ([patientInfo.mstatus isEqual:@"2"]) {
        cell.costLabel.text = @"Declined";
        cell.costLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];

    } else if ([patientInfo.mstatus isEqual:@"3"]) {
        cell.costLabel.text = @"Clossed";
        cell.costLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];

    }
    

    
    
       // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (IS_IPHONE) {
        MSGSession *patientInfo;
        
        if (isMySessions == true) {
            patientInfo = [_myArray objectAtIndex:indexPath.row];
            
        } else {
            patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        }
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DocMSGSessioniPhone *vc = (DocMSGSessioniPhone *)[sb instantiateViewControllerWithIdentifier:@"DocMSGSessioniPhone"];
        vc.msgSession = patientInfo;
        vc.delegate = self;
        vc.isMySession = isMySessions;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        [self presentViewController:nav animated:YES completion:nil];
        
        
        
    } else {
        
        MSGSession *patientInfo;
        
        if (isMySessions == true) {
            patientInfo = [_myArray objectAtIndex:indexPath.row];
            
        } else {
            patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        }
        /*UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
         DocMSGSessionViewController *vc = (DocMSGSessionViewController *)[sb instantiateViewControllerWithIdentifier:@"DocMSGSessionViewController"];
         vc.msgSession = patientInfo;
         vc.delegate = self;
         vc.isMySession = isMySessions;
         UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];*/
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DocMSGSessioniPhone *vc = (DocMSGSessioniPhone *)[sb instantiateViewControllerWithIdentifier:@"DocMSGSessioniPhone"];
        vc.msgSession = patientInfo;
        vc.delegate = self;
        vc.isMySession = isMySessions;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
        
        [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        
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

- (void)acceptedSession:(MSGSession *)patientInfo {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DocChatViewViewController *vc = (DocChatViewViewController *)[sb instantiateViewControllerWithIdentifier:@"DocChatViewViewController"];
    vc.msgSession = patientInfo;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    [self requestPatientsDataByPage:1 keyword : @""];
}

- (void)declinedSession {
    [self requestPatientsDataByPage:1 keyword : @""];
}

- (void)visitSession:(MSGSession *)patientInfo {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DocChatViewViewController *vc = (DocChatViewViewController *)[sb instantiateViewControllerWithIdentifier:@"DocChatViewViewController"];
    vc.msgSession = patientInfo;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)refreshPatientsInfo3 {
    [self requestPatientsDataByPage:1 keyword : @""];
}

- (void)refreshPationInfo2 {
    [self requestPatientsDataByPage:1 keyword : @""];
}


@end
