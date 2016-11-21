//
//  PatientRecordProfViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PatientRecordProfViewController.h"
#import "UIImageView+WebCache.h"

@interface PatientRecordProfViewController ()

@end

@implementation PatientRecordProfViewController

@synthesize doctor;
@synthesize patientInfo;
@synthesize profPatient;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    
    if (IS_IPHONE) {
        [menuTable registerNib:[UINib nibWithNibName:@"DocMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    } else {
        [menuTable registerNib:[UINib nibWithNibName:@"DashboardDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    }
    self.title = @"PATIENT RECORD";
    
    //menuTable.tableHeaderView = statView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self loadPatient];
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadPatient {
    [profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
    [profileBackIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
    
    
    profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
    profileIMG.layer.masksToBounds = YES;
    profileIMG.layer.borderColor = [UIColor blackColor].CGColor;
    profileIMG.layer.borderWidth = 1.0;
    
    docName.text = [NSString stringWithFormat:@"%@ %@", patientInfo.firstname, patientInfo.lastname];
    docSpeciality.text = patientInfo.occupation;
   /* docFrom.text = [NSString stringWithFormat:@"From %@ %@ %@ %@ %@ %@", patientInfo.street1, patientInfo.street2, patientInfo.city, patientInfo.state,patientInfo.zipcode, patientInfo.country];
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[patientInfo.dob integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    // title = [formatter stringFromDate:dob];
    
    pDob.text = [NSString stringWithFormat:@"Born on %@", [formatter stringFromDate:dob]];*/
     [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getPatientProfile:patientInfo.docid keyword:patientInfo.postid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patiens) {
        [SVProgressHUD dismiss];
        if (success) {
            if (patiens.count == 1) {
                profPatient = [patiens objectAtIndex:0];
            }
        }
        
    }];
    
}

- (IBAction)goToPatientInfo:(id)sender {
    PatientRecAboutViewController *vc = [[PatientRecAboutViewController alloc] init];
    vc.profPatient = profPatient;
    vc.patientInfo = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goToMeds:(id)sender {
    
    PatientRecMedicationViewController *vc = [[PatientRecMedicationViewController alloc] initWithNibName:@"PatientRecMedicationViewController" bundle:nil];
    vc.profPatient = profPatient;
    vc.patientInfo = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToConditions:(id)sender {
    PatientRecConditionsVC *vc = [[PatientRecConditionsVC alloc] initWithNibName:@"PatientRecConditionsVC" bundle:nil];
    vc.profPatient = profPatient;
    vc.patientInfo = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToAllergies:(id)sender {
    PatientRecAllergyViewController *vc = [[PatientRecAllergyViewController alloc] initWithNibName:@"PatientRecAllergyViewController" bundle:nil];
    vc.profPatient = profPatient;
    vc.patientInfo = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToAppointments:(id)sender {
    PatientRecAppointmentVC *vc = [[PatientRecAppointmentVC alloc] initWithNibName:@"PatientRecAppointmentVC" bundle: nil];
    vc.profPatient = profPatient;
    vc.patientInfo = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToNotes:(id)sender {
    PaitentRecNotesViewController *vc = [[PaitentRecNotesViewController alloc] initWithNibName:@"PaitentRecNotesViewController" bundle:nil] ;
    vc.profPatient = profPatient;
    vc.patientInfo = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goToShareRecord:(id)sender {
    SendPatientRecViewController  *vc = [[SendPatientRecViewController alloc] initWithNibName:@"SendPatientRecViewController" bundle:nil];
    vc.profPatient = profPatient;
    vc.patientInfo = patientInfo;
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE) {
        
        DocMenuTableViewCell    *cell = (DocMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
        
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"Profile Info";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Medications";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Conditions";
            cell.nameLabel.textColor = [UIColor colorWithRed:241.0f/255.0f green:201.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-box-icon.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Allergies";
            cell.nameLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"human-brain-icon.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Notes";
            cell.nameLabel.textColor = [UIColor colorWithRed:150.0f/255.0f green:197.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"appointmenticonv2.png"];
        } else if (indexPath.row == 5) {
            cell.nameLabel.text = @"Appointments";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:143.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
        } else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Send Records";
            cell.nameLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:74.0f/255.0f blue:91.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"shareiconv2.png"];
        }
        
    
      
        
        cell.clipsToBounds = YES;
        
        return cell;
        
    } else {
        DashboardDocTableViewCell  *cell = (DashboardDocTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"Profile Info";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Medications";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Conditions";
            cell.nameLabel.textColor = [UIColor colorWithRed:241.0f/255.0f green:201.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-box-icon.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Allergies";
            cell.nameLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"human-brain-icon.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Notes";
            cell.nameLabel.textColor = [UIColor colorWithRed:150.0f/255.0f green:197.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"appointmenticonv2.png"];
        } else if (indexPath.row == 5) {
            cell.nameLabel.text = @"Appointments";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:143.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
        } else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Send Records";
            cell.nameLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:74.0f/255.0f blue:91.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"shareiconv2.png"];
        }
        cell.clipsToBounds = YES;
        
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        return 60.0f;
    } else {
        return 150.0f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
     
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientRecAboutViewController *vc = (PatientRecAboutViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientRecAboutViewController"];
        vc.profPatient = profPatient;
        vc.patientInfo = patientInfo;
        
        [self.navigationController pushViewController:vc animated:YES];

    } else if (indexPath.row == 1) {
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientRecMedicationViewController *vc = (PatientRecMedicationViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientRecMedicationViewController"];
        vc.profPatient = profPatient;
        vc.patientInfo = patientInfo;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 2) {
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientRecConditionsVC *vc = (PatientRecConditionsVC *)[sb instantiateViewControllerWithIdentifier:@"PatientRecConditionsVC"];
        vc.profPatient = profPatient;
        vc.patientInfo = patientInfo;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 3) {
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientRecAllergyViewController *vc = (PatientRecAllergyViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientRecAllergyViewController"];
        vc.profPatient = profPatient;
        vc.patientInfo = patientInfo;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 4) {
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PaitentRecNotesViewController *vc = (PaitentRecNotesViewController *)[sb instantiateViewControllerWithIdentifier:@"PaitentRecNotesViewController"];
        vc.profPatient = profPatient;
        vc.patientInfo = patientInfo;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 5) {
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientRecAppointmentVC *vc = (PatientRecAppointmentVC *)[sb instantiateViewControllerWithIdentifier:@"PatientRecAppointmentVC"];
        vc.profPatient = profPatient;
        vc.patientInfo = patientInfo;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 6) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        SendPatientRecViewController  *vc = (SendPatientRecViewController *)[sb instantiateViewControllerWithIdentifier:@"SendPatientRecViewController"];
        vc.profPatient = profPatient;
        vc.patientInfo = patientInfo;
    
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



@end
