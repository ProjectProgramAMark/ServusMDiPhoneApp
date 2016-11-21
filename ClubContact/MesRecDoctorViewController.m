//
//  MesRecDoctorViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/26/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MesRecDoctorViewController.h"
#import "Patient.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "Doctors.h"

@interface MesRecDoctorViewController () <SpecialitySelectorDelegate>

@end

@implementation MesRecDoctorViewController
@synthesize patientsArray;
@synthesize conditionsArray;
@synthesize addedConditionsArray;
@synthesize selectedAllergens;
@synthesize selectedConditions;
@synthesize pharmacy;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    patientsArray = [[NSMutableArray alloc] init];
    currentPage = 1;
    [doctorsTable addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];
    
    [doctorsTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];
    
    [doctorsTable registerNib:[UINib nibWithNibName:@"DoctorCellV2" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    self.title = @"SELECT DOCTOR";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.patientsArray count] == 0)
    {
        [self requestPatientsDataByPage:1 keyword : @""];
    }
    
}


- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
    /*[[AppController sharedInstance] getAllPatiensByPage:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
     if (success)
     {
     currentPage = page;
     if(currentPage == 1)
     {
     [_patientsArray removeAllObjects];
     }
     [_patientsArray addObjectsFromArray:patients];
     [patientsGrid reloadData];
     }
     
     [patientsGrid.footer endRefreshing];
     [patientsGrid.header endRefreshing];
     }];*/
    
    [[AppController sharedInstance] getAllDoctors2:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [patientsArray removeAllObjects];
            }
            [patientsArray addObjectsFromArray:conditions];
            [doctorsTable reloadData];
        }
        
        [doctorsTable.footer endRefreshing];
        [doctorsTable.header endRefreshing];
        
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [patientsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoctorCellV2 *cell = (DoctorCellV2 *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    Doctors *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
   /* NSString *isOnline = @"Offline";
    if ([patientInfo.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Available";
        cell.onlineLabel.textColor = [UIColor colorWithRed:62.0f/255.0f green:190.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = true;
        cell.messageIcon.selected = true;
    } else if ([patientInfo.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Unavailable";
        cell.onlineLabel.textColor = [UIColor colorWithRed:238.0f/255.0f green:43.0f/255.0f blue:41.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = false;
        cell.messageIcon.selected = false;
    }
    
    cell.facetimeIcon.tag = indexPath.row;
    cell.messageIcon.tag = indexPath.row;
    [cell.facetimeIcon addTarget:self action:@selector(openVideoChat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageIcon addTarget:self action:@selector(openMessaging:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.costLabel.text = [NSString stringWithFormat:@"1 Token/message"];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.firstname, patientInfo.lastname];
    cell.specialityLabel.text = patientInfo.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
    // cell.nameLabel.text = imageName;
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    
    cell.clipsToBounds = YES;*/
    
   
    
    NSString *isOnline = @"Offline";
    if ([patientInfo.isOnline intValue] == 1) {
        //isOnline = @"Online";
        cell.onlineLabel.text = @"Available";
        cell.onlineLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
        cell.facetimeIcon.selected = true;
        cell.messageIcon.selected = true;
    } else if ([patientInfo.isOnline intValue] == 2) {
        cell.onlineLabel.text = @"Unavailable";
        cell.onlineLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        
        
        cell.facetimeIcon.selected = false;
        cell.messageIcon.selected = false;
    }
    
    cell.facetimeIcon.tag = indexPath.row;
    cell.messageIcon.tag = indexPath.row;
    [cell.facetimeIcon addTarget:self action:@selector(openVideoChat:) forControlEvents:UIControlEventTouchUpInside];
    [cell.messageIcon addTarget:self action:@selector(openMessaging:) forControlEvents:UIControlEventTouchUpInside];
    cell.facetimeIcon.hidden = true;
    cell.messageIcon.hidden = true;
    
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.firstname, patientInfo.lastname];
    cell.specialityLabel.text = patientInfo.speciality;
    [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
    // cell.nameLabel.text = imageName;
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    
    cell.clipsToBounds = YES;
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Doctors *patientInfo = [patientsArray objectAtIndex:indexPath.row];
    
    [Flurry logEvent:@"DoctorView" withParameters:[NSDictionary dictionaryWithObject:patientInfo.username forKey:@"searchKey"]];
    
   
    MesDocProfileViewController *vc =[[MesDocProfileViewController alloc] initWithNibName:@"MesDocProfileViewController" bundle:nil];
    vc.doctor = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}





- (IBAction)openVideoChat:(UIButton *)sender {
    
    Doctors *patientInfo = [patientsArray objectAtIndex:sender.tag];
    
    NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
    
    if (patientChose) {
        
        Pharmacy *pharmacy2 = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"pharmacyObj"]];
        TalkCreateViewController *vc = [[TalkCreateViewController alloc] initWithNibName:@"TalkCreateViewController" bundle:nil];
        vc.doctor =patientInfo;
        vc.allergenArray = [NSMutableArray array];
        vc.selectedConditions = [NSMutableArray array];
        vc.pharmacy = pharmacy2;
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Set Up Profile" message:@"You have not completed your profile yet" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *accessAction = [UIAlertAction actionWithTitle:@"Complete Profile" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            ShortQuestViewController *vc = [[ShortQuestViewController alloc] initWithNibName:@"ShortQuestViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }];
        
        
        
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //  [self dismissViewControllerAnimated:self completion:nil];
            
        }];
        
        [actionSheet addAction:accessAction];
        
        [actionSheet addAction:cancelAction];
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }
    
    
}

- (IBAction)openMessaging:(UIButton *)sender {
    Doctors *patientInfo = [patientsArray objectAtIndex:sender.tag];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    MesDocProfileViewController *vc = (MesDocProfileViewController *)[sb instantiateViewControllerWithIdentifier:@"MesDocProfileViewController"];
    vc.doctor = patientInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestPatientsDataByPage:1 keyword:searchBar.text];
    [searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  {
    [self requestPatientsDataByPage:1 keyword:searchBar.text];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self inialiseToolbar];
    doctorSearch.inputAccessoryView = toolbar;
    return true;
}


-(void)inialiseToolbar{
    
    CGFloat _width = self.view.frame.size.width;
    CGFloat _height = 40.0;
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -_height, _width, _height)];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButtonItemSubmit = [[UIBarButtonItem alloc] initWithTitle:@"Speciality" style:UIBarButtonItemStyleBordered target:self action:@selector(specialitySelect:)];
    [toolbar setItems:[[NSArray alloc] initWithObjects:flexibleSpace,barButtonItemSubmit,  nil]];
}


- (IBAction)specialitySelect:(id)sender {
    SpecialitySelectorViewController *vc = [[SpecialitySelectorViewController alloc] init];
    vc.delegate = self;
    // isSpecilitySelect = true;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)specialitySelectDone:(NSString *)speciality {
    doctorSearch.text = speciality;
    [self requestPatientsDataByPage:1 keyword:speciality];
    
}

@end
