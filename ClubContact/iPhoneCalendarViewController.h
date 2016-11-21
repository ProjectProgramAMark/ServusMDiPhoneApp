//
//  iPhoneCalendarViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/19/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "CalendarKit.h"
#import "CKCalendarViewController.h"
#import "AppController.h"
#import "Chameleon.h"
#import "CalendarDetailViewController.h"
#import "CreateNewEventViewController.h"


@interface iPhoneCalendarViewController : UIViewController <CreateNewEventViewDelegate> {
    CKCalendarView *calendar;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}
@end
