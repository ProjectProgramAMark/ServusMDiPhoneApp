//
//  AddAppointmentViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/16/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"
#import "PatientsViewController.h"
#import "AppController.h"

@protocol AddAppointmentViewControllerDelegate <NSObject>
@required
//- (void)addNewEvent:(FFEvent *)eventNew;
- (void)refreshCalendar;
@end

@interface AddAppointmentViewController : UIViewController {
    NSString *patientFullName;
    NSString *patientID;
    NSString *fromdate;
    NSString *todate;
    NSString *titleString;
    NSString *noteString;
    
}

@property (nonatomic, strong) id<AddAppointmentViewControllerDelegate> protocol;
@property (nonatomic, strong) NSString *patientFullName;
@property (nonatomic, strong) NSString *patientID;
@property (nonatomic, strong) UIButton *patientButton;
@property (nonatomic, strong) UIButton *buttonCancel;
@property (nonatomic, strong) UIButton *buttonDone;



@end
