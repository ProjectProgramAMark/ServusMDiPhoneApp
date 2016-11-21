//
//  MyProfileConsultationHistory.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/29/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MyProfileConsultationHistory.h"
#import "SWRevealViewController.h"

@interface MyProfileConsultationHistory ()

@end

@implementation MyProfileConsultationHistory


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // [menuTable registerNib:[UINib nibWithNibName:@"DocMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    consultationsArray = [[NSMutableArray alloc] init];
    [menuTable registerNib:[UINib nibWithNibName:@"ConsultationTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    
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
    self.navigationItem.rightBarButtonItem = notiButtonItem;
    self.title = @"CONSULTATIONS";
}

- (void)viewWillAppear:(BOOL)animated {
    //  [self loadDoctorData];
    [self loadConsultations];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
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
            [self.revealViewController revealToggle:sender];
}

- (void)loadConsultations
{
    [SVProgressHUD showWithStatus:@"Loading..."];
   [[AppController sharedInstance] getAllConsultations3:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
       [SVProgressHUD dismiss];
        if (success)
        {
            
            [consultationsArray removeAllObjects];
            [consultationsArray addObjectsFromArray:conditions];
            [menuTable reloadData];
        }
        
  
    }];
}




- (void)loadDoctorData {
    /*if (doctor) {
        [profileIMG setImageWithURL:[NSURL URLWithString:doctor.profileimage]];
        [profileBackIMG setImageWithURL:[NSURL URLWithString:doctor.profileimage]];
        
        
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
        profileIMG.layer.masksToBounds = YES;
        profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        profileIMG.layer.borderWidth = 3.0;
        
        docName.text = [NSString stringWithFormat:@"Dr. %@ %@", doctor.firstname, doctor.lastname];
        docSpeciality.text = doctor.speciality;
        docFrom.text = [NSString stringWithFormat:@"From %@ %@ %@ %@ %@", doctor.officeaddress, doctor.officecity, doctor.officestate, doctor.officezip, doctor.officecountry];
        
        NSString *isOnline = @"Offline";
        if ([doctor.isOnline intValue] == 1) {
            //isOnline = @"Online";
            docOnline.text = @"Online";
            docOnline.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
        } else if ([doctor.isOnline intValue] == 2) {
            docOnline.text = @"Offline";
            docOnline.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
        }
        
        
        
    }*/
}

- (IBAction)addNewConsultation:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    ShortQuestViewController *vc = [[ShortQuestViewController alloc] initWithNibName:@"ShortQuestViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return consultationsArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsultationTableViewCell *cell = ( ConsultationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    
    Consulatation *noteDic = [consultationsArray objectAtIndex:indexPath.row];
    
    @try {
        
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[noteDic.consultime integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
        NSString *timeString =  [formatter stringFromDate:dob];;
        
        NSString *statusString = @"";
        
        if ([noteDic.ctype isEqual:@"0"]) {
            statusString = @"Pending";
            cell.statusLabel.text = statusString;
            cell.statusLabel.textColor  = [UIColor colorWithRed:228.0f/255.0f green:193.0f/255.0f blue:91.0f/255.0f alpha:1.0f];

            
            
        } else if ([noteDic.ctype isEqual:@"1"]) {
            statusString = @"Accepted";
            cell.statusLabel.text = statusString;
            cell.statusLabel.textColor  = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
            
        } else if ([noteDic.ctype isEqual:@"2"]) {
            statusString = @"Declined";
            cell.statusLabel.text = statusString;
            cell.statusLabel.textColor  = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            
        }
        
        cell.dateLabel.text = [NSString stringWithFormat:@"%@", timeString];
       // cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@", noteDic.dfirstname, noteDic.dlastname];
      
        
        cell.clipsToBounds = YES;
        
        
    }
    @catch (NSException *exception) {
        
    }
    
    
    
    
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        return 90.0f;
    } else {
        return 90.0f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Consulatation *noteDic = [consultationsArray objectAtIndex:indexPath.row];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getDoctorProfile2:noteDic.did WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success) {
           
            DoctorProfilePatientViC *vc = [[DoctorProfilePatientViC alloc] initWithNibName:@"DoctorProfilePatientViC" bundle:nil];
            vc.doctor = doctorProfile;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }];
    return;
    
    
    //Consulatation *noteDic = [consultationsArray objectAtIndex:indexPath.row];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Consultation" message:@"Select an option" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *audoAction = [UIAlertAction actionWithTitle:@"Call Audio" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:noteDic.clink]];
        [QBRequest  userWithLogin:[NSString stringWithFormat:@"user-%@", noteDic.did] successBlock:^(QBResponse *response, QBUUser *user) {
            docQB = user;
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.docQB = user;
            [self callWithConferenceType:QBRTCConferenceTypeAudio];
            
        } errorBlock:^(QBResponse *response) {
            NSLog(@"error: %@", response.error);
            
        }];
        
        
        
    }];
    
    UIAlertAction *videoAction = [UIAlertAction actionWithTitle:@"Call Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
        
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:noteDic.clink]];
        [QBRequest  userWithLogin:[NSString stringWithFormat:@"user-%@", noteDic.did] successBlock:^(QBResponse *response, QBUUser *user) {
            docQB = user;
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.docQB = user;
            [self callWithConferenceType:QBRTCConferenceTypeVideo];
            
        } errorBlock:^(QBResponse *response) {
            NSLog(@"error: %@", response.error);
            
        }];
        
    }];
    
    UIAlertAction *copyAction = [UIAlertAction actionWithTitle:@"Copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        /*  NSString *copyStringverse = noteDic.clink;
         UIPasteboard *pb = [UIPasteboard generalPasteboard];
         [pb setString:copyStringverse];*/
        
    }];
    
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //  [self dismissViewControllerAnimated:self completion:nil];
        
    }];
    
    if ([noteDic.ctype isEqual:@"1"]) {
        
        [actionSheet addAction:audoAction];
        [actionSheet addAction:videoAction];
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



- (IBAction)openDocProfile:(UIButton *)sender {
     Consulatation *noteDic = [consultationsArray objectAtIndex:sender.tag];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getDoctorProfile2:noteDic.did WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            DoctorProfilePatientViC *vc = (DoctorProfilePatientViC *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfilePatientViC"];
            vc.doctor = doctorProfile;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }];
    
}


- (void)callWithConferenceType:(QBRTCConferenceType)conferenceType {
    
    
    [CallManager.instance callToUsers:[NSArray arrayWithObject:docQB]
                   withConferenceType:conferenceType];
    
}





@end
