//
//  DrugsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"
#import "Drug.h"
#import "DrugSearchAPIClient.h"
#import "DrugListCell.h"
#import "DrugDetailViewController.h"
#import "DrugIndicationsSearchAPIClient.h"
#import "Condition.h"
#import "PatientRecordAboutCell.h"
#import "Flurry.h"
#import "NewGreenTableViewCell.h"
#define kPatientsCellID @"cell"

@class DrugsViewController;             //define class, so protocol can see MyClass
@protocol DrugsListDelegate <NSObject>   //define delegate protocol
- (void) refreshMedicationAdd;  //define delegate method to be implemented within another class
@end

@interface DrugsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate > {
    
    IBOutlet UISearchBar *searchDrugs;
    IBOutlet UITableView *drugsTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    int currentPage;
}
@property (strong, nonatomic) NSMutableArray *conditionsArray;

@property (strong, nonatomic) NSMutableArray *addedConditionsArray;

@property (strong, nonatomic) DrugSearchAPIClient *drugClient;
@property (strong, nonatomic) DrugIndicationsSearchAPIClient *drugIndicationsClient;

@property (nonatomic) NSMutableArray *selectedConditions;

@property (nonatomic) NSMutableArray *selectedAllergens;

@property (nonatomic) BOOL isMedPres;

@property (nonatomic, retain) Patient *patient;

@property (nonatomic, weak) id <DrugsListDelegate> delegate;

@end
