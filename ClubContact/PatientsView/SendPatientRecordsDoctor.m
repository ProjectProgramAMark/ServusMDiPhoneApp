//
//  SendPatientRecordsDoctor.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SendPatientRecordsDoctor.h"
#import "Patient.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "Doctors.h"

@interface SendPatientRecordsDoctor () <SpecialitySelectorDelegate>

@end

@implementation SendPatientRecordsDoctor


@synthesize patientInfo;
@synthesize doctor;
@synthesize patientsArray;
@synthesize profPatient;
@synthesize conditionsArray;
@synthesize addedConditionsArray;
@synthesize selectedAllergens;
@synthesize selectedConditions;
@synthesize pharmacy;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    patientsArray = [[NSMutableArray alloc] init];
    currentPage = 1;
   /* [doctorsTable addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];
    
    [doctorsTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];*/
    
    /*[doctorsTable registerNib:[UINib nibWithNibName:@"DashboardDoctorCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];*/
    
    
    isRefresshing = false;
    isMaxLimit = false;
    
    [doctorsTable registerNib:[UINib nibWithNibName:@"DoctorCellV2" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    //self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    self.title = @"SELECT DOCTOR";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    isRefresshing = false;
    isMaxLimit = false;

    [super viewWillAppear:animated];
    if ([self.patientsArray count] == 0)
    {
        [self requestPatientsDataByPage:1 keyword : @""];
    }
    
}


- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    /*[[AppController sharedInstance] getAllPatiensByPage:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
     if (success)
     {
     currentPage = page;
     if(currentPage == 1)
     {
     [_patientsArray removeAllObjects];
     }
     [_patientsArray addObjectsFromArray:patients];
     [patientsGrid reloadData];
     }
     
     [patientsGrid.footer endRefreshing];
     [patientsGrid.header endRefreshing];
     }];*/
    isRefresshing = true;
    isMaxLimit = false;
    
    [[AppController sharedInstance] getAllDoctors3:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [patientsArray removeAllObjects];
            }
            if (conditions.count == 0) {
                isMaxLimit = true;
            }
            [patientsArray addObjectsFromArray:conditions];
            [doctorsTable reloadData];
        }
        
        isRefresshing = false;
       
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
   
    
    DoctorCellV2 *cell = (DoctorCellV2 *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    Doctors *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
    
    NSString *isOnline = @"Offline";
    if ([patientInfo2.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Available";
        cell.onlineLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = true;
        cell.messageIcon.selected = true;
    } else if ([patientInfo2.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Unavailable";
        cell.onlineLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = false;
        cell.messageIcon.selected = false;
    }
    
    cell.facetimeIcon.tag = indexPath.row;
    cell.messageIcon.tag = indexPath.row;
    [cell.facetimeIcon addTarget:self action:@selector(openVideoChat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageIcon addTarget:self action:@selector(openMessaging:) forControlEvents:UIControlEventTouchUpInside];
    cell.facetimeIcon.hidden = true;
    cell.messageIcon.hidden = true;
    
    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo2.firstname, patientInfo2.lastname];
    
    cell.specialityLabel.text = patientInfo2.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo2.profileimage]];
    // cell.nameLabel.text = imageName;
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    cell.cellImageView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.cellImageView.layer.borderWidth = 1.0f;
    
    cell.clipsToBounds = YES;
    
    if (indexPath.row == ([patientsArray count] - 1)) {
        if (isMaxLimit == false && isRefresshing == false) {
            [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
        }
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //return 150.0f;
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Doctors *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
    doctorSend = patientInfo2;
    /* UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
     DoctorProfilePatientViC *vc = (DoctorProfilePatientViC *)[sb instantiateViewControllerWithIdentifier:@"DoctorProfilePatientViC"];
     vc.doctor = patientInfo;
     
     [self.navigationController pushViewController:vc animated:YES];*/
    /*  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
     TalkDoctorProfileViewController *vc = (TalkDoctorProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"TalkDoctorProfileViewController"];
     vc.doctor = patientInfo;
     
     [self.navigationController pushViewController:vc animated:YES];*/
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode"
                                                    message:@"Enter your passcode"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Ok", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    isPasscodeUpdate = true;
    /* [SVProgressHUD showWithStatus:@"Sending..."];
     [[AppController sharedInstance] createShareRecord:patientInfo2.uid patientid:profPatient.postid WithCompletion:^(BOOL success, NSString *message, NSString *msgID) {
     [SVProgressHUD dismiss];
     if (success) {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sent" message:@"Patient records sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
     [alert show];
     }
     }];*/
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (isPasscodeUpdate == true) {
        isPasscodeUpdate = false;
        if (buttonIndex == 1) {
            [SVProgressHUD showWithStatus:@"Checking..."];
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
            [[AppController sharedInstance] checkDoctorPasscode:passcodeString completion:^(BOOL success, NSString *message) {
                [SVProgressHUD dismiss];
                if (success) {
                    [SVProgressHUD showWithStatus:@"Sending..."];
                    [[AppController sharedInstance] createShareRecordDoctor:doctorSend.uid patientid:profPatient.postid WithCompletion:^(BOOL success, NSString *message, NSString *msgID) {
                        [SVProgressHUD dismiss];
                        if (success) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sent" message:@"Patient records sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                            [alert show];
                        }
                    }];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];
        }
    }
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
    
    
}

- (IBAction)openMessaging:(UIButton *)sender {
    PatientLinks *patientInfo = [patientsArray objectAtIndex:sender.tag];
    [[AppController sharedInstance] getDoctorProfile2:patientInfo.docid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        if (success) {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            MesDocProfileViewController *vc = (MesDocProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"MesDocProfileViewController"];
            vc.doctor = doctorProfile;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self inialiseToolbar];
    doctorSearch.inputAccessoryView = toolbar;
    return true;
}


-(void)inialiseToolbar{
    
    CGFloat _width = self.view.frame.size.width;
    CGFloat _height = 40.0;
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -_height, _width, _height)];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButtonItemSubmit = [[UIBarButtonItem alloc] initWithTitle:@"Speciality" style:UIBarButtonItemStyleBordered target:self action:@selector(specialitySelect:)];
    [toolbar setItems:[[NSArray alloc] initWithObjects:flexibleSpace,barButtonItemSubmit,  nil]];
}


- (IBAction)specialitySelect:(id)sender {
    SpecialitySelectorViewController *vc = [[SpecialitySelectorViewController alloc] init];
    vc.delegate = self;
    // isSpecilitySelect = true;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)specialitySelectDone:(NSString *)speciality {
    doctorSearch.text = speciality;
    [self requestPatientsDataByPage:1 keyword:speciality];
    
}


@end
