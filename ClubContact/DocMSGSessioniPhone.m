//
//  DocMSGSessioniPhone.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/22/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DocMSGSessioniPhone.h"

@interface DocMSGSessioniPhone ()

@end

@implementation DocMSGSessioniPhone


@synthesize msgSession;
@synthesize delegate;
@synthesize isMySession;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPop)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
  /*  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop)];*/
     UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.navigationController.navigationBar.barTintColor = [UIColor flatWhiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.view.backgroundColor = [UIColor whiteColor];
    doc = [[Doctors alloc] init];
    
    self.title = @"SESSION DETAILS";
    
    [menuTable registerNib:[UINib nibWithNibName:@"PatientRecordAboutCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    if (isMySession == true) {
       // [profileIMG setImageWithURL:[NSURL URLWithString:msgSession.dprofileimg]];
        
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
        profileIMG.layer.masksToBounds = YES;
        profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        profileIMG.layer.borderWidth = 3.0;
        
        
        
        [profileIMG setImageWithURL:[NSURL URLWithString:msgSession.dprofileimg]];
        [profileIMG2 setImageWithURL:[NSURL URLWithString:msgSession.dprofileimg]];
        
        nameLabel.text = [NSString stringWithFormat:@"%@ %@", msgSession.dfirstname, msgSession.dfirstname];
        //cell.messageCountLabel.text = patientInfo.msgCount;
        emailText.text = [NSString stringWithFormat:@"%@", msgSession.dmail];
        
        noteText.text = @"";
        
          [self loadDoctorProfile:msgSession.did];
        
    } else {
        //[profileIMG setImageWithURL:[NSURL URLWithString:msgSession.profileimg]];
        
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
        profileIMG.layer.masksToBounds = YES;
        profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        profileIMG.layer.borderWidth = 3.0;
        
        
        
        [profileIMG setImageWithURL:[NSURL URLWithString:msgSession.profileimg]];
        [profileIMG2 setImageWithURL:[NSURL URLWithString:msgSession.profileimg]];
        
        
        nameLabel.text = [NSString stringWithFormat:@"%@ %@", msgSession.pfirstname, msgSession.plastname];
        //cell.messageCountLabel.text = patientInfo.msgCount;
        emailText.text = [NSString stringWithFormat:@"%@", msgSession.pmail];
        
        noteText.text = @"";
        [self loadDoctorProfile:msgSession.pid];
        
    }
    
    if ([msgSession.mstatus isEqual:@"0"]) {
        sessionStatus.text = @"Pending";
        sessionStatus.textColor = [UIColor flatGrayColor];
        acceptButton.hidden = false;
        declineButton.hidden = false;
        visitButton.hidden = true;
        
    } else if ([msgSession.mstatus isEqual:@"1"]) {
        sessionStatus.text = @"Accepted";
        sessionStatus.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
        acceptButton.hidden = true;
        declineButton.hidden = true;
        visitButton.hidden = false;
    } else if ([msgSession.mstatus isEqual:@"2"]) {
        sessionStatus.text = @"Declined";
        sessionStatus.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
        acceptButton.hidden = true;
        declineButton.hidden = true;
        visitButton.hidden = true;
    } else if ([msgSession.mstatus isEqual:@"3"]) {
        sessionStatus.text = @"Closed";
        sessionStatus.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
        acceptButton.hidden = true;
        declineButton.hidden = true;
        visitButton.hidden = true;
    }
    
    if (isMySession == true) {
        acceptButton.hidden = true;
        declineButton.hidden = true;
        visitButton.hidden = false;
    }
    
    
}

- (void)cancelPop {
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)loadDoctorProfile:(NSString *)docid {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getDoctorProfile2:docid WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success) {
            doc = doctorProfile;
            [menuTable reloadData];
        }
    }];
}

- (IBAction)acceptMSGSession:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [[AppController sharedInstance] acceptDocMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message) {
        if (success) {
            [self.delegate acceptedSession:msgSession];
            
        }
    }];
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (msgSession) {
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
        cell.nameLabel.text = [NSString stringWithFormat:@"Telephone: %@" , doc.telephone ];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
        
        // cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
        
        
    } else if (indexPath.row == 1) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Email: %@", doc.email];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
    } else if (indexPath.row == 2) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Office Name: %@", doc.officename];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
    }  else if (indexPath.row == 3) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Address: %@", doc.officeaddress];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
    }  else if (indexPath.row == 4) {
        cell.nameLabel.text = [NSString stringWithFormat:@"City: %@", doc.officecity];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
    }  else if (indexPath.row == 5) {
        cell.nameLabel.text = [NSString stringWithFormat:@"State: %@", doc.officestate];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
    }   else if (indexPath.row == 6) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Country: %@", doc.officecountry];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
    } else if (indexPath.row == 7) {
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[msgSession.created integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
        NSString *timeString =  [formatter stringFromDate:dob];
        cell.nameLabel.text = [NSString stringWithFormat:@"Created: %@", timeString];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
        
    } else if (indexPath.row == 8) {
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[msgSession.closetime integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
        NSString *timeString =  [formatter stringFromDate:dob];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"Closed: %@", timeString];
        
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"doctoriconv2.png"];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}











- (IBAction)declineMSGSession:(id)sender {
    /* [[AppController sharedInstance] declineMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message)  {
     if (success) {
     [self.delegate declinedSession];
     [self dismissViewControllerAnimated:NO completion:nil];
     }
     }];*/
    
    [[AppController sharedInstance] declineDocMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message) {
        if (success) {
            [self.delegate declinedSession];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
    
}

- (IBAction)visitMSGSession:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate visitSession:msgSession];
}


@end
