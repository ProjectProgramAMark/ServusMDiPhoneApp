//
//  RefillDetailiPhoneViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "RefillDetailiPhoneViewController.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"


@interface RefillDetailiPhoneViewController ()

@end

@implementation RefillDetailiPhoneViewController

@synthesize patient;
@synthesize patientMedication;
@synthesize refill;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
   // self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    self.title = @"REFILL DETAILS";
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
     [menuTable registerNib:[UINib nibWithNibName:@"PatientRecordAboutCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshData];
    
    profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
    profileIMGView2.layer.masksToBounds = YES;
    //profileIMGView2.layer.borderColor = [UIColor whiteColor].CGColor;
    //profileIMGView2.layer.borderWidth = 3.0;
    
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: patient.profilepic]];
    //[profileIMGView3 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
    jobLabel2.text = [NSString stringWithFormat:@"%@", patient.occupation];
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (void)refreshData {
    drugName.text = patientMedication.medname;
    
    doseLabel.text = [NSString stringWithFormat:@"Dose %@ %@", patientMedication.dose, patientMedication.doseunit];
    
    pharmacyName.text = [NSString stringWithFormat:@"Pharmacy: %@", patientMedication.pharmacy];
    pharmcyAddress.text = [NSString stringWithFormat:@"Address: %@", patientMedication.pharmaddress];
    
    NSDate *dob2 = [NSDate dateWithTimeIntervalSince1970:[refill.sentdate integerValue]];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"dd MMMM yyyy HH:MM"];
    NSString *timeString2 =  [formatter2 stringFromDate:dob2];
    
    
    double unixTimeStamp2 =[refill.refillupdate doubleValue];
    NSTimeInterval _interval2=unixTimeStamp2;
    NSDate* sourceDate2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
    NSTimeZone* sourceTimeZone2 = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSTimeZone* destinationTimeZone2 = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset2 = [sourceTimeZone2 secondsFromGMTForDate:sourceDate2];
    NSInteger destinationGMTOffset2 = [destinationTimeZone2 secondsFromGMTForDate:sourceDate2];
    NSTimeInterval interval2 = destinationGMTOffset2 - sourceGMTOffset2;
    
    NSDate* destinationDate2 = [[NSDate alloc] initWithTimeInterval:interval2 sinceDate:sourceDate2];
    
    NSString *dateString2 = [NSDateFormatter localizedStringFromDate:destinationDate2
                                                           dateStyle:NSDateFormatterShortStyle
                                                           timeStyle:NSDateFormatterShortStyle];
    
    NSString *refillStatus = @"Pending";
    
    if ([refill.refillstatus intValue] == 0) {
        refillStatus = @"Pending";
        acceptedButton.hidden = false;
        declineButton.hidden = false;
        updateLabel.hidden = true;
    } else if ([refill.refillstatus intValue] == 1) {
        refillStatus = @"Accepted";
        acceptedButton.hidden = true;
        declineButton.hidden = true;
        updateLabel.hidden = false;
    } else if ([refill.refillstatus intValue] == 2) {
        refillStatus = @"Declined";
        acceptedButton.hidden = true;
        declineButton.hidden = true;
        updateLabel.hidden = false;
    }
    
    statusLabel.text = [NSString stringWithFormat:@"Status: %@", refillStatus];
    sentLabel.text = [NSString stringWithFormat:@"Sent: %@", timeString2];
    updateLabel.text = [NSString stringWithFormat:@"Updated: %@", dateString2];
}

- (IBAction)acceptedClick:(id)sender {
     [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance] acceptRefill:refill.refillid completion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Refill request accepted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [self.delegate refreshRefillMedication];
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
}

- (IBAction)declineClick:(id)sender {
    
     [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance] declineRefill:refill.refillid completion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Refill request declined" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [self.delegate refreshRefillMedication];
              [self.navigationController popViewControllerAnimated:true];
        }
        
    }];
}








- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (refill) {
        return 5;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PatientRecordAboutCell    *cell = (PatientRecordAboutCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    // if (_addedConditionsArray.count > 0) {
    if (indexPath.row == 0) {
        
        //  cell.allergen = patientInfo;
        cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientMedication.medname];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
        
    } else if (indexPath.row == 1) {
        
        //  cell.allergen = patientInfo;
        cell.nameLabel.text = [NSString stringWithFormat:@"Dose: %@ %@",  patientMedication.dose, patientMedication.doseunit];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
        
    } else if (indexPath.row == 2) {
        
        //  cell.allergen = patientInfo;
        cell.nameLabel.text = [NSString stringWithFormat:@"Pharmacy: %@",  patientMedication.pharmacy];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];
        
    }  else if (indexPath.row == 3) {
        
        //  cell.allergen = patientInfo;
        cell.nameLabel.text = [NSString stringWithFormat:@"Address: %@",  patientMedication.pharmaddress];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];
     
    } else if (indexPath.row == 4) {
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[refill.sentdate integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
        NSString *timeString =  [formatter stringFromDate:dob];;
        cell.nameLabel.text = [NSString stringWithFormat:@"Sent: %@", timeString];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
    }  else if (indexPath.row == 5) {
        
        NSString *refillStatus = @"Pending";
        
        if ([refill.refillstatus intValue] == 0) {
            refillStatus = @"Pending";
        } else if ([refill.refillstatus intValue] == 1) {
            refillStatus = @"Accepted";
           
        } else if ([refill.refillstatus intValue] == 2) {
            refillStatus = @"Declined";
            
        }
        

        
        //  cell.allergen = patientInfo;
        cell.nameLabel.text = [NSString stringWithFormat:@"Status: %@",  refillStatus];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)profileClick:(id)sender {
    if (self.isRefill == true) {
        PatientDetailViewController *vc = [[PatientDetailViewController alloc] initWithNibName:@"PatientDetailViewController" bundle:nil];
        vc.patient = self.patient;
        //  vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



@end
