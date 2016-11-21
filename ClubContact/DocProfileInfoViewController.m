//
//  DocProfileInfoViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/12/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "DocProfileInfoViewController.h"

@interface DocProfileInfoViewController ()

@end

@implementation DocProfileInfoViewController

@synthesize doctor;
@synthesize isConsultation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    self.title = @"PROFILE INFO";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewWillAppear:(BOOL)animated {
    specialityLabel.text = doctor.speciality;
    fromLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", doctor.officeaddress, doctor.officecity, doctor.officestate, doctor.officezip, doctor.officecountry];
    
    if (isConsultation == true) {
        costLabel.text = [NSString stringWithFormat:@"%@ Tokens", doctor.ccost];
    } else {
    costLabel.text = [NSString stringWithFormat:@"1 Token/Message"];
    }
    
    if ([doctor.yearsExperience intValue] > 1) {
        experienceLabel.text = [NSString stringWithFormat:@"%@ years ", doctor.yearsExperience];
    } else {
        experienceLabel.text = [NSString stringWithFormat:@"%@ year", doctor.yearsExperience];
    }
    
   residencyLabel.text = [NSString stringWithFormat:@"%@", doctor.residency];
    schoolLabel.text = [NSString stringWithFormat:@"%@", doctor.school];
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
