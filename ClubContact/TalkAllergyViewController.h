//
//  TalkAllergyViewController.h
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
#import "TalkConditionsViewController.h"
#import "ConditionsTableViewCell.h"
@interface TalkAllergyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITabBarDelegate> {
    
    IBOutlet UISearchBar *searchCondition;
    IBOutlet UITableView *conditionTable;
    
    int currentPage;
    
    int offSetKeyboard;
    
    CGRect keyboardFrame;
    
    BOOL isOffSet;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}


@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIView *msgInPutView;
@property (weak, nonatomic) IBOutlet UIButton *sendChatBtn;

@property (strong, nonatomic) NSMutableArray *conditionsArray;

@property (strong, nonatomic) NSMutableArray *addedConditionsArray;

@property (strong, nonatomic) AllergenSearchAPIClient *allergenClient;

@property (nonatomic) NSMutableArray *selectedConditions;
@property (nonatomic) IBOutlet UITabBar *bottomTab;

- (IBAction)sendMessageNow:(id)sender;


@end
