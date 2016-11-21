//
//  AllergyListViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllergyListTableViewCell.h"
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"
#import "Allergen.h"
#import "AllergenSearchAPIClient.h"
#import "DrugsViewController.h"
#import "PatientRecordAboutCell.h"
#import "NewGreenTableViewCell.h"

#define kPatientsCellID @"cell"

@class AllergyListViewController;             //define class, so protocol can see MyClass
@protocol AllergyListDelegate <NSObject>   //define delegate protocol
- (void) refreshMedicationAdd;  //define delegate method to be implemented within another class
@end

@interface AllergyListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    
    IBOutlet UISearchBar *searchCondition;
    IBOutlet UITableView *conditionTable;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;

    
    int currentPage;
}
@property (strong, nonatomic) NSMutableArray *conditionsArray;

@property (strong, nonatomic) NSMutableArray *addedConditionsArray;

@property (strong, nonatomic) AllergenSearchAPIClient *allergenClient;

@property (nonatomic) NSMutableArray *selectedConditions;

@property (nonatomic, retain) Patient *patient;

@property (nonatomic, weak) id <AllergyListDelegate> delegate;

@end
