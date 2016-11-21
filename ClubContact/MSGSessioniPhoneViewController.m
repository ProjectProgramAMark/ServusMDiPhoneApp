//
//  MSGSessioniPhoneViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MSGSessioniPhoneViewController.h"

@interface MSGSessioniPhoneViewController ()

@end

@implementation MSGSessioniPhoneViewController



@synthesize msgSession;
@synthesize delegate;
@synthesize profIMG2;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPop)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.navigationController.navigationBar.barTintColor = [UIColor flatWhiteColor];
    self.navigationController.navigationBar.translucent = false;
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"SESSION DETAILS";
    
    [menuTable registerNib:[UINib nibWithNibName:@"PatientRecordAboutCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
    // cell.profileIMG.layer.borderWidth = 3.0;
    
    nameLabel.text = [NSString stringWithFormat:@"%@ %@", msgSession.pfirstname, msgSession.plastname];
    //cell.messageCountLabel.text = patientInfo.msgCount;
    emailText.text = [NSString stringWithFormat:@"%@", msgSession.pmail];
    
    noteText.text = [NSString stringWithFormat:@"%@", msgSession.mnote];
    
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
        visitButton.hidden = false;
    }
    
    
    profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
    profileIMG.layer.masksToBounds = YES;
    profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
    profileIMG.layer.borderWidth = 3.0;
    
    
    
    [profileIMG setImageWithURL:[NSURL URLWithString:msgSession.profileimg]];
    [profIMG2 setImageWithURL:[NSURL URLWithString:msgSession.profileimg]];
    
    if (msgSession.street1 == 0) {
        
    } else {
  //  noteText.text = [NSString stringWithFormat:@"From %@ %@ %@ %@ %@", msgSession.street1, msgSession.city, msgSession.state, msgSession.country, msgSession.zipcode];
    }
    
}

- (void)cancelPop {
    [self dismissViewControllerAnimated:NO completion:nil];
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (msgSession) {
        return 8;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PatientRecordAboutCell    *cell = (PatientRecordAboutCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    // if (_addedConditionsArray.count > 0) {
    if (indexPath.row == 0) {
        
        //  cell.allergen = patientInfo;
        cell.nameLabel.text = [NSString stringWithFormat:@"Telephone: %@" , msgSession.telephone ];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
        
        // cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
        
        
    } else if (indexPath.row == 1) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Email: %@", msgSession.pmail];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
    } else if (indexPath.row == 2) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Address: %@", msgSession.street1];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
    }  else if (indexPath.row == 3) {
        cell.nameLabel.text = [NSString stringWithFormat:@"City: %@", msgSession.city];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
    }  else if (indexPath.row == 4) {
        cell.nameLabel.text = [NSString stringWithFormat:@"State: %@", msgSession.state];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
    }   else if (indexPath.row == 5) {
        cell.nameLabel.text = [NSString stringWithFormat:@"Country: %@", msgSession.country];
        cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
    } else if (indexPath.row == 6) {
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[msgSession.created integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
        NSString *timeString =  [formatter stringFromDate:dob];
        cell.nameLabel.text = [NSString stringWithFormat:@"Created: %@", timeString];
        cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];

    } else if (indexPath.row == 7) {
        NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[msgSession.closetime integerValue]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
        NSString *timeString =  [formatter stringFromDate:dob];

        cell.nameLabel.text = [NSString stringWithFormat:@"Closed: %@", timeString];
        
        cell.nameLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:55.0f/255.0f blue:86.0f/255.0f alpha:1.0f];
        cell.cellImageView.image = [UIImage imageNamed:@"msg2.png"];

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}











- (IBAction)acceptMSGSession:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [[AppController sharedInstance] acceptMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message)  {
        if (success) {
            [self.delegate acceptedSession:msgSession];
            
        }
    }];
    
    
}

- (IBAction)declineMSGSession:(id)sender {
    [[AppController sharedInstance] declineMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message)  {
        if (success) {
            [self.delegate declinedSession];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
    
}

- (IBAction)visitMSGSession:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    if ([msgSession.mstatus isEqual:@"3"]) {
   
        [self.delegate visitClosedSession:msgSession];
        
    } else {
         [self.delegate visitSession:msgSession];
    }
}



@end
