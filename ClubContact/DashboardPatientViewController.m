//
//  DashboardPatientViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DashboardPatientViewController.h"
#import "Patient.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@implementation DashboardPatientViewController

@synthesize patientsArray;
@synthesize gridMenu;
@synthesize pmaster;
@synthesize notificationsArray;

- (void)viewDidLoad {
    
    patientsArray = [[NSMutableArray alloc] init];
    randomFacts = [[NSMutableArray alloc] init];
    notificationsArray = [[NSMutableArray alloc] init];
    consultationArray = [[NSMutableArray alloc] init];
    medicationArray = [[NSMutableArray alloc] init];
    appointmentArray = [[NSMutableArray alloc] init];
    randomFacts = [NSMutableArray arrayWithObjects:@"You are taller in the morning than in the evening.", @"Your stomach manufactures a new lining every three days to avoid digesting itself.", @"Human bone is as strong as granite, relative to supporting resistance.", @"The average red blood cell lives for 120 days.", @"A red blood cell can circumnavigate your body in under 20 seconds.", @"A person can expect to breathe in about 45 pounds of dust over his/her lifetime.", @"It's impossible to sneeze with your eyes open.", @"our body has about 5.6 liters (6 quarts) of blood. This 5.6 liters of blood circulates through the body three times every minute.", @"Your eyeballs are three and a half percent salt.", @"You burn more calories while sleeping than you do when watching television.", nil];
    
    currentPage = 1;
    doctorSearch.delegate = self;
    
 //   UIBarButtonItem *docProfile = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"exit24.png"] style:UIBarButtonItemStylePlain target:self action:@selector(logOut2:)];
  //  self.navigationItem.rightBarButtonItem = docProfile;
      //  self.navigationItem.leftBarButtonItem = nil;
   /* UIBarButtonItem *docProfile = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStylePlain target:self action:@selector(logOut2:)];
    self.navigationItem.rightBarButtonItem= docProfile;
    [self.navigationItem setHidesBackButton:YES];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"(0)"] style:UIBarButtonItemStylePlain target:self action:@selector(goToNotifications:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.view.backgroundColor = [UIColor whiteColor];*/
    
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
    
    
   
    
    [doctorsTable addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];
    
    [doctorsTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];
    
    [doctorsTable registerNib:[UINib nibWithNibName:@"DashboardDoctorCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
  //  [UINib nibWithNibName:@"MSGPatientGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];

 
    
    if (IS_IPHONE) {
        [menuCollection registerNib:[UINib nibWithNibName:@"DashboardCollectionCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    } else {
        [menuCollection registerNib:[UINib nibWithNibName:@"DashboardCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    }
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
     [self loadVideoChatUser];
    
    
    consultationHeight = consultationBox.frame.origin.y;
    appointmentHeight = appointmentBox.frame.origin.y;
    medicineHeight = medicineBox.frame.origin.y;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    [super viewWillAppear:animated];
    if ([self.patientsArray count] == 0)
    {
      //  [self loadVideoChatUser];
        [self requestPatientsDataByPage:1 keyword : @""];
        
        
    }
    [self loadNotifications];
    [self loadPMaster];
    [self loadConsultations];
    [self getPatientMedication];
    [self loadAppointmentsNew];
}


- (void)viewDidDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}

- (void)loadVideoChatUser {
    PatientLogin *plogin = [PatientLogin getFromUserDefault];
    

    
    QBUUser *user = [QBUUser user];
    user.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
    user.password = [NSString stringWithFormat:@"passwordmyfidem"];
    user.email = plogin.email;
    user.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];
    
    [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
        // Success, do something
        [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
            // Success, do something
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.userQB = user1;
            [self logInChatWithUser:user1];
        } errorBlock:^(QBResponse *response) {
            // error handling
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
        } errorBlock:^(QBResponse *response) {
            // error handling
            NSLog(@"error: %@", response.error);
        }];
    }];
    
    
/*    [QBRequest createSessionWithSuccessBlock:^(QBResponse *response, QBASession *session) {
        // Success, You have got Application session, now READ something.
        QBUUser *user = [QBUUser user];
        user.login = [NSString stringWithFormat:@"user-%@", plogin.uid];
        user.password = [NSString stringWithFormat:@"passwordmyfidem"];
        user.email = plogin.email;
        user.fullName = [NSString stringWithFormat:@"%@ %@",  plogin.firstname, plogin.lastname  ];
        
        [QBRequest signUp:user successBlock:^(QBResponse *response, QBUUser *user) {
            // Success, do something
            [QBRequest logInWithUserLogin:[NSString stringWithFormat:@"user-%@", plogin.uid] password:[NSString stringWithFormat:@"passwordmyfidem"] successBlock:^(QBResponse *response, QBUUser *user1) {
                // Success, do something
                AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appdelegate.userQB = user1;
                [self logInChatWithUser:user1];
            } errorBlock:^(QBResponse *response) {
                // error handling
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
            } errorBlock:^(QBResponse *response) {
                // error handling
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
    user1.ID = (int)user.ID;
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

- (void)loadPMaster {
    [[AppController sharedInstance] getPMasterByID:@"" WithCompletion:^(BOOL success, NSString *message, PMaster *msgsession) {
        if (success) {
            pmaster = msgsession;
            
            [profileIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            [profileBackIMG setImageWithURL:[NSURL URLWithString:pmaster.profileimage]];
            
            
            profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
            profileIMG.layer.masksToBounds = YES;
            //profileIMG.layer.borderColor = [UIColor blackColor].CGColor;
            //profileIMG.layer.borderWidth = 1.0;
            
            int min = 1; //Get the current text from your minimum and maximum textfields.
            int max = (int)randomFacts.count;
            
            int randNum = arc4random() % (max - min) + min; //create the random number.

            
            nameLabel.text = [NSString stringWithFormat:@"%@ %@", pmaster.firstname, pmaster.lastname];
            tokenLabel.text = [NSString stringWithFormat:@"Tokens: %@", pmaster.tokens];
            randomFactLabel.text = [NSString stringWithFormat:@"Random Fact: %@", [randomFacts objectAtIndex:randNum]];
        

        }
    }];
    
  
    
    

}


- (void)loadNotifications {
    [[AppController sharedInstance] getPNotifications:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *array) {
        if (success) {
            int notiCount = 0;
            for (Notifications *noti in array) {
                if ([noti.isRead intValue] == 0) {
                    notiCount += 1;
                } else {
                    
                }
            }
            notificationsArray = [NSMutableArray arrayWithArray:array];
            /*UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"(%i)", notiCount] style:UIBarButtonItemStylePlain target:self action:@selector(goToNotifications:)];
            self.navigationItem.leftBarButtonItem = leftButton;*/
            [UIApplication sharedApplication].applicationIconBadgeNumber = notiCount;
            
            if (notiCount > 99) {
                notificationCountLabel.text = @"100+";
            } else {
                notificationCountLabel.text = [NSString stringWithFormat:@"%i", notiCount];
            }
            
            
        }
    }];
}


- (void)loadConsultations
{
    [[AppController sharedInstance] getAllConsultations3:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        if (success)
        {
            
            //[consultationsArray removeAllObjects];
            //[consultationsArray addObjectsFromArray:conditions];
            //[menuTable reloadData];
            
            [consultationArray removeAllObjects];
            [consultationArray addObjectsFromArray:conditions];
            
            
       
            
            float tempApptHeight = 180;
            float tempApptOrigin = 0;
            float tempConHeight = 180;
            float tempConOrigin = 0;
            float tempMedHeight = 180;
            float tempMedOrigin = 0;
            
            if (appointmentArray.count == 0) {
                tempApptOrigin = 0.0f;
                tempApptHeight = 0.0f;
                appointmentBox.hidden = true;
            } else {
                tempApptOrigin = 8.0f;
                appointmentBox.hidden = false;
                if (appointmentArray.count == 1) {
                    tempApptHeight = 35.0f + (45.0f * 1);
                    
                } else if (appointmentArray.count == 2) {
                    tempApptHeight = 35.0f + (45.0f * 2);
                } else {
                    tempApptHeight = 35.0f + (45.0f * 3);
                }
            }
            
            if (consultationArray.count == 0) {
                tempConOrigin =  0.0f;
                tempConHeight = 0.0f;
                consultationBox.hidden = true;
            } else {
                tempConOrigin= 8.0f;
                consultationBox.hidden = false;
                
                //  tempConHeight = 35.0f + (45.0f * consultationArray.count);
                if (consultationArray.count == 1) {
                    tempConHeight = 35.0f + (45.0f * 1);
                } else  if (consultationArray.count == 1) {
                    tempConHeight = 35.0f + (45.0f * 2);
                } else {
                    tempConHeight = 35.0f + (45.0f * 3);
                }
            }
            
            
            if (medicationArray.count == 0) {
                tempMedOrigin= 0.0f;
                tempMedHeight = 0.0f;
                medicineBox.hidden = true;
            } else {
                medicineBox.hidden = false;
                tempMedOrigin =  8.0f;
                if (medicationArray.count == 1 ) {
                    tempMedHeight = 35.0f + (45.0f * 1);
                } else  if (medicationArray.count == 2 ) {
                    tempMedHeight = 35.0f + (45.0f * 2);
                } else {
                    tempMedHeight = 35.0f + (45.0f * 3);
                }
            }
            
            
            
            appointmentBox.frame = CGRectMake(appointmentBox.frame.origin.x, tempApptOrigin , appointmentBox.frame.size.width, tempApptHeight);
            
            consultationBox.frame = CGRectMake(consultationBox.frame.origin.x, tempApptOrigin + tempApptHeight + tempConOrigin, consultationBox.frame.size.width, tempConHeight );
            
            medicineBox.frame = CGRectMake(medicineBox.frame.origin.x,  tempApptOrigin + tempApptHeight + tempConOrigin + tempConHeight + tempMedOrigin, medicineBox.frame.size.width, tempMedHeight);
            
            
            float totalHeight = tempApptOrigin + tempApptHeight + tempConOrigin + tempConHeight + tempMedOrigin + tempMedHeight + 8.0f;
            
            awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, totalHeight);
            [awesomeScrollView addSubview:awesomeStuffContainer];
            awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
            
            
            if (conditions.count > 0) {
                
                  Consulatation *noteDic1 = [conditions objectAtIndex:0];
                NSString *statusString  = @"";
                if ([noteDic1.ctype isEqual:@"0"]) {
                    statusString = @"Pending";
                    consulStatusL1.text = statusString;
                    consulStatusL1.textColor  = [UIColor colorWithRed:228.0f/255.0f green:193.0f/255.0f blue:91.0f/255.0f alpha:1.0f];
                    
                    
                    
                } else if ([noteDic1.ctype isEqual:@"1"]) {
                    statusString = @"Accepted";
                    consulStatusL1.text = statusString;
                    consulStatusL1.textColor  = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
                    
                } else if ([noteDic1.ctype isEqual:@"2"]) {
                    statusString = @"Declined";
                    consulStatusL1.text = statusString;
                    consulStatusL1.textColor  = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
                    
                }
                consultNameL1.text = [NSString stringWithFormat:@"Dr. %@ %@", noteDic1.dfirstname, noteDic1.dlastname];
                consulContainer1.hidden = false;
                
                    if (conditions.count > 1) {
                        
                        
                        Consulatation *noteDic2 = [conditions objectAtIndex:1];
                       
                        if ([noteDic2.ctype isEqual:@"0"]) {
                            statusString = @"Pending";
                            consulStatusL2.text = statusString;
                            consulStatusL2.textColor  = [UIColor colorWithRed:228.0f/255.0f green:193.0f/255.0f blue:91.0f/255.0f alpha:1.0f];
                            
                            
                            
                        } else if ([noteDic2.ctype isEqual:@"1"]) {
                            statusString = @"Accepted";
                            consulStatusL2.text = statusString;
                            consulStatusL2.textColor  = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
                            
                        } else if ([noteDic2.ctype isEqual:@"2"]) {
                            statusString = @"Declined";
                            consulStatusL2.text = statusString;
                            consulStatusL2.textColor  = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
                            
                        }
                        consultNameL2.text = [NSString stringWithFormat:@"Dr. %@ %@", noteDic2.dfirstname, noteDic2.dlastname];
                        consulContainer2.hidden = false;
                        

                            if (conditions.count > 2) {
                                
                                
                                Consulatation *noteDic3 = [conditions objectAtIndex:2];
                                
                                if ([noteDic3.ctype isEqual:@"0"]) {
                                    statusString = @"Pending";
                                    consulStatusL3.text = statusString;
                                    consulStatusL3.textColor  = [UIColor colorWithRed:228.0f/255.0f green:193.0f/255.0f blue:91.0f/255.0f alpha:1.0f];
                                    
                                    
                                    
                                } else if ([noteDic3.ctype isEqual:@"1"]) {
                                    statusString = @"Accepted";
                                    consulStatusL3.text = statusString;
                                    consulStatusL3.textColor  = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
                                    
                                } else if ([noteDic3.ctype isEqual:@"2"]) {
                                    statusString = @"Declined";
                                    consulStatusL3.text = statusString;
                                    consulStatusL3.textColor  = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
                                    
                                }
                                consultNameL3.text = [NSString stringWithFormat:@"Dr. %@ %@", noteDic3.dfirstname, noteDic3.dlastname];
                                consulContainer3.hidden = false;
                                
                                
                                
                            } else {
                                  consulContainer3.hidden = true;
                            }
                        
                        
                    } else {
                        consulContainer2.hidden = true;
                        consulContainer3.hidden = true;
                    }


                
            } else {
                consulContainer1.hidden = true;
                consulContainer2.hidden = true;
                consulContainer3.hidden = true;
            }
        }
        
        
    }];
}


- (void)getPatientMedication {
    
    //[SVProgressHUD showWithStatus:@"Loading..."];
    
    [[AppController sharedInstance] getAllMedicationForPatients:@"" doctor:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
      //  [SVProgressHUD dismiss];
        if (success)
        {
            
            [medicationArray removeAllObjects];
            [medicationArray addObjectsFromArray:conditions];
            
            
            
            float tempApptHeight = 180;
            float tempApptOrigin = 0;
            float tempConHeight = 180;
            float tempConOrigin = 0;
            float tempMedHeight = 180;
            float tempMedOrigin = 0;
            if (appointmentArray.count == 0) {
                tempApptOrigin = 0.0f;
                tempApptHeight = 0.0f;
                appointmentBox.hidden = true;
            } else {
                tempApptOrigin = 8.0f;
                 appointmentBox.hidden = false;
                if (appointmentArray.count == 1) {
                    tempApptHeight = 35.0f + (45.0f * 1);
                    
                } else if (appointmentArray.count == 2) {
                    tempApptHeight = 35.0f + (45.0f * 2);
                } else {
                    tempApptHeight = 35.0f + (45.0f * 3);
                }
            }
            
            if (consultationArray.count == 0) {
                tempConOrigin =  0.0f;
                tempConHeight = 0.0f;
                consultationBox.hidden = true;
            } else {
                tempConOrigin= 8.0f;
                consultationBox.hidden = false;
                
                //  tempConHeight = 35.0f + (45.0f * consultationArray.count);
                if (consultationArray.count == 1) {
                    tempConHeight = 35.0f + (45.0f * 1);
                } else  if (consultationArray.count == 1) {
                    tempConHeight = 35.0f + (45.0f * 2);
                } else {
                    tempConHeight = 35.0f + (45.0f * 3);
                }
            }
            
            
            if (medicationArray.count == 0) {
                tempMedOrigin= 0.0f;
                tempMedHeight = 0.0f;
                medicineBox.hidden = true;
            } else {
                 medicineBox.hidden = false;
                tempMedOrigin =  8.0f;
                if (medicationArray.count == 1 ) {
                    tempMedHeight = 35.0f + (45.0f * 1);
                } else  if (medicationArray.count == 2 ) {
                    tempMedHeight = 35.0f + (45.0f * 2);
                } else {
                    tempMedHeight = 35.0f + (45.0f * 3);
                }
            }
            
            
            
            
            appointmentBox.frame = CGRectMake(appointmentBox.frame.origin.x, tempApptOrigin , appointmentBox.frame.size.width, tempApptHeight);
            
            consultationBox.frame = CGRectMake(consultationBox.frame.origin.x, tempApptOrigin + tempApptHeight + tempConOrigin, consultationBox.frame.size.width, tempConHeight );
            
            medicineBox.frame = CGRectMake(medicineBox.frame.origin.x,  tempApptOrigin + tempApptHeight + tempConOrigin + tempConHeight + tempMedOrigin, medicineBox.frame.size.width, tempMedHeight);
            
            
            float totalHeight = tempApptOrigin + tempApptHeight + tempConOrigin + tempConHeight + tempMedOrigin + tempMedHeight + 8.0f;
            
            awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, totalHeight);
            [awesomeScrollView addSubview:awesomeStuffContainer];
            awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
            
            
            
             if (conditions.count > 0) {
                  PatientMedication *patientInfo2 = [conditions objectAtIndex:0];
                 medNameL1.text  = [NSString stringWithFormat:@"%@", patientInfo2.medname];
                  NSString *titleLabel = [NSString stringWithFormat:@"Prescribed by Dr. %@ %@",patientInfo2.docfname, patientInfo2.doclname];
                 medDocL1.text = titleLabel;
                 medContainer1.hidden = false;
                 
                 if (conditions.count > 1) {
                     PatientMedication *patientInfo2 = [conditions objectAtIndex:1];
                     medNameL2.text  = [NSString stringWithFormat:@"%@", patientInfo2.medname];
                     NSString *titleLabel = [NSString stringWithFormat:@"Prescribed by Dr. %@ %@",patientInfo2.docfname, patientInfo2.doclname];
                     medDocL2.text = titleLabel;
                     medContainer2.hidden = false;
                     
                     if (conditions.count > 2) {
                         PatientMedication *patientInfo2 = [conditions objectAtIndex:2];
                         medNameL3.text  = [NSString stringWithFormat:@"%@", patientInfo2.medname];
                         NSString *titleLabel = [NSString stringWithFormat:@"Prescribed by Dr. %@ %@",patientInfo2.docfname, patientInfo2.doclname];
                         medDocL3.text = titleLabel;
                         medContainer3.hidden = false;
                         
                     } else {
                              medContainer3.hidden = true;
                     }
                     
                 } else {
                     medContainer2.hidden = true;
                     medContainer3.hidden = true;
                 }
                 
                 
             } else {
                 medContainer1.hidden = true;
                 medContainer2.hidden = true;
                 medContainer3.hidden = true;
             }
            
        }
        
    }];
}


- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
   
    
    [[AppController sharedInstance] getAllDoctors2:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [patientsArray removeAllObjects];
            }
            [patientsArray addObjectsFromArray:conditions];
           [doctorsTable reloadData];
        }
        
        //[patientsGrid.footer endRefreshing];
        //[patientsGrid.header endRefreshing];
        
    }];
}


- (void)loadAppointmentsNew {
    
    [[AppController sharedInstance] getFutureAppointmensForPatients:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        [SVProgressHUD dismiss];
        if (success)
        {
            [appointmentArray removeAllObjects];
            [appointmentArray addObjectsFromArray:conditions];
            
            
            float tempApptHeight = 180;
            float tempApptOrigin = 0;
            float tempConHeight = 180;
            float tempConOrigin = 0;
            float tempMedHeight = 180;
            float tempMedOrigin = 0;
            if (appointmentArray.count == 0) {
                tempApptOrigin = 0.0f;
                tempApptHeight = 0.0f;
                appointmentBox.hidden = true;
            } else {
                tempApptOrigin = 8.0f;
                appointmentBox.hidden = false;
                if (appointmentArray.count == 1) {
                    tempApptHeight = 35.0f + (45.0f * 1);
                    
                } else if (appointmentArray.count == 2) {
                    tempApptHeight = 35.0f + (45.0f * 2);
                } else {
                    tempApptHeight = 35.0f + (45.0f * 3);
                }
            }
            
            if (consultationArray.count == 0) {
                tempConOrigin =  0.0f;
                tempConHeight = 0.0f;
                consultationBox.hidden = true;
            } else {
                tempConOrigin= 8.0f;
                consultationBox.hidden = false;
                
                //  tempConHeight = 35.0f + (45.0f * consultationArray.count);
                if (consultationArray.count == 1) {
                    tempConHeight = 35.0f + (45.0f * 1);
                } else  if (consultationArray.count == 1) {
                    tempConHeight = 35.0f + (45.0f * 2);
                } else {
                    tempConHeight = 35.0f + (45.0f * 3);
                }
            }
            
            
            if (medicationArray.count == 0) {
                tempMedOrigin= 0.0f;
                tempMedHeight = 0.0f;
                medicineBox.hidden = true;
            } else {
                medicineBox.hidden = false;
                tempMedOrigin =  8.0f;
                if (medicationArray.count == 1 ) {
                    tempMedHeight = 35.0f + (45.0f * 1);
                } else  if (medicationArray.count == 2 ) {
                    tempMedHeight = 35.0f + (45.0f * 2);
                } else {
                    tempMedHeight = 35.0f + (45.0f * 3);
                }
            }
            
            
            
            appointmentBox.frame = CGRectMake(appointmentBox.frame.origin.x, tempApptOrigin , appointmentBox.frame.size.width, tempApptHeight);
            
            consultationBox.frame = CGRectMake(consultationBox.frame.origin.x, tempApptOrigin + tempApptHeight + tempConOrigin, consultationBox.frame.size.width, tempConHeight );
            
            medicineBox.frame = CGRectMake(medicineBox.frame.origin.x,  tempApptOrigin + tempApptHeight + tempConOrigin + tempConHeight + tempMedOrigin, medicineBox.frame.size.width, tempMedHeight);
            
            
            float totalHeight = tempApptOrigin + tempApptHeight + tempConOrigin + tempConHeight + tempMedOrigin + tempMedHeight + 8.0f;
            
            awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, totalHeight);
            [awesomeScrollView addSubview:awesomeStuffContainer];
            awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
            
            
            
            if (appointmentArray.count > 0) {
                Appointments *appt = [appointmentArray objectAtIndex:0];
                
                apptNameL1.text = [NSString stringWithFormat:@"Appointment with Dr. %@ %@", appt.firstname, appt.lastname];
                
                double unixTimeStamp =[appt.fromdate doubleValue];
                NSTimeInterval _interval=unixTimeStamp;
                NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
                
                NSDate* destinationDate = sourceDate;
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
                aptTimeL1.text =  [NSString stringWithFormat:@"%@", [formatter stringFromDate:destinationDate]];
                
                
                apptContainer1.hidden = false;
                if (appointmentArray.count > 1) {
                    
                    
                    Appointments *appt = [appointmentArray objectAtIndex:1];
                    
                    apptNameL2.text = [NSString stringWithFormat:@"Appointment with Dr. %@ %@", appt.firstname, appt.lastname];
                    
                    unixTimeStamp =[appt.fromdate doubleValue];
                    _interval=unixTimeStamp;
                    sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
                    
                    destinationDate = sourceDate;
                    
                    formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
                    aptTimeL2.text =  [NSString stringWithFormat:@"%@", [formatter stringFromDate:destinationDate]];

                    
                    
                    
                    apptContainer2.hidden = false;
                     if (appointmentArray.count > 2) {
                         Appointments *appt = [appointmentArray objectAtIndex:2];
                         
                         apptNameL3.text = [NSString stringWithFormat:@"Appointment with Dr. %@ %@", appt.firstname, appt.lastname];
                         
                         unixTimeStamp =[appt.fromdate doubleValue];
                         _interval=unixTimeStamp;
                         sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
                         
                         destinationDate = sourceDate;
                         
                         formatter = [[NSDateFormatter alloc] init];
                         [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
                         aptTimeL3.text =  [NSString stringWithFormat:@"%@", [formatter stringFromDate:destinationDate]];
                         
                         apptContainer3.hidden = false;
                     } else {
                         apptContainer3.hidden = true;
                     }
                    
                    
                } else {
                    apptContainer2.hidden = true;
                    apptContainer3.hidden = true;
                }
                
            } else {
                apptContainer1.hidden = true;
                apptContainer2.hidden = true;
                apptContainer3.hidden = true;
            }
            
        }
        
    }];
    
}

- (IBAction)goToNotifications:(id)sender {
    NotificationsViewController *vc = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
    //   vc.patientInfo = patientInfo;
    //  vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goToAppointments:(UIButton *)sender {
    
    Appointments *appt = [appointmentArray objectAtIndex:sender.tag];
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getLinkPatients:appt.patientid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        
        if (success) {
            if (conditions.count > 0) {
                PatientLinks *plink = [conditions objectAtIndex:0];
                
                [[AppController sharedInstance] getDoctorProfile2:plink.docid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
                    [SVProgressHUD dismiss];
                    if (success) {
                        PMasterCalDetailsViewController *vc = [[PMasterCalDetailsViewController alloc] initWithNibName:@"PMasterCalDetailsViewController" bundle:nil];
                        vc.appointment = appt;
                        vc.doctor = doctorProfile;
                        vc.patientInfo = plink;
                        if ([appt.patientid isEqual:plink.postid]) {
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                        
                    }
                }];
                
            } else {
                [SVProgressHUD dismiss];
            }
            
            
        } else {
            [SVProgressHUD dismiss];
        }
        
        
        
    }];
    

    
    
}


- (IBAction)goToConsulttionsIndi:(UIButton *)sender {
    Consulatation   *noteDic = [consultationArray objectAtIndex:sender.tag];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getDoctorProfile2:noteDic.did WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success) {
            DoctorProfilePatientViC *vc = [[DoctorProfilePatientViC alloc] initWithNibName:@"DoctorProfilePatientViC" bundle:nil];
            vc.doctor = doctorProfile;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }];

}

- (IBAction)goToMedIndi:(UIButton *)sender {
    PatientMedication *patientInfo2 = [medicationArray objectAtIndex:sender.tag];
  
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getLinkPatients:patientInfo2.patientid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        [SVProgressHUD dismiss];
        if (success) {
            if (conditions.count > 0) {
                PatientLinks *plink = [conditions objectAtIndex:0];
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                RefillMedInfoViewController *vc = [[RefillMedInfoViewController alloc] initWithNibName:@"RefillMedInfoViewController" bundle:nil];
                vc.patientLink = plink;
                vc.medication = patientInfo2;
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
    }];

}


- (IBAction)goToPatientProfile:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    MyProfilePatientViewController *vc = [[MyProfilePatientViewController alloc] initWithNibName:@"MyProfilePatientViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateImageViewCellOffset:(DashboardDoctorCell *)cell
{
    CGFloat imageOverflowHeight = [cell imageOverflowHeight];
    
    CGFloat cellOffset = cell.frame.origin.y - doctorsTable.contentOffset.y;
    CGFloat maxOffset = doctorsTable.frame.size.height - cell.frame.size.height;
    CGFloat verticalOffset = imageOverflowHeight * (0.5f - cellOffset/maxOffset);
    
    cell.imageOffset = CGPointMake(0.0f, verticalOffset);
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
    
    
    Doctors *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
    NSString *isOnline = @"Offline";
    if ([patientInfo.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Online";
        cell.onlineLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
    } else if ([patientInfo.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Offline";
        cell.onlineLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
    }
    

    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.firstname, patientInfo.lastname];
    cell.specialityLabel.text = patientInfo.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
   // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     Doctors *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    DoctorProfilePatientViC *vc = (DoctorProfilePatientViC *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfilePatientViC"];
    vc.doctor = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewdelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (DashboardDoctorCell *cell in doctorsTable.visibleCells) {
       // [self updateImageViewCellOffset:cell];
    }
}



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
            MyProfilePatientViewController *vc = [[MyProfilePatientViewController alloc] initWithNibName:@"MyProfilePatientViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
        }  else if ([item.title isEqual:@"Link Patient Records"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            LinkPatientsViewController *vc = (LinkPatientsViewController  *)[sb instantiateViewControllerWithIdentifier:@"LinkPatientsViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }  else if ([item.title isEqual:@"My Patient Records"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            PatientRecordsViewController *vc = (PatientRecordsViewController  *)[sb instantiateViewControllerWithIdentifier:@"PatientRecordsViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }  else if ([item.title isEqual:@"Medications"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            SelectDocRefillViewController *vc = (SelectDocRefillViewController  *)[sb instantiateViewControllerWithIdentifier:@"SelectDocRefillViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
        }  else if ([item.title isEqual:@"Calendar"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            CalendarRecViewController *vc = (CalendarRecViewController  *)[sb instantiateViewControllerWithIdentifier:@"CalendarRecViewController"];
            
            [self.navigationController pushViewController:vc animated:YES];
        } else if ([item.title isEqual:@"Log Out"]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientRegisterUserDefault];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientUserDefault];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }

    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  [self updateImageViewCellOffset:(DashboardDoctorCell *)cell];
}



- (void)refreshPatientList {
    [self requestPatientsDataByPage:1 keyword : doctorSearch.text];
}

#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestPatientsDataByPage:1 keyword : doctorSearch.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self requestPatientsDataByPage:1 keyword : searchText];
}


- (IBAction)logOut2:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientRegisterUserDefault];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientUserDefault];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)patientMenu:(id)sender {
    
   /* CNPGridMenuItem *messageItem = [[CNPGridMenuItem alloc] init];
    messageItem.icon = [UIImage imageNamed:@"messageicon.png"];
    messageItem.title = @"Messages";
    
    CNPGridMenuItem *profileItem = [[CNPGridMenuItem alloc] init];
    profileItem.icon = [UIImage imageNamed:@"users81.png"];
    profileItem.title = @"My Profile";
    
    CNPGridMenuItem *patientItem = [[CNPGridMenuItem alloc] init];
    patientItem.icon = [UIImage imageNamed:@"patientsicon2.png"];
    patientItem.title = @"My Patient Records";
    
    CNPGridMenuItem *appointmentItem = [[CNPGridMenuItem alloc] init];
    appointmentItem.icon = [UIImage imageNamed:@"appointments.png"];
    appointmentItem.title = @"Calendar";
    
    CNPGridMenuItem *linkItem = [[CNPGridMenuItem alloc] init];
    linkItem.icon = [UIImage imageNamed:@"link23.png"];
    linkItem.title = @"Link Patient Records";
    
    CNPGridMenuItem *medicalItem = [[CNPGridMenuItem alloc] init];
    medicalItem.icon = [UIImage imageNamed:@"medicalicon2.png"];
    medicalItem.title = @"Medications";
    
    CNPGridMenuItem *exitItem = [[CNPGridMenuItem alloc] init];
    exitItem.icon = [UIImage imageNamed:@"exit2.png"];
    exitItem.title = @"Log Out";
    
    CNPGridMenuItem *consultationItem = [[CNPGridMenuItem alloc] init];
    consultationItem.icon = [UIImage imageNamed:@"headphones1"];
    consultationItem.title = @"Online Consultation";
    
    CNPGridMenuItem *paymentsItem = [[CNPGridMenuItem alloc] init];
    paymentsItem.icon = [UIImage imageNamed:@"money146.png"];
    paymentsItem.title = @"Payments";
    
    
    
    gridMenu = [[CNPGridMenu alloc] initWithMenuItems:@[patientItem, medicalItem, linkItem, appointmentItem, consultationItem, messageItem, paymentsItem, profileItem, exitItem]];
    gridMenu.delegate = self;
    [self presentGridMenu:gridMenu animated:YES completion:^{
        NSLog(@"Grid Menu Presented");
    }];
    */

    
     [self.revealViewController revealToggle:sender];
}


#pragma mark - UICollectionView


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        
        
        DashboardCollectionCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"My Records";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Medications";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Link Records";
            /*cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"patientlinkv2.png"];*/
            cell.nameLabel.textColor = [UIColor colorWithRed:192.0f/255.0f green:49.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"file-folder.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Consultation";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
           // cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
          
            cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Appointments";
            cell.nameLabel.textColor = [UIColor colorWithRed:209.0f/255.0f green:104.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phonebook.png"];
        } else if (indexPath.row == 5) {
            cell.nameLabel.text = @"Message";
          //  cell.nameLabel.textColor = [UIColor colorWithRed:103.0f/255.0f green:170.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
            //cell.cellImageView.image = [UIImage imageNamed:@"messages-iconv2.png"];
        }  else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Payments";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        }  else if (indexPath.row == 7) {
            cell.nameLabel.text = @"My Profile";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"dna-icon.png"];
        }  else if (indexPath.row == 8) {
            cell.nameLabel.text = @"IVA";
            cell.nameLabel.textColor = [UIColor colorWithRed:169.0f/255.0f green:204.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"miciconv3.png"];
        }  else if (indexPath.row == 9) {
            cell.nameLabel.text = @"Log Out";
            cell.nameLabel.textColor = [UIColor colorWithRed:169.0f/255.0f green:204.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"inside-logout-icon.png"];
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
            cell.nameLabel.text = @"My Records";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Medications";
            cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"tablets-icon.png"];
        } else if (indexPath.row == 2) {
            cell.nameLabel.text = @"Link Records";
            /*cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
             cell.cellImageView.image = [UIImage imageNamed:@"patientlinkv2.png"];*/
            cell.nameLabel.textColor = [UIColor colorWithRed:192.0f/255.0f green:49.0f/255.0f blue:62.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"file-folder.png"];
        } else if (indexPath.row == 3) {
            cell.nameLabel.text = @"Consultation";
            cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
            // cell.cellImageView.image = [UIImage imageNamed:@"phone-iconv2.png"];
            
            cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];
        } else if (indexPath.row == 4) {
            cell.nameLabel.text = @"Appointments";
            cell.nameLabel.textColor = [UIColor colorWithRed:209.0f/255.0f green:104.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"phonebook.png"];
        } else if (indexPath.row == 5) {
            cell.nameLabel.text = @"Message";
            //  cell.nameLabel.textColor = [UIColor colorWithRed:103.0f/255.0f green:170.0f/255.0f blue:42.0f/255.0f alpha:1.0f];
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
            //cell.cellImageView.image = [UIImage imageNamed:@"messages-iconv2.png"];
        }  else if (indexPath.row == 6) {
            cell.nameLabel.text = @"Payments";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"medicine-cart-icon.png"];
        }  else if (indexPath.row == 7) {
            cell.nameLabel.text = @"My Profile";
            cell.nameLabel.textColor = [UIColor colorWithRed:191.0f/255.0f green:220.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"dna-icon.png"];
        }  else if (indexPath.row == 8) {
            cell.nameLabel.text = @"IVA";
            cell.nameLabel.textColor = [UIColor colorWithRed:169.0f/255.0f green:204.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"miciconv3.png"];
        }  else if (indexPath.row == 9) {
            cell.nameLabel.text = @"Log Out";
            cell.nameLabel.textColor = [UIColor colorWithRed:169.0f/255.0f green:204.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"inside-logout-icon.png"];
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
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PatientRecordsViewController *vc = (PatientRecordsViewController  *)[sb instantiateViewControllerWithIdentifier:@"PatientRecordsViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 1) {
      /*  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        SelectDocRefillViewController *vc = (SelectDocRefillViewController  *)[sb instantiateViewControllerWithIdentifier:@"SelectDocRefillViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
        */
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        SelectRecMedViewController *vc = (SelectRecMedViewController *)[sb instantiateViewControllerWithIdentifier:@"SelectRecMedViewController"];
     //   vc.patientInfo = patientInfo;
      //  vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];

    } else if (indexPath.row == 2) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        LinkPatientsViewController *vc = (LinkPatientsViewController  *)[sb instantiateViewControllerWithIdentifier:@"LinkPatientsViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 3) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ShortQuestViewController *vc = (ShortQuestViewController  *)[sb instantiateViewControllerWithIdentifier:@"ShortQuestViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
    
    } else if (indexPath.row == 4) {
      /*  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        CalendarRecViewController *vc = (CalendarRecViewController  *)[sb instantiateViewControllerWithIdentifier:@"CalendarRecViewController"];
        
        [self.navigationController pushViewController:vc animated:YES]; */
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        CalendarPatientViewController *vc = (CalendarPatientViewController  *)[sb instantiateViewControllerWithIdentifier:@"CalendarPatientViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 5) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MesRecDoctorViewController *vc = (MesRecDoctorViewController  *)[sb instantiateViewControllerWithIdentifier:@"MesRecDoctorViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 6) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        PaymentsPageViewController *vc = (PaymentsPageViewController  *)[sb instantiateViewControllerWithIdentifier:@"PaymentsPageViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }  else if (indexPath.row == 7) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MyProfilePatientViewController *vc = [[MyProfilePatientViewController alloc] initWithNibName:@"MyProfilePatientViewController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }  else if (indexPath.row == 8) {
        
       /* if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
            UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
        else
            UIGraphicsBeginImageContext(self.view.bounds.size);
        
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        IVAViewController *vc = (IVAViewController  *)[sb instantiateViewControllerWithIdentifier:@"IVAViewController"];
        vc.ivaIMage = image;
      //  self.view.backgroundColor = [UIColor clearColor];
        
        [self presentViewController:vc animated:YES completion:nil];*/
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Coming Soon" message:@"This feature will be available soon" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    } else if (indexPath.row == 9) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientRegisterUserDefault];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPatientUserDefault];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController popViewControllerAnimated:YES];
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








@end
