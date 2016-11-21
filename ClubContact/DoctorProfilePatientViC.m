//
//  DoctorProfilePatientViC.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DoctorProfilePatientViC.h"
#import "UIImageView+WebCache.h"

@interface DoctorProfilePatientViC ()

@end

@implementation DoctorProfilePatientViC

@synthesize doctor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [menuTable registerNib:[UINib nibWithNibName:@"DocMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    if (IS_IPHONE) {
        [menuTable registerNib:[UINib nibWithNibName:@"DocMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    } else {
        [menuTable registerNib:[UINib nibWithNibName:@"DashboardDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    }
    

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    
    self.title = @"DOCTOR PROFILE";

}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadDoctorData];
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
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

- (void)loadDoctorData {
    if (doctor) {
        [profileIMG setImageWithURL:[NSURL URLWithString:doctor.profileimage]];
        
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
        profileIMG.layer.masksToBounds = YES;
        profileIMG.layer.borderColor = [UIColor blackColor].CGColor;
        profileIMG.layer.borderWidth = 1.0f;
         
        docName.text = [NSString stringWithFormat:@"Dr. %@ %@", doctor.firstname, doctor.lastname];
        docSpeciality.text = doctor.speciality;
        docFrom.text = [NSString stringWithFormat:@"From %@ %@ %@ %@ %@", doctor.officeaddress, doctor.officecity, doctor.officestate, doctor.officezip, doctor.officecountry];
        
        NSString *isOnline = @"Offline";
        if ([doctor.isOnline intValue] == 1) {
            //isOnline = @"Online";
            docOnline.text = @"Available";
            docOnline.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
            
        } else if ([doctor.isOnline intValue] == 2) {
            docOnline.text = @"Unavailable";
            docOnline.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            
        }
        
        
        
        
    }
}




- (IBAction)goToDoctorProfileInfo:(id)sender {
    DocProfileInfoViewController *vc = [[DocProfileInfoViewController alloc] init];
    vc.doctor = doctor;
    vc.isConsultation = true;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (IBAction)goToReviews:(id)sender {
    ReviewsViewController *vc = [[ReviewsViewController alloc] initWithNibName:@"ReviewsViewController" bundle:nil];
    vc.doctor = doctor;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goToPreviousConsultations:(id)sender {
    TalkConPreviousViewController *vc = [[TalkConPreviousViewController alloc] initWithNibName:@"TalkConPreviousViewController" bundle:nil];
    vc.doctor = doctor;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToNewConsultations:(id)sender {
    
    NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
    
    if (patientChose) {
        
        Pharmacy *pharmacy = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyObj"]];
        TalkCreateViewController *vc = [[TalkCreateViewController alloc] initWithNibName:@"TalkCreateViewController" bundle:nil];
        vc.doctor = doctor;
        vc.allergenArray = [NSMutableArray array];
        vc.selectedConditions = [NSMutableArray array];
        vc.pharmacy = pharmacy;
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Set Up Profile" message:@"You have not completed your profile yet" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *accessAction = [UIAlertAction actionWithTitle:@"Complete Profile" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            ShortQuestViewController *vc = [[ShortQuestViewController alloc] initWithNibName:@"ShortQuestViewController" bundle:nil] ;
            
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

- (IBAction)goToNewMessaging:(id)sender {
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    [[AppController sharedInstance] createNewMSGSession:doctor.uid WithCompletion:^(BOOL success, NSString *message, NSString *msgID) {
        [SVProgressHUD dismiss];
        if (success) {
            [self loadMessagingView:msgID];
        }
    }];
}

- (IBAction)goToPreviousMessaging:(id)sender {
     MesHistoryViewController *vc = [[MesHistoryViewController alloc] initWithNibName:@"MesHistoryViewController" bundle:nil];
    vc.doctor = doctor;
    
    [self.navigationController pushViewController:vc animated:YES];
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE) {
        
    DocMenuTableViewCell    *cell = (DocMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
    
    
    
    /*if (indexPath.row == 0) {
        cell.nameLabel.text = @"Message";
        cell.nameLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"messageIconRed.png"];
    } else if (indexPath.row == 1) {
        cell.nameLabel.text = @"My Patient Record";
        cell.nameLabel.textColor = [UIColor colorWithRed:67.0f/255.0f green:148.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patientIconBlue.png"];
    } else if (indexPath.row == 2) {
        cell.nameLabel.text = @"Appointments";
        cell.nameLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:67.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"appointmentIconBrown.png"];
    } else if (indexPath.row == 3) {
        cell.nameLabel.text = @"Online Consultations";
        cell.nameLabel.textColor = [UIColor colorWithRed:224.0f/255.0f green:0.0f/255.0f blue:81.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"consultationIconPink.png"];
    } else if (indexPath.row == 4) {
        cell.nameLabel.text = @"Medication";
        cell.nameLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"medical109.png"];
    } else if (indexPath.row == 5) {
        cell.nameLabel.text = @"Reviews";
        cell.nameLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"bookmark46.png"];
    }*/
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"New Session";
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Previous Sessions";
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"New Consultation";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Previous Consultations";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Reviews";
            cell.nameLabel.textColor = [UIColor colorWithRed:140.0f/255.0f green:88.0f/255.0f blue:177.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"perfect1.png"];
        }
        
    cell.clipsToBounds = YES;
    
    return cell;
        
    } else {
       DashboardDocTableViewCell  *cell = (DashboardDocTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"New Session";
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Previous Sessions";
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"New Consultation";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Previous Consultations";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Reviews";
            cell.nameLabel.textColor = [UIColor colorWithRed:140.0f/255.0f green:88.0f/255.0f blue:177.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"perfect1.png"];
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
        [[AppController sharedInstance] createNewMSGSession:doctor.uid WithCompletion:^(BOOL success, NSString *message, NSString *msgID) {
            if (success) {
                [self loadMessagingView:msgID];
            }
        }];
    } else if (indexPath.row == 1) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MesHistoryViewController *vc = (MesHistoryViewController *)[sb instantiateViewControllerWithIdentifier:@"MesHistoryViewController"];
        vc.doctor = doctor;
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
        
        if (patientChose) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            
            Pharmacy *pharmacy = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyObj"]];
            TalkCreateViewController *vc = (TalkCreateViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkCreateViewController"];
            vc.doctor = doctor;
            vc.allergenArray = [NSMutableArray array];
            vc.selectedConditions = [NSMutableArray array];
            vc.pharmacy = pharmacy;
            
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Set Up Profile" message:@"You have not completed your profile yet" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *accessAction = [UIAlertAction actionWithTitle:@"Complete Profile" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                ShortQuestViewController *vc = (ShortQuestViewController  *)[sb instantiateViewControllerWithIdentifier:@"ShortQuestViewController"];
                
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
        
    } else if (indexPath.row == 3) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        TalkConPreviousViewController *vc = (TalkConPreviousViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkConPreviousViewController"];
        vc.doctor = doctor;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 4) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ReviewsViewController *vc = (ReviewsViewController *)[sb instantiateViewControllerWithIdentifier:@"ReviewsViewController"];
        vc.doctor = doctor;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}




- (void)loadMessagingView:(NSString *)msgID {
    
    [[AppController sharedInstance] getMSGSessionsByID2:doctor.uid sessionID:msgID WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
        if (success) {
            BOOL isClosed = false;
            PatientMessagingView *vc = [[PatientMessagingView  alloc] initWithNibName:@"PatientMessagingView" bundle:nil];
            vc.doctorV2 = doctor;
            vc.msgSession = msgsession;
            vc.isClosedSessionOpen = false;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
}




@end
