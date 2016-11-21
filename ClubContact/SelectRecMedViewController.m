//
//  SelectRecMedViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SelectRecMedViewController.h"
#import "SWRevealViewController.h"

@interface SelectRecMedViewController () <RefillMedInfoDelegate>

@end

@implementation SelectRecMedViewController


@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize patientsArray;
@synthesize delegate;
@synthesize doctorArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    doctorArray = [[NSMutableArray alloc] init];
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
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
    
    //self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"MedRefillTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    self.title = @"SELECT MEDICATION";
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
- (IBAction)goBackToChose:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
    [self.revealViewController revealToggle:sender];
}


- (void)viewDidAppear:(BOOL)animated {
    // [menuTable reloadData];
   // [self getAllLinkedPatients];
    [self getPatientMedication];
}


- (void)viewDidDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}


- (void)getAllLinkedPatients {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getLinkPatients:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
          [SVProgressHUD dismiss];
        
        if (success)
        {
            
            [doctorArray removeAllObjects];
            [patientsArray removeAllObjects];
            for (PatientLinks *doc in conditions) {
               // [self getPatientMedication:doc];
            }
            
          //  [patientsArray addObjectsFromArray:conditions];
            //[doctorsTable reloadData];
        }
        
        //[patientsGrid.footer endRefreshing];
        //[patientsGrid.header endRefreshing];
        
    }];
    
}


//-(void)getPatientMedication:(PatientLinks *)patientl {

-(void)getPatientMedication {
   // [SVProgressHUD showWithStatus:@"Loading..."];
  /*  [[AppController sharedInstance] getAllMedicationByPatient2:patientInfo.postid doctor:patientInfo.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        [SVProgressHUD dismiss];
        if (success)
        {
            [patientsArray removeAllObjects];
            [patientsArray  addObjectsFromArray:conditions];
           // [menuTable reloadData];
   
        }
    }];*/
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    [[AppController sharedInstance] getAllMedicationForPatients:@"" doctor:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        [SVProgressHUD dismiss];
        if (success)
        {
            [patientsArray removeAllObjects];
            [patientsArray  addObjectsFromArray:conditions];
            
            [menuTable reloadData];
        }
        
    }];
    
    
    /*[[AppController sharedInstance] getAllMedicationByPatientForRefill:patientl.postid doctor:patientl.docid patient:patientl WithCompletion:^(BOOL success, NSString *message, PatientLinks *patientLink, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
           // [patientsArray removeAllObjects];
            [patientsArray  addObjectsFromArray:conditions];
            
              for (Condition  *doc in conditions) {
                  [doctorArray addObject:patientLink];
              }
            
            //[doctorArray addObject:patientLink];
            // [menuTable reloadData];
            
        }
    }];*/
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (patientsArray ) {
        return patientsArray.count;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   /* PatientLinks *plink = [doctorArray objectAtIndex:section];
    
    NSString *titleLabel = [NSString stringWithFormat:@"Dr. %@ %@",plink.docfname, plink.doclname];
    
    return titleLabel;*/
    
    return @"";
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MedRefillTableViewCell *cell = (MedRefillTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    cell.cellImageView.image = [UIImage imageNamed:@"medicationColor"];
    
    PatientMedication *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
   // PatientLinks *plink = [doctorArray objectAtIndex: indexPath.section];
    NSString *titleLabel = [NSString stringWithFormat:@"Prescribed by Dr. %@ %@",patientInfo2.docfname, patientInfo2.doclname];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", patientInfo2.medname, patientInfo2.requests];
   // cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    cell.docLabel.text = titleLabel;
    
    cell.docButton.tag = indexPath.row;
    //[cell.docButton addTarget:self action:@selector(openDocProfile:) forControlEvents:UIControlEventTouchUpInside];
    cell.docButton.hidden = true;
    // cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
    cell.clipsToBounds = YES;
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   PatientMedication *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
  
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getLinkPatients:patientInfo2.patientid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
       
        [SVProgressHUD dismiss];
        if (success) {
            if (conditions.count > 0) {
                PatientLinks *plink = [conditions objectAtIndex:0];
               
                RefillMedInfoViewController *vc = [[RefillMedInfoViewController alloc] initWithNibName:@"RefillMedInfoViewController" bundle:nil];
                vc.patientLink = plink;
                vc.medication = patientInfo2;
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
    }];

    
}

- (void)refreshRefillMedication {
    [self getAllLinkedPatients];
   // [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)openDocProfile:(UIButton *)sender {
    PatientLinks *plink = [doctorArray objectAtIndex: sender.tag];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getDoctorProfile2:plink.docid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
         [SVProgressHUD dismiss];
        if (success) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            DoctorProfilePatientViC *vc = (DoctorProfilePatientViC *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfilePatientViC"];
            vc.doctor = doctorProfile;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }];
    
}


@end
