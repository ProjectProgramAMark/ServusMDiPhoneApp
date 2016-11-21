//
//  RefillPatientsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/17/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "RefillPatientsViewController.h"
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"
#import "PatientDetailViewController.h"
#import "SWRevealViewController.h"

@interface RefillPatientsViewController () <PatientsDetailDelegate> {
    
    int currentPage;
}

@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;




@end

@implementation RefillPatientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    patientsGrid.delegate = self;
    patientsGrid.dataSource = self;
    _patientsArray = [NSMutableArray array];
    
    _searchBar.delegate = self;
    
    self.title = @"PATIENTS";
    
    [menuTable addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];
    
    [menuTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    currentPage = 0;
    
    
     [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatientTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
   
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
    
    //self.title = @"REFILL LIST";


    
}

- (IBAction)goBackToChose:(id)sender {
   [self.revealViewController revealToggle:sender];
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

- (void)viewWillDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}

- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    [[AppController sharedInstance] getAllPatiensByPage3:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





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
    
    if ([patientInfo.msgCount intValue] >1) {
        cell.costLabel.text = [NSString stringWithFormat:@"%@ Refills", patientInfo.msgCount];
    } else {
        cell.costLabel.text = [NSString stringWithFormat:@"%@ Refill", patientInfo.msgCount];
    }

    
    // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
   // cell.delegate = self;
    
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
   /* PatientDetailViewController *vc = [[PatientDetailViewController alloc] initWithNibName:@"PatientDetailViewController" bundle:nil];
    vc.patient = patientInfo;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];*/
    MedicationPListViewController  *vc = [[MedicationPListViewController alloc] init];
    vc.patient = patientInfo;
    vc.isRefill = true;
    
    [self.navigationController pushViewController:vc animated:YES];
    


}













- (void)refreshPatientList {
    [self requestPatientsDataByPage:1 keyword : _searchBar.text];
}

#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestPatientsDataByPage:1 keyword : _searchBar.text];
}



@end
