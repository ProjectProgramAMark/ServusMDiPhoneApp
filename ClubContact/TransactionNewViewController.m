//
//  TransactionNewViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/26/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import "TransactionNewViewController.h"

@interface TransactionNewViewController ()

@end

@implementation TransactionNewViewController

@synthesize conditionsArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    conditionsArray = [NSMutableArray array];
    
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
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
    
    self.title = @"TRANSACTIONS";
    
    /*[conditionTable addLegendHeaderWithRefreshingBlock:^{
        [self loadNotifications];
    }];
    */
    [conditionTable registerNib:[UINib nibWithNibName:@"TransactionCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadNotifications];
}


- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)loadNotifications {
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    
    [[AppController sharedInstance] getDoctorTransactions:@"" keyword:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *array) {
        [SVProgressHUD dismiss];
        //[conditionTable.header endRefreshing];
        if (success) {
            
            conditionsArray= [NSMutableArray arrayWithArray:array];
            [conditionTable reloadData];
            //[self markNotifcationsRead];
        }
        
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

- (void)markNotifcationsRead {
    [[AppController sharedInstance] markNotificationsRead:@"" completion:^(BOOL success, NSString *message) {
        if (success) {
            
        }
        
    }];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 1;
    
}


#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [conditionsArray count];
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // PharmacyListCell *cell = [tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
    
    TransactionCellTableViewCell  *cell = (TransactionCellTableViewCell  *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    
    Transactions *patientInfo = [conditionsArray objectAtIndex:indexPath.row];
    
    cell.typeLabel.text = [NSString stringWithFormat:@"%@", patientInfo.type];
      cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
    
    if ([patientInfo.credits intValue] < 2) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ token", patientInfo.credits];
    } else {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.credits];
    }
    
    if ([patientInfo.credits intValue] < 0) {
        cell.nameLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    } else {
        cell.nameLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
    }
    
    //cell.nameLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.credits];
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[patientInfo.created integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd, yyyy"];
    cell.dateLabel.text = [formatter stringFromDate:dob];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48.0f;
}





- (void)refreshRefillMedication {
    
}

@end
