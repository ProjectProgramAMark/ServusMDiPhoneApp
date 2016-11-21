//
//  AddReviewDoctorViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AddReviewDoctorViewController.h"

@interface AddReviewDoctorViewController ()

@end

@implementation AddReviewDoctorViewController

@synthesize doctor;

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
    self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    self.title = @"ADD REVIEW";
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, reviewText.frame.size.height)];
    leftView.backgroundColor = reviewText.backgroundColor;
    reviewText.leftView = leftView;
    reviewText.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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




- (IBAction)addReviewToDoctor:(id)sender {
    if (reviewText.text.length == 0) {
        [self showAlertViewWithMessage:@"Enter a review for the doctor" withTag:1 withTitle:@"Error" andViewController:self isCancelButton:NO];
    } else {
     
        NSString *strcomment= reviewText.text;
        
        NSData *data = [strcomment dataUsingEncoding:NSNonLossyASCIIStringEncoding];
        strcomment = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSString *stars = @"1";
        
        if (starControll.selectedSegmentIndex == 0) {
            stars = @"1";
            
        } else if (starControll.selectedSegmentIndex == 1) {
            stars = @"2";
        } else if (starControll.selectedSegmentIndex == 2) {
            stars = @"3";
        } else if (starControll.selectedSegmentIndex == 3) {
            stars = @"4";
        } else if (starControll.selectedSegmentIndex == 4) {
            stars = @"5";
        }
        
        [SVProgressHUD showWithStatus:@"Saving..."];
        [[AppController sharedInstance] addRatingToDoctor:doctor.uid stars:stars review:strcomment WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            [SVProgressHUD dismiss];
            if (success) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

@end
