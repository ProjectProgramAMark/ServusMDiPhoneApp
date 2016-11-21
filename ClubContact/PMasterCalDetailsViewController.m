//
//  PMasterCalDetailsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PMasterCalDetailsViewController.h"

@interface PMasterCalDetailsViewController ()

@end

@implementation PMasterCalDetailsViewController


@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize appointment;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"PatientRecordAboutCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    self.title = @"APPOINTMENT";
    
   /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    
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
- (void)viewWillAppear:(BOOL)animated {
   // [menuTable reloadData];
    
    
    patientName.text = [NSString stringWithFormat:@"%@ %@", patientInfo.firstname, patientInfo.lastname];
    docName.text =[NSString stringWithFormat:@"%@ %@", doctor.firstname, doctor.lastname];;
    specializationLabel.text = doctor.speciality;
    docEmail.text = doctor.email;
    docPhone.text = doctor.telephone;
    docAddress.text = [NSString stringWithFormat:@"%@, %@, %@, %@", doctor.officeaddress, doctor.officecity, doctor.officestate, doctor.officezip];;
    
    double unixTimeStamp =[appointment.fromdate doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSDate* destinationDate = sourceDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
    fromLabel.text =  [NSString stringWithFormat:@"From %@", [formatter stringFromDate:destinationDate]];
    
    double unixTimeStamp2 =[appointment.todate doubleValue];
    NSTimeInterval _interval2=unixTimeStamp2;
    NSDate* sourceDate2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
    
    NSDate* destinationDate2 = sourceDate2;
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"MMMM dd yyyy h:MM a"];
    toLabel.text =  [NSString stringWithFormat:@"To %@", [formatter2 stringFromDate:destinationDate2]];
    
}

- (NSString *)aboutValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
           
            title = [NSString stringWithFormat:@"%@ %@", patientInfo.firstname, patientInfo.lastname];
            break;
        }
        case 1:
        {
            title =  [NSString stringWithFormat:@"%@ %@", doctor.firstname, doctor.lastname];;
            break;
        }
        case 2:
        {
            title = doctor.speciality;
            break;
        }
        case 3:
        {
            NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[appointment.fromdate integerValue]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];

            title = [formatter stringFromDate:dob];
            break;
        }
        case 4:
        {
            NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[appointment.todate integerValue]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
            title = [formatter stringFromDate:dob];
            break;
        }
        case 5:
        {
            title = [NSString stringWithFormat:@"%@", doctor.officeaddress];
            break;
        }
        case 6:
        {
            title =  [NSString stringWithFormat:@"%@", doctor.officecity];
            break;
        }
        case 7:
        {
            title = [NSString stringWithFormat:@"%@", doctor.officestate];
            break;
        }
        case 8:
        {
            title = [NSString stringWithFormat:@"%@", doctor.officezip];;
            break;
        }
        case 9:
        {
            title = [NSString stringWithFormat:@"%@", doctor.officecountry];;
            break;
        }
        case 10:
        {
            title = [NSString stringWithFormat:@"%@", doctor.email];;
            break;
        }
        case 11:
        {
            title = [NSString stringWithFormat:@"%@", doctor.telephone];;
            break;
        }
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}

- (NSString *)aboutTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Name";
            break;
        }
        case 1:
        {
            title = @"Doctor";
            break;
        }
        case 2:
        {
            title = @"Specialization";
            break;
        }
        case 3:
        {
            
            title = @"From";
            break;
        }
        case 4:
        {
            title = @"To";
            break;
        }
        case 5:
        {
            title = @"Address";
            break;
        }
        case 6:
        {
            title = @"City";
            break;
        }
        case 7:
        {
            title = @"State";
            break;
        }
        case 8:
        {
            title = @"Zip code";
            break;
        }
        case 9:
        {
            title = @"Country";
            break;
        }
        case 10:
        {
            title = @"Email";
            break;
        }
        case 11:
        {
            title = @"Phone";
            break;
        }
                default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (appointment) {
        return 12;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PatientRecordAboutCell    *cell = (PatientRecordAboutCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    cell.nameLabel.textColor = [UIColor colorWithRed:209.0f/255.0f green:104.0f/255.0f blue:195.0f/255.0f alpha:1.0f];
    cell.cellImageView.image = [UIImage imageNamed:@"phonebook.png"];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
   // cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    cell.clipsToBounds = YES;
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
