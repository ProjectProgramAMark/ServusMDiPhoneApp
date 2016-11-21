//
//  ShortQuestViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppController.h"
#import "BaseViewController.h"
#import "TalkConditionsViewController.h"
#import "TermsViewController.h"
@interface ShortQuestViewController : BaseViewController <UITextFieldDelegate, UITabBarDelegate> {
    IBOutlet UIProgressView *docProgress;
    IBOutlet UILabel *patientName;
    IBOutlet UILabel *patientLocation;
    IBOutlet UITextField *patientTele;
    IBOutlet UITextField *choseText;
    IBOutlet UISegmentedControl *primaryPhysician;
    IBOutlet UIPickerView *whatPicker;
       IBOutlet UIButton *showTermsButton;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}


@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic, retain) PMaster *pmaster;
@property (nonatomic) IBOutlet UITabBar *bottomTab;


- (IBAction)showTerms:(id)sender;

@end
