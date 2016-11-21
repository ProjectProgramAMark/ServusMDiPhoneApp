//
//  DocProfileInfoViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/12/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctors.h"

@interface DocProfileInfoViewController : UIViewController {
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UILabel *specialityLabel;
    IBOutlet UILabel *residencyLabel;
    IBOutlet UILabel *costLabel;
    IBOutlet UILabel *schoolLabel;
    IBOutlet UILabel *experienceLabel;
    IBOutlet UILabel *fromLabel;
    
}

@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic) BOOL isConsultation;

@end
