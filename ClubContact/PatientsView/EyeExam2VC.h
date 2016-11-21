//
//  EyeExam2VC.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 9/22/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyeExam2.h"
#import "BaseViewController.h"
#import "AppController.h"
#import "AboutTableViewCell.h"
#import "PatientRecordAboutCell.h"
#import "EyeExamShareViewController.h"
#import "AmslerGridViewController.h"
#define kAboutCellID            @"aboutCell"

@interface EyeExam2VC : BaseViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITabBarDelegate, AmslerGridViewControllerDelegate> {
    
    EyeExam2 *eyeExam;
    int catType;
    
    BOOL unaidedSelect;
    BOOL presentingSelect;
    BOOL minfestSelect;
    BOOL cycloplegicSelect;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
}


@property (nonatomic, retain)  NSString *patientID;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet EyeExam2 *eyeExam;
@property (nonatomic) IBOutlet UITabBar *bottomTab;


@end
