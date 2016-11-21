//
//  RefillDetailsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/18/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "Chameleon.h"
#import "PatientMedication.h"
#import "Refills.h"
#import "Patient.h"
#import "PatientRecordAboutCell.h"

@class RefillDetailsViewController;             //define class, so protocol can see MyClass
@protocol RefillDetailsDelegate <NSObject>   //define delegate protocol
- (void) refreshRefillMedication;  //define delegate method to be implemented within another class
@end

@interface RefillDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
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
}

@property (nonatomic, retain) PatientMedication *patientMedication;
@property (nonatomic, retain) Patient *patient;
@property (nonatomic, retain) Refills *refill;

@property (nonatomic, weak) id <RefillDetailsDelegate> delegate;

@end
