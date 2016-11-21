//
//  PatientRecAboutViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PatientRecAboutViewController.h"

@interface PatientRecAboutViewController ()

@end

@implementation PatientRecAboutViewController

@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"PatientRecordAboutCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    self.title = @"PROFILE INFO";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    
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
- (void)viewDidAppear:(BOOL)animated {
    //[menuTable reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    
    occupationLabel.text = profPatient.occupation;
    addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", profPatient.street1, profPatient.street2, profPatient.city, profPatient.state, profPatient.zipcode];
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[profPatient.dob integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
   dobLabel.text = [formatter stringFromDate:dob];
    phoneLabel.text = profPatient.telephone;
    emailLabel.text = profPatient.email;
    ssnLabel.text = profPatient.ssnDigits;
    
    
    
}

- (NSString *)aboutValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[profPatient.dob integerValue]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd MMMM yyyy"];
            title = [formatter stringFromDate:dob];
            break;
        }
        case 1:
        {
            title = profPatient.occupation;
            break;
        }
        case 2:
        {
            title = profPatient.gender;
            break;
        }
        case 3:
        {
            title = [NSString stringWithFormat:@"%@", profPatient.street1];
            break;
        }
        case 4:
        {
            title = [NSString stringWithFormat:@"%@", profPatient.street2];
            break;
        }
        case 5:
        {
            title = [NSString stringWithFormat:@"%@", profPatient.city];
            break;
        }
        case 6:
        {
            title = [NSString stringWithFormat:@"%@", profPatient.state];
            break;
        }
        case 7:
        {
            title = [NSString stringWithFormat:@"%@", profPatient.country];
            break;
        }
        case 8:
        {
            title = profPatient.telephone;
            break;
        }
        case 9:
        {
            title = profPatient.email;
            break;
        }
        case 10:
        {
            title = profPatient.ssnDigits;
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
            title = @"Date of Birth";
            break;
        }
        case 1:
        {
            title = @"Job";
            break;
        }
        case 2:
        {
            title = @"Gender";
            break;
        }
        case 3:
        {
            title = @"Street 1";
            break;
        }
        case 4:
        {
            title = @"Street 2";
            break;
        }
        case 5:
        {
            title = @"City";
            break;
        }
        case 6:
        {
            title = @"State";
            break;
        }
        case 7:
        {
            title = @"Country";
            break;
        }
        case 8:
        {
            title = @"Phone";
            break;
        }
        case 9:
        {
            title = @"Email";
            break;
        }
        case 10:
        {
            title = @"SSN";
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
    if (profPatient) {
        return 11;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        PatientRecordAboutCell    *cell = (PatientRecordAboutCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
        
        cell.cellImageView.image = [UIImage imageNamed:@"patienticonv2.png"];
        
    cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
     cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
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
