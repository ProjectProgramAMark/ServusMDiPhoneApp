//
//  CalendarDetailViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/19/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "CalendarDetailViewController.h"
#import "Chameleon.h"
#import "UIImageView+WebCache.h"

@interface CalendarDetailViewController () <PatientsDetailDelegate>

@end

@implementation CalendarDetailViewController

@synthesize ckEvent;
@synthesize appointment;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPop:)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
//    self.navigationController.navigationBar.barTintColor = [UIColor flatYellowColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    //self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    self.title = @"APPOINTMENT DETAILS";
    
     [menuTable registerNib:[UINib nibWithNibName:@"PatientRecordAboutCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelPop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[appointment.fromdate integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
    NSString *timeString =  [formatter stringFromDate:dob];
    
    NSDate *dob2 = [NSDate dateWithTimeIntervalSince1970:[appointment.todate integerValue]];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"dd MMMM yyyy HH:MM"];
    NSString *timeString2 =  [formatter2 stringFromDate:dob2];
    
    fromTimeLabel1.text = [NSString stringWithFormat:@"From: %@",timeString];
    toTimeLabel1.text = [NSString stringWithFormat:@"To: %@",timeString2];
  
    nameLabel.text = [NSString stringWithFormat:@"%@ %@", appointment.firstname, appointment.lastname];
    emailLabel.text = [NSString stringWithFormat:@"Email: %@", appointment.patientemail];
    teleLabel.text = [NSString stringWithFormat:@"Phone: %@", appointment.patienttele];
    noteText.text =  [NSString stringWithFormat:@"Note: %@", appointment.appnotes];
    
    profIMG.layer.cornerRadius = profIMG.frame.size.width/2;
    profIMG.layer.masksToBounds = YES;
    profIMG.layer.borderColor = [UIColor blackColor].CGColor;
    profIMG.layer.borderWidth = 1.0;
    
    
    
    [profIMG setImageWithURL:[NSURL URLWithString:appointment.patientProfIMG]];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}


- (IBAction)accessPatientRecord:(id)sender {
    Doctor *doc = [Doctor getFromUserDefault];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getPatientProfile:doc.uid keyword:appointment.patientid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patiens) {
        [SVProgressHUD dismiss];
        if (success) {
            Patient *patientInfo = [patiens objectAtIndex:0];
   
            PatientDetailViewController *vc = [[PatientDetailViewController alloc] initWithNibName:@"PatientDetailViewController" bundle:nil];
            vc.patient = patientInfo;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (appointment) {
        return 5;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PatientRecordAboutCell    *cell = (PatientRecordAboutCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    // if (_addedConditionsArray.count > 0) {
    if (indexPath.row == 0) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Email: %@", appointment.patientemail];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
    } else if (indexPath.row == 1) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Telephone: %@", appointment.patienttele];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
    }  else if (indexPath.row == 2) {
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[appointment.fromdate integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
        NSString *timeString =  [formatter stringFromDate:dob];;
        cell.nameLabel.text = [NSString stringWithFormat:@"From: %@", timeString];
        cell.nameLabel.textColor = [UIColor colorWithRed:209.0f/255.0f green:104.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"phonebook.png"];
    }  else if (indexPath.row == 3) {
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[appointment.todate integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
        NSString *timeString =  [formatter stringFromDate:dob];;
        cell.nameLabel.text = [NSString stringWithFormat:@"To: %@", timeString];
        cell.nameLabel.textColor = [UIColor colorWithRed:209.0f/255.0f green:104.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"phonebook.png"];
    } else if (indexPath.row == 4) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Patient Record"];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 4) {
        //    Doctor *doctor = [Doctor ]
        Doctor *doc = [Doctor getFromUserDefault];
        
        [[AppController sharedInstance] getPatientProfile:doc.uid keyword:appointment.patientid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patiens) {
            if (success) {
                Patient *patientInfo = [patiens objectAtIndex:0];
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                SharedPatientProfileViewController *vc = (SharedPatientProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"SharedPatientProfileViewController"];
                vc.patient = patientInfo;
                //vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }];
        
    }
    
}



- (void)refreshPatientList {
    
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
