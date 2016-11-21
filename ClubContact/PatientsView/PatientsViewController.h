//
//  PatientsViewController.h
//  ClubContact
//
//  Created by wangkun on 15/3/11.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AddConditionsViewController.h"
#import "Chameleon.h"
#import "MSGPatientGridCell.h"
#import "UIImageView+WebCache.h"
#import "MSGPatientGridCelliPhone.h"
#import "AddPatientiPhoneViewController.h"
#import "DashboardPatientTableViewCell.h"


@class PatientsViewController;             //define class, so protocol can see MyClass
@protocol PatientsViewControllerDelegate <NSObject>   //define delegate protocol
- (void) patientAppointmentAdded:(NSString *)paitentname patientid:(NSString *)patientid;  //define delegate method to be implemented within another class
@end

@interface PatientsViewController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    IBOutlet UITableView *menuTable;
    
    
}

@property (nonatomic) BOOL shouldPatientSelect;
@property (nonatomic, weak) id <PatientsViewControllerDelegate> delegate;

@end
