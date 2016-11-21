//
//  DoctorProfilePatientViC.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Doctors.h"
#import "DocMenuTableViewCell.h"
#import "DashboardDocTableViewCell.h"
#import "ReviewsViewController.h"
#import "MesHistoryViewController.h"
#import "TalkConPreviousViewController.h"
#import "TalkCreateViewController.h"
#import "ShortQuestViewController.h"

@interface DoctorProfilePatientViC : BaseViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *docName;
    IBOutlet UILabel *docFrom;
    IBOutlet UILabel *docSpeciality;
    IBOutlet UILabel *docOnline;
    
    IBOutlet UITableView *menuTable;
    
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
}

@property (nonatomic, retain) Doctors *doctor;

@end
