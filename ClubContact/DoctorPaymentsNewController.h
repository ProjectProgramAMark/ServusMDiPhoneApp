//
//  DoctorPaymentsNewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/24/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DashboardCollectionCell.h"
#import "DashboardCollectionCelliPhone.h"
#import <Stripe/Stripe.h>
#import "AFHTTPSessionManager.h"
#import "UIImageView+WebCache.h"
#import "Doctor.h"
#import "TransactionViewController.h"
#import "WithdrawalViewController.h"
#import "SubscriptionPlanViewController.h"
#import "TransactionNewViewController.h"
#import "NotificationsDoctorViewController.h"

@interface DoctorPaymentsNewController : BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, STPCheckoutViewControllerDelegate, NSURLConnectionDelegate, UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UICollectionView *menuCollection;
    int currentPage;
    
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *firstname;
    IBOutlet UILabel *lastname;
    IBOutlet UILabel *tokens;
    IBOutlet UILabel *fullNameLabel;
    // IBOutlet UILabel *docOnline;
    int paymentType;
    NSMutableData *responseData;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UITableView *transactionTableView;
    IBOutlet UILabel *notificationCountLabel;
   // IBOutlet UILabel *notificationCountLabel;
     int subcriptionType;
    
}
@property (strong, nonatomic) NSMutableArray *transactionArray;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic, retain) Doctors *pmaster;

-(IBAction)requestWithdrawal:(id)sender;


@end
