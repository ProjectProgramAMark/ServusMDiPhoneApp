//
//  TransactionsPatientViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/12/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DashboardCollectionCell.h"
#import "DashboardCollectionCelliPhone.h"
#import <Stripe/Stripe.h>
#import "AFHTTPSessionManager.h"
#import "TransactionCellTableViewCell.h"

@interface TransactionsPatientViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UITableView *transactionTableView;
    IBOutlet UILabel *notificationCountLabel;
    
    NSMutableArray *transactionArray ;
}

@end
