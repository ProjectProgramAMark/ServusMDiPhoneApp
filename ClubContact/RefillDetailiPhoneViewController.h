//
//  RefillDetailiPhoneViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "Chameleon.h"
#import "PatientMedication.h"
#import "Refills.h"
#import "Patient.h"
#import "PatientRecordAboutCell.h"
#import "PatientDetailViewController.h"
@class RefillDetailiPhoneViewController;             //define class, so protocol can see MyClass
@protocol RefillDetailsiPhoneDelegate <NSObject>   //define delegate protocol
- (void) refreshRefillMedication;  //define delegate method to be implemented within another class
@end
@interface RefillDetailiPhoneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>  {
    
    IBOutlet UILabel *drugName;
    IBOutlet UILabel *doseLabel;
    IBOutlet UILabel *pharmacyName;
    IBOutlet UILabel *pharmcyAddress;
    IBOutlet UILabel *statusLabel;
    IBOutlet UILabel *sentLabel;
    IBOutlet UILabel *updateLabel;
    
    IBOutlet UIButton *acceptedButton;
    IBOutlet UIButton *declineButton;
    
      IBOutlet UITableView *menuTable;
    
    IBOutlet UIImageView *profileIMGView2;
    
    IBOutlet UILabel *nameLabel2;
    IBOutlet UILabel *jobLabel2;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (nonatomic, retain) PatientMedication *patientMedication;
@property (nonatomic, retain) Patient *patient;
@property (nonatomic, retain) Refills *refill;
@property (nonatomic) BOOL isRefill;

@property (nonatomic, weak) id <RefillDetailsiPhoneDelegate> delegate;




@end
