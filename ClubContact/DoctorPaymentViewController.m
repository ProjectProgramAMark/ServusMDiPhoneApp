//
//  DoctorPaymentViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DoctorPaymentViewController.h"

@interface DoctorPaymentViewController ()

@end

@implementation DoctorPaymentViewController

@synthesize pmaster;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [menuCollection registerNib:[UINib nibWithNibName:@"DashboardCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    [menuCollection registerNib:[UINib nibWithNibName:@"DashboardCollectionCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    
    /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *transactButton = [[UIBarButtonItem alloc] initWithTitle:@"Transactions" style:UIBarButtonItemStylePlain target:self action:@selector(goToTransactions:)];
    self.navigationItem.rightBarButtonItem = transactButton;
    
    self.title = @"PAYMENTS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadPMaster];
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goToTransactions:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    TransactionViewController *vc = (TransactionViewController *)[sb instantiateViewControllerWithIdentifier:@"TransactionViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestWithdrawal:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    WithdrawalViewController *vc = (WithdrawalViewController *)[sb instantiateViewControllerWithIdentifier:@"WithdrawalViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadPMaster {
   /* [[AppController sharedInstance] getPMasterByID:@"" WithCompletion:^(BOOL success, NSString *message, PMaster *msgsession) {
        if (success) {
            pmaster = msgsession;
            
            [profileIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            [profileBackIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            
            
            profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
            profileIMG.layer.masksToBounds = YES;
            profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
            profileIMG.layer.borderWidth = 3.0;
            
            firstname.text = [NSString stringWithFormat:@"%@ %@", pmaster.firstname, pmaster.lastname];
            tokens.text = [NSString stringWithFormat:@"Tokens: %@", pmaster.tokens];
        }
    }];*/
    [[AppController sharedInstance] getDoctorProfile:@"" WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success)
        {
           
            
            pmaster = doctorProfile;
            
            [profileIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            [profileBackIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            
            
            profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
            profileIMG.layer.masksToBounds = YES;
            profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
            profileIMG.layer.borderWidth = 3.0;
            
            firstname.text = [NSString stringWithFormat:@"Dr. %@ %@", pmaster.firstname, pmaster.lastname];
            tokens.text = [NSString stringWithFormat:@"Tokens: %@", pmaster.tokens];
        }
    }];

}

#pragma mark - UICollectionView


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 7;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        
        
        DashboardCollectionCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"10 Tokens ($2)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"50 Tokens ($10)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"100 Tokens ($20)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"200 Tokens ($40)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"500 Tokens ($100)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 5) {
            cell.nameLabel.text = @"1000 Tokens ($200)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Subscription";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        }
        
        
        return cell;
        
        
    } else {
        // MSGPatientGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        
        /* Patient *patientInfo = [patientsArray objectAtIndex:indexPath.row];
         
         [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profilepic]];
         
         cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
         cell.profileIMG.layer.masksToBounds = YES;
         // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
         // cell.profileIMG.layer.borderWidth = 3.0;
         
         cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName];
         cell.messageCountLabel.text = patientInfo.msgCount;*/
        DashboardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"10 Tokens ($2)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"50 Tokens ($10)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"100 Tokens ($20)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"200 Tokens ($40)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"500 Tokens ($100)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 5) {
            cell.nameLabel.text = @"1000 Tokens ($200)";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        } else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Subscription";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        }
        
        return cell;
    }
    
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /*     Patient *patientInfo = [patientsArray objectAtIndex:indexPath.row];
     UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
     PatientDetailViewController *vc = (PatientDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDetailViewController"];
     vc.patient = patientInfo;
     vc.delegate = self;
     [self.navigationController pushViewController:vc animated:YES];*/
    
    if (indexPath.row == 6) {
        if (pmaster != NULL) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            SubscriptionPlanViewController *vc = (SubscriptionPlanViewController *)[sb instantiateViewControllerWithIdentifier:@"SubscriptionPlanViewController"];
            vc.docID = pmaster.uid;
            vc.isRegisteredUser = false;
            vc.patientCount = [pmaster.patientCount intValue];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        return;
    }
    STPCheckoutOptions *options = [[STPCheckoutOptions alloc] initWithPublishableKey:[Stripe defaultPublishableKey]];
    
    if (indexPath.row == 0) {
        options.purchaseDescription = @"10 Tokens";
        options.purchaseAmount = 200;
        paymentType = 0;
    } else if (indexPath.row == 1) {
        options.purchaseDescription = @"50 Tokens";
        options.purchaseAmount = 1000;
        paymentType = 1;
    } else if (indexPath.row == 2) {
        options.purchaseDescription = @"100 Tokens";
        options.purchaseAmount = 2000;
        paymentType = 2;
    } else if (indexPath.row == 3) {
        options.purchaseDescription = @"200 Tokens";
        options.purchaseAmount = 4000;
        paymentType = 3;
    } else if (indexPath.row == 4) {
        options.purchaseDescription = @"500 Tokens";
        options.purchaseAmount = 10000;
        paymentType = 4;
    } else if (indexPath.row == 5) {
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval;
    /* if (IS_IPHONE) {
     retval = CGSizeMake(140, 140);
     } else {
     retval = CGSizeMake(200, 200);
     }*/
    
    if (IS_IPHONE) {
        retval = CGSizeMake(85, 107);
    } else {
        retval = CGSizeMake(200, 184);
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
