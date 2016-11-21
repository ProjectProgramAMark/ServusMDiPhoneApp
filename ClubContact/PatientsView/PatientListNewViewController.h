//
//  PatientListNewViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/24/15.
//  Copyright © 2015 askpi. All rights reserved.
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
#import "SWTableViewCell.h"
#import "EditPatientViewController.h"
#import "MedicationPListViewController.h"
#import "PatientAppointmentViewController.h"
@class PatientListNewViewController;             //define class, so protocol can see MyClass
@protocol PatientListNewViewControllerDelegate <NSObject>   //define delegate protocol
- (void) patientAppointmentAdded:(NSString *)paitentname patientid:(NSString *)patientid;  //define delegate method to be implemented within another class
@end

@interface PatientListNewViewController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate,SWTableViewCellDelegate> {
    UIBarButtonItem * addButton;
    BOOL shouldPatientSelect;
    
    IBOutlet UICollectionView *patientsGrid;
    IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *menuButton;
     IBOutlet UIView *menuButton2;
    IBOutlet UIView *notificationButton;
    BOOL isRefresshing;
    BOOL isMaxLimit;
}

@property (nonatomic) BOOL shouldPatientSelect;
@property (nonatomic, weak) id <PatientListNewViewControllerDelegate> delegate;

@end
