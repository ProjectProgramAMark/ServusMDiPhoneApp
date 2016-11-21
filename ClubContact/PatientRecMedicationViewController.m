//
//  PatientRecMedicationViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PatientRecMedicationViewController.h"

@interface PatientRecMedicationViewController () <RefillMedInfoDelegate>

@end

@implementation PatientRecMedicationViewController


@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize patientsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"MedRefillTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    self.title = @"MEDICATION";
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
    [self getPatientMedication];
}



-(void)getPatientMedication {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllMedicationByPatient2:patientInfo.postid doctor:patientInfo.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        [SVProgressHUD dismiss];
        if (success)
        {
            [profPatient.medications removeAllObjects];
            [profPatient.medications addObjectsFromArray:conditions];
            [menuTable reloadData];
            
           /* if (conditions.count > 1) {
                refillNOLabel2.text = [NSString stringWithFormat:@"%i Prescriptions", (int)conditions.count];
            } else {
                refillNOLabel2.text = [NSString stringWithFormat:@"%i Prescriptions", (int)conditions.count];
            }*/
        }
    }];
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (profPatient.medications.count) {
        return profPatient.medications.count;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MedRefillTableViewCell    *cell = (MedRefillTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
    
    PatientMedication *patientInfo2 = [profPatient.medications objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", patientInfo2.medname, patientInfo2.requests];

    NSString *titleLabel = [NSString stringWithFormat:@"Prescribed by Dr. %@ %@",patientInfo.docfname, patientInfo.doclname];
    
    cell.docLabel.text = titleLabel;
    cell.clipsToBounds = YES;
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PatientMedication *patientInfo2 = [profPatient.medications objectAtIndex:indexPath.row];
   // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    RefillMedInfoViewController *vc = [[RefillMedInfoViewController alloc] initWithNibName:@"RefillMedInfoViewController" bundle:nil];
    vc.patientLink = patientInfo;
    vc.medication = patientInfo2;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    

}



- (void)refreshRefillMedication {
    [self getPatientMedication];
}

@end
