//
//  CalendarPatientViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CalendarKit.h"
#import "CKCalendarViewController.h"
#import "AppController.h"
#import "Chameleon.h"
#import "CalendarDetailViewController.h"
#import "CreateNewEventViewController.h"
#import "PMasterNewAppViewController.h"
#import "PMasterCalDetailsViewController.h"
#import "TalkCreateViewController.h"
#import "CalendarRecViewController.h"

@interface CalendarPatientViewController : UIViewController  {
    CKCalendarView *calendar;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (strong, nonatomic) NSMutableArray *patientsArray;

@property (nonatomic, retain) PatientLinks *patientLink;
@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) NSMutableDictionary *plinkDict;

@end
