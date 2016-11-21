//
//  MesRecDoctorViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DashboardDoctorCell.h"
#import "DashboardCollectionCelliPhone.h"
#import "DashboardCollectionCell.h"
#import "PMaster.h"
#import "DoctorProfilePatientViC.h"
#import "Pharmacy.h"
#import "TalkDoctorProfileViewController.h"
#import "MesDocProfileViewController.h"
#import "DoctorCellV2.h"
@interface MesRecDoctorViewController :  BaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SWTableViewCellDelegate> {
    IBOutlet UITableView *doctorsTable;
    IBOutlet UISearchBar *doctorSearch;
    
    int currentPage;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    UIToolbar *toolbar;
}
@property (strong, nonatomic) NSMutableArray *conditionsArray;

@property (strong, nonatomic) NSMutableArray *addedConditionsArray;
@property (nonatomic) NSMutableArray *selectedConditions;
@property (nonatomic) NSMutableArray *selectedAllergens;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic) Pharmacy *pharmacy;
@end
