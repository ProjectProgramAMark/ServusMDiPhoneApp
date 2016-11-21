//
//  SubscriptionPlanViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/16/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SubscriptionPlanViewController.h"

@interface SubscriptionPlanViewController ()

@end

@implementation SubscriptionPlanViewController

@synthesize docID;
@synthesize isRegisteredUser;
@synthesize patientCount;
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
    
    self.title = @"SUBSCRIPTION";
    
  /*  awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;*/
    
   

}

- (void)viewWillAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    if (isRegisteredUser == false) {
        /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
        self.navigationItem.leftBarButtonItem = cancelButton;*/
        
             [self loadPMaster];
    } else {
       /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Skip" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
        self.navigationItem.leftBarButtonItem = cancelButton;*/
        profileArea.hidden = true;
        awesomeScrollView.frame =CGRectMake(0, 0, windowWidth, windowHeight);
    }
   // [self loadPMaster];
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (IBAction)goBackToChose:(id)sender {
  //  [self.navigationController popViewControllerAnimated:YES];
    if (isRegisteredUser == true) {
        [self.delegate paymentComplated:@""];
    } else {
            [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)loadPMaster {
    
    [[AppController sharedInstance] getDoctorProfile:@"" WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success)
        {
            
            
            pmaster = doctorProfile;
            
            [profileIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            //[profileBackIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            
            
            profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
            profileIMG.layer.masksToBounds = YES;
            //  profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
            // profileIMG.layer.borderWidth = 3.0;
            
            fullNameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@", pmaster.firstname, pmaster.lastname];
           // tokens.text = [NSString stringWithFormat:@"Available Tokens: %@", pmaster.tokens];
            if ([pmaster.subscriptionplan intValue] == 2) {
                planLabel.text = @"Basic plan";
                
            } else  if ([pmaster.subscriptionplan intValue] == 3) {
             planLabel.text = @"Pro plan";
            } else {
                planLabel.text = @"Free plan";
            }
        }
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)subscribeProPlan:(id)sender {
    if (docID.length == 0) {
        [self showAlertViewWithMessage:@"Could not retrive doctor details. Please go back & try again" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        
    } else {
        if (patientCount < 2500) {
            [self showAlertViewWithMessage:@"You do not have enough patients to subscribe to this plan" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        
            return;
        }
         subcriptionType = 3;
        
          STPCheckoutOptions *options = [[STPCheckoutOptions alloc] initWithPublishableKey:[Stripe defaultPublishableKey]];
        
        options.purchaseDescription = @"Subcription Pro Plan $7/mo";
        options.purchaseAmount = 700;
        
        options.logoColor = [UIColor purpleColor];
        STPCheckoutViewController *checkoutViewController = [[STPCheckoutViewController alloc] initWithOptions:options];
        checkoutViewController.checkoutDelegate = self;
        [self presentViewController:checkoutViewController animated:YES completion:nil];
    }
}

- (void)subscribeBasicPlan:(id)sender {
    if (docID.length == 0) {
        [self showAlertViewWithMessage:@"Could not retrive doctor details. Please go back & try again" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        
    } else {
        if (patientCount > 2499) {
            [self showAlertViewWithMessage:@"You have too many patients to subscribe to this plan" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
            
            return;
        }
        
        subcriptionType = 2;
        
        STPCheckoutOptions *options = [[STPCheckoutOptions alloc] initWithPublishableKey:[Stripe defaultPublishableKey]];
        
        options.purchaseDescription = @"Subcription Basic Plan $5/mo";
        options.purchaseAmount = 500;
        
        options.logoColor = [UIColor purpleColor];
        STPCheckoutViewController *checkoutViewController = [[STPCheckoutViewController alloc] initWithOptions:options];
        checkoutViewController.checkoutDelegate = self;
        [self presentViewController:checkoutViewController animated:YES completion:nil];
        
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
           // [self loadPMaster];
            if (isRegisteredUser == true) {
                [self.delegate paymentComplated:@""];
            }
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
   // Doctor *patientLogin = [Doctor getFromUserDefault];
    NSMutableDictionary *chargeParams = [[NSMutableDictionary alloc] init];
    [chargeParams setObject:token.tokenId forKey:@"stripeToken"];
    [chargeParams setObject:docID  forKey:@"aUID"];
    [chargeParams setObject:@"app@myfidem.com"  forKey:@"cEmail"];
    
    
    //NSString *charURL = @"http://173.82.2.240/patient/subcription1.php";
    NSString *charURL = @"http://api.myfidem.com/patient/subcription1.php";
   /* if (subcriptionType == 2) {
        charURL = @"http://api.myfidem.com/patient/charge2app.php";
    } else  if (paymentType == 3) {
        charURL = @"http://api.myfidem.com/patient/charge10app.php";
    } else  if (paymentType == 2) {
        charURL = @"http://api.myfidem.com/patient/charge20app.php";
    } else  if (paymentType == 3) {
        charURL = @"http://api.myfidem.com/patient/charge40app.php";
    } else  if (paymentType == 4) {
        charURL = @"http://api.myfidem.com/patient/charge100app.php";
    } else  if (paymentType == 5) {
        charURL = @"http://api.myfidem.com/patient/charge200app.php";
    }*/
    NSString *planString = @"1";
    
    if (subcriptionType == 2) {
        planString = @"2";
    } else if (subcriptionType == 3) {
        planString = @"3";
    }
    
    NSURL *url = [NSURL URLWithString:charURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body     = [NSString stringWithFormat:@"stripeToken=%@&aUID=%@&aPlan=%@", token.tokenId, docID, planString];
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
                                   
                                   NSString* respsoneString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"Response %@", respsoneString);
                                 
                                   
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
