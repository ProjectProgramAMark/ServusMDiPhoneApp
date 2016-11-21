//
//  AppRequestDetail.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AppRequestDetail.h"
#import "UIImageView+WebCache.h"

@interface AppRequestDetail ()

@end

@implementation AppRequestDetail

@synthesize delegate;
@synthesize appRequest;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.navigationController.navigationBar.barTintColor = [UIColor flatWhiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Color all navigation items accordingly to new barTintColor
    self.navigationController.navigationBar.tintColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:self.navigationController.navigationBar.barTintColor isFlat:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"REQUEST DETAILS";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
   // [acceptButton setBackgroundColor:[UIColor flatLimeColor]];
   // [declineButton setBackgroundColor:[UIColor flatRedColor]];
    
    
    double unixTimeStamp =[appRequest.fromdate doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
   // NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    NSDate* destinationDate = sourceDate;
    
    double unixTimeStamp2 =[appRequest.todate doubleValue];
    NSTimeInterval _interval2=unixTimeStamp2;
    NSDate* sourceDate2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
    NSTimeZone* sourceTimeZone2 = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSTimeZone* destinationTimeZone2 = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset2 = [sourceTimeZone secondsFromGMTForDate:sourceDate2];
    NSInteger destinationGMTOffset2 = [destinationTimeZone2 secondsFromGMTForDate:sourceDate2];
    NSTimeInterval interval2 = destinationGMTOffset2 - sourceGMTOffset2;
    
    //NSDate* destinationDate2 = [[NSDate alloc] initWithTimeInterval:interval2 sinceDate:sourceDate2];
    
    NSDate* destinationDate2 = sourceDate2;
    
    NSString *paitentName = [NSString stringWithFormat:@"%@ %@", appRequest.firstname, appRequest.lastname];
    
    NSDateComponents *fromcomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:destinationDate];
    NSDateComponents *tocomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:destinationDate2];
    
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
        fromHour = [NSString stringWithFormat:@"0%i", [fromcomponents hour]];
    } else {
        fromHour = [NSString stringWithFormat:@"%i", [fromcomponents hour]];
    }
    
    if ([fromcomponents minute] < 10) {
        fromMinute = [NSString stringWithFormat:@"0%i", [fromcomponents minute]];
    } else {
        fromMinute = [NSString stringWithFormat:@"%i", [fromcomponents minute]];
    }
    
    NSString *toHour = @"00";
    NSString *toMinute = @"00";
    
    if ([tocomponents hour] < 10) {
        toHour = [NSString stringWithFormat:@"0%i", [tocomponents hour]];
    } else {
        toHour = [NSString stringWithFormat:@"%i", [tocomponents hour]];
    }
    
    if ([tocomponents minute] < 10) {
        toMinute = [NSString stringWithFormat:@"0%i", [tocomponents minute]];
    } else {
        toMinute = [NSString stringWithFormat:@"%i", [tocomponents minute]];
    }
    
    NSString *fromtime = [NSString stringWithFormat:@"%@:%@", fromHour, fromMinute];
    
    NSString *totime = [NSString stringWithFormat:@"%@:%@", toHour, toMinute];
    
    
    
    monthLabel1.text = monthname;
    fromTimeLabel1.text = fromtime;
    toTimeLabel1.text = totime;
    dayLabel1.text = [NSString stringWithFormat:@"%i", [fromcomponents day]];
    nameLabel.text = paitentName;
    emailLabel.text = appRequest.patientemail;
    teleLabel.text = appRequest.patienttele;
    noteText.text = appRequest.appnotes;
    
    profIMG.layer.cornerRadius = profIMG.frame.size.width/2;
    profIMG.layer.masksToBounds = YES;
    
    profBlurEffect.layer.cornerRadius = profBlurEffect.frame.size.width/2;
    profBlurEffect.layer.masksToBounds = YES;
    
    [profIMG setImageWithURL:[NSURL URLWithString:appRequest.patientProfIMG]];
    
}

- (IBAction)cancelPop:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)declineRequest:(id)sender {
    [[AppController sharedInstance] declineRequestAppointment:appRequest.appid completion:^(BOOL success, NSString *message) {
         [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate refreshPationInfo];
    }];

}

- (IBAction)acceptRequest:(id)sender {
    [[AppController sharedInstance] acceptRequestAppointment:appRequest.appid completion:^(BOOL success, NSString *message) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate refreshPationInfo];
    }];
}

@end
