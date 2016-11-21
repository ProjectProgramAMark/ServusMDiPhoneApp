//
//  TalkDoctorTypeViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
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
#import "TalkPharmcyViewController.h"


@interface TalkDoctorTypeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITabBarDelegate> {
    
    IBOutlet UISearchBar *searchCondition;
    IBOutlet UITableView *conditionTable;
    
    int currentPage;
    
     BOOL isSearchInProgress;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}
@property (strong, nonatomic) NSMutableArray *conditionsArray;
@property (strong, nonatomic) NSMutableArray *allergenArray;
@property (strong, nonatomic) NSMutableArray *addedConditionsArray;
@property (nonatomic , strong)NSMutableArray *arraySearchResults;

@property (strong, nonatomic) AllergenSearchAPIClient *allergenClient;

@property (nonatomic) NSMutableArray *selectedConditions;
@property (nonatomic) Pharmacy *pharmacy;
@property (nonatomic) IBOutlet UITabBar *bottomTab;



@end
