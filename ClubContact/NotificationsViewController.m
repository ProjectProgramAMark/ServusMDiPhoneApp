//
//  NotificationsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 8/5/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "NotificationsViewController.h"
#import "SVProgressHUD.h"

@interface NotificationsViewController () <RefillMedInfoDelegate>

@end

@implementation NotificationsViewController

@synthesize conditionsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    conditionsArray = [NSMutableArray array];

    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    
    
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
    // Do any additional setup after loading the view.
    
    self.title = @"NOTIFICATIONS";
    
    [conditionTable addLegendHeaderWithRefreshingBlock:^{
        [self loadNotifications];
    }];
    
   [conditionTable registerNib:[UINib nibWithNibName:@"UnifiedReqTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    int notiCount =  (int)[UIApplication sharedApplication].applicationIconBadgeNumber;
    
    if (notiCount > 99) {
        notificationCountLabel.text = @"100+";
    } else {
        notificationCountLabel.text = [NSString stringWithFormat:@"%i", notiCount];
    }
    
    [self loadNotifications];
}


- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)loadNotifications {
     [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getPNotifications:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *array) {
        [SVProgressHUD dismiss];
        [conditionTable.header endRefreshing];
        if (success) {
            int notiCount = 0;
            for (Notifications *noti in array) {
                if ([noti.isRead intValue] == 0) {
                    notiCount += 1;
                } else {
              
                }
            }
            conditionsArray= [NSMutableArray arrayWithArray:array];
            //self.title = [NSString stringWithFormat:@"NOTIFICATIONS (%i)", notiCount];
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = notiCount;
            
            if (notiCount > 99) {
                notificationCountLabel.text = @"100+";
            } else {
                notificationCountLabel.text = [NSString stringWithFormat:@"%i", notiCount];
            }

            
            [conditionTable reloadData];
            [self markNotifcationsRead];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)markNotifcationsRead {
    [[AppController sharedInstance] markNotificationsRead:@"" completion:^(BOOL success, NSString *message) {
        if (success) {
            
        }
        
    }];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 1;
    
}


#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [conditionsArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // PharmacyListCell *cell = [tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
    
    ///PatientRecordAboutCell  *cell = (PatientRecordAboutCell  *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    UnifiedReqTableViewCell  *cell = (UnifiedReqTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    Notifications *patientInfo = [conditionsArray objectAtIndex:indexPath.row];
    
    if ([patientInfo.notiType isEqual:@"AcceptApp"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ accepted your appointment request.", patientInfo.ffirstname, patientInfo.flastname];
         cell.imgView.image = [UIImage imageNamed:@"days4"];
    } else if ([patientInfo.notiType isEqual:@"DeclineApp"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ declined your appointment request.", patientInfo.ffirstname, patientInfo.flastname];
        cell.imgView.image = [UIImage imageNamed:@"days4"];
    } else if ([patientInfo.notiType isEqual:@"AcceptConsul"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ accepted your consultation request.", patientInfo.ffirstname, patientInfo.flastname];
        
        cell.imgView.image = [UIImage imageNamed:@"videoChatIcon2"];
        
    } else if ([patientInfo.notiType isEqual:@"DeclineConsul"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ declined your consultation request.", patientInfo.ffirstname, patientInfo.flastname];
        
        cell.imgView.image = [UIImage imageNamed:@"videoChatIcon2"];
    } else if ([patientInfo.notiType isEqual:@"AcceptMessage"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ accepted your message request.", patientInfo.ffirstname, patientInfo.flastname];
        cell.imgView.image = [UIImage imageNamed:@"chatIcon2"];
        
    } else if ([patientInfo.notiType isEqual:@"DeclineMessage"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ declined your message request.", patientInfo.ffirstname, patientInfo.flastname];
       
        cell.imgView.image = [UIImage imageNamed:@"chatIcon2"];
        
    } else if ([patientInfo.notiType isEqual:@"AcceptRefill"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ accepted your refill request.", patientInfo.ffirstname, patientInfo.flastname];
        
       cell.imgView.image = [UIImage imageNamed:@"refillIcon2"];
        
    } else if ([patientInfo.notiType isEqual:@"DeclineRefill"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ declined your refill request.", patientInfo.ffirstname, patientInfo.flastname];
        
       cell.imgView.image = [UIImage imageNamed:@"refillIcon2"];
        
    } else if ([patientInfo.notiType isEqual:@"Message"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ sent you a message", patientInfo.ffirstname, patientInfo.flastname];
        
        cell.imgView.image = [UIImage imageNamed:@"chatIcon2"];
        
    }
    
   
    
       
    
    if ([patientInfo.isRead intValue] == 0) {
        cell.statusLabel.text = @"Unread";
        cell.statusLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        ;
        
    } else  {
        cell.statusLabel.text = @"Read";
        cell.statusLabel.textColor =  [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
    }
    
    double unixTimeStamp =[patientInfo.fcreated doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSDate* destinationDate = sourceDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
    cell.dateLabel.text = [formatter stringFromDate:destinationDate];
    
    

    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Notifications *patientInfo = [conditionsArray objectAtIndex:indexPath.row];
    if ([patientInfo.notiType isEqual:@"AcceptApp"]) {
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] getDoctorProfile2:patientInfo.fuid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
           
            if (success) {
                [[AppController sharedInstance] getSingleAppointmens:patientInfo.notiID WithCompletion:^(BOOL success2, NSString *message, NSMutableArray *array) {
                     [SVProgressHUD dismiss];
                    if (success2) {
                        if (array.count > 0) {
                            Appointments *appointment = [array objectAtIndex:0];
                            PatientLinks*plink = [[PatientLinks alloc] init];
                            plink.firstname = patientInfo.pfirstname;
                            plink.lastname = patientInfo.plastname;
                            
                            PMasterCalDetailsViewController *vc = [[PMasterCalDetailsViewController  alloc] initWithNibName:@"PMasterCalDetailsViewController " bundle:nil];
                            vc.appointment = appointment;
                            vc.doctor = doctorProfile;
                            vc.patientInfo = plink;
                            if ([appointment.patientid isEqual:plink.postid]) {
                                [self.navigationController pushViewController:vc animated:YES];
                            }
                        }
                    }
                    
                }];
               
                
            } else {
                 [SVProgressHUD dismiss];
            }
        }];

        
        
    } else if ([patientInfo.notiType isEqual:@"AcceptConsul"]) {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] getDoctorProfile2:patientInfo.fuid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
              [SVProgressHUD dismiss];
            if (success) {
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                TalkConPreviousViewController *vc = [[TalkConPreviousViewController alloc] initWithNibName:@"TalkConPreviousViewController" bundle:nil];
                vc.doctor = doctorProfile;
                
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [SVProgressHUD dismiss];
            }
        }];
        

    } else if ([patientInfo.notiType isEqual:@"DeclineConsul"]) {
        
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] getDoctorProfile2:patientInfo.fuid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
              [SVProgressHUD dismiss];
            if (success) {
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                TalkConPreviousViewController *vc = [[TalkConPreviousViewController alloc] initWithNibName:@"TalkConPreviousViewController" bundle:nil];
                vc.doctor = doctorProfile;
                
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [SVProgressHUD dismiss];
            }
        }];
        

    } else if ([patientInfo.notiType isEqual:@"AcceptRefill"]) {
        
    
        
        PatientLinks*plink = [[PatientLinks alloc] init];
        plink.firstname = patientInfo.pfirstname;
        plink.lastname = patientInfo.plastname;
        plink.docid = patientInfo.fuid;
        
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] getMedicationByID:patientInfo.notiID WithCompletion:^(BOOL success, NSString *message, PatientMedication *medication) {
            [SVProgressHUD dismiss];
            if (success) {
                if (medication.postid) {
                    plink.postid = medication.patientid;
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                    RefillMedInfoViewController *vc = [[RefillMedInfoViewController alloc] initWithNibName:@"RefillMedInfoViewController" bundle:nil];
                    vc.patientLink = plink;
                    vc.medication = medication;
                    vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            }
            
           
            
        }];

        
        
    } else if ([patientInfo.notiType isEqual:@"DeclineRefill"]) {
        PatientLinks*plink = [[PatientLinks alloc] init];
        plink.firstname = patientInfo.pfirstname;
        plink.lastname = patientInfo.plastname;
        plink.docid = patientInfo.fuid;
        
        
        
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] getMedicationByID:patientInfo.notiID WithCompletion:^(BOOL success, NSString *message, PatientMedication *medication) {
            [SVProgressHUD dismiss];
            if (success) {
                if (medication.postid) {
                    plink.postid = medication.patientid;
                    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                    RefillMedInfoViewController *vc = [[RefillMedInfoViewController alloc] initWithNibName:@"RefillMedInfoViewController" bundle:nil];
                    vc.patientLink = plink;
                    vc.medication = medication;
                    vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
            }
            
            
            
        }];
        
    } else if ([patientInfo.notiType isEqual:@"Message"]) {
        
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] getDoctorProfile2:patientInfo.fuid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
          //  [SVProgressHUD dismiss];
            if (success) {
               
                [[AppController sharedInstance] getMSGSessionsByID2:doctorProfile.uid sessionID:patientInfo.notiID WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
                     [SVProgressHUD dismiss];
                    if (success) {
                        if (msgsession.postid) {
                            
                        
                        
                        BOOL isClosed = false;
                        if ([msgsession.mstatus isEqual:@"0"]) {
                            
                            isClosed = false;
                            
                        } else if ([msgsession.mstatus isEqual:@"1"]) {
                            isClosed = false;
                            
                        } else if ([msgsession.mstatus isEqual:@"2"]) {
                            isClosed = true;
                            
                        } else if ([msgsession.mstatus isEqual:@"3"]) {
                            isClosed = true;
                            
                        }
                        
                        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                        PatientMessagingView *vc = [[PatientMessagingView alloc] initWithNibName:@"PatientMessagingView" bundle:nil];
                        vc.doctorV2 = doctorProfile;
                        vc.msgSession = msgsession;
                        vc.isClosedSessionOpen = isClosed;
                        
                        [self.navigationController pushViewController:vc animated:YES];
                        }

                        
                    }
                }];
            } else {
                [SVProgressHUD dismiss];
            }
        }];

        
       
        
    } else if ([patientInfo.notiType isEqual:@"AcceptMessage"]) {
        
        
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] getDoctorProfile2:patientInfo.fuid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
            //  [SVProgressHUD dismiss];
            if (success) {
                
                [[AppController sharedInstance] getMSGSessionsByID2:doctorProfile.uid sessionID:patientInfo.notiID WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
                    [SVProgressHUD dismiss];
                    if (success) {
                        if (msgsession.postid) {
                            
                            
                            
                            BOOL isClosed = false;
                            if ([msgsession.mstatus isEqual:@"0"]) {
                                
                                isClosed = false;
                                
                            } else if ([msgsession.mstatus isEqual:@"1"]) {
                                isClosed = false;
                                
                            } else if ([msgsession.mstatus isEqual:@"2"]) {
                                isClosed = true;
                                
                            } else if ([msgsession.mstatus isEqual:@"3"]) {
                                isClosed = true;
                                
                            }
                            
                            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                            PatientMessagingView *vc = [[PatientMessagingView alloc] initWithNibName:@"PatientMessagingView" bundle:nil];
                            vc.doctorV2 = doctorProfile;
                            vc.msgSession = msgsession;
                            vc.isClosedSessionOpen = isClosed;
                            
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                        
                        
                    }
                }];
            } else {
                [SVProgressHUD dismiss];
            }
        }];
        
        
        
        
    }
}


- (void)refreshRefillMedication {
    
}



@end
