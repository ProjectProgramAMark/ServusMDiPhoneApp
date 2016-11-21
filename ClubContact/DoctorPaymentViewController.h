//
//  DoctorPaymentViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
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
@interface DoctorPaymentViewController : BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, STPCheckoutViewControllerDelegate, NSURLConnectionDelegate> {
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
}

@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic, retain) Doctors *pmaster;

-(IBAction)requestWithdrawal:(id)sender;


@end
