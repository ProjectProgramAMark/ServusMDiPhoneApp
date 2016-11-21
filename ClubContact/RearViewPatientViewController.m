//
//  RearViewPatientViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/11/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "RearViewPatientViewController.h"
#import "SWRevealViewController.h"

@interface RearViewPatientViewController ()

@end

@implementation RearViewPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = true;
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, awesomeStuffContainer.frame.size.width, awesomeScrollView.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    //[self loadVideoChatUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.revealViewController.navigationController.navigationBarHidden = true;
    [self loadVideoChatUser];
}





- (void)loadVideoChatUser {
    PatientLogin *plogin = [PatientLogin getFromUserDefault];
    
    /*[QBRequest createSessionWithSuccessBlock:^(QBResponse *response, QBASession *session) {
        // Success, You have got Application session, now READ something.
        QBUUser *user = [QBUUser user];
        user.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
        user.password = [NSString stringWithFormat:@"passwordmyfidem"];
        user.email = plogin.email;
        user.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];
        
        [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
            // Success, do something
            [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
                // Success, do something
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userQB = user1;
                [self logInChatWithUser:user1];
            } errorBlock:^(QBResponse *response) {
                // error handling
                NSLog(@"error: %@", response.error);
            }];
        } errorBlock:^(QBResponse *response) {
            // error handling
            NSLog(@"error: %@", response.error);
            [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
                // Success, do something
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userQB = user1;
                
                [self logInChatWithUser:user1];
            } errorBlock:^(QBResponse *response) {
                // error handling
                NSLog(@"error: %@", response.error);
            }];
        }];
        
    } errorBlock:^(QBResponse *response) {
        // error handling
        NSLog(@"error: %@", response.error);
    }];*/
}


- (void)logInChatWithUser:(QBUUser *)user {
    
    /*  PatientLogin *plogin = [PatientLogin getFromUserDefault];
     QBUUser *user1 = [QBUUser user];
     user1.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
     user1.password = [NSString stringWithFormat:@"passwordmyfidem"];
     user1.email = plogin.email;
     user1.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];*/
    // QBUUser *user1 = [QBUUser user];
    
    //NSLog(@"Curent id %i", (int)user.ID);
    QBUUser *user1 = [QBUUser user];
    user1.ID = (int)user.ID;
    user1.login = user.login;
    user1.fullName = user.fullName;
    user1.password = [NSString stringWithFormat:@"passwordmyfidem"];
    
    
    __weak __typeof(self)weakSelf = self;
    [[ConnectionManager instance] logInWithUser:user1
                                     completion:^(BOOL error)
     {
         if (!error) {
             
             [QBRTCClient.instance addDelegate:self];
             
         }
         else {
             
             [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Login chat error!", nil)];
         }
     }];
}

- (void)didReceiveNewSession:(QBRTCSession *)session userInfo:(NSDictionary *)userInfo {
    [CallManager.instance incominingCall:session userInfo:userInfo];
}

- (void)sessionDidClose:(QBRTCSession *)session {
    [CallManager.instance closeThisSession:session];
}


- (IBAction)goToPatientRecords:(id)sender {
    
   
    PatientRecordsViewController *vc = [[PatientRecordsViewController alloc] initWithNibName:@"PatientRecordsViewController" bundle:nil];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
    
}

- (IBAction)goToConsultations:(id)sender {
    
    
    MyProfileConsultationHistory *vc = [[MyProfileConsultationHistory alloc] initWithNibName:@"MyProfileConsultationHistory" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
    
}


- (IBAction)goToMedications:(id)sender {
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    SelectRecMedViewController *vc = [[SelectRecMedViewController alloc] initWithNibName:@"SelectRecMedViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}

- (IBAction)goToPayments:(id)sender {
    PaymentsPageViewController *vc = [[PaymentsPageViewController alloc] initWithNibName:@"PaymentsPageViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}


- (IBAction)goToMessaging:(id)sender {
   // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    MyProfileMessageHistory *vc = [[MyProfileMessageHistory alloc] initWithNibName:@"MyProfileMessageHistory" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}

- (IBAction)goToCalendar:(id)sender {
    CalendarPatientViewController *vc = [[CalendarPatientViewController alloc] initWithNibName:@"CalendarPatientViewController" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}

- (IBAction)goToHome:(id)sender {
    DashboardPatientViewController *vc = [[DashboardPatientViewController alloc] initWithNibName:@"DashboardPatientViewController" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}

- (IBAction)logOut:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientRegisterUserDefault];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientUserDefault];
    [[NSUserDefaults standardUserDefaults] synchronize];
     
    self.revealViewController.navigationController.navigationBarHidden = false;

    [self.revealViewController.navigationController popViewControllerAnimated:YES];
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
