//
//  AppointmentDetailViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/16/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AppointmentDetailViewController.h"
#import "FFImportantFilesForCalendar.h"

@interface AppointmentDetailViewController () {
    
}

//@property (nonatomic, strong) FFEvent *event;
@property (nonatomic, strong) UILabel *labelCustomerName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelHours;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelEmail;
@property (nonatomic, strong) UILabel *labelPhone;
@property (nonatomic, strong) UITextView *labelNotes;

@end

@implementation AppointmentDetailViewController

@synthesize protocol;
@synthesize event;
@synthesize buttonEditPopover;
@synthesize labelCustomerName;
@synthesize labelDate;
@synthesize labelHours;
@synthesize labelTitle;
@synthesize labelNotes;
@synthesize labelEmail;
@synthesize labelPhone;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  /*  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
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

- (void)viewWillAppear:(BOOL)animated {
    
    [self.view.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
    [self.view.layer setBorderWidth:2.];
    
    [self addButtonEditPopoverWithViewSize:self.view.frame.size];
    [self addLabelCustomerNameWithViewSize:self.view.frame.size];
    [self addLabelTitleWithViewSize:self.view.frame.size];
    [self addLabelEmailWithViewSize:self.view.frame.size];
    [self addLabelPhoneWithViewSize:self.view.frame.size];
    [self addLabelDateWithViewSize:self.view.frame.size];
    [self addLabelHoursWithViewSize:self.view.frame.size];
    [self addLabelNoteWithViewSize:self.view.frame.size];

}


#pragma mark - Button Actions

- (IBAction)buttonEditPopoverAction:(id)sender {
    
    if ([protocol respondsToSelector:@selector(showEditViewWithEvent:)]) {
       // [protocol showEditViewWithEvent:event];
    }
}

#pragma mark - Add Subviews

- (void)addButtonEditPopoverWithViewSize:(CGSize)sizeView {
    
    CGFloat width = 100;
    CGFloat height = BUTTON_HEIGHT;
    CGFloat gap = 30;
    
    buttonEditPopover = [[UIButton alloc] initWithFrame:CGRectMake(sizeView.width-width-gap, 22, width, height)];
    [buttonEditPopover setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buttonEditPopover setTitle:@"Delete" forState:UIControlStateNormal];
    [buttonEditPopover.titleLabel setFont:[UIFont boldSystemFontOfSize:buttonEditPopover.titleLabel.font.pointSize]];
    //[buttonEditPopover addTarget:self action:@selector(buttonEditPopoverAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonEditPopover addTarget:self action:@selector(deleteAppointment:) forControlEvents:UIControlEventTouchUpInside];
    [buttonEditPopover setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    
    [self.view addSubview:buttonEditPopover];
}

- (void)addLabelCustomerNameWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelCustomerName = [[UILabel alloc] initWithFrame:CGRectMake(gap, buttonEditPopover.frame.origin.y, sizeView.width-3*gap-buttonEditPopover.frame.size.width, buttonEditPopover.frame.size.height)];
    [labelCustomerName setText:event.stringCustomerName];
    [labelCustomerName setFont:[UIFont boldSystemFontOfSize:labelCustomerName.font.pointSize]];
    
    [self.view addSubview:labelCustomerName];
}


- (void)addLabelTitleWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(gap, labelCustomerName.frame.origin.y + labelCustomerName.frame.size.height, 320.0, labelCustomerName.frame.size.height)];
    [labelTitle setText:event.cusTitle];
    [labelTitle setFont:[UIFont boldSystemFontOfSize:labelCustomerName.font.pointSize]];
    
    [self.view addSubview:labelTitle];
}

- (void)addLabelEmailWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(gap, labelTitle.frame.origin.y+labelTitle.frame.size.height, 320., labelTitle.frame.size.height)];
    [labelEmail setText:[NSString stringWithFormat:@"Email: %@", event.cusEmail ]];
    [labelEmail setTextColor:[UIColor grayColor]];
    [labelEmail setFont:[UIFont systemFontOfSize:labelTitle.font.pointSize-3]];
    
    [self.view addSubview:labelEmail];
}

- (void)addLabelPhoneWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(gap, labelEmail.frame.origin.y+labelEmail.frame.size.height, 320., labelEmail.frame.size.height)];
    [labelPhone setText:[NSString stringWithFormat:@"Phone: %@", event.cusTele ]];
    [labelPhone setTextColor:[UIColor grayColor]];
    [labelPhone setFont:[UIFont systemFontOfSize:labelTitle.font.pointSize-3]];
    
    [self.view addSubview:labelPhone];
}

- (void)addLabelDateWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelDate = [[UILabel alloc] initWithFrame:CGRectMake(gap, labelPhone.frame.origin.y+labelPhone.frame.size.height, 180., labelPhone.frame.size.height)];
    [labelDate setText:[NSDate stringDayOfDate:event.dateDay]];
    [labelDate setTextColor:[UIColor grayColor]];
    [labelDate setFont:[UIFont systemFontOfSize:labelTitle.font.pointSize-3]];
    
    [self.view addSubview:labelDate];
}

- (void)addLabelHoursWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    CGFloat x = labelDate.frame.origin.x + labelDate.frame.size.width+gap;
    
    labelHours = [[UILabel alloc] initWithFrame:CGRectMake(x, labelDate.frame.origin.y, sizeView.width-x-gap, labelDate.frame.size.height)];
    [labelHours setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [labelHours setText:[NSString stringWithFormat:@"%@ - %@", [NSDate stringTimeOfDate:event.dateTimeBegin], [NSDate stringTimeOfDate:event.dateTimeEnd]]];
    [labelHours setTextAlignment:NSTextAlignmentRight];
    [labelHours setTextColor:[UIColor grayColor]];
    [labelHours setFont:labelDate.font];
    
    [self.view addSubview:labelHours];
}

- (void)addLabelNoteWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelNotes = [[UITextView alloc] initWithFrame:CGRectMake(gap, labelDate.frame.origin.y+labelDate.frame.size.height, 320., 150)];
    [labelNotes setText:@"83927489 23489234 cdbhs8934 34823748349 dkjsbf289478234 njdfnui284u834083 nwejnfjkdsnf9204903284 34830249023 njdnfj209831209 389012839012 njdknfjksnfkjs"];
    [labelNotes setTextColor:[UIColor grayColor]];
    
    [labelNotes setFont:[UIFont systemFontOfSize:labelTitle.font.pointSize-3]];
    [labelNotes setEditable:false];
    [labelNotes setBackgroundColor:[UIColor clearColor]];
    
    
    [self.view addSubview:labelNotes];
}

- (IBAction)deleteAppointment:(id)sender {
    
    /*  UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleActionSheet];
     
     
     
     UIAlertAction *yesaction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
     
     
     [[AppController sharedInstance] deleteDoctorAppointment:event.cusID completion:^(BOOL success, NSString *message) {
     
     if (protocol != nil) {
     // [protocol responds];
     [protocol refreshCalendar];
     
     }
     
     }];
     
     
     
     }];
     
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
     
     }];
     
     [actionSheet addAction:yesaction];
     [actionSheet addAction:cancelAction];
     
     [self presentViewController:actionSheet animated:YES completion:nil];*/
    
    [[AppController sharedInstance] deleteDoctorAppointment:event.cusID completion:^(BOOL success, NSString *message) {
        
        if (protocol != nil) {
            // [protocol responds];
            [protocol refreshCalendar];
            
        }
        
    }];
    
    
    
    
}

@end
