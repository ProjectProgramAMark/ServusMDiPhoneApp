//
//  FFAddEventPopoverController.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/25/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>

#import "FFEvent.h"
#import "PatientsViewController.h"
#import "AppController.h"

@protocol FFAddEventPopoverControllerProtocol <NSObject>
@required
- (void)addNewEvent:(FFEvent *)eventNew;
- (void)refreshCalendar;
@end


@interface FFAddEventPopoverController : UIPopoverController {
    NSString *patientFullName;
    NSString *patientID;
    NSString *fromdate;
    NSString *todate;
    NSString *titleString;
    NSString *noteString;
    
}

@property (nonatomic, strong) id<FFAddEventPopoverControllerProtocol> protocol;
@property (nonatomic, strong) NSString *patientFullName;
@property (nonatomic, strong) NSString *patientID;
@property (nonatomic, strong) UIButton *patientButton;
@property (nonatomic, strong) UIButton *buttonCancel;
@property (nonatomic, strong) UIButton *buttonDone;

- (id)initPopover;

@end
