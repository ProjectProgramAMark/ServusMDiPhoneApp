//
//  MesDocProfileViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Doctors.h"
#import "DocMenuTableViewCell.h"
#import "DashboardDocTableViewCell.h"
#import "TalkConPreviousViewController.h"
#import "TalkCreateViewController.h"
#import "MesHistoryViewController.h"
#import "PatientMessagingView.h"
#import "ReviewsViewController.h"
#import "DocProfileInfoViewController.h"

@interface MesDocProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *docName;
    IBOutlet UILabel *docFrom;
    IBOutlet UILabel *docSpeciality;
    IBOutlet UILabel *docOnline;
    IBOutlet UILabel *docCost;
    IBOutlet UILabel *docYears;
    IBOutlet UILabel *docSchool;
    IBOutlet UILabel *docResidency;
    
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
}

@property (nonatomic, retain) Doctors *doctor;


@end
