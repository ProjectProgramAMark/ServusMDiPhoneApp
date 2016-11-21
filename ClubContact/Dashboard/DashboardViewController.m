//
//  DashboardViewController.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DashboardViewController.h"
#import "PatientsViewController.h"

@interface DashboardViewController ()
@property (weak, nonatomic) IBOutlet UIView *proceduresView;
@property (weak, nonatomic) IBOutlet UIView *patientsView;

@end

@implementation DashboardViewController

@synthesize gridMenu;
@synthesize patientsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self addSwipeGestureShowCalendar];
    //[self addTapForProcedures];
    
   // UIBarButtonItem *docProfile = [[UIBarButtonItem alloc] initWithTitle:@"My Profile" style:UIBarButtonItemStylePlain target:self action:@selector(goToDoctor:)];
    UIBarButtonItem *docProfile = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logOut2:)];
    self.navigationItem.rightBarButtonItem= docProfile;
    
    UIBarButtonItem *docProfile2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"medical51"] style:UIBarButtonItemStylePlain target:self action:@selector(doctorProfileClick:)];
    self.navigationItem.leftBarButtonItem= docProfile2;
    
    [self.navigationItem setHidesBackButton:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    patientsArray = [[NSMutableArray alloc] init];
    
    currentPage = 0;
    
   /* [patientsGrid addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];
    
    [patientsGrid addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];*/
 
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    
   // [patientsGrid registerNib:[UINib nibWithNibName:@"DashboardCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    if (IS_IPHONE) {
    [patientsGrid registerNib:[UINib nibWithNibName:@"DashboardCollectionCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
        
    } else {
         [patientsGrid registerNib:[UINib nibWithNibName:@"DashboardCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    }
    
      //[doctorsTable registerNib:[UINib nibWithNibName:@"DashboardDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    if (IS_IPHONE) {
     [doctorsTable registerNib:[UINib nibWithNibName:@"DocMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    } else {
     [doctorsTable registerNib:[UINib nibWithNibName:@"DashboardDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    }
    
    
   // [self updateDoctorOnline];
    
    
    /*repeatTimer = [NSTimer scheduledTimerWithTimeInterval: 60.0
                                                   target: self
                                                 selector:@selector(updateDoctorOnline)
                                                 userInfo: nil repeats:YES];
    */
    /*if (IS_IPHONE) {
    
        statView.frame = CGRectMake((windowWidth/2) - (statView.frame.size.width/2), 0, statView.frame.size.width, statView.frame.size.height);
        statView.hidden = false;
        buttonViewiPad.hidden = true;
        buttowViewiPhone.hidden = false;
        buttowViewiPhone.frame = CGRectMake(0, statView.frame.size.height + statView.frame.origin.y,windowWidth , self.view.frame.size.height - (statView.frame.origin.y + statView.frame.size.height));
    } else {
        statView.hidden = false;
        buttonViewiPad.hidden = false;
        buttowViewiPhone.hidden = true;
        statView.frame = CGRectMake((windowWidth/2) - (statView.frame.size.width/2), 0, statView.frame.size.width, statView.frame.size.height);
    }*/
    [self loadVideoChatUser];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [self refreshDoctorData];
    [self requestPatientsDataByPage:1 keyword : @""];
    [self getSharedDocuments];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor flatWhiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self setNeedsStatusBarAppearanceUpdate];
    
    //Color all navigation items accordingly to new barTintColor
    self.navigationController.navigationBar.tintColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:self.navigationController.navigationBar.barTintColor isFlat:YES];
}

- (void)viewWillDisappear:(BOOL)animated    {
   // [repeatTimer invalidate];
}


- (void)loadVideoChatUser {
    Doctor *plogin = [Doctor getFromUserDefault];
     [SVProgressHUD dismiss];
    /*[QBRequest createSessionWithSuccessBlock:^(QBResponse *response, QBASession *session) {
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
    
    /*  PatientLogin *plogin = [PatientLogin getFromUserDefault];
     QBUUser *user1 = [QBUUser user];
     user1.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
     user1.password = [NSString stringWithFormat:@"passwordmyfidem"];
     user1.email = plogin.email;
     user1.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];*/
    // QBUUser *user1 = [QBUUser user];
    
    //NSLog(@"Curent id %i", (int)user.ID);
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
           // [_tableView reloadData];
          /*  if (IS_IPHONE) {
                [profileIMGView2 setImageWithURL:[NSURL URLWithString:_doctor.profileimage]];
                
                nameLabel2.text = [NSString stringWithFormat:@"Dr. %@", _doctor.fullname];
                
                if ([_doctor.refillCount intValue] > 1) {
                    refillNOLabel2.text = [NSString stringWithFormat:@"%@ Refill", _doctor.refillCount];
                } else {
                    refillNOLabel2.text = [NSString stringWithFormat:@"%@ Refills", _doctor.refillCount];
                }
                
                if ([_doctor.messageCount intValue] > 1) {
                    messageNOLabel2.text = [NSString stringWithFormat:@"%@ Message",_doctor.messageCount];
                } else {
                    messageNOLabel2.text = [NSString stringWithFormat:@"%@ Messages",_doctor.messageCount];
                }
                
                if ([_doctor.requestCount intValue] > 1) {
                    appointmentNOLabel2.text = [NSString stringWithFormat:@"%@, Appointment", _doctor.requestCount];
                } else {
                   appointmentNOLabel2.text = [NSString stringWithFormat:@"%@ Appointments", _doctor.requestCount];
                }
                
                
                profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
                profileIMGView2.layer.masksToBounds = YES;
                profileIMGView2.layer.borderColor = [UIColor whiteColor].CGColor;
                profileIMGView2.layer.borderWidth = 3.0;
            } else {
            
            [profileIMGView setImageWithURL:[NSURL URLWithString:_doctor.profileimage]];
            
            nameLabel.text = [NSString stringWithFormat:@"Dr. %@", _doctor.fullname];
            
            refillNOLabel.text = _doctor.refillCount;
            messageNOLabel.text = _doctor.messageCount;
            appointmentNOLabel.text = _doctor.requestCount;
            
            profileIMGView.layer.cornerRadius = profileIMGView.frame.size.width/2;
            profileIMGView.layer.masksToBounds = YES;
            profileIMGView.layer.borderColor = [UIColor whiteColor].CGColor;
            profileIMGView.layer.borderWidth = 3.0;
                
            }*/
            [profileIMGView setImageWithURL:[NSURL URLWithString:_doctor.profileimage]];
            [profileIMGBack setImageWithURL:[NSURL URLWithString:_doctor.profileimage]];
            
            nameLabel.text = [NSString stringWithFormat:@"Dr. %@", _doctor.fullname];
            
            if ([_doctor.refillCount intValue] > 1) {
                refillNOLabel.text = [NSString stringWithFormat:@"%@ Refill", _doctor.refillCount];
            } else {
                refillNOLabel.text = [NSString stringWithFormat:@"%@ Refills", _doctor.refillCount];
            }
            
            if ([_doctor.messageCount intValue] > 1) {
                messageNOLabel.text = [NSString stringWithFormat:@"%@ Message",_doctor.messageCount];
            } else {
                messageNOLabel.text = [NSString stringWithFormat:@"%@ Messages",_doctor.messageCount];
            }
            
            if ([_doctor.requestCount intValue] > 1) {
                appointmentNOLabel.text = [NSString stringWithFormat:@"%@ Appointment", _doctor.requestCount];
            } else if ([_doctor.requestCount intValue] == 0) {
                 appointmentNOLabel.text = [NSString stringWithFormat:@"0 Appointment"];
                
            } else {
                appointmentNOLabel.text = [NSString stringWithFormat:@"%@ Appointments", _doctor.requestCount];
            }
            
            [patientsGrid reloadData];

            
            //refillNOLabel.text = _doctor.refillCount;
            //messageNOLabel.text = _doctor.messageCount;
            //appointmentNOLabel.text = _doctor.requestCount;
            
            profileIMGView.layer.cornerRadius = profileIMGView.frame.size.width/2;
            profileIMGView.layer.masksToBounds = YES;
            profileIMGView.layer.borderColor = [UIColor whiteColor].CGColor;
            profileIMGView.layer.borderWidth = 3.0;
        }
    }];
}

- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    [[AppController sharedInstance] getAllPatiensByPage4:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [patientsArray removeAllObjects];
            }
            [patientsArray addObjectsFromArray:patients];
            [patientsGrid reloadData];
        }
        
        [patientsGrid.footer endRefreshing];
        [patientsGrid.header endRefreshing];
    }];
}

- (void)updateDoctorOnline {
    [[AppController sharedInstance] updateOnlineStatus:@"" completion:^(BOOL success, NSString *message) {
        
    }];
}

- (void)getSharedDocuments {

    [[AppController sharedInstance] getSharedDocuments:@"" keyword:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
        if (success) {
            sharedDocumentUnread = 0;
            for (SharedDocuments *shd in patients) {
                int isRead = [shd.read intValue];
                
                Doctor *doc = [Doctor getFromUserDefault];
                
                int docid = [doc.uid intValue];
                
                if (isRead == 0 & docid != [shd.fromdoc intValue]) {
                    sharedDocumentUnread += 1;
                }
                
            }
            
            [patientsGrid reloadData];
            
            
        }
        
    }];
}

- (void)addTapForProcedures
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInProcedures:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];

}

- (void)tapInProcedures:(UITapGestureRecognizer *)tap
{
    CGPoint location = [tap locationInView:self.view];
    if (CGRectContainsPoint(self.proceduresView.frame, location))
    {
        [self goProceduresPage];
    }
    else if (CGRectContainsPoint(self.patientsView.frame, location))
    {
        [self goPatientsPage];
    }

}

- (void)goProceduresPage
{

}

- (void)goPatientsPage
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    PatientsViewController *vc = (PatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientsViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOut2:(id)sender {
    [repeatTimer invalidate];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDoctorUserDefault];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goToDoctor:(id)sender {
    /*UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DoctorProfileViewController *vc = (DoctorProfileViewController  *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfileViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];*/
    
    CNPGridMenuItem *messageItem = [[CNPGridMenuItem alloc] init];
    messageItem.icon = [UIImage imageNamed:@"messageicon.png"];
    messageItem.title = @"Messages";
    
    CNPGridMenuItem *profileItem = [[CNPGridMenuItem alloc] init];
    profileItem.icon = [UIImage imageNamed:@"doctorprofile2.png"];
    profileItem.title = @"My Profile";
    
    CNPGridMenuItem *patientItem = [[CNPGridMenuItem alloc] init];
    patientItem.icon = [UIImage imageNamed:@"patientsicon2.png"];
    patientItem.title = @"Patients";
    
    CNPGridMenuItem *appointmentItem = [[CNPGridMenuItem alloc] init];
    appointmentItem.icon = [UIImage imageNamed:@"appointments.png"];
    appointmentItem.title = @"Calendar";
    
    CNPGridMenuItem *requestItem = [[CNPGridMenuItem alloc] init];
    requestItem.icon = [UIImage imageNamed:@"requests2.png"];
    requestItem.title = @"Appoitnment Requests";
    
    CNPGridMenuItem *medicalItem = [[CNPGridMenuItem alloc] init];
    medicalItem.icon = [UIImage imageNamed:@"medicalicon2.png"];
    medicalItem.title = @"Refills";
    
    CNPGridMenuItem *exitItem = [[CNPGridMenuItem alloc] init];
    exitItem.icon = [UIImage imageNamed:@"exit2.png"];
    exitItem.title = @"Log Out";
    
    CNPGridMenuItem *consultationItem = [[CNPGridMenuItem alloc] init];
    consultationItem.icon = [UIImage imageNamed:@"headphones1"];
    consultationItem.title = @"Consultation";
    
    CNPGridMenuItem *doctorsItem = [[CNPGridMenuItem alloc] init];
    doctorsItem.icon = [UIImage imageNamed:@"doctorsm.png"];
    doctorsItem.title = @"Doctor Chat";
    
    
    
    gridMenu = [[CNPGridMenu alloc] initWithMenuItems:@[patientItem, medicalItem, requestItem, appointmentItem, consultationItem, messageItem, doctorsItem, profileItem, exitItem]];
    gridMenu.delegate = self;
    [self presentGridMenu:gridMenu animated:YES completion:^{
        NSLog(@"Grid Menu Presented");
    }];

    
}

- (IBAction)goToMessages:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    MessagePatientsList *vc = (MessagePatientsList *)[sb instantiateViewControllerWithIdentifier:@"MessagePatientsList"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)gridMenuDidTapOnBackground:(CNPGridMenu *)menu {
    [self dismissGridMenuAnimated:YES completion:^{
        NSLog(@"Grid Menu Dismissed With Background Tap");
    }];
}

- (void)gridMenu:(CNPGridMenu *)menu didTapOnItem:(CNPGridMenuItem *)item {
    [self dismissGridMenuAnimated:YES completion:^{
        NSLog(@"Grid Menu Did Tap On Item: %@", item.title);
        if ([item.title isEqual:@"My Profile"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            DoctorProfileViewController *vc = (DoctorProfileViewController  *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfileViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
        } else if ([item.title isEqual:@"Calendar"]) {
            if (IS_IPHONE) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                iPhoneCalendarViewController *vc = (iPhoneCalendarViewController  *)[sb instantiateViewControllerWithIdentifier:@"iPhoneCalendarViewController"];
                
                [self.navigationController pushViewController:vc animated:YES];
            } else {
             [self.navigationController pushViewController:[AppDelegate sharedInstance].calendarViewController animated:YES];
                
            }
            
        } else if ([item.title isEqual:@"Messages"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            MessagePatientsList *vc = (MessagePatientsList *)[sb instantiateViewControllerWithIdentifier:@"MessagePatientsList"];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if ([item.title isEqual:@"Patients"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            PatientsViewController *vc = (PatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientsViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if ([item.title isEqual:@"Log Out"]) {
             [repeatTimer invalidate];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDoctorUserDefault];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else if ([item.title isEqual:@"Appoitnment Requests"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            RequestsViewController *vc = (RequestsViewController *)[sb instantiateViewControllerWithIdentifier:@"RequestsViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        } else if ([item.title isEqual:@"Refills"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            RefillPatientsViewController *vc = (RefillPatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"RefillPatientsViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }  else if ([item.title isEqual:@"Consultation"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            ConsultationListView *vc = (ConsultationListView *)[sb instantiateViewControllerWithIdentifier:@"ConsultationListView"];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }  else if ([item.title isEqual:@"Doctor Chat"]) {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            MySessionViewController *vc = (MySessionViewController *)[sb instantiateViewControllerWithIdentifier:@"MySessionViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];

            
        }
        
    }];
}

- (IBAction)appointmentRequestClick {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    RequestsViewController *vc = (RequestsViewController *)[sb instantiateViewControllerWithIdentifier:@"RequestsViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)refillRequestClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    RefillPatientsViewController *vc = (RefillPatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"RefillPatientsViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)messagesClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    MessagePatientsList *vc = (MessagePatientsList *)[sb instantiateViewControllerWithIdentifier:@"MessagePatientsList"];
    
    [self.navigationController pushViewController:vc animated:YES];

}


- (IBAction)appointmentMenuClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    RequestsViewController *vc = (RequestsViewController *)[sb instantiateViewControllerWithIdentifier:@"RequestsViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)calendarMenuClick:(id)sender {
    if (IS_IPHONE) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        iPhoneCalendarViewController *vc = (iPhoneCalendarViewController  *)[sb instantiateViewControllerWithIdentifier:@"iPhoneCalendarViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.navigationController pushViewController:[AppDelegate sharedInstance].calendarViewController animated:YES];
        
    }

}

- (IBAction)patientMenuClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    PatientsViewController *vc = (PatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientsViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)doctorProfileClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DoctorProfileViewController *vc = (DoctorProfileViewController  *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfileViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)consultationMenuClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    ConsultationListView *vc = (ConsultationListView *)[sb instantiateViewControllerWithIdentifier:@"ConsultationListView"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)chatMenuClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    MessagePatientsList *vc = (MessagePatientsList *)[sb instantiateViewControllerWithIdentifier:@"MessagePatientsList"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)doctoChatMenuClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    MySessionViewController *vc = (MySessionViewController *)[sb instantiateViewControllerWithIdentifier:@"MySessionViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 11;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     if (IS_IPHONE) {
        /* MSGPatientGridCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
         
         
         Patient *patientInfo = [patientsArray objectAtIndex:indexPath.row];
         
         [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profilepic]];
         
         cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
         cell.profileIMG.layer.masksToBounds = YES;
         
         cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName];
         cell.messageCountLabel.text = patientInfo.msgCount;
        
         return cell;*/
         
         DashboardCollectionCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
         

         if (indexPath.row == 0) {
             cell.nameLabel.text = @"Patients";
             cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
         } else if (indexPath.row == 1) {
              cell.nameLabel.text = [NSString stringWithFormat:@"Appointments (%i)", [_doctor.requestCount intValue]];
             cell.nameLabel.textColor = [UIColor colorWithRed:209.0f/255.0f green:104.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"phonebook.png"];
         }  else if (indexPath.row == 2) {
              cell.nameLabel.text = [NSString stringWithFormat:@"Refills (%i)", [_doctor.refillCount intValue]];
             cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
         } else if (indexPath.row == 3) {
             cell.nameLabel.text = @"Calendar";
             cell.nameLabel.textColor = [UIColor colorWithRed:205.0f/255.0f green:101.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"calendar-iconv2.png"];
         } else if (indexPath.row == 4) {
             cell.nameLabel.text = @"Consultations";
             cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];

         } else if (indexPath.row == 5) {
             cell.nameLabel.text = @"Doctor Chat";
             cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
         } else if (indexPath.row == 6) {
             cell.nameLabel.text = [NSString stringWithFormat:@"Message (%i)", [_doctor.messageCount intValue]];
             cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
         }   else if (indexPath.row == 7) {
             cell.nameLabel.text = @"Records";
             cell.nameLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:74.0f/255.0f blue:91.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"shareiconv2.png"];
         } else if (indexPath.row == 8) {
             cell.nameLabel.text = @"Reviews";
             cell.nameLabel.textColor = [UIColor colorWithRed:140.0f/255.0f green:88.0f/255.0f blue:177.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"perfect1.png"];
         } else if (indexPath.row == 9) {
             /*cell.nameLabel.text = @"Profile";
             cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"dna-icon.png"];*/
             cell.nameLabel.text =  [NSString stringWithFormat:@"Documents (%i)", sharedDocumentUnread];
             cell.nameLabel.textColor = [UIColor colorWithRed:146.0f/255.0f green:163.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"document-edit-icon.png"];
         }    else if (indexPath.row == 10) {
             cell.nameLabel.text =  [NSString stringWithFormat:@"Payments"];
             cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
         }

         
         
         return cell;
         
         
     } else {
      // MSGPatientGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
         
         
         
        /* Patient *patientInfo = [patientsArray objectAtIndex:indexPath.row];
         
         [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profilepic]];
         
         cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
         cell.profileIMG.layer.masksToBounds = YES;
         // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
         // cell.profileIMG.layer.borderWidth = 3.0;
         
         cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName];
         cell.messageCountLabel.text = patientInfo.msgCount;*/
         DashboardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
         
         if (indexPath.row == 0) {
             cell.nameLabel.text = @"Patients";
             cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
         } else if (indexPath.row == 1) {
             cell.nameLabel.text = [NSString stringWithFormat:@"Appointments (%i)", [_doctor.requestCount intValue]];
             cell.nameLabel.textColor = [UIColor colorWithRed:209.0f/255.0f green:104.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"phonebook.png"];
         }  else if (indexPath.row == 2) {
              cell.nameLabel.text = [NSString stringWithFormat:@"Refills (%i)", [_doctor.refillCount intValue]];
             cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
         } else if (indexPath.row == 3) {
             cell.nameLabel.text = @"Calendar";
             cell.nameLabel.textColor = [UIColor colorWithRed:205.0f/255.0f green:101.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"calendar-iconv2.png"];
         } else if (indexPath.row == 4) {
             cell.nameLabel.text = @"Consultations";
             cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];
             
         } else if (indexPath.row == 5) {
             cell.nameLabel.text = @"Doctor Chat";
             cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
         } else if (indexPath.row == 6) {
              cell.nameLabel.text = [NSString stringWithFormat:@"Message (%i)", [_doctor.messageCount intValue]];
             cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
         }   else if (indexPath.row == 7) {
             cell.nameLabel.text = @"Records";
             cell.nameLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:74.0f/255.0f blue:91.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"shareiconv2.png"];
         } else if (indexPath.row == 8) {
             cell.nameLabel.text = @"Reviews";
             cell.nameLabel.textColor = [UIColor colorWithRed:140.0f/255.0f green:88.0f/255.0f blue:177.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"perfect1.png"];
         } else if (indexPath.row == 9) {
           /*  cell.nameLabel.text = @"Profile";
             cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"dna-icon.png"];*/
             cell.nameLabel.text =  [NSString stringWithFormat:@"Documents (%i)", sharedDocumentUnread];
             cell.nameLabel.textColor = [UIColor colorWithRed:146.0f/255.0f green:163.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"document-edit-icon.png"];
         } else if (indexPath.row == 10) {
             cell.nameLabel.text =  [NSString stringWithFormat:@"Payments"];
             cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
         }
         
         
      
         return cell;
     }
    
   

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
/*     Patient *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    PatientDetailViewController *vc = (PatientDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDetailViewController"];
    vc.patient = patientInfo;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];*/
    if (indexPath.row == 0) {
        if (_doctor != NULL) {
            if ([_doctor.subscriptionpaid intValue] > 0) {
                
            
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientsViewController *vc = (PatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientsViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
            } else {
                [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
            }
        } else {
            [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
    } else if (indexPath.row == 1) {
       
            if (_doctor != NULL) {
                if ([_doctor.subscriptionpaid intValue] > 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        RequestsViewController *vc = (RequestsViewController *)[sb instantiateViewControllerWithIdentifier:@"RequestsViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
                } else {
                    [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
                }
            } else {
                [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
            }

    } else if (indexPath.row == 2) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        RefillPatientsViewController *vc = (RefillPatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"RefillPatientsViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }  else if (indexPath.row == 3) {
     
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

    
    } else if (indexPath.row == 4) {
      
            if (_doctor != NULL) {
                if ([_doctor.subscriptionpaid intValue] > 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ConsultationListView *vc = (ConsultationListView *)[sb instantiateViewControllerWithIdentifier:@"ConsultationListView"];
                    
        
        [self.navigationController pushViewController:vc animated:YES];
                } else {
                    [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
                }
            } else {
                [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
            }
            

    } else if (indexPath.row == 5) {
        if (_doctor != NULL) {
            if ([_doctor.subscriptionpaid intValue] > 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MySessionViewController *vc = (MySessionViewController *)[sb instantiateViewControllerWithIdentifier:@"MySessionViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
            } else {
                [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
            }
        } else {
            [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
    } else if (indexPath.row == 6) {
        if (_doctor != NULL) {
            if ([_doctor.subscriptionpaid intValue] > 0) {
                
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MessagePatientsList *vc = (MessagePatientsList *)[sb instantiateViewControllerWithIdentifier:@"MessagePatientsList"];
        
        [self.navigationController pushViewController:vc animated:YES];
            } else {
                [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
            }
        } else {
            [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
        

        
    } else if (indexPath.row == 7) {
        if (_doctor != NULL) {
            if ([_doctor.subscriptionpaid intValue] > 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        SharedProfileListViewController *vc = (SharedProfileListViewController *)[sb instantiateViewControllerWithIdentifier:@"SharedProfileListViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
            } else {
                [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
            }
        } else {
            [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
        
    } else if (indexPath.row == 8) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DoctorReviewViewController *vc = (DoctorReviewViewController *)[sb instantiateViewControllerWithIdentifier:@"DoctorReviewViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 9) {
       /* UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DoctorProfileViewController *vc = (DoctorProfileViewController  *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfileViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];*/
        if (_doctor != NULL) {
            if ([_doctor.subscriptionpaid intValue] > 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        SharedDocumentViewController *vc = (SharedDocumentViewController  *)[sb instantiateViewControllerWithIdentifier:@"SharedDocumentViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
            } else {
                [self showAlertViewWithMessage:@"You have not subscribed to use the service" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
            }
        } else {
            [self showAlertViewWithMessage:@"Please wait for the doctor details to load" withTag:0 withTitle:@"Error" andViewController:self isCancelButton:NO];
        }
        
    } else if (indexPath.row == 10) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DoctorPaymentViewController *vc = (DoctorPaymentViewController  *)[sb instantiateViewControllerWithIdentifier:@"DoctorPaymentViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }

    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval;
    /* if (IS_IPHONE) {
         retval = CGSizeMake(140, 140);
     } else {
         retval = CGSizeMake(200, 200);
     }*/
    
    if (IS_IPHONE) {
        retval = CGSizeMake(85, 107);
    } else {
        retval = CGSizeMake(200, 184);
    }
    
    
    return retval;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (IS_IPHONE) {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    } else {
        return UIEdgeInsetsMake(50, 20, 50, 20);
        
    }

}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (IS_IPHONE) {
        DocMenuTableViewCell *cell = (DocMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"Patients";
            cell.nameLabel.textColor = [UIColor colorWithRed:67.0f/255.0f green:148.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"patientIconBlue.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Appointments";
            cell.nameLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:67.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"appointmentIconBrown.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Calendar";
            cell.nameLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:133.0f/255.0f blue:7.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"calendarIconOrange.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Consultations";
            cell.nameLabel.textColor = [UIColor colorWithRed:224.0f/255.0f green:0.0f/255.0f blue:81.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"consultationIconPink.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Doctor Chat";
            cell.nameLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"doctorChatIconGreen.png"];
        } else if (indexPath.row == 5) {
            cell.nameLabel.text = @"Message";
            cell.nameLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"messageIconRed.png"];
        }  else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Reviews";
            cell.nameLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"bookmark46.png"];
        }
        

        
        return cell;
        
        
        
    } else {
        DashboardDocTableViewCell *cell = (DashboardDocTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"Patients";
            cell.nameLabel.textColor = [UIColor colorWithRed:67.0f/255.0f green:148.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"patientIconBlue.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Appointments";
            cell.nameLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:67.0f/255.0f blue:56.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"appointmentIconBrown.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Calendar";
            cell.nameLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:133.0f/255.0f blue:7.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"calendarIconOrange.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Consultations";
            cell.nameLabel.textColor = [UIColor colorWithRed:224.0f/255.0f green:0.0f/255.0f blue:81.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"consultationIconPink.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Doctor Chat";
            cell.nameLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"doctorChatIconGreen.png"];
        } else if (indexPath.row == 5) {
            cell.nameLabel.text = @"Message";
            cell.nameLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"messageIconRed.png"];
        }  else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Reviews";
            cell.nameLabel.textColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"bookmark46.png"];
        }
        

        
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
    if (indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientsViewController *vc = (PatientsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientsViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        RequestsViewController *vc = (RequestsViewController *)[sb instantiateViewControllerWithIdentifier:@"RequestsViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        if (IS_IPHONE) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            iPhoneCalendarViewController *vc = (iPhoneCalendarViewController  *)[sb instantiateViewControllerWithIdentifier:@"iPhoneCalendarViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.navigationController pushViewController:[AppDelegate sharedInstance].calendarViewController animated:YES];
            
        }

    } else if (indexPath.row == 3) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ConsultationListView *vc = (ConsultationListView *)[sb instantiateViewControllerWithIdentifier:@"ConsultationListView"];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MySessionViewController *vc = (MySessionViewController *)[sb instantiateViewControllerWithIdentifier:@"MySessionViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 5) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MessagePatientsList *vc = (MessagePatientsList *)[sb instantiateViewControllerWithIdentifier:@"MessagePatientsList"];
        
        [self.navigationController pushViewController:vc animated:YES];

    } else if (indexPath.row == 6) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DoctorReviewViewController *vc = (DoctorReviewViewController *)[sb instantiateViewControllerWithIdentifier:@"DoctorReviewViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 7) {
      /*  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DoctorReviewViewController *vc = (DoctorReviewViewController *)[sb instantiateViewControllerWithIdentifier:@"DoctorReviewViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];*/
        
    }
}








- (void)refreshPatientList {
     [self requestPatientsDataByPage:1 keyword : @""];
}

@end
