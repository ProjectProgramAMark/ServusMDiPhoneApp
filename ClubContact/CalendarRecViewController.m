//
//  CalendarRecViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "CalendarRecViewController.h"

@interface CalendarRecViewController ()

@end

@implementation CalendarRecViewController

@synthesize patientsArray;
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
  //  self.navigationItem.rightBarButtonItem = notiButtonItem;
    

    
    [doctorsTable registerNib:[UINib nibWithNibName:@"DoctorCellV2" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    [self getAllLinkedPatients];
    
    self.title = @"SELECT YOUR DOCTOR";
    
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

- (void)getAllLinkedPatients {
    [[AppController sharedInstance] getLinkPatients:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        
        
        if (success)
        {
            
            [patientsArray removeAllObjects];
            
            [patientsArray addObjectsFromArray:conditions];
            [doctorsTable reloadData];
        }
        

        
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
   /* DashboardDoctorCell *cell = (DashboardDoctorCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    PatientLinks *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
    NSString *isOnline = @"Offline";
    if ([patientInfo.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Online";
        cell.onlineLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = true;
        cell.messageIcon.selected = true;
    } else if ([patientInfo.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Offline";
        cell.onlineLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = false;
        cell.messageIcon.selected = false;
    }
    
    
    cell.facetimeIcon.tag = indexPath.row;
    cell.messageIcon.tag = indexPath.row;
    [cell.facetimeIcon addTarget:self action:@selector(openVideoChat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageIcon addTarget:self action:@selector(openMessaging:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.docfname, patientInfo.doclname];
    cell.specialityLabel.text = patientInfo.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.docprof]];
    // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    
    return cell;*/
    
    DoctorCellV2 *cell = (DoctorCellV2 *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
   PatientLinks *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
     
   
    if ([patientInfo.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Available";
        cell.onlineLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = true;
        cell.messageIcon.selected = true;
    } else if ([patientInfo.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Unavailable";
        cell.onlineLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        
        
        cell.facetimeIcon.selected = false;
        cell.messageIcon.selected = false;
    }
    
    cell.facetimeIcon.tag = indexPath.row;
    cell.messageIcon.tag = indexPath.row;
    [cell.facetimeIcon addTarget:self action:@selector(openVideoChat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageIcon addTarget:self action:@selector(openMessaging:) forControlEvents:UIControlEventTouchUpInside];
    cell.facetimeIcon.hidden = true;
    cell.messageIcon.hidden = true;
    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.firstname, patientInfo.firstname];
    cell.specialityLabel.text = patientInfo.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
    // cell.nameLabel.text = imageName;
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    
    cell.clipsToBounds = YES;
    

    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PatientLinks *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
   
    PMasterNewAppViewController *vc = [[PMasterNewAppViewController alloc] initWithNibName:@"PMasterNewAppViewController" bundle:nil];
    vc.patientLink = patientInfo;

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





- (IBAction)openVideoChat:(UIButton *)sender {
    
    PatientLinks *patientInfo = [patientsArray objectAtIndex:sender.tag];
    
    NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
    
    if (patientChose) {
        
        [[AppController sharedInstance] getDoctorProfile2:patientInfo.docid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
            if (success) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                
                Pharmacy *pharmacy = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyObj"]];
                TalkCreateViewController *vc = (TalkCreateViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkCreateViewController"];
                vc.doctor =doctorProfile;
                vc.allergenArray = [NSMutableArray array];
                vc.selectedConditions = [NSMutableArray array];
                vc.pharmacy = pharmacy;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        
        
        
    } else {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Set Up Profile" message:@"You have not completed your profile yet" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *accessAction = [UIAlertAction actionWithTitle:@"Complete Profile" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
          
            ShortQuestViewController *vc = [[ShortQuestViewController alloc] initWithNibName:@"ShortQuestViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }];
        
        
        
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //  [self dismissViewControllerAnimated:self completion:nil];
            
        }];
        
        [actionSheet addAction:accessAction];
        
        [actionSheet addAction:cancelAction];
        if (IS_IPHONE) {
            [self presentViewController:actionSheet animated:YES completion:nil];
        } else {
            UIPopoverPresentationController *popPresenter = [actionSheet
                                                             popoverPresentationController];
            popPresenter.sourceView = self.navigationController.view;
            popPresenter.sourceRect = CGRectMake(windowWidth/2 - 150.0f, 0, 300, 400);
            [self presentViewController:actionSheet animated:YES completion:nil];
        }
    }
    
    
}

- (IBAction)openMessaging:(UIButton *)sender {
    PatientLinks *patientInfo = [patientsArray objectAtIndex:sender.tag];
    [[AppController sharedInstance] getDoctorProfile2:patientInfo.docid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        if (success) {
            
           
            MesDocProfileViewController *vc = [[MesDocProfileViewController alloc] initWithNibName:@"MesDocProfileViewController" bundle:nil];
            vc.doctor = doctorProfile;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}




@end
