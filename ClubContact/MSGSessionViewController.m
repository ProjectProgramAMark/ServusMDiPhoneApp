//
//  MSGSessionViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MSGSessionViewController.h"

@interface MSGSessionViewController ()

@end

@implementation MSGSessionViewController



@synthesize msgSession;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPop)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
    self.navigationController.navigationBar.barTintColor = [UIColor flatWhiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self setNeedsStatusBarAppearanceUpdate];
    
     self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"SESSION DETAILS";
    
  /*  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidAppear:(BOOL)animated {
    [profileIMG setImageWithURL:[NSURL URLWithString:msgSession.profileimg]];
    
    profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
    profileIMG.layer.masksToBounds = YES;
    // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
    // cell.profileIMG.layer.borderWidth = 3.0;
    
    nameLabel.text = [NSString stringWithFormat:@"%@ %@", msgSession.pfirstname, msgSession.plastname];
    //cell.messageCountLabel.text = patientInfo.msgCount;
    emailText.text = [NSString stringWithFormat:@"%@", msgSession.pmail];
    
    noteText.text = [NSString stringWithFormat:@"%@", msgSession.mnote];
    
    if ([msgSession.mstatus isEqual:@"0"]) {
        sessionStatus.text = @"Pending";
        sessionStatus.textColor = [UIColor flatGrayColor];
        acceptButton.hidden = false;
        declineButton.hidden = false;
        visitButton.hidden = true;
        
    } else if ([msgSession.mstatus isEqual:@"1"]) {
        sessionStatus.text = @"Accepted";
        sessionStatus.textColor = [UIColor flatGreenColor];
        acceptButton.hidden = true;
        declineButton.hidden = true;
        visitButton.hidden = false;
    } else if ([msgSession.mstatus isEqual:@"2"]) {
        sessionStatus.text = @"Declined";
        sessionStatus.textColor = [UIColor flatRedColor];
        acceptButton.hidden = true;
        declineButton.hidden = true;
        visitButton.hidden = true;
    } else if ([msgSession.mstatus isEqual:@"3"]) {
        sessionStatus.text = @"Closed";
        sessionStatus.textColor = [UIColor flatRedColor];
        acceptButton.hidden = true;
        declineButton.hidden = true;
        visitButton.hidden = true;
    }
    

}

- (void)cancelPop {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)acceptMSGSession:(id)sender {
      [self dismissViewControllerAnimated:NO completion:nil];
    [[AppController sharedInstance] acceptMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message)  {
        if (success) {
            [self.delegate acceptedSession:msgSession];
          
        }
    }];
  
    
}

- (IBAction)declineMSGSession:(id)sender {
    [[AppController sharedInstance] declineMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message)  {
        if (success) {
            [self.delegate declinedSession];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
   
}

- (IBAction)visitMSGSession:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if ([msgSession.mstatus isEqual:@"3"]) {
         [self.delegate visitClosedSession:msgSession];
    } else {
    [self.delegate visitSession:msgSession];
        
    }
}




@end
