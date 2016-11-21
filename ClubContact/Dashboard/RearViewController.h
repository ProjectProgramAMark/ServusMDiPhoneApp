//
//  RearViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/20/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Chameleon.h"
#import "UIImageView+WebCache.h"
#import "Doctor.h"
#import "DoctorProfileViewController.h"
#import "PatientsViewController.h"
#import "RequestsViewController.h"
#import "iPhoneCalendarViewController.h"
#import "MessagePatientsList.h"
#import "DoctorPaymentViewController.h"
#import "PatientListNewViewController.h"
#import "DoctorPaymentsNewController.h"
#import "DashboardV2ViewController.h"
#import "UnifiedRequestsViewController.h"

@interface RearViewController : BaseViewController {
    IBOutlet UIImageView *profIMGView;
    IBOutlet UILabel *nameLabel;
}



@property (strong, nonatomic) Doctors *doctor;

- (IBAction)goToConsultationRequests:(id)sender ;

@end
