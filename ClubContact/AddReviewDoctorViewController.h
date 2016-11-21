//
//  AddReviewDoctorViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "BaseViewController.h"
#import "Doctors.h"
#import "Patient.h"

@interface AddReviewDoctorViewController : BaseViewController {
    IBOutlet UISegmentedControl *starControll;
    IBOutlet UITextField *reviewText;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
}


@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) PatientLinks *patientInfo;
@property (nonatomic, retain) Patient *profPatient;


@end
