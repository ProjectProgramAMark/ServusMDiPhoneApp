//
//  SpecialitySelectorViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/30/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConditionsTableViewCell.h"


@class SpecialitySelectorViewController;             //define class, so protocol can see MyClass
@protocol SpecialitySelectorDelegate <NSObject>   //define delegate protocol
- (void) specialitySelectDone:(NSString *)speciality;  //define delegate method to be implemented within another class
@end

@interface SpecialitySelectorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    IBOutlet UISearchBar *searchCondition;
    IBOutlet UITableView *conditionTable;
    
    int currentPage;
    
    BOOL isSearchInProgress;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (strong, nonatomic) NSMutableArray *conditionsArray;
@property (strong, nonatomic) NSMutableArray *arraySearchResults;

@property (nonatomic, weak) id <SpecialitySelectorDelegate> delegate;

@end
