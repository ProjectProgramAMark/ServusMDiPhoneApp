//
//  PatientRecAppointmentVC.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PatientRecAppointmentVC.h"

@interface PatientRecAppointmentVC ()

@end

@implementation PatientRecAppointmentVC


@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize patientsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"ConditionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    self.title = @"APPOINTMENTS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)viewDidAppear:(BOOL)animated {
    // [menuTable reloadData];
    [self getPatientAppointments];
}



- (void)getPatientAppointments {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllAppointmensByPatient2:patientInfo.postid doctor:patientInfo.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [profPatient.appointments removeAllObjects];
            [profPatient.appointments addObjectsFromArray:conditions];
            [menuTable reloadData];
            
           
        }
    }];
    
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (profPatient) {
        return profPatient.appointments.count;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ConditionsTableViewCell   *cell = (ConditionsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
      Appointments *patientInfo2 = [profPatient.appointments objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo2.apptitle];
    
    cell.clipsToBounds = YES;
    
   
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    Appointments *appt = [profPatient.appointments objectAtIndex:indexPath.row];
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getLinkPatients:appt.patientid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        
        if (success) {
            if (conditions.count > 0) {
                PatientLinks *plink = [conditions objectAtIndex:0];
                
                [[AppController sharedInstance] getDoctorProfile2:plink.docid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
                    [SVProgressHUD dismiss];
                    if (success) {
                        PMasterCalDetailsViewController *vc = [[PMasterCalDetailsViewController alloc] initWithNibName:@"PMasterCalDetailsViewController" bundle:nil];
                        vc.appointment = appt;
                        vc.doctor = doctorProfile;
                        vc.patientInfo = plink;
                        if ([appt.patientid isEqual:plink.postid]) {
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
       

}

- (void)refreshCalendar {
    [self getPatientAppointments];
}




@end
