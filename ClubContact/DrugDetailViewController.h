//
//  DrugDetailViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drug.h"
#import "MonoGraph.h"
#import "PatientEdicationAPIClient.h"
#import "Ingrediant.h"
#import "Chameleon.h"
#import "Allergen.h"
#import "Condition.h"
#import "AppController.h"
#import "ContradictionAPIClient.h"
#import "SendPrescriptionController.h"
#import "SendPrescriptioniPhoneViewController.h"

@class DrugDetailViewController;             //define class, so protocol can see MyClass
@protocol DrugDetailListDelegate <NSObject>   //define delegate protocol
- (void) refreshMedicationAdd;  //define delegate method to be implemented within another class
@end

@interface DrugDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
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

@property (nonatomic) Drug *drug;

@property (nonatomic, retain) Patient *patient;

@property (nonatomic, weak) id <DrugDetailListDelegate> delegate;

@end
