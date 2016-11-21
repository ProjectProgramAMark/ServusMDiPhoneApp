//
//  NotificationsDoctorViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/5/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "NotificationsDoctorViewController.h"

@interface NotificationsDoctorViewController () <MessagingViewDelegate, AppRequestDetailiPhoneDelegate, ConsultationDetailiPhoneDelegate>

@end

@implementation NotificationsDoctorViewController

@synthesize conditionsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    conditionsArray = [NSMutableArray array];
    
     [conditionTable registerNib:[UINib nibWithNibName:@"UnifiedReqTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    
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
    
    
    self.title = [NSString stringWithFormat:@"NOTIFICATIONS"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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




- (void)loadNotifications {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getDNotifications:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *array) {
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
           // self.title = [NSString stringWithFormat:@"NOTIFICATIONS (%i)", notiCount];
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


- (void)markNotifcationsRead {
    [[AppController sharedInstance] markNotificationsRead2:@"" completion:^(BOOL success, NSString *message) {
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
    
    UnifiedReqTableViewCell  *cell = (UnifiedReqTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    Notifications *patientInfo = [conditionsArray objectAtIndex:indexPath.row];
    
    if ([patientInfo.notiType isEqual:@"Appointment"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"You got a new appointment request"];
        
        cell.imgView.image = [UIImage imageNamed:@"days4"];
        
    } else if ([patientInfo.notiType isEqual:@"Consultation"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"%@ %@ sent you a consultation request" ,patientInfo.ffirstname, patientInfo.flastname];
        
        cell.imgView.image = [UIImage imageNamed:@"videoChatIcon2"];
        
    }  else if ([patientInfo.notiType isEqual:@"Message"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"%@ %@ sent you a message" ,patientInfo.ffirstname, patientInfo.flastname];
        
        cell.imgView.image = [UIImage imageNamed:@"chatIcon2"];
        
    }  else if ([patientInfo.notiType isEqual:@"Refill"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"You got a refill request"];
        
        cell.imgView.image = [UIImage imageNamed:@"refillIcon2"];
        
    }  else if ([patientInfo.notiType isEqual:@"DocMessage"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Dr. %@ %@ sent you a message" ,patientInfo.ffirstname, patientInfo.flastname];
        
        cell.imgView.image = [UIImage imageNamed:@"chatIcon2"];

        
    }  else if ([patientInfo.notiType isEqual:@"New Session"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"%@ %@ sent you a messaging request" ,patientInfo.ffirstname, patientInfo.flastname];
        
        cell.imgView.image = [UIImage imageNamed:@"chatIcon2"];
        
        
    }else if ([patientInfo.notiType isEqual:@"Record"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"%@ %@ shared a patient record" ,patientInfo.ffirstname, patientInfo.flastname];
        
        cell.imgView.image = [UIImage imageNamed:@"documentIcon2"];
        
    } else {
    
        cell.topTitleLabel.text = [NSString stringWithFormat:@"%@ %@ %@" ,patientInfo.ffirstname, patientInfo.flastname, patientInfo.notiType];
    
        cell.imgView.image = [UIImage imageNamed:@"videoChatIcon2"];
        
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
    

    
    
    /*cell.nameLabel.text = patientInfo.pharmName;
     cell.addressLabel.text = patientInfo.address;
     
     cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
     cell.addressLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
     cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];*/
    
    
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Notifications *patientInfo = [conditionsArray objectAtIndex:indexPath.row];
    
    
    
    
    if ([patientInfo.notiType isEqual:@"Message"]) {
        [SVProgressHUD showWithStatus:@"Please wait..."];
        Doctor *doc = [Doctor getFromUserDefault];
        [[AppController sharedInstance] getMSGSessionsByID:doc.uid sessionID:patientInfo.notiID WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
            [SVProgressHUD dismiss];
            if (success) {
                if ([msgsession.mstatus intValue] == 3) {
                    //[repeatTimer2 invalidate];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Closed Session" message:@"This session is closed by the patient" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    
                } else if ([msgsession.mstatus intValue] == 2) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Declined Session" message:@"You declied this chat request" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    
                } else if ([msgsession.mstatus intValue] == 0) {
                    MessagePatientsList *vc = [[MessagePatientsList alloc] initWithNibName:@"MessagePatientsList" bundle:nil];
                    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self.revealViewController pushFrontViewController:navigationController animated:YES];
                    
                } else {
                    
                    
                    MessagingViewController *vc = [[MessagingViewController alloc] initWithNibName:@"MessagingViewController" bundle:nil];
                    vc.msgSession = msgsession;
                    // vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:true];
                }
                
                
            }
        }];

        
        
    } else if ([patientInfo.notiType isEqual:@"Appointment"]) {
        
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [[AppController sharedInstance] getRequestAppointmensIndividual:@"" postid:patientInfo.notiID WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            [SVProgressHUD dismiss];
            if (success) {
                if (conditions.count > 0) {
                    RequestAppointments *reqApp = [conditions objectAtIndex:0];
                    AppRequestiPhoneViewController *vc = [[AppRequestiPhoneViewController alloc] initWithNibName:@"AppRequestiPhoneViewController" bundle:nil];
                    
                    
                    vc.appRequest = reqApp;
                    
                    vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:true];
                    
                    
                    
                    
                }
            }
            
        }];;
        
    }  else if ([patientInfo.notiType isEqual:@"New Session"]) {
        
        MessagePatientsList *vc = [[MessagePatientsList alloc] initWithNibName:@"MessagePatientsList" bundle:nil];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.revealViewController pushFrontViewController:navigationController animated:YES];

    }  else if ([patientInfo.notiType isEqual:@"Consultation"]) {
        
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [[AppController sharedInstance] getConsultationIndividual:@"" postid:patientInfo.notiID  WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            [SVProgressHUD dismiss];
            if (success)
            {
                if (conditions.count > 0) {
                    Consulatation *conApp = [conditions objectAtIndex:0];
                    
                    ConsultationDetailiPhone *vc = [[ConsultationDetailiPhone alloc] initWithNibName:@"ConsultationDetailiPhone" bundle:nil];
                    
                    vc.consultation = conApp;
                    
                    vc.delegate = self;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                    
                } else {
                    [self showAlertViewWithMessage:@"Consultation request does not exist" withTag:0 withTitle:@"" andViewController:self isCancelButton:false];
                }
                
                
            }
            
            
        }];

        
    } else if ([patientInfo.notiType isEqual:@"Refill"]) {
        RefillPatientsViewController *vc = [[RefillPatientsViewController alloc] initWithNibName:@"RefillPatientsViewController" bundle:nil];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.revealViewController pushFrontViewController:navigationController animated:YES];
        
    }else if ([patientInfo.notiType isEqual:@"Record"]) {
        
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [[AppController sharedInstance] getPatientProfile:patientInfo.fuid keyword:patientInfo.puid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patiens) {
            [SVProgressHUD dismiss];
            if (success) {
                Patient *patientInfo2 = [patiens objectAtIndex:0];
           
                PatientDetailViewController *vc = [[PatientDetailViewController alloc] initWithNibName:@"PatientDetailViewController" bundle:nil];
                vc.patient = patientInfo2;
                //vc.delegate = self;
                vc.isSharedProfile = true;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }];

        
        
    }
    
    
}

- (void)refreshPatientsInfo3 {
    
}

@end
