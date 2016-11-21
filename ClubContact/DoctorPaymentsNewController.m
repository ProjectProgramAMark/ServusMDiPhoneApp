//
//  DoctorPaymentsNewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/24/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import "DoctorPaymentsNewController.h"
#import "SWRevealViewController.h"

@interface DoctorPaymentsNewController ()

@end

@implementation DoctorPaymentsNewController

@synthesize pmaster;
@synthesize transactionArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    self.title = @"PAYMENTS";
    
    
    
    [transactionTableView registerNib:[UINib nibWithNibName:@"TransactionCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadPMaster];
    [self loadTransactions];
    
    int notiCount =  (int)[UIApplication sharedApplication].applicationIconBadgeNumber;
    
    if (notiCount > 99) {
        notificationCountLabel.text = @"100+";
    } else {
        notificationCountLabel.text = [NSString stringWithFormat:@"%i", notiCount];
    }

}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}

- (IBAction)goToNotifications:(id)sender {
    NotificationsDoctorViewController *vc = [[NotificationsDoctorViewController alloc] initWithNibName:@"NotificationsDoctorViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goBackToChose:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
       [self.revealViewController revealToggle:sender];
}

- (IBAction)goToTransactions:(id)sender {
    TransactionNewViewController *vc = [[TransactionNewViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestWithdrawal:(id)sender {
    WithdrawalViewController *vc = [[WithdrawalViewController alloc] initWithNibName:@"WithdrawalViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
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
            tokens.text = [NSString stringWithFormat:@"Available Tokens: %@", pmaster.tokens];
        }
    }];
    
}



- (void)loadTransactions {
   // [SVProgressHUD showWithStatus:@"Loading..."];
   
    
    [[AppController sharedInstance] getDoctorTransactions:@"" keyword:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *array) {
      //  [SVProgressHUD dismiss];
      //  [conditionTable.header endRefreshing];
        if (success) {
            
           transactionArray = [NSMutableArray arrayWithArray:array];
            [transactionTableView reloadData];
            //[self markNotifcationsRead];
        }
        
    }];
}



- (IBAction)buyPointsClicked:(UIButton *)sender {
    
    STPCheckoutOptions *options = [[STPCheckoutOptions alloc] initWithPublishableKey:[Stripe defaultPublishableKey]];
    
    if (sender.tag == 0) {
        options.purchaseDescription = @"10 Tokens";
        options.purchaseAmount = 200;
        paymentType = 0;
    } else if (sender.tag == 1) {
        options.purchaseDescription = @"50 Tokens";
        options.purchaseAmount = 1000;
        paymentType = 1;
    } else if (sender.tag == 2) {
        options.purchaseDescription = @"100 Tokens";
        options.purchaseAmount = 2000;
        paymentType = 2;
    } else if (sender.tag == 3) {
        options.purchaseDescription = @"200 Tokens";
        options.purchaseAmount = 4000;
        paymentType = 3;
    } else if (sender.tag == 4) {
        options.purchaseDescription = @"500 Tokens";
        options.purchaseAmount = 10000;
        paymentType = 4;
    } else if (sender.tag == 5) {
        options.purchaseDescription = @"1000 Tokens";
        options.purchaseAmount = 20000;
        paymentType = 5;
    } else {
        return;
    }
    
    options.logoColor = [UIColor purpleColor];
    STPCheckoutViewController *checkoutViewController = [[STPCheckoutViewController alloc] initWithOptions:options];
    checkoutViewController.checkoutDelegate = self;
    [self presentViewController:checkoutViewController animated:YES completion:nil];
    
}

- (IBAction)subscribeDoctor:(id)sender {
    SubscriptionPlanViewController *vc = [[SubscriptionPlanViewController alloc] initWithNibName:@"SubcriptionPlanViewController" bundle:nil];
    vc.docID = pmaster.uid;
    vc.isRegisteredUser = false;
    vc.patientCount = [pmaster.patientCount intValue];
    
    [self.navigationController pushViewController:vc animated:YES];

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





#pragma mark - Stripe Checkout


- (void)checkoutController:(STPCheckoutViewController *)controller didCreateToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion {
    [self createBackendChargeWithToken:token completion:completion];
}

- (void)checkoutController:(STPCheckoutViewController *)controller didFinishWithStatus:(STPPaymentStatus)status error:(NSError *)error {
    switch (status) {
        case STPPaymentStatusSuccess:
            [[[UIAlertView alloc] initWithTitle:@"Success!"
                                        message:@"Payment successfully created!"
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            [self loadPMaster];
            break;
        case STPPaymentStatusError:
            // [self presentError:error];
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:@"Payment did not go through"
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            break;
        case STPPaymentStatusUserCancelled:
            // do nothing
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - STPBackendCharging

- (void)createBackendChargeWithToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion {
    Doctor *patientLogin = [Doctor getFromUserDefault];
    NSMutableDictionary *chargeParams = [[NSMutableDictionary alloc] init];
    [chargeParams setObject:token.tokenId forKey:@"stripeToken"];
    [chargeParams setObject:patientLogin.uid  forKey:@"aUID"];
    [chargeParams setObject:@"app@myfidem.com"  forKey:@"cEmail"];
    
    
    NSString *charURL = @"http://api.myfidem.com/patient/charge2app.php";
    if (paymentType == 0) {
        charURL = @"http://api.myfidem.com/patient/charge2app.php";
    } else  if (paymentType == 1) {
        charURL = @"http://api.myfidem.com/patient/charge10app.php";
    } else  if (paymentType == 2) {
        charURL = @"http://api.myfidem.com/patient/charge20app.php";
    } else  if (paymentType == 3) {
        charURL = @"http://api.myfidem.com/patient/charge40app.php";
    } else  if (paymentType == 4) {
        charURL = @"http://api.myfidem.com/patient/charge100app.php";
    } else  if (paymentType == 5) {
        charURL = @"http://api.myfidem.com/patient/charge200app.php";
    }
    
    NSURL *url = [NSURL URLWithString:charURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body     = [NSString stringWithFormat:@"stripeToken=%@&aUID=%@", token.tokenId, patientLogin.uid];
    
    request.HTTPBody   = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error) {
                               if (error) {
                                   NSString* respsoneString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"Response %@", respsoneString);
                                   completion(STPBackendChargeResultSuccess, nil);
                               } else {
                                   NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:kNilOptions
                                                                                          error:&error];
                                   
                                   if ([json[@"responseCode"] integerValue] == 200) {
                                       completion(STPBackendChargeResultSuccess, nil);
                                   } else {
                                       
                                       completion(STPBackendChargeResultFailure, error);
                                   }
                               }
                           }];
    
    
}

#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //Now you can do what you want with the response string from the data
    NSString* respsoneString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response %@", respsoneString);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //Do something if there is an error in the connection
}


@end
