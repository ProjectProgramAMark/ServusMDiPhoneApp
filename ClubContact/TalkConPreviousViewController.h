//
//  TalkConPreviousViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Consulatation.h"
#import "DocMenuTableViewCell.h"
#import "DashboardDocTableViewCell.h"
#import "PatientRecordAboutCell.h"
#import "TalkCreateViewController.h"
#import "CallManager.h"
#import "ConsultationTableViewCell.h"

@interface TalkConPreviousViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *docName;
    IBOutlet UILabel *docFrom;
    IBOutlet UILabel *docSpeciality;
    IBOutlet UILabel *docOnline;
    IBOutlet UILabel *docCost;
    
    IBOutlet UITableView *menuTable;
    
    NSMutableArray *consultationsArray;
    QBUUser *docQB;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (nonatomic, retain) Doctors *doctor;



@end
