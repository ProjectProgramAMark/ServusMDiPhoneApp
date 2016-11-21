//
//  AddAllergyViewController.h
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
#import "PatientRecordAboutCell.h"
#import "Flurry.h"
#import "BaseViewController.h"
#import "NewGreenTableViewCell.h"
@class AddAllergyViewController;             //define class, so protocol can see MyClass
@protocol AddAllergyDelegate <NSObject>   //define delegate protocol
- (void) refreshPatientAllergy;  //define delegate method to be implemented within another class
@end //end

#define kPatientsCellID @"cell"

@interface AddAllergyViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    
    IBOutlet UISearchBar *searchCondition;
    IBOutlet UITableView *conditionTable;
    
    NSString *patientID;
    
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
@property (nonatomic, retain)  NSString *patientID;

@property (nonatomic, weak) id <AddAllergyDelegate> delegate;
@property (strong, nonatomic) AllergenSearchAPIClient *allergenClient;

@end
