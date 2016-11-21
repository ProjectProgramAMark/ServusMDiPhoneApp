//
//  TransactionsPatientViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/12/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "TransactionsPatientViewController.h"

@interface TransactionsPatientViewController ()

@end

@implementation TransactionsPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [transactionTableView registerNib:[UINib nibWithNibName:@"TransactionCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    
    
    transactionArray = [[NSMutableArray alloc] init];
    
    
    self.title = @"TRANSACTIONS";

}


- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadTransactions];
}

- (void)loadTransactions {
    // [SVProgressHUD showWithStatus:@"Loading..."];
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    [[AppController sharedInstance] getPatientTransaction:@"" keyword:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *array) {
          [SVProgressHUD dismiss];
        //  [conditionTable.header endRefreshing];
        if (success) {
            
            transactionArray = [NSMutableArray arrayWithArray:array];
            [transactionTableView reloadData];
            //[self markNotifcationsRead];
        }
        
    }];
}



#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return transactionArray.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // PharmacyListCell *cell = [tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
    
    TransactionCellTableViewCell  *cell = (TransactionCellTableViewCell  *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    
    Transactions *patientInfo = [transactionArray objectAtIndex:indexPath.row];
    
    cell.typeLabel.text = [NSString stringWithFormat:@"%@", patientInfo.type];
    /*cell.typeLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
     
     cell.dateLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
     cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];*/
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



@end
