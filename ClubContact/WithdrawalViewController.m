//
//  WithdrawalViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "WithdrawalViewController.h"

@interface WithdrawalViewController ()

@end

@implementation WithdrawalViewController
@synthesize bnkDetails;
@synthesize pmaster;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


    
    [dataTableView registerNib:[UINib nibWithNibName:@"RegisterTableViewCell" bundle:nil] forCellReuseIdentifier:@"registerCell"];
    
    bnkDetails = [[BankDetails alloc] init];
    
    self.title = @"WITHDRAW";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadWithdrawalForm];
    [self loadPMaster];
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadWithdrawalForm {
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    
    [[AppController sharedInstance] getPMasterBankDetails:@"" WithCompletion:^(BOOL success, NSString *message, BankDetails *msgsession) {
        
        [SVProgressHUD dismiss];
        if (success) {
              bnkDetails = msgsession;
            [dataTableView reloadData];
        }
      
        
    }];

    
}



- (void)loadPMaster {
    
    [[AppController sharedInstance] getDoctorProfile:@"" WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success)
        {
            
            
            pmaster = doctorProfile;
            
            [profileIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            
            profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
            profileIMG.layer.masksToBounds = YES;
            
            fullNameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@", pmaster.firstname, pmaster.lastname];
            planLabel.text = [NSString stringWithFormat:@"Available Tokens: %@", pmaster.tokens];
           
        }
    }];
    
}





- (IBAction)requestWithdrawal:(id)sender {
    [self.view endEditing:YES];
    if (bnkDetails.bankname.length == 0) {
         [self showAlertViewWithMessage:@"Please enter your bank name" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (bnkDetails.bankaddress.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your bank address" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (bnkDetails.accname.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your account name" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (bnkDetails.accno.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your account number" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (bnkDetails.routeno.length == 0) {
        [self showAlertViewWithMessage:@"Please enter your routing number" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if (bnkDetails.withdraw.length == 0) {
        [self showAlertViewWithMessage:@"Please the number of tokens to withdraw" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else if ([bnkDetails.withdraw intValue] > [bnkDetails.credits intValue]) {
        [self showAlertViewWithMessage:@"You do not have enought tokens to withdraw" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else {
    [SVProgressHUD showWithStatus:@"Requesting..."];
    [[AppController sharedInstance] addWithdrawalRequest:bnkDetails WithCompletion:^(BOOL success, NSString *message) {
        
        if (success) {
            [self showAlertViewWithMessage:@"Withdrawal request sent" withTag:1 withTitle:@"Success" andViewController:self isCancelButton:NO];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self showAlertViewWithMessage:message withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
        
    }];
    }
}

#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    // return 10;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNumber = 6;
    
    return rowNumber;
}


- (NSString *)registerTableValue:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = bnkDetails.bankname;
            break;
        }
        case 1:
        {
            title = bnkDetails.bankaddress;
            break;
        }
        case 2:
        {
            title = bnkDetails.accname;
            break;
        }
        case 3:
        {
            title = bnkDetails.accno;
            break;
        }
        case 4:
        {
            title = bnkDetails.routeno;
            break;
        }case 5:
        {
            title = bnkDetails.withdraw;
            break;
        }
                default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)registerTableTitle:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Bank Name";
            break;
        }
        case 1:
        {
            title = @"Bank Address";
            break;
        }
        case 2:
        {
            title = @"Account Name";
            break;
        }
        case 3:
        {
            title = @"Account Number";
            break;
        }
        case 4:
        {
            title = @"Routing Number";
            break;
        }case 5:
        {
            title = @"Tokens to withdraw";
            break;
        }
                default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegisterTableViewCell   *cell = (RegisterTableViewCell  *)[tableView dequeueReusableCellWithIdentifier:@"registerCell"];
    
    // cell.valueLabel.borderStyle = UITextBorderStyleBezel;
    cell.valueText.enabled = true;
    cell.valueText.delegate = self;
    
    
    if (indexPath.row == 10) {
        cell.valueText.secureTextEntry = true;
    } else {
        cell.valueText.secureTextEntry = false;
    }
    
    cell.valueText.placeholder = [self registerTableTitle:indexPath.row];
    cell.valueText.text = [self registerTableValue:indexPath.row];
    cell.valueText.tag = indexPath.row + 100;
    cell.backgroundColor = [UIColor clearColor];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, cell.valueText.frame.size.height)];
    leftView.backgroundColor = cell.valueText.backgroundColor;
    cell.valueText.leftView = leftView;
    cell.valueText.leftViewMode = UITextFieldViewModeAlways;
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 101) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 102) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 103) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 104) {
        [dataTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        bnkDetails.bankname = textField.text;
    } else if (textField.tag == 101) {
        bnkDetails.bankaddress = textField.text;
    } else if (textField.tag == 102) {
        bnkDetails.accname = textField.text;
    } else if (textField.tag == 103) {
        bnkDetails.accno = textField.text;
    } else if (textField.tag == 104) {
        bnkDetails.routeno = textField.text;
    } else if (textField.tag == 105) {
        bnkDetails.withdraw = textField.text;
    }
    
    return YES;
}

@end
