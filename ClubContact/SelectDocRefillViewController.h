//
//  SelectDocRefillViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "DashboardDoctorCell.h"
#import "PatientRecordProfViewController.h"
#import "PatientRecMedicationViewController.h"
#import "SelectRecMedViewController.h"

@class SelectDocRefillViewController;             //define class, so protocol can see MyClass
@protocol SelectDocRefillDelegate <NSObject>   //define delegate protocol
- (void) refreshRefillMedication;  //define delegate method to be implemented within another class
@end

@interface SelectDocRefillViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *doctorsTable;
    
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    
}

@property (strong, nonatomic) NSMutableArray *patientsArray;


@property (nonatomic, weak) id <SelectDocRefillDelegate> delegate;

@end
