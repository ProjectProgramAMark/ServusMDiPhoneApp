//
//  DocMSGSessionViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/13/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DocMSGSessionViewController.h"

@interface DocMSGSessionViewController ()

@end

@implementation DocMSGSessionViewController


@synthesize msgSession;
@synthesize delegate;
@synthesize isMySession;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPop)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    */
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"SESSION DETAILS";
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop)];*/
     UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    if (isMySession == true) {
        [profileIMG setImageWithURL:[NSURL URLWithString:msgSession.dprofileimg]];
        
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
        profileIMG.layer.masksToBounds = YES;
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        
        nameLabel.text = [NSString stringWithFormat:@"%@ %@", msgSession.dfirstname, msgSession.dfirstname];
        //cell.messageCountLabel.text = patientInfo.msgCount;
        emailText.text = [NSString stringWithFormat:@"%@", msgSession.dmail];
        
        noteText.text = @"";

    } else {
    [profileIMG setImageWithURL:[NSURL URLWithString:msgSession.profileimg]];
    
    profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
    profileIMG.layer.masksToBounds = YES;
    // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
    // cell.profileIMG.layer.borderWidth = 3.0;
    
    nameLabel.text = [NSString stringWithFormat:@"%@ %@", msgSession.pfirstname, msgSession.plastname];
    //cell.messageCountLabel.text = patientInfo.msgCount;
    emailText.text = [NSString stringWithFormat:@"%@", msgSession.pmail];
    
    noteText.text = @"";
        
    }
    
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
    
    if (isMySession == true) {
        acceptButton.hidden = true;
        declineButton.hidden = true;
        visitButton.hidden = false;
    }
    
    
}

- (void)cancelPop {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)acceptMSGSession:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [[AppController sharedInstance] acceptDocMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message) {
        if (success) {
            [self.delegate acceptedSession:msgSession];
            
        }
    }];
    
    
    
}

- (IBAction)declineMSGSession:(id)sender {
   /* [[AppController sharedInstance] declineMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message)  {
        if (success) {
            [self.delegate declinedSession];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];*/
    
    [[AppController sharedInstance] declineDocMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message) {
        if (success) {
            [self.delegate declinedSession];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
    
}

- (IBAction)visitMSGSession:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate visitSession:msgSession];
}




@end
