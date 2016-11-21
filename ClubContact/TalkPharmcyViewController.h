//
//  TalkPharmcyViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PharmacyListCell.h"
#import "AppController.h"
#import "MJRefresh.h"
#import "Allergen.h"
#import "AllergenSearchAPIClient.h"
#import "DrugsViewController.h"
#import "DeviceInfo.h"
#import "SearchPharmacyAPIClient.h"
#import <CoreLocation/CoreLocation.h>
#import "TalkDoctorViewController.h"
#import "TalkDoctorTypeViewController.h"
#import "PharmacyTableViewCell.h"
#import "DashboardPatientViewController.h"
#import "TalkConditionsViewController.h"
#import "TalkAllergyViewController.h"
#define kPatientsCellID @"cell"
#import "PharmacyNewTableViewCell.h"


@interface TalkPharmcyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate, UITabBarDelegate> {
    
    IBOutlet UISearchBar *searchCondition;
    IBOutlet UITableView *conditionTable;
    
    CLLocation *location;
    
    NSString *cityText;
    NSString *countryText;
    
    int currentPage;
    
    BOOL isNotLoaded;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}
@property (strong, nonatomic) NSMutableArray *conditionsArray;

@property (strong, nonatomic) NSMutableArray *addedConditionsArray;
@property (strong, nonatomic) NSMutableArray *pharmacySelectedArray;

@property (strong, nonatomic) AllergenSearchAPIClient *allergenClient;

@property (nonatomic) NSMutableArray *selectedConditions;
@property (nonatomic) NSMutableArray *selectedAllergens;

@property (nonatomic, retain) Patient *patient;

@property (nonatomic, weak) id <PharmacySelecterDelegate> delegate;

@property (nonatomic,strong) CLLocationManager *locationManager;


@property (strong, nonatomic) SearchPharmacyAPIClient *pharmacyClient;
@property (nonatomic) IBOutlet UITabBar *bottomTab;



@end
