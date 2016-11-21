//
//  MessageInviteView.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/4/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MessageInviteView.h"
#import "PatientsTableViewCell.h"
#import "PatientDetailViewController.h"
#import "AddPatientViewController.h"
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"

#define kPatientsCellID @"cell"
@interface MessageInviteView () {
    int currentPage;

}


@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;



@end

@implementation MessageInviteView


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
    
     [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatientTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    
    self.title = @"INVITE PATIENTS";
    
  
    
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
    [[AppController sharedInstance] getAllPatiensByPage:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
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





- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _patientsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSGPatientGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
    
    
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
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    [[AppController sharedInstance] inviteMessaging:patientInfo.postid completion:^(BOOL success, NSString *message) {
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Invitation sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
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
   /* DashboardPatientTableViewCell *cell = (DashboardPatientTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[patientInfo.dob integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    
    
    NSString *street1 = @"";
    
    //  cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",patientInfo.firstName, patientInfo.lastName];
    cell.specialityLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", patientInfo.street1, patientInfo.street2, patientInfo.city, patientInfo.state, patientInfo.zipcode, patientInfo.country];  [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profilepic]];
    if ([patientInfo.msgCount intValue] >1) {
        cell.costLabel.text = [NSString stringWithFormat:@"%@ Refills", patientInfo.msgCount];
    } else {
        cell.costLabel.text = [NSString stringWithFormat:@"%@ Refill", patientInfo.msgCount];
    }*/
    
    
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    [[AppController sharedInstance] inviteMessaging:patientInfo.postid completion:^(BOOL success, NSString *message) {
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Invitation sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
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

@end
