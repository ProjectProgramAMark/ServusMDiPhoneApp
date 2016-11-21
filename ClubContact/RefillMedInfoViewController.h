//
//  RefillMedInfoViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Drug.h"
#import "MonoGraph.h"
#import "PatientEdicationAPIClient.h"
#import "Ingrediant.h"
#import "Chameleon.h"
#import "Allergen.h"
#import "Condition.h"
#import "AppController.h"
#import "ContradictionAPIClient.h"
#import "PatientMedication.h"
#import "DrugSearchAPIClient.h"
#import "Refills.h"
#import "RefillDetailsViewController.h"
#import "RefillDetailiPhoneViewController.h"

@class RefillMedInfoViewController;             //define class, so protocol can see MyClass
@protocol RefillMedInfoDelegate <NSObject>   //define delegate protocol
- (void) refreshRefillMedication;  //define delegate method to be implemented within another class
@end

@interface RefillMedInfoViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UITableView *drugDetailTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
}

@property (nonatomic) NSMutableArray *selectedConditions;

@property (nonatomic) NSMutableArray *patientConditions;

@property (nonatomic) NSMutableArray *selectedAllergens;
@property (nonatomic) NSMutableArray *contradictedConditions;

@property (nonatomic) NSMutableArray *monoGraphArray;
@property (nonatomic) PatientEdicationAPIClient *monoClient;
@property (nonatomic) ContradictionAPIClient *concClient;
@property (strong, nonatomic) DrugSearchAPIClient *drugClient;

@property (nonatomic) Drug *drug;

@property (nonatomic) PatientMedication *medication;

@property (nonatomic, retain) Patient *patient;

@property (nonatomic, weak) id <RefillMedInfoDelegate> delegate;
@property (nonatomic, retain) PatientLinks *patientLink;
@end
