//
//  RefillDetailsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/18/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "RefillDetailsViewController.h"

@interface RefillDetailsViewController ()

@end

@implementation RefillDetailsViewController

@synthesize patient;
@synthesize patientMedication;
@synthesize refill;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 //   [acceptedButton setBackgroundColor:[UIColor flatLimeColor]];
  //  [declineButton setBackgroundColor:[UIColor flatRedColor]];
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
     [menuTable registerNib:[UINib nibWithNibName:@"PatientRecordAboutCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    
    self.title = @"REFILL DETAILS";
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
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
}

- (void)refreshData {
    drugName.text = patientMedication.medname;
    
    doseLabel.text = [NSString stringWithFormat:@"Dose %@ %@", patientMedication.dose, patientMedication.doseunit];
    
    pharmacyName.text = [NSString stringWithFormat:@"Pharmacy: %@", patientMedication.pharmacy];
    pharmcyAddress.text = [NSString stringWithFormat:@"Address: %@", patientMedication.pharmaddress];
    
    double unixTimeStamp =[refill.sentdate doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:destinationDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    
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
    sentLabel.text = [NSString stringWithFormat:@"Sent: %@", dateString];
    updateLabel.text = [NSString stringWithFormat:@"Updated: %@", dateString2];
}

- (IBAction)acceptedClick:(id)sender {
   [[AppController sharedInstance] acceptRefill:refill.refillid completion:^(BOOL success, NSString *message) {
       if (success) {
           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Refill request accepted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
           [alert show];
           [self.delegate refreshRefillMedication];
           [self dismissViewControllerAnimated:YES completion:nil];
       }
   }];
}

- (IBAction)declineClick:(id)sender {
    
    
    [[AppController sharedInstance] declineRefill:refill.refillid completion:^(BOOL success, NSString *message) {
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Refill request declined" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [self.delegate refreshRefillMedication];
            [self dismissViewControllerAnimated:YES completion:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
