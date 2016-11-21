//
//  TransactionViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "TransactionViewController.h"

@interface TransactionViewController ()

@end

@implementation TransactionViewController


@synthesize conditionsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    conditionsArray = [NSMutableArray array];
    
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    // Do any additional setup after loading the view.
    
    self.title = @"TRANSACTIONS";
    
    [conditionTable addLegendHeaderWithRefreshingBlock:^{
        [self loadNotifications];
    }];
    
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
        [conditionTable.header endRefreshing];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // PharmacyListCell *cell = [tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
    
    TransactionCellTableViewCell  *cell = (TransactionCellTableViewCell  *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    
    Transactions *patientInfo = [conditionsArray objectAtIndex:indexPath.row];
    
    cell.typeLabel.text = [NSString stringWithFormat:@"%@", patientInfo.type];
    cell.typeLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    
    cell.dateLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
    
    if ([patientInfo.credits intValue] < 2) {
         cell.nameLabel.text = [NSString stringWithFormat:@"%@ token", patientInfo.credits];
    } else {
         cell.nameLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.credits];
    }
    //cell.nameLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.credits];
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[patientInfo.created integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
    cell.dateLabel.text = [formatter stringFromDate:dob];
    
    
    /*cell.nameLabel.text = patientInfo.pharmName;
     cell.addressLabel.text = patientInfo.address;
     
     cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
     cell.addressLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
     cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];*/
    
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

   
    
}


- (void)refreshRefillMedication {
    
}


@end
