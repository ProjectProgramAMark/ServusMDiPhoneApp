//
//  AddEyeExamFormViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 9/5/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EyeExam.h"
#import "BaseViewController.h"
#import "AppController.h"
#import "AboutTableViewCell.h"

#define kAboutCellID            @"aboutCell"

@interface AddEyeExamFormViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITabBarDelegate>  {
    
    EyeExam *eyeExam;
    int catType;
    
}


@property (nonatomic, retain)  NSString *patientID;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) IBOutlet UITabBar *bottomTab;


@end
