//
//  RequestsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "RequestsViewController.h"
#import "PatientsViewController.h"

@interface RequestsViewController()
@property (weak, nonatomic) IBOutlet UIView *proceduresView;
@property (weak, nonatomic) IBOutlet UIView *patientsView;

@end

@implementation RequestsViewController

@synthesize requestsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    requestsArray = [[NSMutableArray alloc] init];
 
    currentPage = 1;
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
   
    
    [menuTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];
    

    self.title = @"APPOINTMENT REQUESTS";
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"RequestGridCell" bundle:nil] forCellWithReuseIdentifier:@"RequestGrid"];
    [patientsGrid registerNib:[UINib nibWithNibName:@"RequestGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"RequestGrid"];
    
     self.view.backgroundColor = [UIColor whiteColor];
    
     [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatientTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];

}

-(void)viewWillAppear:(BOOL)animated {
       [self requestPatientsDataByPage:1 keyword : @""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    [[AppController sharedInstance] getRequestAppointmens:@"1" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {

        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [requestsArray removeAllObjects];
            }
            [requestsArray addObjectsFromArray:conditions];
            [menuTable reloadData];
        }
        
        [menuTable.footer endRefreshing];
        [menuTable.header endRefreshing];
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return requestsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        RequestGridCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RequestGrid" forIndexPath:indexPath];
        
        RequestAppointments *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        @try {
            
            double unixTimeStamp =[noteDic.fromdate doubleValue];
            NSTimeInterval _interval=unixTimeStamp;
            NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
            NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
            
            NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
            NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
            NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
            
            // NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
            NSDate* destinationDate = sourceDate;
            
            double unixTimeStamp2 =[noteDic.todate doubleValue];
            NSTimeInterval _interval2=unixTimeStamp2;
            NSDate* sourceDate2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
            NSTimeZone* sourceTimeZone2 = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
            NSTimeZone* destinationTimeZone2 = [NSTimeZone systemTimeZone];
            
            NSInteger sourceGMTOffset2 = [sourceTimeZone secondsFromGMTForDate:sourceDate2];
            NSInteger destinationGMTOffset2 = [destinationTimeZone2 secondsFromGMTForDate:sourceDate2];
            NSTimeInterval interval2 = destinationGMTOffset2 - sourceGMTOffset2;
            
            // NSDate* destinationDate2 = [[NSDate alloc] initWithTimeInterval:interval2 sinceDate:sourceDate2];
            
            NSDate* destinationDate2 = sourceDate2;
            
            NSString *paitentName = [NSString stringWithFormat:@"%@ %@", noteDic.firstname, noteDic.lastname];
            
            NSDateComponents *fromcomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:destinationDate];
            NSDateComponents *tocomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:destinationDate2];
            
            NSString *monthname = @"Jan";
            
            if ([fromcomponents month] == 1) {
                monthname = @"Jan";
            } else if ([fromcomponents month] == 2) {
                monthname = @"Feb";
            } else if ([fromcomponents month] == 3) {
                monthname = @"Mar";
            } else if ([fromcomponents month] == 4) {
                monthname = @"Apr";
            } else if ([fromcomponents month] == 5) {
                monthname = @"May";
            } else if ([fromcomponents month] == 6) {
                monthname = @"Jun";
            } else if ([fromcomponents month] == 7) {
                monthname = @"Jul";
            } else if ([fromcomponents month] == 8) {
                monthname = @"Aug";
            } else if ([fromcomponents month] == 9) {
                monthname = @"Sep";
            } else if ([fromcomponents month] == 10) {
                monthname = @"Oct";
            } else if ([fromcomponents month] == 11) {
                monthname = @"Now";
            } else if ([fromcomponents month] == 12) {
                monthname = @"Dec";
            }
            
            NSString *fromHour = @"00";
            NSString *fromMinute = @"00";
            
            if ([fromcomponents hour] < 10) {
                fromHour = [NSString stringWithFormat:@"0%i", [fromcomponents hour]];
            } else {
                fromHour = [NSString stringWithFormat:@"%i", [fromcomponents hour]];
            }
            
            if ([fromcomponents minute] < 10) {
                fromMinute = [NSString stringWithFormat:@"0%i", [fromcomponents minute]];
            } else {
                fromMinute = [NSString stringWithFormat:@"%i", [fromcomponents minute]];
            }
            
            NSString *toHour = @"00";
            NSString *toMinute = @"00";
            
            if ([tocomponents hour] < 10) {
                toHour = [NSString stringWithFormat:@"0%i", [tocomponents hour]];
            } else {
                toHour = [NSString stringWithFormat:@"%i", [tocomponents hour]];
            }
            
            if ([tocomponents minute] < 10) {
                toMinute = [NSString stringWithFormat:@"0%i", [tocomponents minute]];
            } else {
                toMinute = [NSString stringWithFormat:@"%i", [tocomponents minute]];
            }
            
            NSString *fromtime = [NSString stringWithFormat:@"%@:%@", fromHour, fromMinute];
            
            NSString *totime = [NSString stringWithFormat:@"%@:%@", toHour, toMinute];
            
            
            
            cell.monthLabel1.text = monthname;
            cell.fromTimeLabel1.text = fromtime;
            cell.toTimeLabel1.text = totime;
            cell.dayLabel1.text = [NSString stringWithFormat:@"%i", [fromcomponents day]];
            
            
            cell.profIMG.layer.cornerRadius = cell.profIMG.frame.size.width/2;
            cell.profIMG.layer.masksToBounds = YES;
            
            cell.profBlurEffect.layer.cornerRadius = cell.profBlurEffect.frame.size.width/2;
            cell.profBlurEffect.layer.masksToBounds = YES;
            
            [cell.profIMG setImageWithURL:[NSURL URLWithString:noteDic.patientProfIMG]];
            
            cell.nameLabel1.text = paitentName;
            cell.nameLabel1.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        }
        @catch (NSException *exception) {
            
        }
        
        
        
        return cell;
    } else {
  RequestGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RequestGrid" forIndexPath:indexPath];
    
    RequestAppointments *noteDic = [requestsArray objectAtIndex:indexPath.row];
    
    @try {
        
        double unixTimeStamp =[noteDic.fromdate doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
       // NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        NSDate* destinationDate = sourceDate;
        
        double unixTimeStamp2 =[noteDic.todate doubleValue];
        NSTimeInterval _interval2=unixTimeStamp2;
        NSDate* sourceDate2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
        NSTimeZone* sourceTimeZone2 = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone2 = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset2 = [sourceTimeZone secondsFromGMTForDate:sourceDate2];
        NSInteger destinationGMTOffset2 = [destinationTimeZone2 secondsFromGMTForDate:sourceDate2];
        NSTimeInterval interval2 = destinationGMTOffset2 - sourceGMTOffset2;
        
       // NSDate* destinationDate2 = [[NSDate alloc] initWithTimeInterval:interval2 sinceDate:sourceDate2];
        
        NSDate* destinationDate2 = sourceDate2;
        
        NSString *paitentName = [NSString stringWithFormat:@"%@ %@", noteDic.firstname, noteDic.lastname];
        
        NSDateComponents *fromcomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:destinationDate];
         NSDateComponents *tocomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:destinationDate2];
        
        NSString *monthname = @"Jan";
        
        if ([fromcomponents month] == 1) {
            monthname = @"Jan";
        } else if ([fromcomponents month] == 2) {
             monthname = @"Feb";
        } else if ([fromcomponents month] == 3) {
            monthname = @"Mar";
        } else if ([fromcomponents month] == 4) {
            monthname = @"Apr";
        } else if ([fromcomponents month] == 5) {
            monthname = @"May";
        } else if ([fromcomponents month] == 6) {
            monthname = @"Jun";
        } else if ([fromcomponents month] == 7) {
            monthname = @"Jul";
        } else if ([fromcomponents month] == 8) {
            monthname = @"Aug";
        } else if ([fromcomponents month] == 9) {
            monthname = @"Sep";
        } else if ([fromcomponents month] == 10) {
            monthname = @"Oct";
        } else if ([fromcomponents month] == 11) {
            monthname = @"Now";
        } else if ([fromcomponents month] == 12) {
            monthname = @"Dec";
        }
        
        NSString *fromHour = @"00";
        NSString *fromMinute = @"00";
        
        if ([fromcomponents hour] < 10) {
            fromHour = [NSString stringWithFormat:@"0%i", [fromcomponents hour]];
        } else {
            fromHour = [NSString stringWithFormat:@"%i", [fromcomponents hour]];
        }
        
        if ([fromcomponents minute] < 10) {
            fromMinute = [NSString stringWithFormat:@"0%i", [fromcomponents minute]];
        } else {
            fromMinute = [NSString stringWithFormat:@"%i", [fromcomponents minute]];
        }
        
        NSString *toHour = @"00";
        NSString *toMinute = @"00";
        
        if ([tocomponents hour] < 10) {
            toHour = [NSString stringWithFormat:@"0%i", [tocomponents hour]];
        } else {
            toHour = [NSString stringWithFormat:@"%i", [tocomponents hour]];
        }
        
        if ([tocomponents minute] < 10) {
            toMinute = [NSString stringWithFormat:@"0%i", [tocomponents minute]];
        } else {
            toMinute = [NSString stringWithFormat:@"%i", [tocomponents minute]];
        }
        
        NSString *fromtime = [NSString stringWithFormat:@"%@:%@", fromHour, fromMinute];
        
         NSString *totime = [NSString stringWithFormat:@"%@:%@", toHour, toMinute];
        
       
        
        cell.monthLabel1.text = monthname;
        cell.fromTimeLabel1.text = fromtime;
        cell.toTimeLabel1.text = totime;
        cell.dayLabel1.text = [NSString stringWithFormat:@"%i", [fromcomponents day]];
        
        cell.profIMG.layer.cornerRadius = cell.profIMG.frame.size.width/2;
        cell.profIMG.layer.masksToBounds = YES;
        
        cell.profBlurEffect.layer.cornerRadius = cell.profBlurEffect.frame.size.width/2;
        cell.profBlurEffect.layer.masksToBounds = YES;
        
        [cell.profIMG setImageWithURL:[NSURL URLWithString:noteDic.patientProfIMG]];
        
        
        cell.nameLabel1.text = paitentName;
        cell.nameLabel1.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
    }
    @catch (NSException *exception) {
        
    }

    
    
    return cell;
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        AppRequestiPhoneViewController *vc = (AppRequestiPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"AppRequestiPhoneViewController"];
        
        RequestAppointments *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        vc.appRequest = noteDic;
        
        vc.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:nil];

    } else {
    
   /* UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    AppRequestDetail *vc = (AppRequestDetail *)[sb instantiateViewControllerWithIdentifier:@"AppRequestDetail"];
    
      RequestAppointments *noteDic = [requestsArray objectAtIndex:indexPath.row];
    
    vc.appRequest = noteDic;
    
    vc.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];*/
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        AppRequestiPhoneViewController *vc = (AppRequestiPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"AppRequestiPhoneViewController"];
        
        RequestAppointments *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        vc.appRequest = noteDic;
        
        vc.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize retval;
    if (IS_IPHONE) {
        retval = CGSizeMake(140, 140);
    } else {
        retval = CGSizeMake(200, 200);
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






#pragma mark - TableView





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return requestsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardPatientTableViewCell *cell = (DashboardPatientTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    RequestAppointments *noteDic = [requestsArray objectAtIndex:indexPath.row];
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[noteDic.fromdate integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
    
    NSDate *dob2 = [NSDate dateWithTimeIntervalSince1970:[noteDic.todate integerValue]];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"dd MMMM yyyy HH:MM"];
    
    
    NSString *street1 = @"";
    
    //  cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",noteDic.firstname, noteDic.lastname];
    cell.specialityLabel.text = [NSString stringWithFormat:@"From %@", [formatter stringFromDate:dob]];
    
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:noteDic.patientProfIMG]];
    
    cell.costLabel.text = [NSString stringWithFormat:@"To %@", [formatter stringFromDate:dob2]];
    // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (IS_IPHONE) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        AppRequestiPhoneViewController *vc = (AppRequestiPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"AppRequestiPhoneViewController"];
        
        RequestAppointments *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        vc.appRequest = noteDic;
        
        vc.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        [self presentViewController:nav animated:YES completion:nil];
        
    } else {
        
        /* UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
         AppRequestDetail *vc = (AppRequestDetail *)[sb instantiateViewControllerWithIdentifier:@"AppRequestDetail"];
         
         RequestAppointments *noteDic = [requestsArray objectAtIndex:indexPath.row];
         
         vc.appRequest = noteDic;
         
         vc.delegate = self;
         
         UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];*/
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        AppRequestiPhoneViewController *vc = (AppRequestiPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"AppRequestiPhoneViewController"];
        
        RequestAppointments *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        vc.appRequest = noteDic;
        
        vc.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
        
        [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }
}














- (void)refreshPationInfo {
     [self requestPatientsDataByPage:1 keyword : @""];
}

@end
