//
//  iPhoneCalendarViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/19/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "iPhoneCalendarViewController.h"

#import "NSCalendarCategories.h"

#import "NSDate+Components.h"
#import "SWRevealViewController.h"

@interface iPhoneCalendarViewController () <CKCalendarViewDelegate, CKCalendarViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *data;

@end

@implementation iPhoneCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /**
     *  Create a dictionary for the data source
     */
    
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
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    [self requestDoctorAppointments];
    
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
        [self.revealViewController revealToggle:sender];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}



- (void)requestDoctorAppointments
{
    [[AppController sharedInstance] getAllAppointmens:@"1" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
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
   UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    
    // CKCalendarEvent *test = [self.data objectForKey:date];
    CreateNewEventViewController *vc = [[CreateNewEventViewController alloc] initWithNibName:@"CreateNewEventViewController" bundle:nil];
   // vc.appointment = event.appointment;
    vc.delegate =self;
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
    CalendarDetailViewController *vc = [[CalendarDetailViewController alloc] initWithNibName:@"CalendarDetailViewController" bundle:nil];
    vc.appointment = event.appointment;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
