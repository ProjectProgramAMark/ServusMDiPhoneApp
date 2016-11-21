//
//  PharmacySelectController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
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
#import "PharmacyTableViewCell.h"

#define kPatientsCellID @"cell"

@class PharmacySelectController;             //define class, so protocol can see MyClass
@protocol PharmacySelecterDelegate <NSObject>   //define delegate protocol
- (void) pharmacySelected:(Pharmacy *)pharm;  //define delegate method to be implemented within another class
@end

@interface PharmacySelectController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate> {
    
    IBOutlet UISearchBar *searchCondition;
    IBOutlet UITableView *conditionTable;
    
    CLLocation *location;
    
    NSString *cityText;
    NSString *countryText;
    
    int currentPage;
    
    BOOL isNotLoaded;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
}
@property (strong, nonatomic) NSMutableArray *conditionsArray;

@property (strong, nonatomic) NSMutableArray *addedConditionsArray;

@property (strong, nonatomic) AllergenSearchAPIClient *allergenClient;

@property (nonatomic) NSMutableArray *selectedConditions;

@property (nonatomic, retain) Patient *patient;

@property (nonatomic, weak) id <PharmacySelecterDelegate> delegate;

@property (nonatomic,strong) CLLocationManager *locationManager;


@property (strong, nonatomic) SearchPharmacyAPIClient *pharmacyClient;

@end
