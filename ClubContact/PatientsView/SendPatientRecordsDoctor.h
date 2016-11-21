//
//  SendPatientRecordsDoctor.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/10/15.
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

@interface SendPatientRecordsDoctor : BaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIAlertViewDelegate> {
    IBOutlet UITableView *doctorsTable;
    IBOutlet UISearchBar *doctorSearch;
    
    int currentPage;
    BOOL isPasscodeUpdate;
    Doctors  *doctorSend;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    UIToolbar *toolbar;
    
    BOOL isRefresshing;
    BOOL isMaxLimit;

    
    
}
@property (strong, nonatomic) NSMutableArray *conditionsArray;

@property (strong, nonatomic) NSMutableArray *addedConditionsArray;
@property (nonatomic) NSMutableArray *selectedConditions;
@property (nonatomic) NSMutableArray *selectedAllergens;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic) Pharmacy *pharmacy;

@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) PatientLinks *patientInfo;
@property (nonatomic, retain) Patient *profPatient;
@end
