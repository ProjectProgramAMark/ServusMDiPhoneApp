//
//  AddEyeExam2VC.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 9/22/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyeExam.h"
#import "EyeExam2.h"
#import "BaseViewController.h"
#import "AppController.h"
#import "AboutTableViewCell.h"
#import "Doctor.h"
#import "EyeExamTableViewCell.h"
#import "AmslerGridViewController.h"
#define kAboutCellID            @"aboutCell"

@interface AddEyeExam2VC : BaseViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITabBarDelegate, AmslerGridViewControllerDelegate>  {
    
    EyeExam2 *eyeExam;
    int catType;
    
    CGFloat old_distance;
    
    BOOL zoomOn;
    
    BOOL unaidedSelect;
    BOOL presentingSelect;
    BOOL minfestSelect;
    BOOL cycloplegicSelect;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
   
    
}


@property (nonatomic, retain)  NSString *patientID;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) IBOutlet UITabBar *bottomTab;
@property (nonatomic, retain) IBOutlet UITextField *actifText;

@end
