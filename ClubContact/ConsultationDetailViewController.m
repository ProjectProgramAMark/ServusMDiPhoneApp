//
//  ConsultationDetailViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "ConsultationDetailViewController.h"

@interface ConsultationDetailViewController ()

@end

@implementation ConsultationDetailViewController

@synthesize delegate;
@synthesize nameLabel1;
@synthesize consultation;
@synthesize fromTimeLabel1;
@synthesize monthLabel1;
@synthesize dayLabel1;
@synthesize emailLabel;
@synthesize linkButton;
@synthesize linkLabel;
@synthesize acceptButton;
@synthesize declineButton;
@synthesize cStatus;
@synthesize costLabel;
@synthesize noteText;
@synthesize profBlurEffect;
@synthesize profIMG;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
  /*  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPop:)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
    self.navigationController.navigationBar.barTintColor = [UIColor flatWhiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Color all navigation items accordingly to new barTintColor
    self.navigationController.navigationBar.tintColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:self.navigationController.navigationBar.barTintColor isFlat:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"CONSULTATION DETAILS";
    
    //[acceptButton setBackgroundColor:[UIColor flatLimeColor]];
    //[declineButton setBackgroundColor:[UIColor flatRedColor]];
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop:)];*/
     UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelPop:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //declineButton.frame = CGRectMake(declineButton.frame.origin.x, declineButton.frame.origin.y, windowWidth/2, declineButton.frame.size.height);
    //acceptButton.frame = CGRectMake(acceptButton.frame.origin.x, acceptButton.frame.origin.y, windowWidth/2, acceptButton.frame.size.height);
    
    
    @try {
        
        double unixTimeStamp =[consultation.consultime doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
    //    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        NSDate* destinationDate = sourceDate;
        
        
        NSString *paitentName = [NSString stringWithFormat:@"Name: %@ %@", consultation.dfirstname, consultation.plastname];
        
        NSDateComponents *fromcomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:destinationDate];
        // NSDateComponents *tocomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:destinationDate2];
        
        NSString *monthname = @"Jan";
        
        if ([fromcomponents month] == 1) {
            monthname = @"Jan";
        } else if ([fromcomponents month] == 2) {
            monthname = @"Feb";
        } else if ([fromcomponents month] == 3) {
            monthname = @"Mar";
        } else if ([fromcomponents month] == 4) {
            monthname = @"Apr";
        } else if ([fromcomponents month] == 5) {
            monthname = @"May";
        } else if ([fromcomponents month] == 6) {
            monthname = @"Jun";
        } else if ([fromcomponents month] == 7) {
            monthname = @"Jul";
        } else if ([fromcomponents month] == 8) {
            monthname = @"Aug";
        } else if ([fromcomponents month] == 9) {
            monthname = @"Sep";
        } else if ([fromcomponents month] == 10) {
            monthname = @"Oct";
        } else if ([fromcomponents month] == 11) {
            monthname = @"Now";
        } else if ([fromcomponents month] == 12) {
            monthname = @"Dec";
        }
        
        NSString *fromHour = @"00";
        NSString *fromMinute = @"00";
        
        if ([fromcomponents hour] < 10) {
            fromHour = [NSString stringWithFormat:@"%i", [fromcomponents hour]];
        } else {
            fromHour = [NSString stringWithFormat:@"%i", [fromcomponents hour]];
        }
        
        if ([fromcomponents minute] < 10) {
            fromMinute = [NSString stringWithFormat:@"0%i", [fromcomponents minute]];
        } else {
            fromMinute = [NSString stringWithFormat:@"%i", [fromcomponents minute]];
        }
        
        
        NSString *fromtime = [NSString stringWithFormat:@"%@:%@", fromHour, fromMinute];
        
        //   NSString *totime = [NSString stringWithFormat:@"%@:%@", toHour, toMinute];
        
        
        
        self.monthLabel1.text = monthname;
        self.fromTimeLabel1.text = fromtime;
        // cell.toTimeLabel1.text = totime;
        self.dayLabel1.text = [NSString stringWithFormat:@"%i", [fromcomponents day]];
        
        
        if ([consultation.ctype isEqual:@"0"]) {
            self.cStatus.text = @"Pending";
            self.cStatus.textColor = [UIColor lightGrayColor];
            linkButton.hidden = true;
            acceptButton.hidden = false;
            declineButton.hidden = false;
            
            
        } else if ([consultation.ctype isEqual:@"1"]) {
            self.cStatus.text = @"Accepted";
            self.cStatus.textColor = [UIColor flatTealColor];
            linkButton.hidden = false;
            acceptButton.hidden = true;
            declineButton.hidden = true;
            
        } else if ([consultation.ctype isEqual:@"2"]) {
            self.cStatus.text = @"Declined";
            self.cStatus.textColor = [UIColor flatRedColor];
            linkButton.hidden =false;
            acceptButton.hidden = true;
            declineButton.hidden = true;
            
        }
        
        profIMG.layer.cornerRadius = profIMG.frame.size.width/2;
        profIMG.layer.masksToBounds = YES;
        
        profBlurEffect.layer.cornerRadius = profBlurEffect.frame.size.width/2;
        profBlurEffect.layer.masksToBounds = YES;
        
        [profIMG setImageWithURL:[NSURL URLWithString:consultation.profileimg]];
        
        self.nameLabel1.text = paitentName;
         self.emailLabel.text = [NSString stringWithFormat:@"Email: %@",consultation.pmail];
        self.linkLabel.text = [NSString stringWithFormat:@"Link: %@",consultation.clink];
         self.costLabel.text = [NSString stringWithFormat:@"Charge: %@ Tokens",consultation.ccost];
        self.noteText.text = [NSString stringWithFormat:@"%@",consultation.cnotes];
    }
    @catch (NSException *exception) {
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)linkClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:consultation.clink]];
}

- (IBAction)acceptClicked:(id)sender {
    [[AppController sharedInstance] acceptConsultation:consultation.postid completion:^(BOOL success, NSString *message) {
        if (success) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.delegate refreshPationInfo];
        }
    }];
}


- (IBAction)declineClicked:(id)sender {
    [[AppController sharedInstance ] declineConsultation:consultation.postid completion:^(BOOL success, NSString *message) {
        if (success) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.delegate refreshPationInfo];
        }
    }];
}

@end
