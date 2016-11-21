//
//  PatientAppointmentViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/1/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "PatientAppointmentViewController.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"
@interface PatientAppointmentViewController () <CreateNewEventViewDelegate>

@end

@implementation PatientAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"APPOINTMENTS";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
     if (self.isSharedProfile == false) {
         self.navigationItem.rightBarButtonItem = notiButtonItem;
     }
    
    [_tableView registerNib:[UINib nibWithNibName:@"AppointmentDashTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getPatientAppointments];
    
    profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
    profileIMGView2.layer.masksToBounds = YES;
    profileIMGView2.layer.borderColor = [UIColor blackColor].CGColor;
    profileIMGView2.layer.borderWidth = 1.0;
    
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    //[profileIMGView3 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
    jobLabel2.text = [NSString stringWithFormat:@"%@", _patient.occupation];
    
    
    
    
    
}

- (void)getPatientAppointments
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllAppointmensByPatient:_patient.postid docid:_patient.docid   WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.appointments removeAllObjects];
            [_patient.appointments addObjectsFromArray:conditions];
            [_tableView reloadData];
            
                        
            
        }
    }];}


- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)addAppointments:(id)sender {
    
  /*  AddConditionsViewController *vc = [[AddConditionsViewController alloc] initWithNibName:@"AddConditionsViewController" bundle:nil];
    
    vc.patientID = _patient.postid;
    
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:true];*/
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    
    // CKCalendarEvent *test = [self.data objectForKey:date];
    CreateNewEventViewController *vc = (CreateNewEventViewController *)[sb instantiateViewControllerWithIdentifier:@"CreateNewEventViewController"];
    // vc.appointment = event.appointment;
    vc.delegate =self;
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _patient.appointments.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppointmentDashTableViewCell *cell = (AppointmentDashTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Appointments *noteDic = [_patient.appointments objectAtIndex:indexPath.row];
    
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

#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    return title;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     if (self.isSharedProfile == false) {
    return UITableViewCellEditingStyleDelete;
         
     } else {
         return UITableViewCellEditingStyleNone;
     }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Appointments *appointment = [_patient.appointments objectAtIndex:indexPath.row];
    if (appointment)
    {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] deleteDoctorAppointment:appointment.appid completion:^(BOOL success, NSString *message) {
            
            [SVProgressHUD dismiss];
            if (success)
            {
                [self getPatientAppointments];
            }
            else
            {
                [UIAlertView showWithTitle:@"Failed" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            }
            
            
        }];
    }
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 48.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
     [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    Appointments *noteDic = [_patient.appointments objectAtIndex:indexPath.row];
    
    CalendarDetailViewController *vc = [[CalendarDetailViewController alloc] initWithNibName:@"CalendarDetailViewController" bundle:nil];
    vc.appointment = noteDic ;
    
    [self.navigationController pushViewController:vc animated:YES];

    
    
    
}



- (void)createdNewEvent  {
    [self getPatientAppointments];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
