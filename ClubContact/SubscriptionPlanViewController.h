//
//  SubscriptionPlanViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/16/15.
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
#import "AppController.h"

@protocol  SubscriptionPlanViewController <NSObject>
- (void)paymentComplated:(NSString *)sender;

@end


@interface SubscriptionPlanViewController : BaseViewController <STPCheckoutViewControllerDelegate, NSURLConnectionDelegate> {
    
    int subcriptionType;
    NSMutableData *responseData;
    
    IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    IBOutlet UILabel *planLabel;
    IBOutlet UILabel *fullNameLabel;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    IBOutlet UIView *profileArea;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (weak, nonatomic) id<SubscriptionPlanViewController> delegate;
@property (nonatomic) BOOL isRegisteredUser;
@property (nonatomic) int patientCount;

@property (nonatomic) NSString *docID;
@property (nonatomic, retain) Doctors *pmaster;

- (IBAction)subscribeProPlan:(id)sender;
- (IBAction)subscribeBasicPlan:(id)sender;

@end
