//
//  PaymentsPageViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DashboardCollectionCell.h"
#import "DashboardCollectionCelliPhone.h"
#import <Stripe/Stripe.h>
#import "AFHTTPSessionManager.h"
#import "TransactionCellTableViewCell.h"
#import "TransactionsPatientViewController.h"

@interface PaymentsPageViewController : BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, STPCheckoutViewControllerDelegate, NSURLConnectionDelegate> {
    IBOutlet UICollectionView *menuCollection;
    int currentPage;
    
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *firstname;
    IBOutlet UILabel *lastname;
    IBOutlet UILabel *tokens;
    // IBOutlet UILabel *docOnline;
    int paymentType;
    NSMutableData *responseData;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UITableView *transactionTableView;
    IBOutlet UILabel *notificationCountLabel;
    
    NSMutableArray *transactionArray ;
}

@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic, retain) PMaster *pmaster;
//@property(weak, nonatomic) PTKView *paymentView;

@end
