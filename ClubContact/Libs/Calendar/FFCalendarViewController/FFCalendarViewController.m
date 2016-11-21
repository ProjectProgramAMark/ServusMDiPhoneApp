//
//  FFCalendarViewController.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 12/02/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFCalendarViewController.h"

#import "FFCalendar.h"

@interface FFCalendarViewController () <FFButtonAddEventWithPopoverProtocol, FFYearCalendarViewProtocol, FFMonthCalendarViewProtocol, FFWeekCalendarViewProtocol, FFDayCalendarViewProtocol>
@property (nonatomic) BOOL boolDidLoad;
@property (nonatomic) BOOL boolYearViewIsShowing;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) UILabel *labelWithMonthAndYear;
@property (nonatomic, strong) NSArray *arrayButtons;
@property (nonatomic, strong) NSArray *arrayCalendars;
@property (nonatomic, strong) FFEditEventPopoverController *popoverControllerEditar;
@property (nonatomic, strong) FFYearCalendarView *viewCalendarYear;
@property (nonatomic, strong) FFMonthCalendarView *viewCalendarMonth;
@property (nonatomic, strong) FFWeekCalendarView *viewCalendarWeek;
@property (nonatomic, strong) FFDayCalendarView *viewCalendarDay;
@end

@implementation FFCalendarViewController

#pragma mark - Synthesize

@synthesize boolDidLoad;
@synthesize boolYearViewIsShowing;
@synthesize protocol;
@synthesize arrayWithEvents;
@synthesize dictEvents;
@synthesize labelWithMonthAndYear;
@synthesize arrayButtons;
@synthesize arrayCalendars;
@synthesize popoverControllerEditar;
@synthesize viewCalendarYear;
@synthesize viewCalendarMonth;
@synthesize viewCalendarWeek;
@synthesize viewCalendarDay;

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged:) name:DATE_MANAGER_DATE_CHANGED object:nil];
    
    [self customNavigationBarLayout];
    
    [self addCalendars];
    
    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:0]];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onBackAction)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (!boolDidLoad) {
        boolDidLoad = YES;
        [self buttonTodayAction:nil];
    }
    
    [self requestDoctorAppointments];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestDoctorAppointments
{
    [[AppController sharedInstance] getAllAppointmens:@"1" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        if (success)
        {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            
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
                    
                    NSString *paitentName = [NSString stringWithFormat:@"%@ %@", noteDic.firstname, noteDic.lastname];
                    
                    
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

                    
                    [tempArray addObject:event1];

                }
                @catch (NSException *exception) {
                    
                }
               
            }
            
            [self setArrayWithEvents:tempArray];
                [self arrayUpdatedWithAllEvents];
             [self addCalendars];
            
           
          
        }
        

        
    }];
}

#pragma mark - Back Action

- (void)onBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - FFDateManager Notification

- (void)dateChanged:(NSNotification *)notification {
    
    [self updateLabelWithMonthAndYear];
}

- (void)updateLabelWithMonthAndYear {
    
    NSDateComponents *comp = [NSDate componentsOfDate:[[FFDateManager sharedManager] currentDate]];
    NSString *string = boolYearViewIsShowing ? [NSString stringWithFormat:@"%li", (long)comp.year] : [NSString stringWithFormat:@"%@ %li", [arrayMonthName objectAtIndex:comp.month-1], (long)comp.year];
    [labelWithMonthAndYear setText:string];
}

#pragma mark - Init dictEvents

- (void)setArrayWithEvents:(NSMutableArray *)_arrayWithEvents {
    
    arrayWithEvents = _arrayWithEvents;
    
    dictEvents = [NSMutableDictionary new];
    
    for (FFEvent *event in _arrayWithEvents) {
        NSDateComponents *comp = [NSDate componentsOfDate:event.dateDay];
        NSDate *newDate = [NSDate dateWithYear:comp.year month:comp.month day:comp.day];
        NSMutableArray *array = [dictEvents objectForKey:newDate];
        if (!array) {
            array = [NSMutableArray new];
            [dictEvents setObject:array forKey:newDate];
        }
        [array addObject:event];
    }
}

#pragma mark - Custom NavigationBar

- (void)customNavigationBarLayout {
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.navigationController.navigationBar setBarTintColor:[UIColor lighterGrayCustom]];
    
    [self addRightBarButtonItems];
    [self addLeftBarButtonItems];
}

- (void)addRightBarButtonItems {
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.;
    
    FFRedAndWhiteButton *buttonYear = [self calendarButtonWithTitle:@"Year"];
    FFRedAndWhiteButton *buttonMonth = [self calendarButtonWithTitle:@"Month"];
    FFRedAndWhiteButton *buttonWeek = [self calendarButtonWithTitle:@"Week"];
    FFRedAndWhiteButton *buttonDay = [self calendarButtonWithTitle:@"Day"];
    
    UIBarButtonItem *barButtonYear = [[UIBarButtonItem alloc] initWithCustomView:buttonYear];
    UIBarButtonItem *barButtonMonth = [[UIBarButtonItem alloc] initWithCustomView:buttonMonth];
    UIBarButtonItem *barButtonWeek = [[UIBarButtonItem alloc] initWithCustomView:buttonWeek];
    UIBarButtonItem *barButtonDay = [[UIBarButtonItem alloc] initWithCustomView:buttonDay];
    
    FFButtonAddEventWithPopover *buttonAdd = [[FFButtonAddEventWithPopover alloc] initWithFrame:CGRectMake(0., 0., 30., 44)];
    [buttonAdd setProtocol:self];
    UIBarButtonItem *barButtonAdd = [[UIBarButtonItem alloc] initWithCustomView:buttonAdd];
    
    arrayButtons = @[buttonYear, buttonMonth, buttonWeek, buttonDay];
    [self.navigationItem setRightBarButtonItems:@[barButtonAdd, fixedItem, barButtonYear, barButtonMonth, barButtonWeek, barButtonDay]];
}

- (void)addLeftBarButtonItems {
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonBack = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    FFRedAndWhiteButton *buttonToday = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30)];
    [buttonToday addTarget:self action:@selector(buttonTodayAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonToday setTitle:@"Today" forState:UIControlStateNormal];
    UIBarButtonItem *barButtonToday = [[UIBarButtonItem alloc] initWithCustomView:buttonToday];
    
    labelWithMonthAndYear = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., 170., 30)];
    [labelWithMonthAndYear setTextColor:[UIColor redColor]];
    [labelWithMonthAndYear setFont:buttonToday.titleLabel.font];
    UIBarButtonItem *barButtonLabel = [[UIBarButtonItem alloc] initWithCustomView:labelWithMonthAndYear];
    
    [self.navigationItem setLeftBarButtonItems:@[barButtonBack, barButtonLabel, barButtonToday]];
}

- (FFRedAndWhiteButton *)calendarButtonWithTitle:(NSString *)title {
    
    FFRedAndWhiteButton *button = [[FFRedAndWhiteButton alloc] initWithFrame:CGRectMake(0., 0., 80., 30.)];
    [button addTarget:self action:@selector(buttonYearMonthWeekDayAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

#pragma mark - Add Calendars

- (void)addCalendars {
    
    CGRect frame = CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.height);
    
    viewCalendarYear = [[FFYearCalendarView alloc] initWithFrame:frame];
    [viewCalendarYear setProtocol:self];
    [self.view addSubview:viewCalendarYear];
    
    viewCalendarMonth = [[FFMonthCalendarView alloc] initWithFrame:frame];
    [viewCalendarMonth setProtocol:self];
    [viewCalendarMonth setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarMonth];
    
    viewCalendarWeek = [[FFWeekCalendarView alloc] initWithFrame:frame];
    [viewCalendarWeek setProtocol:self];
    [viewCalendarWeek setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarWeek];
    
    viewCalendarDay = [[FFDayCalendarView alloc] initWithFrame:frame];
    [viewCalendarDay setProtocol:self];
    [viewCalendarDay setDictEvents:dictEvents];
    [self.view addSubview:viewCalendarDay];
    
    arrayCalendars = @[viewCalendarYear, viewCalendarMonth, viewCalendarWeek, viewCalendarDay];
}

#pragma mark - Button Action

- (IBAction)buttonYearMonthWeekDayAction:(id)sender {
    
    long index = [arrayButtons indexOfObject:sender];
    
    [self.view bringSubviewToFront:[arrayCalendars objectAtIndex:index]];
    
    for (UIButton *button in arrayButtons) {
        button.selected = (button == sender);
    }
    
    boolYearViewIsShowing = (index == 0);
    [self updateLabelWithMonthAndYear];
}

- (IBAction)buttonTodayAction:(id)sender {
    
    [[FFDateManager sharedManager] setCurrentDate:[NSDate dateWithYear:[NSDate componentsOfCurrentDate].year
                                                                 month:[NSDate componentsOfCurrentDate].month
                                                                   day:[NSDate componentsOfCurrentDate].day]];
}

#pragma mark - Interface Rotation

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    [viewCalendarYear invalidateLayout];
    [viewCalendarMonth invalidateLayout];
    [viewCalendarWeek invalidateLayout];
    [viewCalendarDay invalidateLayout];
}

#pragma mark - FFButtonAddEventWithPopover Protocol

- (void)addNewEvent:(FFEvent *)eventNew {
    
    NSMutableArray *arrayNew = [dictEvents objectForKey:eventNew.dateDay];
    if (!arrayNew) {
        arrayNew = [NSMutableArray new];
        [dictEvents setObject:arrayNew forKey:eventNew.dateDay];
    }
    [arrayNew addObject:eventNew];
    
    [self setNewDictionary:dictEvents];
}

#pragma mark - FFMonthCalendarView, FFWeekCalendarView and FFDayCalendarView Protocols

- (void)setNewDictionary:(NSDictionary *)dict {
    
    dictEvents = (NSMutableDictionary *)dict;
    
    [viewCalendarMonth setDictEvents:dictEvents];
    [viewCalendarWeek setDictEvents:dictEvents];
    [viewCalendarDay setDictEvents:dictEvents];
    
    [self arrayUpdatedWithAllEvents];
}

#pragma mark - FFYearCalendarView Protocol

- (void)showMonthCalendar {
    
    [self buttonYearMonthWeekDayAction:[arrayButtons objectAtIndex:1]];
}

#pragma mark - Sending Updated Array to FFCalendarViewController Protocol

- (void)arrayUpdatedWithAllEvents {
    
    NSMutableArray *arrayNew = [NSMutableArray new];
    
    NSArray *arrayKeys = dictEvents.allKeys;
    for (NSDate *date in arrayKeys) {
        NSArray *arrayOfDate = [dictEvents objectForKey:date];
        for (FFEvent *event in arrayOfDate) {
            [arrayNew addObject:event];
        }
    }
    
    if (protocol != nil && [protocol respondsToSelector:@selector(arrayUpdatedWithAllEvents:)]) {
        [protocol arrayUpdatedWithAllEvents:arrayNew];
    }
}


- (void)refreshCalendar {
     [self requestDoctorAppointments];
}

@end
