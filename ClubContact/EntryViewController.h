//
//  EntryViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/23/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//


#import "BaseViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "LoginViewController.h"
#import "AppController.h"
#import "Chameleon.h"
#import "LoginPatientViewController.h"

@interface EntryViewController : BaseViewController <UIAlertViewDelegate> {
    IBOutlet UIButton *doctorButton;
    IBOutlet UIButton *patientButton;
    IBOutlet UIImageView *doctorImage;
    IBOutlet UIImageView *patientImage;
    
    BOOL isDoctorPassCode;
}

@end
