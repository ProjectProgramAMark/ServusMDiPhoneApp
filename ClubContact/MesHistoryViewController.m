//
//  MesHistoryViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MesHistoryViewController.h"
#import "Chameleon.h"

@interface MesHistoryViewController ()

@end

@implementation MesHistoryViewController


@synthesize doctor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // [menuTable registerNib:[UINib nibWithNibName:@"DocMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    consultationsArray = [[NSMutableArray alloc] init];
     [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatient2TableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
  
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    self.title = @"MESSAGING";
}

- (void)viewWillAppear:(BOOL)animated {
    //  [self loadDoctorData];
    [self loadConsultations];
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


- (void)loadConsultations
{
    [[AppController sharedInstance] getMesRecSession:doctor.uid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        if (success)
        {
            
            [consultationsArray removeAllObjects];
            [consultationsArray addObjectsFromArray:conditions];
            [menuTable reloadData];
        }
        
        //  [patientsGrid.footer endRefreshing];
        // [patientsGrid.header endRefreshing];
    }];
}




- (void)loadDoctorData {
    if (doctor) {
       /* [profileIMG setImageWithURL:[NSURL URLWithString:doctor.profileimage]];
        [profileBackIMG setImageWithURL:[NSURL URLWithString:doctor.profileimage]];
        
        
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2;
        profileIMG.layer.masksToBounds = YES;
        profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        profileIMG.layer.borderWidth = 3.0;
        
        docName.text = [NSString stringWithFormat:@"Dr. %@ %@", doctor.firstname, doctor.lastname];
        docSpeciality.text = doctor.speciality;
        docFrom.text = [NSString stringWithFormat:@"From %@ %@ %@ %@ %@", doctor.officeaddress, doctor.officecity, doctor.officestate, doctor.officezip, doctor.officecountry];
        
        NSString *isOnline = @"Offline";
        if ([doctor.isOnline intValue] == 1) {
            //isOnline = @"Online";
            docOnline.text = @"Available";
            docOnline.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
        } else if ([doctor.isOnline intValue] == 2) {
            docOnline.text = @"Unavailable";
            docOnline.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
        }*/
        
        
        
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return consultationsArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardPatient2TableViewCell *cell = (DashboardPatient2TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    
    MSGSession *patientInfo = [consultationsArray objectAtIndex:indexPath.row];
    
    @try {
        
        cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
        cell.cellImageView.layer.masksToBounds = YES;
        
        
        //  cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",patientInfo.dfirstname, patientInfo.dlastname];
        cell.costLabel.text = [NSString stringWithFormat:@"%@", patientInfo.lastmessage];
        //cell.timeLabel.text = [NSString stringWithFormat:@"%@", patientInfo.createdago];
        cell.specialityLabel.text = [NSString stringWithFormat:@"%@", patientInfo.dspeciality];
        
        
        double unixTimeStamp =[patientInfo.created doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        
        NSDate* destinationDate = sourceDate;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
        cell.timeLabel.text = [formatter stringFromDate:destinationDate];
        
        
        [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.dprofileimg]];
        
        
        if ([patientInfo.mstatus isEqual:@"0"]) {
            cell.costLabel2.text = @"Pending";
            cell.costLabel2.textColor = [UIColor flatGrayColor];
            
            cell.cellImageView.layer.borderColor = [UIColor flatGrayColor].CGColor;
            cell.cellImageView.layer.borderWidth = 3.0;
            
        } else if ([patientInfo.mstatus isEqual:@"1"]) {
            cell.costLabel2.text = @"Accepted";
            cell.costLabel2.textColor =  [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
            
            cell.cellImageView.layer.borderColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f].CGColor;
            cell.cellImageView.layer.borderWidth = 3.0;
            
        } else if ([patientInfo.mstatus isEqual:@"2"]) {
            cell.costLabel2.text = @"Declined";
            cell.costLabel2.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            
            cell.cellImageView.layer.borderColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f].CGColor;
            cell.cellImageView.layer.borderWidth = 3.0;
            
        } else if ([patientInfo.mstatus isEqual:@"3"]) {
            cell.costLabel2.text = @"Closed";
            cell.costLabel2.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            
            cell.cellImageView.layer.borderColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f].CGColor;
            cell.cellImageView.layer.borderWidth = 3.0;
            
        }
        
        
        
        
       // cell.costLabel.hidden = true;
        
        
        // cell.nameLabel.text = imageName;
        
        cell.clipsToBounds = YES;
        
    }
    @catch (NSException *exception) {
        
    }
    
    
    
    
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        return 100.0f;
    } else {
        return 100.0f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MSGSession *noteDic = [consultationsArray objectAtIndex:indexPath.row];
    
    
    BOOL isClosed = false;
    if ([noteDic.mstatus isEqual:@"0"]) {
    
        isClosed = false;
        
    } else if ([noteDic.mstatus isEqual:@"1"]) {
        isClosed = false;
        
    } else if ([noteDic.mstatus isEqual:@"2"]) {
        isClosed = true;
        
    } else if ([noteDic.mstatus isEqual:@"3"]) {
         isClosed = true;
        
    }
    
   
    PatientMessagingView *vc = [[PatientMessagingView alloc] initWithNibName:@"PatientMessagingView" bundle:nil];
    vc.doctorV2 = doctor;
    vc.msgSession = noteDic;
    vc.isClosedSessionOpen = isClosed;
    
    [self.navigationController pushViewController:vc animated:YES];

   /* Consulatation *noteDic = [consultationsArray objectAtIndex:indexPath.row];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Link to consultation" message:noteDic.clink preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *accessAction = [UIAlertAction actionWithTitle:@"Access Link" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:noteDic.clink]];
        
    }];
    
    UIAlertAction *copyAction = [UIAlertAction actionWithTitle:@"Copy" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSString *copyStringverse = noteDic.clink;
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:copyStringverse];
        
    }];
    
    
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //  [self dismissViewControllerAnimated:self completion:nil];
        
    }];
    
    [actionSheet addAction:accessAction];
    [actionSheet addAction:copyAction];
    
    [actionSheet addAction:cancelAction];
    [self presentViewController:actionSheet animated:YES completion:nil];*/
}



@end
