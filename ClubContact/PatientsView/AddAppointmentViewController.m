//
//  AddAppointmentViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/16/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AddAppointmentViewController.h"

#import "FFGuestsTableView.h"
#import "FFSearchBarWithAutoComplete.h"
#import "FFButtonWithDatePopover.h"
#import "FFButtonWithHourPopover.h"
#import "FFImportantFilesForCalendar.h"


@interface AddAppointmentViewController ()  <UIGestureRecognizerDelegate, UITextFieldDelegate, PatientsViewControllerDelegate>
@property (nonatomic, strong) UIViewController *popoverContent;
@property (nonatomic, strong) FFEvent *event;
//@property (nonatomic, strong) UIButton *buttonCancel;
//@property (nonatomic, strong) UIButton *buttonDone;
//@property (nonatomic, strong) UIButton *patientButton;
@property (nonatomic, strong) UILabel *labelEventName;
@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UITextView *noteText;
@property (nonatomic, strong) FFSearchBarWithAutoComplete *searchBarCustom;
@property (nonatomic, strong) FFButtonWithDatePopover *buttonDate;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeBegin;
@property (nonatomic, strong) FFButtonWithHourPopover *buttonTimeEnd;
@property (nonatomic, strong) FFGuestsTableView *tableViewGuests;

@end

@implementation AddAppointmentViewController

@synthesize protocol;
@synthesize event;
@synthesize popoverContent;
@synthesize buttonDone;
@synthesize buttonCancel;
@synthesize labelEventName;
@synthesize searchBarCustom;
@synthesize buttonDate;
@synthesize buttonTimeBegin;
@synthesize buttonTimeEnd;
@synthesize tableViewGuests;
@synthesize patientButton;
@synthesize titleText;
@synthesize noteText;
@synthesize patientFullName;
@synthesize patientID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDateComponents *comp = [NSDate componentsOfCurrentDate];
    event = [FFEvent new];
    event.stringCustomerName = @"";
    event.dateDay = [NSDate date];
    event.dateTimeBegin = [NSDate dateWithHour:comp.hour min:comp.minute];
    event.dateTimeEnd = [NSDate dateWithHour:comp.hour min:comp.minute+15.];
    event.arrayWithGuests = nil;
    
    popoverContent = [UIViewController new];
    
    UIView *view = [self customViewViewFrame:CGRectMake(0., 0., 300., 700.)];
    [self.view addSubview:view];
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(buttonDoneAction:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(buttonDoneAction:)];
   // self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Button Actions

- (IBAction)buttonCancelAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonDoneAction:(id)sender {
    
    //    [[SVProgressHUD sharedView] setTintColor:[UIColor blackColor]];
    //    [[SVProgressHUD sharedView] setBackgroundColor:[UIColor lighterGrayCustom]];
    
    FFEvent *eventNew = [FFEvent new];
    eventNew.stringCustomerName = searchBarCustom.stringClientName;
    eventNew.numCustomerID = searchBarCustom.numCustomerID;
    eventNew.dateDay = buttonDate.dateOfButton;
    eventNew.dateTimeBegin = buttonTimeBegin.dateOfButton;
    eventNew.dateTimeEnd = buttonTimeEnd.dateOfButton;
    eventNew.arrayWithGuests = tableViewGuests.arrayWithSelectedItens;
    
    //  NSDate *fromdate = [NSDate dateWithYear:<#(NSInteger)#> month:<#(NSInteger)#> day:<#(NSInteger)#>]
    
    
    NSDateComponents *compDate = buttonDate.dateOfButton.componentsOfDate;
    NSDateComponents *compDate2 = buttonTimeBegin.dateOfButton.componentsOfDate;
    NSDateComponents *compDate3 = buttonTimeEnd.dateOfButton.componentsOfDate;
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:compDate.day];
    [comps setMonth:compDate.month];
    [comps setYear:compDate.year];
    [comps setHour:compDate2.hour];
    [comps setMinute:compDate2.minute];
    
    
    NSDate *fromdate1 = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    NSDateComponents *comps2 = [[NSDateComponents alloc] init];
    [comps2 setDay:compDate.day];
    [comps2 setMonth:compDate.month];
    [comps2 setYear:compDate.year];
    [comps2 setHour:compDate3.hour];
    [comps2 setMinute:compDate3.minute];
    
    
    NSDate *todate1 = [[NSCalendar currentCalendar] dateFromComponents:comps2];
    
    // NSDate* referenceDate = [NSDate dateWithTimeIntervalSince1970: 0];
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    int offset = [timeZone secondsFromGMTForDate:todate1];
    int unix_timestamp =  [todate1 timeIntervalSince1970];
    int Timestamp1 = unix_timestamp - offset;
    
    NSTimeZone* timeZone2 = [NSTimeZone localTimeZone];
    int offset2 = [timeZone2 secondsFromGMTForDate:fromdate1];
    int unix_timestamp2 =  [fromdate1 timeIntervalSince1970];
    int Timestamp2 = unix_timestamp2 - offset2;
    
    
    fromdate = [NSString stringWithFormat:@"%i", Timestamp2];
    todate = [NSString stringWithFormat:@"%i", Timestamp1];
    
    NSString *stringError;
    
    if (!patientID) {
        stringError = @"Please select a patient.";
    } else if (![self isTimeBeginEarlier:eventNew.dateTimeBegin timeEnd:eventNew.dateTimeEnd]) {
        stringError = @"Start time must occur earlier than end time.";
    } else if (titleText.text.length == 0) {
        stringError = @"Please enter a title for the appointment";
    }
    
    if (stringError) {
        [[[UIAlertView alloc] initWithTitle:nil message:stringError delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        //        [SVProgressHUD showErrorWithStatus:stringError];
    } else {
        // [protocol addNewEvent:eventNew];
        // [self buttonCancelAction:nil];
        
        
        [[AppController sharedInstance] addAppointment:patientID fromdate:fromdate todate:todate titletext:self.titleText.text notetext:self.noteText.text completion:^(BOOL success, NSString *message) {
            if (protocol != nil) {
                [protocol refreshCalendar];
                //[protocol refr]
                [self buttonCancelAction:nil];
            }
        }];
        
        
    }
    
    /*else if (protocol != nil && [protocol respondsToSelector:@selector(addNewEvent:)]) {
     // [protocol addNewEvent:eventNew];
     // [self buttonCancelAction:nil];
     }*/
}

- (BOOL)isTimeBeginEarlier:(NSDate *)dateBegin timeEnd:(NSDate *)dateEnd {
    
    BOOL boolIsRight = YES;
    
    NSDateComponents *compDateBegin = [NSDate componentsOfDate:dateBegin];
    NSDateComponents *compDateEnd = [NSDate componentsOfDate:dateEnd];
    
    if ((compDateBegin.hour > compDateEnd.hour) || (compDateBegin.hour == compDateEnd.hour && compDateBegin.minute >= compDateEnd.minute)) {
        boolIsRight = NO;
    }
    
    return boolIsRight;
}

#pragma mark - Set Popover Custom View

- (UIView *)customViewViewFrame:(CGRect)frame {
    
    UIView *viewCustom = [[UIView alloc] initWithFrame:frame];
    
    [viewCustom setBackgroundColor:[UIColor lightGrayCustom]];
    [viewCustom.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
    [viewCustom.layer setBorderWidth:2.];
    
    [self addButtonCancelWithCustomView:viewCustom];
    [self addButtonDoneWithCustomView:viewCustom];
    [self addSearchBarWithCustomView:viewCustom];
    [self addButtonDateWithCustomView:viewCustom];
    [self addButtonTimeBeginWithCustomView:viewCustom];
    [self addButtonTimeEndWithCustomView:viewCustom];
    [self addtableCustomTitleView:viewCustom];
    [self addtableCustomNoteView:viewCustom];
    
    /* UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
     [gesture setDelegate:self];
     [viewCustom addGestureRecognizer:gesture];*/
    
    return viewCustom;
}



#pragma mark - Add Subviews

- (void)addButtonCancelWithCustomView:(UIView *)customView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, customView.frame.size.width, BUTTON_HEIGHT+30)];
    [view setBackgroundColor:[UIColor lighterGrayCustom]];
    [customView addSubview:view];
    
    buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self customLayoutOfButton:buttonCancel withTitle:@"Cancel" action:@selector(buttonCancelAction:) frame:CGRectMake(20, 0, 80, BUTTON_HEIGHT+30)];
    [view addSubview:buttonCancel];
}

- (void)addButtonDoneWithCustomView:(UIView *)customView {
    
    buttonDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [self customLayoutOfButton:buttonDone withTitle:@"Done" action:@selector(buttonDoneAction:) frame:CGRectMake(buttonCancel.superview.frame.size.width-80-10, buttonCancel.frame.origin.y, 80, buttonCancel.frame.size.height)];
  //  [buttonDone addTarget:self action:@selector(buttonDoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonCancel.superview addSubview:buttonDone];
}

- (void)addSearchBarWithCustomView:(UIView *)customView {
    
    searchBarCustom = [[FFSearchBarWithAutoComplete alloc] initWithFrame:CGRectMake(0,buttonCancel.superview.frame.origin.y+buttonCancel.superview.frame.size.height+ BUTTON_HEIGHT, customView.frame.size.width, BUTTON_HEIGHT)];
    /*[customView addSubview:searchBarCustom];*/
    
    self.patientButton = [[UIButton alloc] initWithFrame:CGRectMake(0,buttonCancel.superview.frame.origin.y+buttonCancel.superview.frame.size.height+ BUTTON_HEIGHT, customView.frame.size.width, BUTTON_HEIGHT)];
    
    if (self.patientFullName.length == 0) {
        [self.patientButton setTitle:@"Select a patient" forState:UIControlStateNormal];
    } else {
        [self.patientButton setTitle:patientFullName forState:UIControlStateNormal];
    }
    
    [self.patientButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.patientButton setBackgroundColor:[UIColor whiteColor]];
    [self.patientButton addTarget:self action:@selector(patientButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [customView addSubview:self.patientButton];
}

- (void)addButtonDateWithCustomView:(UIView *)customView {
    
    buttonDate = [[FFButtonWithDatePopover alloc] initWithFrame:CGRectMake(0, searchBarCustom.frame.origin.y+searchBarCustom.frame.size.height+2, customView.frame.size.width, BUTTON_HEIGHT) date:event.dateDay];
    [customView addSubview:buttonDate];
}

- (void)addButtonTimeBeginWithCustomView:(UIView *)customView {
    
    buttonTimeBegin = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonDate.frame.origin.y+buttonDate.frame.size.height+BUTTON_HEIGHT, customView.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeBegin];
    [customView addSubview:buttonTimeBegin];
}

- (void)addButtonTimeEndWithCustomView:(UIView *)customView {
    
    buttonTimeEnd = [[FFButtonWithHourPopover alloc] initWithFrame:CGRectMake(0, buttonTimeBegin.frame.origin.y+buttonTimeBegin.frame.size.height+2, customView.frame.size.width, BUTTON_HEIGHT) date:event.dateTimeEnd];
    [customView addSubview:buttonTimeEnd];
}

- (void)addtableViewGuestsWithCustomView:(UIView *)customView {
    
    CGFloat y = buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+BUTTON_HEIGHT;
    
    tableViewGuests = [[FFGuestsTableView alloc] initWithFrame:CGRectMake(0, y, customView.frame.size.width,customView.frame.size.height-y)];
    // [customView addSubview:tableViewGuests];
}

- (void)addtableCustomTitleView:(UIView *)customView {
    
    CGFloat y = buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+BUTTON_HEIGHT;
    
    self.titleText = [[UITextField alloc] initWithFrame:CGRectMake(0, y, customView.frame.size.width,50)];
    self.titleText.placeholder = @"Enter appointment title";
    self.titleText.backgroundColor = [UIColor whiteColor];
    self.titleText.delegate = self;
    [customView addSubview:self.titleText];
}


- (void)addtableCustomNoteView:(UIView *)customView {
    
    CGFloat y = buttonTimeEnd.frame.origin.y+buttonTimeEnd.frame.size.height+BUTTON_HEIGHT+70;
    
    self.noteText = [[UITextView alloc] initWithFrame:CGRectMake(0, y, customView.frame.size.width,customView.frame.size.height-y)];
    
    
    [customView addSubview:self.noteText];
}

#pragma mark - Button Layout

- (void)customLayoutOfButton:(UIButton *)button withTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize]];
    [button setFrame:frame];
    [button setContentMode:UIViewContentModeScaleAspectFit];
}

#pragma mark - Tap Gesture

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    
    //  [searchBarCustom closeKeyboardAndTableView];
}

#pragma mark - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer locationInView:popoverContent.view];
    
    return !(searchBarCustom.arrayOfTableView.count != 0 && CGRectContainsPoint(searchBarCustom.tableViewCustom.frame, point)) &&
    CGRectContainsPoint(tableViewGuests.frame, point) && searchBarCustom.tableViewCustom.superview;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)patientAppointmentAdded:(NSString *)paitentname patientid:(NSString *)patientid {
    patientFullName = paitentname;
    patientID = patientid;
    [self.patientButton setTitle:patientFullName forState:UIControlStateNormal];
}

- (IBAction)patientButtonClicked:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    PatientsViewController *patientsVC = (PatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientsViewController"];
    patientsVC.view.frame = CGRectMake(0, 0, 300, 500);
    patientsVC.shouldPatientSelect = true;
    patientsVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:patientsVC];
    
    UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    [popOver presentPopoverFromRect:self.patientButton.frame
                             inView:[self.patientButton superview]
           permittedArrowDirections:UIPopoverArrowDirectionAny
                           animated:YES];
    
}


@end
