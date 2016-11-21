//
//  ConsultationListView.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "ConsultationListView.h"
#import "PatientsViewController.h"
#import "ConsultationDetailViewController.h"
#import "SWRevealViewController.h"

@interface ConsultationListView () <ConsultationDetailDelegate>

@property (weak, nonatomic) IBOutlet UIView *proceduresView;
@property (weak, nonatomic) IBOutlet UIView *patientsView;


@end


@implementation ConsultationListView

@synthesize requestsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view.
    
    requestsArray = [[NSMutableArray alloc] init];
    
    currentPage = 1;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goToInvite)];
   // self.navigationItem.rightBarButtonItem = addButton;
    
    [menuTable addLegendHeaderWithRefreshingBlock:^{
       [self requestPatientsDataByPage:1 keyword : @""];
    }];
    
    
    self.title = @"CONSULTATIONS";
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGConsultationGridCell" bundle:nil] forCellWithReuseIdentifier:@"MSGConsultation"];
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGConsultationCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGConsultation"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
     UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
      [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatientTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
   // self.navigationItem.rightBarButtonItem = notiButtonItem;


}

- (IBAction)goBackToChose:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
    [self.revealViewController revealToggle:sender];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated   {
    [self requestPatientsDataByPage:1 keyword : @""];

}

- (void)viewWillDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}


- (void)goToInvite {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    ConsultationPatientList *vc = (ConsultationPatientList *)[sb instantiateViewControllerWithIdentifier:@"ConsultationPatientList"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    [[AppController sharedInstance] getAllConsultations:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return requestsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        MSGConsultationCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGConsultation" forIndexPath:indexPath];
        
        Consulatation *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        @try {
            
            double unixTimeStamp =[noteDic.consultime doubleValue];
            NSTimeInterval _interval=unixTimeStamp;
            NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
            NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
            
            NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
            NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
            NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
            
            // NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
            
            NSDate* destinationDate = sourceDate;
            
            
            
            
            NSString *paitentName = [NSString stringWithFormat:@"%@ %@", noteDic.dfirstname, noteDic.plastname];
            
            NSDateComponents *fromcomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:destinationDate];
            // NSDateComponents *tocomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:destinationDate2];
            
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
                fromHour = [NSString stringWithFormat:@"%i", [fromcomponents hour]];
            } else {
                fromHour = [NSString stringWithFormat:@"%i", [fromcomponents hour]];
            }
            
            if ([fromcomponents minute] < 10) {
                fromMinute = [NSString stringWithFormat:@"0%i", [fromcomponents minute]];
            } else {
                fromMinute = [NSString stringWithFormat:@"%i", [fromcomponents minute]];
            }
            
            
            NSString *fromtime = [NSString stringWithFormat:@"%@:%@", fromHour, fromMinute];
            
            //   NSString *totime = [NSString stringWithFormat:@"%@:%@", toHour, toMinute];
            
            
            
            cell.monthLabel1.text = monthname;
            cell.fromTimeLabel1.text = fromtime;
            // cell.toTimeLabel1.text = totime;
            cell.dayLabel1.text = [NSString stringWithFormat:@"%i", [fromcomponents day]];
            
            
            if ([noteDic.ctype isEqual:@"0"]) {
                cell.cStatus.text = @"Pending";
                cell.cStatus.textColor = [UIColor lightGrayColor];
                
            } else if ([noteDic.ctype isEqual:@"1"]) {
                cell.cStatus.text = @"Accepted";
                cell.cStatus.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];

                
            } else if ([noteDic.ctype isEqual:@"2"]) {
                cell.cStatus.text = @"Declined";
                cell.cStatus.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
                ;
                
            }
            
            cell.profIMG.layer.cornerRadius = cell.profIMG.frame.size.width/2;
            cell.profIMG.layer.masksToBounds = YES;
            cell.profIMG.layer.borderColor = [UIColor blackColor].CGColor;
            cell.profIMG.layer.borderWidth = 1.0f;
            
            cell.profBlurEffect.layer.cornerRadius = cell.profBlurEffect.frame.size.width/2;
            cell.profBlurEffect.layer.masksToBounds = YES;
            
            [cell.profIMG setImageWithURL:[NSURL URLWithString:noteDic.profileimg]];

            
            cell.nameLabel1.text = paitentName;
            cell.nameLabel1.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        }
        @catch (NSException *exception) {
            
        }
        
        
        
        return cell;
    } else {
    MSGConsultationGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGConsultation" forIndexPath:indexPath];
    
    Consulatation *noteDic = [requestsArray objectAtIndex:indexPath.row];
    
    @try {
        
        double unixTimeStamp =[noteDic.consultime doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
       // NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        NSDate* destinationDate = sourceDate;
        
        
     
        
        NSString *paitentName = [NSString stringWithFormat:@"%@ %@", noteDic.dfirstname, noteDic.plastname];
        
        NSDateComponents *fromcomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:destinationDate];
       // NSDateComponents *tocomponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:destinationDate2];
        
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
            fromHour = [NSString stringWithFormat:@"%i", [fromcomponents hour]];
        } else {
            fromHour = [NSString stringWithFormat:@"%i", [fromcomponents hour]];
        }
        
        if ([fromcomponents minute] < 10) {
            fromMinute = [NSString stringWithFormat:@"0%i", [fromcomponents minute]];
        } else {
            fromMinute = [NSString stringWithFormat:@"%i", [fromcomponents minute]];
        }
        
        
        NSString *fromtime = [NSString stringWithFormat:@"%@:%@", fromHour, fromMinute];
        
     //   NSString *totime = [NSString stringWithFormat:@"%@:%@", toHour, toMinute];
        
        
        
        cell.monthLabel1.text = monthname;
        cell.fromTimeLabel1.text = fromtime;
       // cell.toTimeLabel1.text = totime;
        cell.dayLabel1.text = [NSString stringWithFormat:@"%i", [fromcomponents day]];
        
        
        if ([noteDic.ctype isEqual:@"0"]) {
            cell.cStatus.text = @"Pending";
            cell.cStatus.textColor = [UIColor lightGrayColor];
            
        } else if ([noteDic.ctype isEqual:@"1"]) {
            cell.cStatus.text = @"Accepted";
            cell.cStatus.textColor = [UIColor flatTealColor];
            
        } else if ([noteDic.ctype isEqual:@"2"]) {
            cell.cStatus.text = @"Declined";
            cell.cStatus.textColor = [UIColor flatRedColor];
            
        }
        
        cell.profIMG.layer.cornerRadius = cell.profIMG.frame.size.width/2;
        cell.profIMG.layer.masksToBounds = YES;
        
        cell.profBlurEffect.layer.cornerRadius = cell.profBlurEffect.frame.size.width/2;
        cell.profBlurEffect.layer.masksToBounds = YES;
        
        [cell.profIMG setImageWithURL:[NSURL URLWithString:noteDic.profileimg]];

        
        
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
        ConsultationDetailiPhone *vc = (ConsultationDetailiPhone *)[sb instantiateViewControllerWithIdentifier:@"ConsultationDetailiPhone"];
        
        Consulatation *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        vc.consultation = noteDic;
        
        vc.delegate = self;
        
       // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        //[self presentViewController:nav animated:YES completion:nil];
        [self.navigationController pushViewController:vc animated:YES];

    } else {
    
    /*UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    ConsultationDetailViewController *vc = (ConsultationDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"ConsultationDetailViewController"];
    
    Consulatation *noteDic = [requestsArray objectAtIndex:indexPath.row];
    
    vc.consultation = noteDic;
    
    vc.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];*/
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ConsultationDetailiPhone *vc = (ConsultationDetailiPhone *)[sb instantiateViewControllerWithIdentifier:@"ConsultationDetailiPhone"];
        
        Consulatation *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        vc.consultation = noteDic;
        
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
    return [requestsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardPatientTableViewCell *cell = (DashboardPatientTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    Consulatation *noteDic = [requestsArray objectAtIndex:indexPath.row];

    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    cell.cellImageView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.cellImageView.layer.borderWidth = 1.0f;
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[noteDic.consultime integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy HH:MM"];
    
    
    NSString *street1 = @"";
    
    //  cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", noteDic.pfirstname, noteDic.plastname];
    cell.specialityLabel.text = @"";
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:noteDic.profileimg]];
    
    
    if ([noteDic.ctype isEqual:@"0"]) {
        cell.costLabel.text = @"Pending";
        cell.costLabel.textColor = [UIColor lightGrayColor];
        
    } else if ([noteDic.ctype isEqual:@"1"]) {
        cell.costLabel.text = @"Accepted";
        cell.costLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
        
    } else if ([noteDic.ctype isEqual:@"2"]) {
        cell.costLabel.text = @"Declined";
        cell.costLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        
    }

    
    
    // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     Consulatation *noteDic = [requestsArray objectAtIndex:indexPath.row];
    
    ConsultationDetailiPhone *vc = [[ConsultationDetailiPhone alloc] initWithNibName:@"ConsultationDetailiPhone" bundle:nil];
    
    vc.consultation = noteDic;
    
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
    /*if (IS_IPHONE) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ConsultationDetailiPhone *vc = (ConsultationDetailiPhone *)[sb instantiateViewControllerWithIdentifier:@"ConsultationDetailiPhone"];
        
        Consulatation *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        vc.consultation = noteDic;
        
        vc.delegate = self;
        
         [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        ConsultationDetailiPhone *vc = (ConsultationDetailiPhone *)[sb instantiateViewControllerWithIdentifier:@"ConsultationDetailiPhone"];
        
        Consulatation *noteDic = [requestsArray objectAtIndex:indexPath.row];
        
        vc.consultation = noteDic;
        
        vc.delegate = self;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
        
        [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
    }*/
}

















- (void)refreshPationInfo {
    [self requestPatientsDataByPage:1 keyword : @""];
}




@end
