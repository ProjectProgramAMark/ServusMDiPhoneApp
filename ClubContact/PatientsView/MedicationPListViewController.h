//
//  MedicationPListViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/1/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NewGreenTableViewCell.h"
#import "PatientDrugDetailsViewController.h"
#import "DrugsViewController.h"
#import "ConditionListViewController.h"
#import "PatientDetailViewController.h"
@interface MedicationPListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UIImageView *profileIMGView2;
    
    IBOutlet UILabel *nameLabel2;
    IBOutlet UILabel *jobLabel2;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Patient *patient;

@property (nonatomic) BOOL isSharedProfile;
@property (nonatomic) BOOL isRefill;

@end
