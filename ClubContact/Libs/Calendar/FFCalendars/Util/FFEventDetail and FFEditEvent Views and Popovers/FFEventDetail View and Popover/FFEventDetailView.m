//
//  FFEventDetailView.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFEventDetailView.h"

#import "FFImportantFilesForCalendar.h"

@interface FFEventDetailView ()
@property (nonatomic, strong) FFEvent *event;
@property (nonatomic, strong) UILabel *labelCustomerName;
@property (nonatomic, strong) UILabel *labelDate;
@property (nonatomic, strong) UILabel *labelHours;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelEmail;
@property (nonatomic, strong) UILabel *labelPhone;
@property (nonatomic, strong) UITextView *labelNotes;
@end

@implementation FFEventDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Synthesize

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

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame event:(FFEvent *)_event
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        event = _event;
        
        [self.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
        [self.layer setBorderWidth:2.];
        
        [self addButtonEditPopoverWithViewSize:frame.size];
        [self addLabelCustomerNameWithViewSize:frame.size];
        [self addLabelTitleWithViewSize:frame.size];
        [self addLabelEmailWithViewSize:frame.size];
        [self addLabelPhoneWithViewSize:frame.size];
        [self addLabelDateWithViewSize:frame.size];
        [self addLabelHoursWithViewSize:frame.size];
        [self addLabelNoteWithViewSize:frame.size];
    }
    return self;
}


- (id)initWithEvent:(FFEvent *)eventInit {
    
    CGSize size = CGSizeMake(320., 70.);
    
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    if (self) {
        
        event = eventInit;
        
        [self.layer setBorderColor:[UIColor lightGrayCustom].CGColor];
        [self.layer setBorderWidth:2.];
        
        [self addButtonEditPopoverWithViewSize:size];
        [self addLabelCustomerNameWithViewSize:size];
        [self addLabelTitleWithViewSize:size];
        [self addLabelEmailWithViewSize:size];
        [self addLabelPhoneWithViewSize:size];
        [self addLabelDateWithViewSize:size];
        [self addLabelHoursWithViewSize:size];
        [self addLabelNoteWithViewSize:size];
    }
    return self;
}

#pragma mark - Button Actions

- (IBAction)buttonEditPopoverAction:(id)sender {
    
    if ([protocol respondsToSelector:@selector(showEditViewWithEvent:)]) {
        [protocol showEditViewWithEvent:event];
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
    
    [self addSubview:buttonEditPopover];
}

- (void)addLabelCustomerNameWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelCustomerName = [[UILabel alloc] initWithFrame:CGRectMake(gap, buttonEditPopover.frame.origin.y, sizeView.width-3*gap-buttonEditPopover.frame.size.width, buttonEditPopover.frame.size.height)];
    [labelCustomerName setText:event.stringCustomerName];
    [labelCustomerName setFont:[UIFont boldSystemFontOfSize:labelCustomerName.font.pointSize]];
    
    [self addSubview:labelCustomerName];
}


- (void)addLabelTitleWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(gap, labelCustomerName.frame.origin.y + labelCustomerName.frame.size.height, 320.0, labelCustomerName.frame.size.height)];
    [labelTitle setText:event.cusTitle];
    [labelTitle setFont:[UIFont boldSystemFontOfSize:labelCustomerName.font.pointSize]];
    
    [self addSubview:labelTitle];
}

- (void)addLabelEmailWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(gap, labelTitle.frame.origin.y+labelTitle.frame.size.height, 320., labelTitle.frame.size.height)];
    [labelEmail setText:[NSString stringWithFormat:@"Email: %@", event.cusEmail ]];
    [labelEmail setTextColor:[UIColor grayColor]];
    [labelEmail setFont:[UIFont systemFontOfSize:labelTitle.font.pointSize-3]];
    
    [self addSubview:labelEmail];
}

- (void)addLabelPhoneWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(gap, labelEmail.frame.origin.y+labelEmail.frame.size.height, 320., labelEmail.frame.size.height)];
    [labelPhone setText:[NSString stringWithFormat:@"Phone: %@", event.cusTele ]];
    [labelPhone setTextColor:[UIColor grayColor]];
    [labelPhone setFont:[UIFont systemFontOfSize:labelTitle.font.pointSize-3]];
    
    [self addSubview:labelPhone];
}

- (void)addLabelDateWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelDate = [[UILabel alloc] initWithFrame:CGRectMake(gap, labelPhone.frame.origin.y+labelPhone.frame.size.height, 180., labelPhone.frame.size.height)];
    [labelDate setText:[NSDate stringDayOfDate:event.dateDay]];
    [labelDate setTextColor:[UIColor grayColor]];
    [labelDate setFont:[UIFont systemFontOfSize:labelTitle.font.pointSize-3]];
    
    [self addSubview:labelDate];
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
    
    [self addSubview:labelHours];
}

- (void)addLabelNoteWithViewSize:(CGSize)sizeView {
    
    CGFloat gap = 30;
    
    labelNotes = [[UITextView alloc] initWithFrame:CGRectMake(gap, labelDate.frame.origin.y+labelDate.frame.size.height, 320., 150)];
    [labelNotes setText:@"83927489 23489234 cdbhs8934 34823748349 dkjsbf289478234 njdfnui284u834083 nwejnfjkdsnf9204903284 34830249023 njdnfj209831209 389012839012 njdknfjksnfkjs"];
    [labelNotes setTextColor:[UIColor grayColor]];

    [labelNotes setFont:[UIFont systemFontOfSize:labelTitle.font.pointSize-3]];
    [labelNotes setEditable:false];
    [labelNotes setBackgroundColor:[UIColor clearColor]];
    
    
    [self addSubview:labelNotes];
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
