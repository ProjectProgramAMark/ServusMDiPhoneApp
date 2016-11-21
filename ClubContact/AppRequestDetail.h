//
//  AppRequestDetail.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chameleon.h"
#import "RequestAppointments.h"
#import "AppController.h"

@class AppRequestDetail;             //define class, so protocol can see MyClass
@protocol AppRequestDetailDelegate <NSObject>   //define delegate protocol
- (void) refreshPationInfo;  //define delegate method to be implemented within another class
@end //end

@interface AppRequestDetail : UIViewController {
    IBOutlet UIButton *acceptButton;
    IBOutlet UIButton *declineButton;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *teleLabel;
    IBOutlet UILabel *emailLabel;
    
    IBOutlet UITextView *noteText;
    
    IBOutlet UILabel *nameLabel1;
    IBOutlet UILabel *fromTimeLabel1;
    IBOutlet UILabel *toTimeLabel1;
    IBOutlet UILabel *monthLabel1;
    IBOutlet UILabel *dayLabel1;
    IBOutlet UIImageView *profIMG;
    IBOutlet UIVisualEffectView *profBlurEffect;
    
}

@property (nonatomic, retain) RequestAppointments *appRequest;

@property (nonatomic, weak) id <AppRequestDetailDelegate> delegate;
@end
