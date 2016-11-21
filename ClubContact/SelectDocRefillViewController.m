//
//  SelectDocRefillViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SelectDocRefillViewController.h"

@interface SelectDocRefillViewController () <SelectDocRefillDelegate>

@end

@implementation SelectDocRefillViewController

@synthesize patientsArray;
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [doctorsTable registerNib:[UINib nibWithNibName:@"DashboardDoctorCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    [self getAllLinkedPatients];
    
    self.title = @"SELECT YOUR DOCTOR";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBackToChose:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
    [self.revealViewController revealToggle:sender];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)getAllLinkedPatients {
    [[AppController sharedInstance] getLinkPatients:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        
        
        if (success)
        {
            
            [patientsArray removeAllObjects];
            
            [patientsArray addObjectsFromArray:conditions];
            [doctorsTable reloadData];
        }
        
        //[patientsGrid.footer endRefreshing];
        //[patientsGrid.header endRefreshing];
        
    }];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [patientsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardDoctorCell *cell = (DashboardDoctorCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    PatientLinks *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
    NSString *isOnline = @"Offline";
    if ([patientInfo.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Online";
        cell.onlineLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
    } else if ([patientInfo.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Offline";
        cell.onlineLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
    }

    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.docfname, patientInfo.doclname];
    cell.specialityLabel.text = patientInfo.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.docprof]];
    // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   /* PatientLinks *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    PatientRecordProfViewController *vc = (PatientRecordProfViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientRecordProfViewController"];
    vc.patientInfo = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];*/
    /* Doctors *patientInfo = [patientsArray objectAtIndex:indexPath.row];
     
     UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
     DoctorProfilePatientViC *vc = (DoctorProfilePatientViC *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfilePatientViC"];
     vc.doctor = patientInfo;
     
     [self.navigationController pushViewController:vc animated:YES];*/
    PatientLinks *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    SelectRecMedViewController *vc = (SelectRecMedViewController *)[sb instantiateViewControllerWithIdentifier:@"SelectRecMedViewController"];
    vc.patientInfo = patientInfo;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewdelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (DashboardDoctorCell *cell in doctorsTable.visibleCells) {
        // [self updateImageViewCellOffset:cell];
    }
}




#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  [self updateImageViewCellOffset:(DashboardDoctorCell *)cell];
}


- (void)refreshRefillMedication {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
