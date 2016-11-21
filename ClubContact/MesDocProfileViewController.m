//
//  MesDocProfileViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MesDocProfileViewController.h"
#import "UIImageView+WebCache.h"

@interface MesDocProfileViewController ()

@end

@implementation MesDocProfileViewController


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
    
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    self.title = @"DOCTOR PROFILE";
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

- (void)loadDoctorData {
    if (doctor) {
        [profileIMG setImageWithURL:[NSURL URLWithString:doctor.profileimage]];
        [profileBackIMG setImageWithURL:[NSURL URLWithString:doctor.profileimage]];
        
        
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
        profileIMG.layer.masksToBounds = YES;
        profileIMG.layer.borderColor = [UIColor blackColor].CGColor;
        profileIMG.layer.borderWidth = 1.0;
        
        docName.text = [NSString stringWithFormat:@"Dr. %@ %@", doctor.firstname, doctor.lastname];
        docSpeciality.text = doctor.speciality;
        docFrom.text = [NSString stringWithFormat:@"From %@ %@ %@ %@ %@", doctor.officeaddress, doctor.officecity, doctor.officestate, doctor.officezip, doctor.officecountry];
        docCost.text = [NSString stringWithFormat:@"1 Token/Message"];
        
        if ([doctor.yearsExperience intValue] > 1) {
            docYears.text = [NSString stringWithFormat:@"Experience: %@ years ", doctor.yearsExperience];
        } else {
            docYears.text = [NSString stringWithFormat:@"Experience: %@ year", doctor.yearsExperience];
        }
        
        docResidency.text = [NSString stringWithFormat:@"Residency: %@", doctor.residency];
        docSchool.text = [NSString stringWithFormat:@"School: %@", doctor.school];
        
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
    [self.navigationController pushViewController:vc animated:true];
    
}

- (IBAction)goToReviews:(id)sender {
    ReviewsViewController *vc = [[ReviewsViewController alloc] initWithNibName:@"ReviewsViewController" bundle:nil];
    vc.doctor = doctor;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToNewSession:(id)sender {
    /*[[AppController sharedInstance] createNewMSGSession:doctor.uid WithCompletion:^(BOOL success, NSString *message, NSString *msgID) {
        if (success) {
            [self loadMessagingView:msgID];
        }
    }];*/
    [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance] createNewMSGSession:doctor.uid WithCompletion:^(BOOL success, NSString *message, NSString *msgID) {
        [SVProgressHUD dismiss];
        if (success) {
            [self loadMessagingView:msgID];
        }
    }];
}

- (IBAction)goToPreviousSessions:(id)sender {
    MesHistoryViewController *vc = [[MesHistoryViewController alloc] initWithNibName:@"MesHistoryViewController" bundle:nil];
    vc.doctor = doctor;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE) {
        
        DocMenuTableViewCell    *cell = (DocMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
        
        
        
        if (indexPath.row == 0) {
            cell.nameLabel.text = @"New Session";
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
        } else if (indexPath.row == 1) {
            cell.nameLabel.text = @"Previous Sessions";
            cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
            cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];
        } else if (indexPath.row == 2) {
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
     
         [SVProgressHUD showWithStatus:@"Please wait..."];
        [[AppController sharedInstance] createNewMSGSession:doctor.uid WithCompletion:^(BOOL success, NSString *message, NSString *msgID) {
            [SVProgressHUD dismiss];
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
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ReviewsViewController *vc = (ReviewsViewController *)[sb instantiateViewControllerWithIdentifier:@"ReviewsViewController"];
        vc.doctor = doctor;
        
        [self.navigationController pushViewController:vc animated:YES];
   
    }
}

- (void)loadMessagingView:(NSString *)msgID {
    
     [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance] getMSGSessionsByID2:doctor.uid sessionID:msgID WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
        if (success) {
            [SVProgressHUD dismiss];
             BOOL isClosed = false;
           
            PatientMessagingView *vc = [[ PatientMessagingView alloc]initWithNibName:@"PatientMessagingView" bundle:nil];
            vc.doctorV2 = doctor;
            vc.msgSession = msgsession;
            vc.isClosedSessionOpen = false;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
  }


@end
