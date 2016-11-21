//
//  RearViewPatientViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/11/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientRecordsViewController.h"
#import "MyProfileConsultationHistory.h"
#import "PaymentsPageViewController.h"
#import "MyProfileMessageHistory.h"
#import "CalendarPatientViewController.h"
#import "DashboardPatientViewController.h"

@interface RearViewPatientViewController : UIViewController <QBRTCClientDelegate> {
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
}

@end
