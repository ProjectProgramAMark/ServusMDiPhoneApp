//
//  AppointmentDetailViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/16/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFEvent.h"
#import "AppController.h"
@protocol AppointmentDetailProtocol <NSObject>
@required
//- (void)showEditViewWithEvent:(FFEvent *)_event;
- (void)refreshCalendar;

@end


@interface AppointmentDetailViewController : UIViewController

@property (nonatomic, strong) id<AppointmentDetailProtocol> protocol;
@property (nonatomic, strong) UIButton *buttonEditPopover;
@property (nonatomic, strong) FFEvent *event;


@end
