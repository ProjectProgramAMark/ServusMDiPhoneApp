//
//  MessagePatientsList.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/3/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MessagePatientsList.h"
//#import "PatientsTableViewCell.h"
#import "PatientDetailViewController.h"
#import "AddPatientViewController.h"
#import "Patient.h"
#import "AppController.h"
#import "MJRefresh.h"
#import "SWRevealViewController.h"

#define kPatientsCellID2 @"cell2"

@interface MessagePatientsList () <MSGSessionDelegate, MessagingViewDelegate, MSGSessioniPhoneDelegate>
{
    int currentPage;
}

@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MessagePatientsList

@synthesize shouldPatientSelect;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (self.shouldPatientSelect == false) {
        
        
        
        /* UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Invite" style:UIBarButtonItemStylePlain target:self action:@selector(goToInvite)];*/
       /*  UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goToInvite)];
   
   
        self.navigationItem.rightBarButtonItem = addButton;*/
        
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    
    patientsGrid.delegate = self;
    patientsGrid.dataSource = self;
    _patientsArray = [NSMutableArray array];
    
    _searchBar.delegate = self;
    
    self.title = @"MESSAGING";
    
   /* [patientsGrid addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];*/
    
    [menuTable addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    
    [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatient2TableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    currentPage = 0;
    
    
        self.view.backgroundColor = [UIColor whiteColor];
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
    
   // [revealController panGestureRecognizer];
    //[revealController tapGestureRecognizer];
    
 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.patientsArray count] == 0)
    {
        [self requestPatientsDataByPage:1 keyword : @""];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}

- (IBAction)goBackToChose:(id)sender {
  //  [self.navigationController popViewControllerAnimated:YES];
     [self.revealViewController revealToggle:sender];
}

- (IBAction)inviteUser:(id)sender {
   /* MessageInviteView *vc = [[MessageInviteView alloc] initWithNibName:@"MessageInviteView" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];*/
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Invite" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *conditionAction = [UIAlertAction actionWithTitle:@"Patient Chat" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        MessageInviteView *vc = [[MessageInviteView alloc] initWithNibName:@"MessageInviteView" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    UIAlertAction *medicationAction = [UIAlertAction actionWithTitle:@"Doctor Chat" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DoctorListViewController *vc = [[DoctorListViewController alloc] initWithNibName:@"DoctorListViewController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
       
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //  [self dismissViewControllerAnimated:self completion:nil];
    }];
    
    [actionSheet addAction:conditionAction];
    [actionSheet addAction:medicationAction];
    [actionSheet addAction:cancelAction];
    
    if (IS_IPHONE) {
        [self presentViewController:actionSheet animated:YES completion:nil];
    } else {
        
        UIPopoverPresentationController *popPresenter = [actionSheet
                                                         popoverPresentationController];
        popPresenter.sourceView = self.navigationController.navigationBar;
        popPresenter.sourceRect = self.navigationController.navigationBar.bounds;
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }
}


- (void)requestPatientsDataByPage:(int)page keyword:(NSString *)keyword
{
   /* [[AppController sharedInstance] getAllPatiensByPage2:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
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
        
        [self.patientsTableView.footer endRefreshing];
        [self.patientsTableView.header endRefreshing];
    }];*/
    
    
    [[AppController sharedInstance] getAllMSGSessions:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        currentPage = page;
        if (success)
        {
        [_patientsArray removeAllObjects];
        [_patientsArray addObjectsFromArray:conditions];
        [menuTable reloadData];
            
            
            [self performSelector:@selector(hideTableViewCells) withObject:nil afterDelay:0.02];
            
        }
     
     [menuTable.footer endRefreshing];
     [menuTable.header endRefreshing];
    }];
}




- (void)hideTableViewCells {
    for (int i = 0; i <= _patientsArray.count; i++)
    {
        NSLog(@"%d", i);
        NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        DashboardPatient2TableViewCell *cell = (DashboardPatient2TableViewCell *)[menuTable cellForRowAtIndexPath:cellIndexPath];
        [cell hideUtilityButtonsAnimated:NO];
        
    }
}


- (void)addPatient
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    AddPatientViewController *vc = (AddPatientViewController *)[sb instantiateViewControllerWithIdentifier:@"AddPatientViewController"];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
    
    [popVC presentPopoverFromBarButtonItem:addButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


- (Patient *)dummyPatientDataForRegister
{
    Patient *dummyPatient = [Patient new];
    dummyPatient.email = @"kalanajayathilaka@yahoo.com";
    dummyPatient.firstName = @"Kalana";
    dummyPatient.lastName =  @"Jayatilake";
    dummyPatient.dob = @"1324234234";
    dummyPatient.occupation = @"Developer";
    dummyPatient.gender = @"M";
    dummyPatient.telephone = @"234234234";
    
    dummyPatient.street1 = @"6612 Clyboung";
    dummyPatient.street2 = @"Unit 95";
    
    dummyPatient.city = @"Hollywood";
    dummyPatient.state = @"CA";
    dummyPatient.country = @"United States";
    dummyPatient.zipcode = @"91606";
    
    dummyPatient.occupation = @"Specialist";
    
    return  dummyPatient;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource
/*- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_patientsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessagingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPatientsCellID2];
    
    if (cell == nil)
    {
        cell = [[MessagingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:kPatientsCellID2] ;
        
    }
    
    Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    cell.patient = patientInfo;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPatientsTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.shouldPatientSelect == false) {
        Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MessagingViewController *vc = (MessagingViewController *)[sb instantiateViewControllerWithIdentifier:@"MessagingViewController"];
        vc.patientID = patientInfo.postid;
      //  vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
       // Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
      //  [self.delegate patientAppointmentAdded:[NSString stringWithFormat:@"%@ %@", patientInfo.firstName, patientInfo.lastName] patientid:patientInfo.postid];
        //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}*/

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _patientsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        
        MSGPatientGridCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        MSGSession *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        
        [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimg]];
        
        cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
        cell.profileIMG.layer.masksToBounds = YES;
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        cell.profileIMG.layer.borderColor = [UIColor blackColor].CGColor;
        cell.profileIMG.layer.borderWidth = 1.0f;
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.pfirstname, patientInfo.plastname];
        //cell.messageCountLabel.text = patientInfo.msgCount;
             cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        
        if ([patientInfo.mstatus isEqual:@"0"]) {
            cell.messageCountLabel.text = @"P";
            cell.messageCountLabel.textColor = [UIColor flatGrayColor];
        } else if ([patientInfo.mstatus isEqual:@"1"]) {
            cell.messageCountLabel.text = @"A";
            cell.messageCountLabel.textColor = [UIColor flatGreenColor];
        } else if ([patientInfo.mstatus isEqual:@"2"]) {
            cell.messageCountLabel.text = @"D";
            cell.messageCountLabel.textColor = [UIColor flatRedColor];
        } else if ([patientInfo.mstatus isEqual:@"3"]) {
            cell.messageCountLabel.text = @"C";
            cell.messageCountLabel.textColor = [UIColor flatRedColor];
        }
        
        
        
        return cell;

    } else {
    
    
    MSGPatientGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
    
    
    MSGSession *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    
    [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimg]];
    
    cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
    cell.profileIMG.layer.masksToBounds = YES;
    // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
    // cell.profileIMG.layer.borderWidth = 3.0;
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", patientInfo.pfirstname, patientInfo.plastname];
    //cell.messageCountLabel.text = patientInfo.msgCount;
        cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
    
    if ([patientInfo.mstatus isEqual:@"0"]) {
       cell.messageCountLabel.text = @"P";
         cell.messageCountLabel.textColor = [UIColor flatGrayColor];
    } else if ([patientInfo.mstatus isEqual:@"1"]) {
       cell.messageCountLabel.text = @"A";
         cell.messageCountLabel.textColor = [UIColor flatGreenColor];
    } else if ([patientInfo.mstatus isEqual:@"2"]) {
        cell.messageCountLabel.text = @"D";
         cell.messageCountLabel.textColor = [UIColor flatRedColor];
    } else if ([patientInfo.mstatus isEqual:@"3"]) {
        cell.messageCountLabel.text = @"C";
         cell.messageCountLabel.textColor = [UIColor flatRedColor];
    }
    
    
    
    return cell;
        
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (IS_IPHONE) {
        MSGSession *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MSGSessioniPhoneViewController *vc = (MSGSessioniPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"MSGSessioniPhoneViewController"];
        vc.msgSession = patientInfo;
        vc.delegate = self;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        [self presentViewController:nav animated:YES completion:nil];
    } else {
    
  /*  MSGSession *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    MSGSessionViewController *vc = (MSGSessionViewController *)[sb instantiateViewControllerWithIdentifier:@"MSGSessionViewController"];
    vc.msgSession = patientInfo;
      vc.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc]; */
        
        MSGSession *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        MSGSessioniPhoneViewController *vc = (MSGSessioniPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"MSGSessioniPhoneViewController"];
        vc.msgSession = patientInfo;
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
    return [_patientsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DashboardPatient2TableViewCell *cell = (DashboardPatient2TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
     MSGSession *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    
   
    //  cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
    if ([patientInfo.chattype  isEqual:@"Patient"]) {
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",patientInfo.pfirstname, patientInfo.plastname];
        [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimg]];
        
    } else {
        
        if ([patientInfo.ismine intValue] == 1) {
             cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.dfirstname, patientInfo.dfirstname];
            [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.dprofileimg]];
            
        } else{
            cell.nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@",patientInfo.pfirstname, patientInfo.plastname];
            [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.profileimg]];
        }
      
    }
    cell.specialityLabel.text = [NSString stringWithFormat:@"%@", patientInfo.lastmessage];
    //cell.timeLabel.text = [NSString stringWithFormat:@"%@", patientInfo.createdago];
    
    
    double unixTimeStamp =[patientInfo.created doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSDate* destinationDate = sourceDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
    cell.timeLabel.text = [formatter stringFromDate:destinationDate];
    
    
   
    
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
    
    
    
    
    cell.costLabel.hidden = true;
    

    // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    
    cell.delegate = self;
    
   /* if ([patientInfo.mstatus isEqual:@"0"]) {
    cell.leftUtilityButtons = [self leftButtons];
        
    } else {
         cell.leftUtilityButtons = [self leftButtons2];
    }*/
    //if ([patientInfo.mstatus isEqual:@"1"]) {
    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
        
    //}
    
      //[cell hideUtilityButtonsAnimated:false];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
       MSGSession *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
       if ([patientInfo.chattype  isEqual:@"Patient"]) {
    if ([patientInfo.mstatus isEqual:@"0"]) {

        UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"" message:@"Accept or decline this chat request by swiping right" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertTest show];
        return;
    }
    
    MessagingViewController *vc = [[MessagingViewController alloc] initWithNibName:@"MessagingViewController" bundle:nil];
    vc.msgSession = patientInfo;
    vc.delegate = self;
    if ([patientInfo.mstatus isEqual:@"3"]) {
        
        vc.isClosedSessionOpen = true;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
           
       } else {
                     
           DocChatViewViewController *vc = [[DocChatViewViewController alloc] initWithNibName:@"DocChatViewViewController" bundle:nil];
           vc.msgSession = patientInfo;
           // vc.delegate = self;
           [self.navigationController pushViewController:vc animated:YES];
       }
    
}



- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:239.0f/255.0f green:92.0f/255.0f blue:95.0f/255.0f alpha:1.0f]
                                                title:@"Close"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:99.0f/255.0f green:203.0f/255.0f blue:159.0f/255.0f alpha:1.0f]
                                               title:@"Accept"];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:225.0f/255.0f green:93.0f/255.0f blue:91.0f/255.0f alpha:1.0f]
                                               title:@"Decline"];

    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:226.0f/255.0f green:191.0f/255.0f blue:99.0f/255.0f alpha:1.0f]
                                               title:@"Profile"];

    
    
    return leftUtilityButtons;
}



- (NSArray *)leftButtons2
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:226.0f/255.0f green:191.0f/255.0f blue:99.0f/255.0f alpha:1.0f]
                                               title:@"Profile"];
    
    
    
    return leftUtilityButtons;
}







#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    // Delete button was pressed
    NSIndexPath *cellIndexPath = [menuTable indexPathForCell:cell];
    
    //  [_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
    //[menuTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [cell hideUtilityButtonsAnimated:true];
    MSGSession *patientInfo = [_patientsArray objectAtIndex:cellIndexPath.row];
  //  if ([patientInfo.mstatus isEqual:@"0"]) {
    switch (index) {
        case 0: {
          //  NSLog(@"left button 0 was pressed");
            if ([patientInfo.chattype  isEqual:@"Patient"]) {
                
            if ([patientInfo.mstatus isEqual:@"0"]) {
                [SVProgressHUD showWithStatus:@"Please wait..."];
            [[AppController sharedInstance] acceptMSGSession:patientInfo.pid sessionID:patientInfo.postid completion:^(BOOL success, NSString *message)  {
                [SVProgressHUD dismiss];
                if (success) {
                  //  [self acceptedSession:msgSession];
                    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                    MessagingViewController *vc = [[MessagingViewController alloc] initWithNibName:@"MessagingViewController" bundle:nil];
                    vc.msgSession = patientInfo;
                    vc.delegate = self;
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self presentViewController:nav animated:YES completion:nil];

                    
                }
            }];
            } else {
                [self showAlertViewWithMessage:@"You already accepted/declined this chat request" withTag:0 withTitle:@"" andViewController:self isCancelButton:false];
            }
                
            } else {
                 if ([patientInfo.ismine intValue] == 1) {
                     return;
                 }
                if ([patientInfo.mstatus isEqual:@"0"]) {
                    [SVProgressHUD showWithStatus:@"Please wait..."];
                [[AppController sharedInstance] acceptDocMSGSession:patientInfo.pid sessionID:patientInfo.postid completion:^(BOOL success, NSString *message) {
                     [SVProgressHUD dismiss];
                    if (success) {
                        
                        DocChatViewViewController *vc = [[DocChatViewViewController alloc] initWithNibName:@"DocChatViewViewController" bundle:nil];
                        vc.msgSession = patientInfo;
                       // vc.delegate = self;
                        [self.navigationController pushViewController:vc animated:YES];
                       

                        
                        
                    }
                }];
                    
                } else {
                    [self showAlertViewWithMessage:@"You already accepted/declined this chat request" withTag:0 withTitle:@"" andViewController:self isCancelButton:false];
                }
            }

        } break;
        case 1: {
           // NSLog(@"left button 1 was pressed");
            if ([patientInfo.chattype  isEqual:@"Patient"]) {
                
            if ([patientInfo.mstatus isEqual:@"0"]) {
                [SVProgressHUD showWithStatus:@"Please wait..."];
            [[AppController sharedInstance] declineMSGSession:patientInfo.pid sessionID:patientInfo.postid completion:^(BOOL success, NSString *message)  {
        
                [SVProgressHUD dismiss];
                if (success) {
                    //[self.delegate declinedSession];
                    //[self dismissViewControllerAnimated:NO completion:nil];
                    UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"" message:@"You declined this chat session" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alertTest show];
                        [self requestPatientsDataByPage:1 keyword : @""];
                }
            }];
            }else {
                [self showAlertViewWithMessage:@"You already accepted/declined this chat request" withTag:0 withTitle:@"" andViewController:self isCancelButton:false];
            }
                
            } else {
                if ([patientInfo.ismine intValue] == 1) {
                    return;
                }
                
                 if ([patientInfo.mstatus isEqual:@"0"]) {
                     [SVProgressHUD showWithStatus:@"Please wait..."];
                [[AppController sharedInstance] declineDocMSGSession:patientInfo.pid sessionID:patientInfo.postid completion:^(BOOL success, NSString *message) {
                     [SVProgressHUD dismiss];
                    if (success) {
                        UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"" message:@"You declined this chat session" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alertTest show];
                        [self requestPatientsDataByPage:1 keyword : @""];
                    }
                }];
                     
                 } else {
                     [self showAlertViewWithMessage:@"You already accepted/declined this chat request" withTag:0 withTitle:@"" andViewController:self isCancelButton:false];
                 }
            }

        }  break;
        case 2: {
            
            NSLog(@"left button 2 was pressed");
            if ([patientInfo.chattype  isEqual:@"Patient"]) {
            MSGPatientProfileViewController *vc =[[MSGPatientProfileViewController alloc] init];
            vc.patientID = patientInfo.pid;
            [self.navigationController pushViewController:vc animated:true];
                
            }
        }
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
   
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        
        case 0:
        {
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [menuTable indexPathForCell:cell];
            
            //  [_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
            //[menuTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [cell hideUtilityButtonsAnimated:true];
             MSGSession *patientInfo = [_patientsArray objectAtIndex:cellIndexPath.row];
            
            
            if ([patientInfo.chattype  isEqual:@"Patient"]) {
            if ([patientInfo.mstatus isEqual:@"1"]) {
                [SVProgressHUD showWithStatus:@"Please wait..."];
            [[AppController sharedInstance] closeMSGSession:patientInfo.pid sessionID:patientInfo.postid completion:^(BOOL success, NSString *message)  {
                [SVProgressHUD dismiss];
                
                if (success) {
                    //[self.navigationController popViewControllerAnimated:YES];
                    //[self.delegate refreshPatientsInfo3];
                    
                    UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"" message:@"You closed this chat session" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alertTest show];

                    
                     [self requestPatientsDataByPage:1 keyword : @""];
                }
                
                
            }];
                
            } else {
                 [self showAlertViewWithMessage:@"You cannot close this chat" withTag:0 withTitle:@"" andViewController:self isCancelButton:false];
            }
                
            } else {
                
                   if ([patientInfo.mstatus isEqual:@"1"]) {
                        [SVProgressHUD showWithStatus:@"Please wait..."];
                       [[AppController sharedInstance] closeMSGSession:patientInfo.pid sessionID:patientInfo.postid completion:^(BOOL success, NSString *message)  {
                           [SVProgressHUD dismiss];
                           if (success) {
                               UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"" message:@"You closed this chat session" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                               [alertTest show];
                        
                        
                               [self requestPatientsDataByPage:1 keyword : @""];
                        
                    }
                    
                }];
                       
                   } else {
                       [self showAlertViewWithMessage:@"You cannot close this chat" withTag:0 withTitle:@"" andViewController:self isCancelButton:false];
                   }

                
            }

            
            
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}










- (void)refreshPatientList {
    [self requestPatientsDataByPage:1 keyword : _searchBar.text];
}

#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestPatientsDataByPage:1 keyword : _searchBar.text];
}

- (void)acceptedSession:(MSGSession *)patientInfo {
    
    MessagingViewController *vc = [[MessagingViewController alloc] initWithNibName:@"MessagingViewController" bundle:nil];
    vc.msgSession = patientInfo;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    [self requestPatientsDataByPage:1 keyword : @""];
}

- (void)declinedSession {
    [self requestPatientsDataByPage:1 keyword : @""];
}

- (void)visitSession:(MSGSession *)patientInfo {

    MessagingViewController *vc = [[MessagingViewController alloc] initWithNibName:@"MessagingViewController" bundle:nil];
    vc.msgSession = patientInfo;
    vc.delegate = self;
    vc.isClosedSessionOpen = false;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)visitClosedSession:(MSGSession *)patientInfo {
    
    MessagingViewController *vc = [[MessagingViewController alloc] initWithNibName:@"MessagingViewController" bundle:nil];
    vc.msgSession = patientInfo;
    vc.delegate = self;
    vc.isClosedSessionOpen = true;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)refreshPatientsInfo3 {
    [self requestPatientsDataByPage:1 keyword : @""];
}

- (void)refreshPationInfo2 {
     [self requestPatientsDataByPage:1 keyword : @""];
}

@end
