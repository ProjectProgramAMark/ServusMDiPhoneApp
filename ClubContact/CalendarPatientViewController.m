//
//  CalendarPatientViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "CalendarPatientViewController.h"
#import "NSCalendarCategories.h"
#import "SWRevealViewController.h"
#import "NSDate+Components.h"

@interface CalendarPatientViewController () <CKCalendarViewDelegate, CKCalendarViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *data;

@end

@implementation CalendarPatientViewController

@synthesize patientLink;
@synthesize doctor;
@synthesize patientsArray;
@synthesize plinkDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  Create a dictionary for the data source
     */
    patientsArray = [[NSMutableArray alloc] init];
    plinkDict = [[NSMutableDictionary alloc] init];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
     UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    calendar = [CKCalendarView new];
    
    // 2. Optionally, set up the datasource and delegates
    [calendar setDelegate:self];
    [calendar setDataSource:self];
    
    // 3. Present the calendar
    [[self view] addSubview:calendar];
    
    self.data = [[NSMutableDictionary alloc] init];
    
    self.title = @"CALENDAR";
    
   // [self requestDoctorAppointments];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    //[self getDoctorProfile];
    // [self requestDoctorAppointments];
    [self loadAppointmentsNew];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)goBackToChose:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
    [self.revealViewController revealToggle:sender];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}



- (void)loadAppointmentsNew {
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllAppointmensForPatients:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
 
        [SVProgressHUD dismiss];
        if (success)
        {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            NSDateComponents *previosDate;
            
            
            for (Appointments *noteDic in conditions)
            {
                @try {
                    
                    double unixTimeStamp =[noteDic.fromdate doubleValue];
                    NSTimeInterval _interval=unixTimeStamp;
                    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
                    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
                    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
                    
                    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
                    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
                    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
                    
                    //   NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
                    NSDate* destinationDate = sourceDate;
                    
                    double unixTimeStamp2 =[noteDic.todate doubleValue];
                    NSTimeInterval _interval2=unixTimeStamp2;
                    NSDate* sourceDate2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
                    NSTimeZone* sourceTimeZone2 = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
                    NSTimeZone* destinationTimeZone2 = [NSTimeZone systemTimeZone];
                    
                    NSInteger sourceGMTOffset2 = [sourceTimeZone secondsFromGMTForDate:sourceDate2];
                    NSInteger destinationGMTOffset2 = [destinationTimeZone2 secondsFromGMTForDate:sourceDate2];
                    NSTimeInterval interval2 = destinationGMTOffset2 - sourceGMTOffset2;
                    
                    //      NSDate* destinationDate2 = [[NSDate alloc] initWithTimeInterval:interval2 sinceDate:sourceDate2];
                    
                    NSDate* destinationDate2 = sourceDate2;
                    
                    //NSString *paitentName = [NSString stringWithFormat:@"%@ - %@ %@", noteDic.apptitle, noteDic.firstname, noteDic.lastname];
                    NSString *paitentName = [NSString stringWithFormat:@"%@ -21232 %@ %@", noteDic.apptitle, noteDic.firstname, noteDic.lastname];
                    if ([noteDic.isme intValue] == 0) {
                        paitentName  = @"Other Patient Appointment";
                    }
                    
                    
                    
                    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:destinationDate];
                    
                    int month;
                    int date;
                    int year;
                    
                    month = (int)components.month;
                    date = (int)components.day;
                    year = (int)components.year ;
                    
                    NSString *title2 = paitentName;
                    NSDate *date2 = [NSDate dateWithDay:date month:month year:year];;
                    CKCalendarEvent *mockingJay = [CKCalendarEvent eventWithTitle:title2 andDate:date2 andInfo:nil andColor:[UIColor clearColor] andApp:noteDic];
                    
                    
                    if ((int)previosDate.year == (int)components.year && (int)previosDate.day == (int)components.day && (int)components.month == (int)previosDate.month) {
                        [tempArray  addObject:mockingJay];
                        
                    } else {
                        tempArray = [[NSMutableArray alloc] init];
                        [tempArray  addObject:mockingJay];
                    }
                    
                    previosDate = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:destinationDate];
                    
                      if ([noteDic.isme intValue]> 0) {
                        self.data[date2] = tempArray;
                     //   [plinkDict setObject:plink2 forKey:noteDic.appid];
                    }
                    
                    
                    
                    
                    
                }
                @catch (NSException *exception) {
                    NSLog(exception.description);
                }
                
            }
            
            //  [self setArrayWithEvents:tempArray];
            //  [self arrayUpdatedWithAllEvents];
            // [self addCalendars];
            [calendar reload];
            
            
            
            
            
            
        }
        
        
        
    }];

}


- (void)getAllLinkedPatients {
     [SVProgressHUD showWithStatus:@"Loading..."];
    [patientsArray removeAllObjects];
    plinkDict = [[NSMutableDictionary alloc] init];
    [[AppController sharedInstance] getLinkPatients:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
          [SVProgressHUD dismiss];
        
        
        if (success)
        {
            
           // [patientsArray removeAllObjects];
            
           // [patientsArray addObjectsFromArray:conditions];
            for (PatientLinks *plink in conditions) {
                
                [[AppController sharedInstance] getAllAppointmens3:plink.docid plink:plink WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions2, PatientLinks *plink2) {
                    
                    [SVProgressHUD dismiss];
                    if (success)
                    {
                        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                        NSDateComponents *previosDate;
                        
                        
                        for (Appointments *noteDic in conditions2)
                        {
                            @try {
                                
                                double unixTimeStamp =[noteDic.fromdate doubleValue];
                                NSTimeInterval _interval=unixTimeStamp;
                                NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
                                NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
                                NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
                                
                                NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
                                NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
                                NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
                                
                                //   NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
                                NSDate* destinationDate = sourceDate;
                                
                                double unixTimeStamp2 =[noteDic.todate doubleValue];
                                NSTimeInterval _interval2=unixTimeStamp2;
                                NSDate* sourceDate2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
                                NSTimeZone* sourceTimeZone2 = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
                                NSTimeZone* destinationTimeZone2 = [NSTimeZone systemTimeZone];
                                
                                NSInteger sourceGMTOffset2 = [sourceTimeZone secondsFromGMTForDate:sourceDate2];
                                NSInteger destinationGMTOffset2 = [destinationTimeZone2 secondsFromGMTForDate:sourceDate2];
                                NSTimeInterval interval2 = destinationGMTOffset2 - sourceGMTOffset2;
                                
                                //      NSDate* destinationDate2 = [[NSDate alloc] initWithTimeInterval:interval2 sinceDate:sourceDate2];
                                
                                NSDate* destinationDate2 = sourceDate2;
                                
                                NSString *paitentName = [NSString stringWithFormat:@"%@ - %@ %@", noteDic.apptitle, noteDic.firstname, noteDic.lastname];
                                if (![noteDic.patientid isEqual:plink2.postid]) {
                                    paitentName  = @"Other Patient Appointment";
                                }
                                
                                
                                
                                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:destinationDate];
                                
                                int month;
                                int date;
                                int year;
                                
                                month = (int)components.month;
                                date = (int)components.day;
                                year = (int)components.year ;
                                
                                NSString *title2 = paitentName;
                                NSDate *date2 = [NSDate dateWithDay:date month:month year:year];;
                                CKCalendarEvent *mockingJay = [CKCalendarEvent eventWithTitle:title2 andDate:date2 andInfo:nil andColor:[UIColor clearColor] andApp:noteDic];
                                
                                
                                if ((int)previosDate.year == (int)components.year && (int)previosDate.day == (int)components.day && (int)components.month == (int)previosDate.month) {
                                    [tempArray  addObject:mockingJay];
                                    
                                } else {
                                    tempArray = [[NSMutableArray alloc] init];
                                    [tempArray  addObject:mockingJay];
                                }
                                
                                previosDate = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:destinationDate];
                                
                                 if ([noteDic.patientid isEqual:plink2.postid]) {
                                self.data[date2] = tempArray;
                                     [plinkDict setObject:plink2 forKey:noteDic.appid];
                                 }
                                
                                
                                
                               
                                
                            }
                            @catch (NSException *exception) {
                                NSLog(exception.description);
                            }
                            
                        }
                        
                        //  [self setArrayWithEvents:tempArray];
                        //  [self arrayUpdatedWithAllEvents];
                        // [self addCalendars];
                        [calendar reload];
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                }];
                
                

                
                
            }
            
        }
        
        
        
    }];
    
}

- (void)getDoctorProfile {
   /* [[AppController sharedInstance] getDoctorProfile2:patientLink.docid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        if (success) {
            doctor = doctorProfile;
        }
    }];*/
}


- (void)requestDoctorAppointments
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllAppointmens2:patientLink.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            NSDateComponents *previosDate;
            
            
            for (Appointments *noteDic in conditions)
            {
                @try {
                    
                    double unixTimeStamp =[noteDic.fromdate doubleValue];
                    NSTimeInterval _interval=unixTimeStamp;
                    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
                    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
                    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
                    
                    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
                    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
                    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
                    
                    //   NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
                    NSDate* destinationDate = sourceDate;
                    
                    double unixTimeStamp2 =[noteDic.todate doubleValue];
                    NSTimeInterval _interval2=unixTimeStamp2;
                    NSDate* sourceDate2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
                    NSTimeZone* sourceTimeZone2 = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
                    NSTimeZone* destinationTimeZone2 = [NSTimeZone systemTimeZone];
                    
                    NSInteger sourceGMTOffset2 = [sourceTimeZone secondsFromGMTForDate:sourceDate2];
                    NSInteger destinationGMTOffset2 = [destinationTimeZone2 secondsFromGMTForDate:sourceDate2];
                    NSTimeInterval interval2 = destinationGMTOffset2 - sourceGMTOffset2;
                    
                    //      NSDate* destinationDate2 = [[NSDate alloc] initWithTimeInterval:interval2 sinceDate:sourceDate2];
                    
                    NSDate* destinationDate2 = sourceDate2;
                    
                    NSString *paitentName = [NSString stringWithFormat:@"%@ - %@ %@", noteDic.apptitle, noteDic.firstname, noteDic.lastname];
                    if (![noteDic.patientid isEqual:patientLink.postid]) {
                        paitentName  = @"Other Patient Appointment";
                    }
                    
                    
                    
                    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:destinationDate];
                    
                    int month;
                    int date;
                    int year;
                    
                    month = (int)components.month;
                    date = (int)components.day;
                    year = (int)components.year ;
                    
                    NSString *title2 = paitentName;
                    NSDate *date2 = [NSDate dateWithDay:date month:month year:year];;
                    CKCalendarEvent *mockingJay = [CKCalendarEvent eventWithTitle:title2 andDate:date2 andInfo:nil andColor:[UIColor clearColor] andApp:noteDic];
                    
                    
                    if ((int)previosDate.year == (int)components.year && (int)previosDate.day == (int)components.day && (int)components.month == (int)previosDate.month) {
                        [tempArray  addObject:mockingJay];
                        
                    } else {
                        tempArray = [[NSMutableArray alloc] init];
                        [tempArray  addObject:mockingJay];
                    }
                    
                    previosDate = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:destinationDate];
                    
                    
                    self.data[date2] = tempArray;
                    
                    
                    
                    //   [calendar reload];
                    
                    /*
                     FFEvent *event1 = [FFEvent new];
                     [event1 setStringCustomerName: paitentName];
                     [event1 setNumCustomerID:[NSNumber numberWithInt:[noteDic.patientid intValue] ]];
                     [event1 setDateDay:destinationDate];
                     [event1 setDateTimeBegin:destinationDate];
                     [event1 setDateTimeEnd:destinationDate2];
                     [event1 setCusFirstname:noteDic.firstname];
                     [event1 setCusLastname:noteDic.lastname];
                     [event1 setCusTitle:noteDic.apptitle];
                     [event1 setCusNotes:noteDic.appnotes];
                     [event1 setCusID:noteDic.appid];
                     [event1 setCusEmail:noteDic.patientemail];
                     [event1 setCusTele:noteDic.patienttele];
                     // [event1 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
                     
                     
                     [tempArray addObject:event1];*/
                    
                }
                @catch (NSException *exception) {
                    NSLog(exception.description);
                }
                
            }
            
            //  [self setArrayWithEvents:tempArray];
            //  [self arrayUpdatedWithAllEvents];
            // [self addCalendars];
            [calendar reload];
            
            
            
            
            
            
        }
        
        
        
    }];
}

- (IBAction)addCalendar:(id)sender {
 /*   UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    PMasterNewAppViewController *vc = (PMasterNewAppViewController *)[sb instantiateViewControllerWithIdentifier:@"PMasterNewAppViewController"];
    vc.patientLink = patientLink;
    [self.navigationController pushViewController:vc animated:YES];*/
   
    CalendarRecViewController *vc = [[CalendarRecViewController alloc] initWithNibName:@"CalendarRecViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date
{
    return [self.data objectForKey:date];
}

#pragma mark - CKCalendarViewDelegate

// Called before/after the selected date changes
- (void)calendarView:(CKCalendarView *)CalendarView willSelectDate:(NSDate *)date
{
    // CKCalendarEvent *test = [self.data objectForKey:date];
    // test.patientName = @"";
}

- (void)calendarView:(CKCalendarView *)CalendarView didSelectDate:(NSDate *)date
{
    
}

//  A row is selected in the events table. (Use to push a detail view or whatever.)
- (void)calendarView:(CKCalendarView *)CalendarView didSelectEvent:(CKCalendarEvent *)event
{
   
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getLinkPatients:event.appointment.patientid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
      
        if (success) {
            if (conditions.count > 0) {
                PatientLinks *plink = [conditions objectAtIndex:0];
          
            [[AppController sharedInstance] getDoctorProfile2:plink.docid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
                [SVProgressHUD dismiss];
                if (success) {
                    PMasterCalDetailsViewController *vc = [[PMasterCalDetailsViewController alloc] initWithNibName:@"PMasterCalDetailsViewController" bundle:nil];
                    vc.appointment = event.appointment;
                    vc.doctor = doctorProfile;
                    vc.patientInfo = plink;
                    if ([event.appointment.patientid isEqual:plink.postid]) {
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                }
            }];
                
            } else {
                 [SVProgressHUD dismiss];
            }

            
        } else {
             [SVProgressHUD dismiss];
        }
        
        
        
    }];
    
    
    
   // [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)createdNewEvent {
    [self requestDoctorAppointments];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
