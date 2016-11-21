//
//  AppRequestiPhoneViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chameleon.h"
#import "RequestAppointments.h"
#import "AppController.h"
#import "PatientRecordAboutCell.h"
#import "SharedPatientProfileViewController.h"
#import "Doctor.h"
@class AppRequestiPhoneViewController;             //define class, so protocol can see MyClass
@protocol AppRequestDetailiPhoneDelegate <NSObject>   //define delegate protocol
- (void) refreshPationInfo;  //define delegate method to be implemented within another class
@end //end



@interface AppRequestiPhoneViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UIButton *acceptButton;
    IBOutlet UIButton *declineButton;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *teleLabel;
    IBOutlet UILabel *emailLabel;
    IBOutlet UILabel *jobLabel;
    
    IBOutlet UILabel *noteText;
    
    IBOutlet UILabel *nameLabel1;
    IBOutlet UILabel *fromTimeLabel1;
    IBOutlet UILabel *toTimeLabel1;
    IBOutlet UILabel *monthLabel1;
    IBOutlet UILabel *dayLabel1;
    IBOutlet UIImageView *profIMG;
    IBOutlet UIVisualEffectView *profBlurEffect;
   IBOutlet UIImageView *profIMG2;
    
     IBOutlet UITableView *menuTable;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;

    
}


@property (nonatomic, retain) RequestAppointments *appRequest;

@property (nonatomic, weak) id <AppRequestDetailiPhoneDelegate> delegate;

@end
