//
//  ConditionListViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 3/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConditionsTableViewCell.h"
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"
#import "AllergyListViewController.h"
#import "PatientRecordAboutCell.h"
#define kPatientsCellID @"cell"
#import "NewGreenTableViewCell.h"


@class ConditionListViewController;             //define class, so protocol can see MyClass
@protocol ConditionsListDelegate <NSObject>   //define delegate protocol
- (void) refreshMedicationAdd;  //define delegate method to be implemented within another class
@end

@interface ConditionListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate> {
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;

    
    IBOutlet UISearchBar *searchCondition;
    IBOutlet UITableView *conditionTable;

        int currentPage;
    
    int offSetKeyboard;
    
    CGRect keyboardFrame;
    
    BOOL isOffSet;
    
}

@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIView *msgInPutView;
@property (weak, nonatomic) IBOutlet UIButton *sendChatBtn;

@property (strong, nonatomic) NSMutableArray *conditionsArray;

@property (strong, nonatomic) NSMutableArray *addedConditionsArray;

@property (nonatomic, retain) Patient *patient;

@property (nonatomic, weak) id <ConditionsListDelegate> delegate;

@end
