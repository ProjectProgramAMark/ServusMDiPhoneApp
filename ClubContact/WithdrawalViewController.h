//
//  WithdrawalViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "MJRefresh.h"
#import "BankDetails.h"
#import "BaseViewController.h"
#import "RegisterTableViewCell.h"
#import <Stripe/Stripe.h>
#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "Doctor.h"

@interface WithdrawalViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    IBOutlet UITableView *dataTableView;
    
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *planLabel;
    IBOutlet UILabel *fullNameLabel;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
}

@property (nonatomic) BankDetails *bnkDetails;
@property (nonatomic, retain) Doctors *pmaster;

@end
