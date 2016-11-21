//
//  CalendarRecViewController.h
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
#import "CalendarPatientViewController.h"
#import "TalkCreateViewController.h"
#import "MesDocProfileViewController.h"
#import "ShortQuestViewController.h"
#import "DoctorProfilePatientViC.h"
#import "DoctorCellV2.h"
@class CalendarRecViewController;             //define class, so protocol can see MyClass
@protocol CalendarRecDelegate <NSObject>   //define delegate protocol
- (void) refreshCalendar;  //define delegate method to be implemented within another class
@end

@interface CalendarRecViewController :  BaseViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *doctorsTable;
    
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    
}

@property (strong, nonatomic) NSMutableArray *patientsArray;


@property (nonatomic, weak) id <CalendarRecDelegate> delegate;


@end
