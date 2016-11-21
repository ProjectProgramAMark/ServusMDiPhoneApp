//
//  DoctorListViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/12/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DoctorListViewController.h"
#import "PatientsTableViewCell.h"
#import "PatientDetailViewController.h"
#import "AddPatientViewController.h"
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"

@interface DoctorListViewController () <SpecialitySelectorDelegate>
{
    int currentPage;
    
}

@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end







@implementation DoctorListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _patientsArray = [NSMutableArray array];
    
    patientsGrid.delegate = self;
    patientsGrid.dataSource = self;
    
    _searchBar.delegate = self;
    
    _searchBar.barTintColor = [UIColor flatWhiteColor];
    
    /* [_patientsTableView addLegendFooterWithRefreshingBlock:^{
     [self requestPatientsDataByPage:currentPage + 1 keyword : _searchBar.text];
     }];
     
     [_patientsTableView addLegendHeaderWithRefreshingBlock:^{
     [self requestPatientsDataByPage:1 keyword : _searchBar.text];
     }];
     
     [_patientsTableView registerClass:[PatientsTableViewCell class]
     forCellReuseIdentifier:kPatientsCellID];*/
    currentPage = 0;
    
    [patientsGrid addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];
    
    [patientsGrid addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    
    [menuTable registerNib:[UINib nibWithNibName:@"DoctorCellV2" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"INVITE DOCTOR";
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
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
    if ([self.patientsArray count] == 0)
    {
        [self requestPatientsDataByPage:1 keyword : @""];
    }
}

- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    /*[[AppController sharedInstance] getAllPatiensByPage:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
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
        
        [patientsGrid.footer endRefreshing];
        [patientsGrid.header endRefreshing];
    }];*/
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllDoctors:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [_patientsArray removeAllObjects];
            }
            [_patientsArray addObjectsFromArray:conditions];
            [menuTable reloadData];
        }
        
        [menuTable.footer endRefreshing];
        [menuTable.header endRefreshing];
        
    }];
}





- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _patientsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        MSGPatientGridCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        Doctors *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        
        [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
        
        cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
        cell.profileIMG.layer.masksToBounds = YES;
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        NSString *isOnline = @"Offline";
        if ([patientInfo.isOnline intValue] == 1) {
            isOnline = @"Online";
        } else if ([patientInfo.isOnline intValue] == 2) {
            isOnline = @"Offline";
        }
        
        cell.nameLabel.text = [NSString stringWithFormat:@"Dr %@ %@", patientInfo.firstname, patientInfo.lastname];
        //  cell.messageCountLabel.text = patientInfo.msgCount;
        cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        
        cell.smallCircleIMG.hidden = true;
        cell.messageCountLabel.hidden = true;
        
        
        
        return cell;
    } else {
    MSGPatientGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
    
    
    Doctors *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    
    [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
    
    cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
    cell.profileIMG.layer.masksToBounds = YES;
    // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
    // cell.profileIMG.layer.borderWidth = 3.0;
    NSString *isOnline = @"Offline";
    if ([patientInfo.isOnline intValue] == 1) {
        isOnline = @"Online";
    } else if ([patientInfo.isOnline intValue] == 2) {
        isOnline = @"Offline";
    }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr %@ %@", patientInfo.firstname, patientInfo.lastname];
  //  cell.messageCountLabel.text = patientInfo.msgCount;
        cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
    
    cell.smallCircleIMG.hidden = true;
    cell.messageCountLabel.hidden = true;
    
    
    
    return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   /* Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    [[AppController sharedInstance] inviteMessaging:patientInfo.postid completion:^(BOOL success, NSString *message) {
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Massage invitation sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    }];*/
    
    Doctors *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    [[AppController sharedInstance] inviteDoctorMessaging:patientInfo.uid completion:^(BOOL success, NSString *message, NSString *sessionid) {
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Message invitation sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
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
    DoctorCellV2 *cell = (DoctorCellV2 *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
      Doctors *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    
    
    NSString *isOnline = @"Offline";
    if ([patientInfo.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Available";
        cell.onlineLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = true;
        cell.messageIcon.selected = true;
    } else if ([patientInfo.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Unavailable";
        cell.onlineLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        
        
        cell.facetimeIcon.selected = false;
        cell.messageIcon.selected = false;
    }
    
    cell.facetimeIcon.tag = indexPath.row;
    cell.messageIcon.tag = indexPath.row;
   //[cell.facetimeIcon addTarget:self action:@selector(openVideoChat:) forControlEvents:UIControlEventTouchUpInside];
   // [cell.messageIcon addTarget:self action:@selector(openMessaging:) forControlEvents:UIControlEventTouchUpInside];
    cell.facetimeIcon.hidden = true;
    cell.messageIcon.hidden = true;
    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.firstname, patientInfo.lastname];
    cell.specialityLabel.text = patientInfo.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
    // cell.nameLabel.text = imageName;
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    cell.cellImageView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.cellImageView.layer.borderWidth = 1.0f;
    cell.costLabel.text = [NSString stringWithFormat:@""];
    cell.clipsToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Doctors *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
       [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance] inviteDoctorMessaging:patientInfo.uid completion:^(BOOL success, NSString *message, NSString *sessionid) {
        [SVProgressHUD dismiss];
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Message invitation sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invitation could not be sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
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

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self inialiseToolbar];
    self.searchBar.inputAccessoryView = toolbar;
    return true;
}


-(void)inialiseToolbar{
    
    CGFloat _width = self.view.frame.size.width;
    CGFloat _height = 40.0;
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -_height, _width, _height)];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButtonItemSubmit = [[UIBarButtonItem alloc] initWithTitle:@"Speciality" style:UIBarButtonItemStyleBordered target:self action:@selector(specialitySelect:)];
    [toolbar setItems:[[NSArray alloc] initWithObjects:flexibleSpace,barButtonItemSubmit,  nil]];
}


- (IBAction)specialitySelect:(id)sender {
    SpecialitySelectorViewController *vc = [[SpecialitySelectorViewController alloc] init];
    vc.delegate = self;
    // isSpecilitySelect = true;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)specialitySelectDone:(NSString *)speciality {
    self.searchBar.text = speciality;
    [self requestPatientsDataByPage:1 keyword:speciality];
    
}


@end
