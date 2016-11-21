//
//  DashboardV2ViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/20/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import "DashboardV2ViewController.h"
#import "SWRevealViewController.h"

@interface DashboardV2ViewController ()

@end

@implementation DashboardV2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    self.title = @"HOME";
    
    
   // [self loadVideoChatUser];
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    [appointmentTableView registerNib:[UINib nibWithNibName:@"AppointmentDashTableViewCell" bundle:nil] forCellReuseIdentifier:kPatientsCellID];
    
    appointmentTableView.separatorColor = [UIColor clearColor];
    
    [self requestDoctorAppointments];
    
    appointmentArray = [[NSMutableArray alloc] init];
    
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
          self.revealViewController.navigationController.navigationBarHidden = true;
     [self refreshDoctorData];
    [self requestDoctorAppointments];
    [self getDoctorRating];
    [self loadNotifications];
    
    
    int notiCount =  (int)[UIApplication sharedApplication].applicationIconBadgeNumber;
    
    if (notiCount > 99) {
        notificationCountLabel.text = @"100+";
    } else {
        notificationCountLabel.text = [NSString stringWithFormat:@"%i", notiCount];
    }
    

    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}

- (void)refreshAllDataForNoti {
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [self refreshDoctorData];
    [self requestDoctorAppointments];
    [self getDoctorRating];
    [self loadNotifications];
    
}

- (void)loadVideoChatUser {
    Doctor *plogin = [Doctor getFromUserDefault];
    [SVProgressHUD dismiss];
   /* [QBRequest createSessionWithSuccessBlock:^(QBResponse *response, QBASession *session) {
        // Success, You have got Application session, now READ something.
        QBUUser *user = [QBUUser user];
        user.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
        user.password =  [NSString stringWithFormat:@"passwordmyfidem"];
        user.email = plogin.email;
        user.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];
        
        [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
            // Success, do something
            [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
                // Success, do something
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userQB = user1;
                [self logInChatWithUser:user1];
                [SVProgressHUD dismiss];
            } errorBlock:^(QBResponse *response) {
                // error handling
                [SVProgressHUD dismiss];
                NSLog(@"error: %@", response.error);
            }];
        } errorBlock:^(QBResponse *response) {
            // error handling
            NSLog(@"error: %@", response.error);
            [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
                // Success, do something
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userQB = user1;
                [self logInChatWithUser:user1];
                [SVProgressHUD dismiss];
            } errorBlock:^(QBResponse *response) {
                // error handling
                [SVProgressHUD dismiss];
                NSLog(@"error: %@", response.error);
            }];
        }];
        
    } errorBlock:^(QBResponse *response) {
        // error handling
        NSLog(@"error: %@", response.error);
    }];*/
}


- (void)logInChatWithUser:(QBUUser *)user {
    
   
    QBUUser *user1 = [QBUUser user];
    user1.ID = user.ID;
    user1.login = user.login;
    user1.fullName = user.fullName;
    user1.password = [NSString stringWithFormat:@"passwordmyfidem"];
    
    __weak __typeof(self)weakSelf = self;
    [[ConnectionManager instance] logInWithUser:user1
                                     completion:^(BOOL error)
     {
         if (!error) {
             
             
             [QBRTCClient.instance addDelegate:self];
         }
         else {
             
             [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Login chat error!", nil)];
         }
     }];
}

- (void)didReceiveNewSession:(QBRTCSession *)session userInfo:(NSDictionary *)userInfo {
    [CallManager.instance incominingCall:session userInfo:userInfo];
}

- (void)sessionDidClose:(QBRTCSession *)session {
    [CallManager.instance closeThisSession:session];
}



- (void)refreshDoctorData {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getDoctorProfile:@"" WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success)
        {
            _doctor = doctorProfile;
           
            [profileIMGView setImageWithURL:[NSURL URLWithString:_doctor.profileimage]];
            
            nameLabel.text = [NSString stringWithFormat:@"Dr. %@", _doctor.fullname];
            
            hospitalLabel.text = _doctor.residency;
            
            refillNumLabel.text = [NSString stringWithFormat:@"%@ Refill Requests", _doctor.refillCount];
            consultationNumLabel.text = [NSString stringWithFormat:@"%@ Consultation Requests", _doctor.consultationCount];
            messageRequestNumLabel.text = [NSString stringWithFormat:@"%@ Messaging Requests", _doctor.requestCount];
            documentRequestNumLabel.text = [NSString stringWithFormat:@"%@ Document Requests", _doctor.documentCount];
            
            
            profileIMGView.layer.cornerRadius = profileIMGView.frame.size.width/2;
            profileIMGView.layer.masksToBounds = YES;
            profileIMGView.layer.borderColor = [UIColor blackColor].CGColor;
            profileIMGView.layer.borderWidth = 1.0f;
            
            
            
            refillCount = [_doctor.refillCount intValue];
            consulCount = [_doctor.consultationCount intValue];
            msgCount  = [_doctor.requestCount intValue];
            documentCount = [_doctor.documentCount intValue];
           
        }
    }];
}






- (void)loadNotifications {
    [[AppController sharedInstance] getDNotifications:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *array) {
               if (success) {
            int notiCount = 0;
            for (Notifications *noti in array) {
                if ([noti.isRead intValue] == 0) {
                    notiCount += 1;
                } else {
                    
                }
            }
            [UIApplication sharedApplication].applicationIconBadgeNumber = notiCount;
            
            if (notiCount > 99) {
                notificationCountLabel.text = @"100+";
            } else {
                notificationCountLabel.text = [NSString stringWithFormat:@"%i", notiCount];
            }
           
            //[self markNotifcationsRead];
        }
    }];
}




- (void)requestDoctorAppointments
{
    [[AppController sharedInstance] getAllFutureAppointmens:@"1"  WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        if (success)
        {
            [appointmentArray removeAllObjects];
            appointmentArray = [[NSMutableArray alloc] initWithArray:conditions];
            [appointmentTableView reloadData];
            
            if (appointmentArray.count == 0) {
                appointmentBox.hidden = true;
                reviewsBox.frame = CGRectMake(reviewsBox.frame.origin.x, 251, reviewsBox.frame.size.width, reviewsBox.frame.size.height);
                
                awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, 447);
                [awesomeScrollView addSubview:awesomeStuffContainer];
                awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
                
            } else {
                appointmentBox.hidden = false;
                
              /*  if (appointmentArray.count == 1) {
                    appointmentBox.frame = CGRectMake(appointmentBox.frame.origin.x, 251, appointmentBox.frame.size.width, 46 + 48);
                    reviewsBox.frame = CGRectMake(reviewsBox.frame.origin.x, (251 + 46) + 48, reviewsBox.frame.size.width, reviewsBox.frame.size.height);
                }
                
                reviewsBox.frame = CGRectMake(reviewsBox.frame.origin.x, 251, reviewsBox.frame.size.width, reviewsBox.frame.size.height);*/
                
                if  (appointmentArray.count == 1) {
                
                appointmentBox.frame = CGRectMake(appointmentBox.frame.origin.x, 251, appointmentBox.frame.size.width, 38 + (48 * 1 ));
                reviewsBox.frame = CGRectMake(reviewsBox.frame.origin.x, (251 + 46) + (48 * 1 ), reviewsBox.frame.size.width, reviewsBox.frame.size.height);
                
                awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, 400 + (48 * appointmentArray.count ));
                [awesomeScrollView addSubview:awesomeStuffContainer];
                awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
                    
                } else if  (appointmentArray.count == 2) {
                    appointmentBox.frame = CGRectMake(appointmentBox.frame.origin.x, 251, appointmentBox.frame.size.width, 38 + (48 * 2 ));
                    reviewsBox.frame = CGRectMake(reviewsBox.frame.origin.x, (251 + 46) + (48 * 2 ), reviewsBox.frame.size.width, reviewsBox.frame.size.height);
                    
                    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, 400 + (48 * 2 ));
                    [awesomeScrollView addSubview:awesomeStuffContainer];
                    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
                } else {
                    appointmentBox.frame = CGRectMake(appointmentBox.frame.origin.x, 251, appointmentBox.frame.size.width, 38 + (48 * 3 ));
                    reviewsBox.frame = CGRectMake(reviewsBox.frame.origin.x, (251 + 46) + (48 * 3 ), reviewsBox.frame.size.width, reviewsBox.frame.size.height);
                    
                    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, 400 + (48 * 3 ));
                    [awesomeScrollView addSubview:awesomeStuffContainer];
                    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
                }
                
            }
                      
        }
        
        
        
    }];
}

- (void)getDoctorRating {
    //[SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getMyDoctorRating:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions, NSString *totalrating)
     {
         //[SVProgressHUD dismiss];
         if (success)
         {
             /*[patientsArray removeAllObjects];
             [patientsArray addObjectsFromArray:conditions];
             [menuTable reloadData];*/
             
             if (conditions.count < 2) {
               reviewsLabel.text = [NSString stringWithFormat:@"%lu Review", (unsigned long)conditions.count];
             } else {
             reviewsLabel.text = [NSString stringWithFormat:@"%lu Reviews", (unsigned long)conditions.count];
                 
             }
             
             ratingLabel.text = [NSString stringWithFormat:@"%@/5", totalrating];
             
             
         }
     }];
    
}



- (IBAction)gotoCalendar:(id)sender {
    if (_doctor != NULL) {
        if ([_doctor.subscriptionpaid intValue] > 0) {
            if (IS_IPHONE) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                iPhoneCalendarViewController *vc = (iPhoneCalendarViewController  *)[sb instantiateViewControllerWithIdentifier:@"iPhoneCalendarViewController"];
                
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [self.navigationController pushViewController:[AppDelegate sharedInstance].calendarViewController animated:YES];
                
            }
        } else {
            [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
    } else {
        [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
    }

}


- (IBAction)openDoctorRatings:(id)sender {
   // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DoctorReviewViewController *vc = [[DoctorReviewViewController alloc] initWithNibName:@"DoctorReviewViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)openMenu:(id)sender {
    [self.revealViewController revealToggle:sender];
}

- (IBAction)goToRefillRequests:(id)sender {
   RefillPatientsViewController *vc = [[RefillPatientsViewController alloc] initWithNibName:@"RefillPatientsViewController" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
    
}

- (IBAction)goToDoctorProfile:(id)sender {
    DoctorProfileViewController *vc = [[DoctorProfileViewController alloc] initWithNibName:@"DoctorProfileViewController" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];

    
}

- (IBAction)goToMessaging:(id)sender {
    if (_doctor != NULL) {
        if ([_doctor.subscriptionpaid intValue] > 0) {
            // self.revealViewController.navigationController.navigationBarHidden = false;
            MessagePatientsList *vc = [[MessagePatientsList alloc] initWithNibName:@"MessagePatientsList" bundle:nil];
            
            
            //[self.revealViewController.navigationController pushViewController:vc animated:YES];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.revealViewController pushFrontViewController:navigationController animated:YES];
            
        } else {
            [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
    } else {
        [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
    }

}

- (IBAction)goToDocuments:(id)sender {
    SharedDocumentViewController *vc = [[SharedDocumentViewController alloc] initWithNibName:@"SharedDocumentViewController" bundle:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.revealViewController pushFrontViewController:navigationController animated:YES];

}


- (IBAction)goToConsultationRequests:(id)sender {
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    ConsultationListView *vc = [[ConsultationListView  alloc] initWithNibName:@"ConsultationListView" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToNotifications:(id)sender {
    NotificationsDoctorViewController *vc = [[NotificationsDoctorViewController alloc] initWithNibName:@"NotificationsDoctorViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return appointmentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppointmentDashTableViewCell *cell = (AppointmentDashTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
    
    Appointments *noteDic = [appointmentArray objectAtIndex:indexPath.row];
    
    double unixTimeStamp =[noteDic.fromdate doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    
     NSDate* destinationDate = sourceDate;
    
    
    NSString *paitentName = [NSString stringWithFormat:@"Appointment with %@ %@", noteDic.firstname, noteDic.lastname];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
    cell.dateLabel.text = [formatter stringFromDate:destinationDate];
    
    cell.nameLabel.text = paitentName;
    
    
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Appointments *noteDic = [appointmentArray objectAtIndex:indexPath.row];
    
    CalendarDetailViewController *vc = [[CalendarDetailViewController alloc] initWithNibName:@"CalendarDetailViewController" bundle:nil];
    vc.appointment = noteDic ;
    
    [self.navigationController pushViewController:vc animated:YES];
}






@end
