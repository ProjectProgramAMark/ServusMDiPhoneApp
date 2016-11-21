//
//  RearViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/20/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import "RearViewController.h"
#import "SWRevealViewController.h"

@interface RearViewController ()

@end

@implementation RearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationController.navigationBarHidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
          self.revealViewController.navigationController.navigationBarHidden = true;
    [self refreshDoctorData];
}


- (void)refreshDoctorData {
  
    [[AppController sharedInstance] getDoctorProfile:@"" WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success)
        {
            _doctor = doctorProfile;
          
            
        }
    }];
}


- (IBAction)viewDoctorProfile:(id)sender {
   //   self.revealViewController.navigationController.navigationBarHidden = false;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DoctorProfileViewController *vc = (DoctorProfileViewController  *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfileViewController"];
    
   // [self.revealViewController.navigationController pushViewController:vc animated:YES];
     //[self.revealViewController setRightViewController:vc animated:YES];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];

}

- (IBAction)userLogOut:(id)sender {
          self.revealViewController.navigationController.navigationBarHidden = false;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDoctorUserDefault];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.revealViewController.navigationController popViewControllerAnimated:YES];
}


- (IBAction)goToHome:(id)sender {
    [AppDelegate sharedInstance].dashVC = [[DashboardV2ViewController alloc] init];
    
    
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:[AppDelegate sharedInstance].dashVC];
   [self.revealViewController pushFrontViewController:frontNavigationController animated:YES];
}

- (IBAction)goToPatientList:(id)sender {
    if (_doctor != NULL) {
        if ([_doctor.subscriptionpaid intValue] > 0) {
            
           // self.revealViewController.navigationController.navigationBarHidden = false;
            PatientListNewViewController *vc = [[PatientListNewViewController  alloc] init];
           // [self.revealViewController.navigationController pushViewController:vc animated:YES];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
             [self.revealViewController pushFrontViewController:navigationController animated:YES];
        } else {
            [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
    } else {
        [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
    }

}

- (IBAction)goToRequests:(id)sender {
    if (_doctor != NULL) {
        if ([_doctor.subscriptionpaid intValue] > 0) {
           // self.revealViewController.navigationController.navigationBarHidden = false;
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            UnifiedRequestsViewController *vc = [[UnifiedRequestsViewController alloc] init];
            
          //  [self.revealViewController.navigationController pushViewController:vc animated:YES];
            // [self.revealViewController setRightViewController:vc animated:YES];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.revealViewController pushFrontViewController:navigationController animated:YES];
        } else {
            [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
    } else {
        [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
    }

}

- (IBAction)goToConsultationRequests:(id)sender {
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    
    ConsultationListView *vc = [[ConsultationListView  alloc] initWithNibName:@"ConsultationListView" bundle:nil];
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
}

- (IBAction)goToCalendar:(id)sender {
    
    if (_doctor != NULL) {
        if ([_doctor.subscriptionpaid intValue] > 0) {
            iPhoneCalendarViewController *vc = [[iPhoneCalendarViewController alloc] initWithNibName:@"iPhoneCalendarViewController" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.revealViewController pushFrontViewController:navigationController animated:YES];
            
        } else {
            [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
    } else {
        [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
    }
}

- (IBAction)goToMessaging:(id)sender {
    if (_doctor != NULL) {
        if ([_doctor.subscriptionpaid intValue] > 0) {
              // self.revealViewController.navigationController.navigationBarHidden = false;
            MessagePatientsList *vc = [[MessagePatientsList alloc] initWithNibName:@"MessagePatientsList" bundle:nil];
            
            
            //[self.revealViewController.navigationController pushViewController:vc animated:YES];
            
             UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.revealViewController pushFrontViewController:navigationController animated:YES];
            
        } else {
            [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
    } else {
        [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
    }
    

}


- (IBAction)goToPayments:(id)sender {
    //self.revealViewController.navigationController.navigationBarHidden = false;
    DoctorPaymentsNewController *vc = [[DoctorPaymentsNewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];

}


@end
