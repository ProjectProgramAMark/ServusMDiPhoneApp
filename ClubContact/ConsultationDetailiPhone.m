//
//  ConsultationDetailiPhone.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/22/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "ConsultationDetailiPhone.h"

@interface ConsultationDetailiPhone ()

@end

@implementation ConsultationDetailiPhone
@synthesize delegate;
@synthesize nameLabel1;
@synthesize consultation;
@synthesize fromTimeLabel1;
@synthesize monthLabel1;
@synthesize dayLabel1;
@synthesize emailLabel;
@synthesize linkButton;
@synthesize linkLabel;
@synthesize acceptButton;
@synthesize declineButton;
@synthesize cStatus;
@synthesize costLabel;
@synthesize noteText;
@synthesize profBlurEffect;
@synthesize profIMG;
@synthesize profIMG2;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
  /*  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPop:)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
   // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
   // self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    self.title = @"CONSULTATION DETAILS";
    
   // [acceptButton setBackgroundColor:[UIColor flatLimeColor]];
   // [declineButton setBackgroundColor:[UIColor flatRedColor]];
    [menuTable registerNib:[UINib nibWithNibName:@"PatientRecordAboutCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelPop:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
   // declineButton.frame = CGRectMake(0, declineButton.frame.origin.y, windowWidth/2, declineButton.frame.size.height);
   // acceptButton.frame = CGRectMake(windowWidth/2, acceptButton.frame.origin.y, windowWidth/2, acceptButton.frame.size.height);
    
    
    @try {
        
        NSDate *dob2 = [NSDate dateWithTimeIntervalSince1970:[consultation.consultime integerValue]];
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
        [formatter2 setDateFormat:@"dd MMMM yyyy HH:MM"];
        NSString *timeString2 =  [formatter2 stringFromDate:dob2];
        
        fromTimeLabel1.text = [NSString stringWithFormat:@"Date: %@",timeString2];

        
        if ([consultation.ctype isEqual:@"0"]) {
            self.cStatus.text = @"Pending";
            self.cStatus.textColor = [UIColor lightGrayColor];
            linkButton.hidden = true;
            acceptButton.hidden = false;
            declineButton.hidden = false;
            
            
        } else if ([consultation.ctype isEqual:@"1"]) {
            self.cStatus.text = @"Accepted";
            self.cStatus.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];

            linkButton.hidden = false;
            acceptButton.hidden = true;
            declineButton.hidden = true;
            
        } else if ([consultation.ctype isEqual:@"2"]) {
            self.cStatus.text = @"Declined";
            self.cStatus.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            ;

            linkButton.hidden =true;
            acceptButton.hidden = true;
            declineButton.hidden = true;
            
        }
        
   
        profIMG.layer.cornerRadius = profIMG.frame.size.width/2;
        profIMG.layer.masksToBounds = YES;
        profIMG.layer.borderColor = [UIColor blackColor].CGColor;
        profIMG.layer.borderWidth = 1.0f;
        
       
        
        [profIMG setImageWithURL:[NSURL URLWithString:consultation.profileimg]];
        
        
        self.nameLabel1.text = [NSString stringWithFormat:@"%@ %@", consultation.pfirstname, consultation.plastname];
        self.emailLabel.text = [NSString stringWithFormat:@"Email: %@",consultation.pmail];
        self.phoneLabel.text = [NSString stringWithFormat:@"Done Instead: %@",consultation.whatWould];
      //  self.linkLabel.text = [NSString stringWithFormat:@"Link: %@",consultation.clink];
        self.costLabel.text = [NSString stringWithFormat:@"Charge: %@ Tokens",consultation.ccost];
        self.noteText.text = [NSString stringWithFormat:@"Note: %@",consultation.cnotes];
        self.pharmnameLabel.text = [NSString stringWithFormat:@"Pharmacy: %@",consultation.pharmname];
        self.pharmAddressLabel.text = [NSString stringWithFormat:@"Pharmacy Address: %@",consultation.pharmadd];
        [menuTable reloadData];
    }
    @catch (NSException *exception) {
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (consultation) {
        return 9;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PatientRecordAboutCell    *cell = (PatientRecordAboutCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    // if (_addedConditionsArray.count > 0) {
    if (indexPath.row == 0) {
       
        //  cell.allergen = patientInfo;
        cell.nameLabel.text = [NSString stringWithFormat:@"Done Instead: %@", consultation.whatWould];
        cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];
        
        // cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
        
        
    } else if (indexPath.row == 1) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Have Primary Physician: %@", consultation.primaryPhysician];
        cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];
    } else if (indexPath.row == 2) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Email: %@", consultation.pmail];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
    }  else if (indexPath.row == 3) {
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[consultation.consultime integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
        NSString *timeString =  [formatter stringFromDate:dob];;
        cell.nameLabel.text = [NSString stringWithFormat:@"Consultation Time: %@", timeString];
        cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];
    } else if (indexPath.row == 4) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Charge: %@ Tokens", consultation.ccost];
        cell.nameLabel.textColor = [UIColor colorWithRed:108.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"cameraIconv4.png"];
    } else if (indexPath.row == 5) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Pharmacy Name: %@", consultation.pharmname];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];
    } else if (indexPath.row == 6) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Pharmacy Address: %@", consultation.pharmadd];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"hospital-icon.png"];
    } else if (indexPath.row == 7) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Conditions"];
        cell.cellImageView.image = [UIImage imageNamed:@"medicine-box-icon.png"];
        cell.nameLabel.textColor = [UIColor colorWithRed:241.0f/255.0f green:201.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    } else if (indexPath.row == 8) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Allergies"];
        cell.cellImageView.image = [UIImage imageNamed:@"human-brain-icon.png"];
        cell.nameLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:203.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 7) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ConsulDetailConditionsViewController *vc =[[ConsulDetailConditionsViewController alloc] initWithNibName:@"ConsulDetailConditionsViewController" bundle:nil];
        vc.consultation = consultation;
          [self.navigationController pushViewController:vc animated:YES];

       
    } else if (indexPath.row == 8) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ConsulDetailAllergyViewController *vc =  [[ConsulDetailAllergyViewController alloc] initWithNibName:@"ConsulDetailAllergyViewController" bundle:nil];
        vc.consultation = consultation;
        [self.navigationController pushViewController:vc animated:YES];
      
    }
}






/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (IBAction)linkClicked:(id)sender {
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:consultation.clink]];
    
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Consultation" message:@"Select an option" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *audoAction = [UIAlertAction actionWithTitle:@"Call Audio" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[AppController sharedInstance] sendCallNotification:consultation.pid completion:^(BOOL success, NSString *message) {
            if (success) {
                
            }
        }];
        
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:noteDic.clink]];
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [QBRequest  userWithLogin:[NSString stringWithFormat:@"user-%@", consultation.pid] successBlock:^(QBResponse *response, QBUUser *user) {
            [SVProgressHUD dismiss];
            docQB = user;
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.docQB = user;
           
            [self callWithConferenceType:QBRTCConferenceTypeAudio];
            
        } errorBlock:^(QBResponse *response) {
            [SVProgressHUD dismiss];
            NSLog(@"error: %@", response.error);
            
        }];
        
        
        
    }];
    
    UIAlertAction *videoAction = [UIAlertAction actionWithTitle:@"Call Video" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[AppController sharedInstance] sendCallNotification:consultation.pid completion:^(BOOL success, NSString *message) {
            if (success) {
                
            }
        }];
        
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:noteDic.clink]];
          [SVProgressHUD showWithStatus:@"Please wait..."];
        [QBRequest  userWithLogin:[NSString stringWithFormat:@"user-%@", consultation.pid] successBlock:^(QBResponse *response, QBUUser *user) {
            [SVProgressHUD dismiss];
            docQB = user;
            AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appdelegate.docQB = user;
            
            [self callWithConferenceType:QBRTCConferenceTypeVideo];
            
        } errorBlock:^(QBResponse *response) {
            [SVProgressHUD dismiss];
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
    
    if ([consultation.ctype isEqual:@"1"]) {
        
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

- (IBAction)acceptClicked:(id)sender {
     [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance] acceptConsultation:consultation.postid completion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        if (success) {
            self.cStatus.text = @"Accepted";
            self.cStatus.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
            linkButton.hidden = false;
            acceptButton.hidden = true;
            declineButton.hidden = true;
            consultation.ctype = @"1";
            //[self.delegate refreshPationInfo];
        }
    }];
}


- (IBAction)declineClicked:(id)sender {
     [SVProgressHUD showWithStatus:@"Please wait..."];
    [[AppController sharedInstance ] declineConsultation:consultation.postid completion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        if (success) {
            linkButton.hidden =true;
            acceptButton.hidden = true;
            declineButton.hidden = true;
            self.cStatus.text = @"Declined";
            self.cStatus.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            ;
           // [self.delegate refreshPationInfo];
        }
    }];
}


- (IBAction)openConsultationCondition:(id)sender {
    
    ConsulDetailConditionsViewController *vc = [[ConsulDetailConditionsViewController alloc] initWithNibName:@"ConsulDetailConditionsViewController" bundle:nil];
    vc.consultation = consultation;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)openConsultationAllergy:(id)sender{
  
    ConsulDetailAllergyViewController *vc = [[ConsulDetailAllergyViewController alloc] initWithNibName:@"ConsulDetailAllergyViewController" bundle:nil];
    vc.consultation = consultation;
    [self.navigationController pushViewController:vc animated:YES];

}



- (void)callWithConferenceType:(QBRTCConferenceType)conferenceType {
    
    
    [CallManager.instance callToUsers:[NSArray arrayWithObject:docQB]
                   withConferenceType:conferenceType];
    
}





@end
