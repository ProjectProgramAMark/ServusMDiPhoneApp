//
//  AddConditionsViewController.h
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
#import "PatientRecordAboutCell.h"
#import "Flurry.h"
#import "BaseViewController.h"
#import "NewGreenTableViewCell.h"
@class AddConditionsViewController;             //define class, so protocol can see MyClass
@protocol AddConditionsDelegate <NSObject>   //define delegate protocol
- (void) refreshPationInfo;  //define delegate method to be implemented within another class
@end //end

#define kPatientsCellID @"cell"

@interface AddConditionsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    
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

@property (nonatomic, weak) id <AddConditionsDelegate> delegate;

@end
