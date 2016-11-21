//
//  UnifiedRequestsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/4/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NewGreenTableViewCell.h"
#import "UnifiedRequests.h"
#import "UnifiedReqTableViewCell.h"
#import "AppController.h"
#import "MessagingViewController.h"
#import "Doctor.h"
#import "AppRequestiPhoneViewController.h"
#import "Consulatation.h"
#import "ConsultationDetailiPhone.h"
#import "MessagePatientsList.h"

@interface UnifiedRequestsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate> {
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
   
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Patient *patient;


@property (strong, nonatomic) NSMutableArray *requestsArray;
@end
