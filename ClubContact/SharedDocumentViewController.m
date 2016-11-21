//
//  SharedDocumentViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/7/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SharedDocumentViewController.h"
#import "SWRevealViewController.h"

@interface SharedDocumentViewController ()

@end

@implementation SharedDocumentViewController


@synthesize eyeExamID;
@synthesize patientID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _patientsArray = [NSMutableArray array];
    
    patientsGrid.delegate = self;
    patientsGrid.dataSource = self;
    
    _searchBar.delegate = self;
    
    _searchBar.barTintColor = [UIColor flatWhiteColor];
    
    /* [_patientsTableView addLegendFooterWithRefreshingBlock:^{
     [self requestPatientsDataByPage:currentPage + 1 keyword : _searchBar.text];
     }];
     
     [_patientsTableView addLegendHeaderWithRefreshingBlock:^{
     [self requestPatientsDataByPage:1 keyword : _searchBar.text];
     }];
     
     [_patientsTableView registerClass:[PatientsTableViewCell class]
     forCellReuseIdentifier:kPatientsCellID];*/
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    currentPage = 0;
    
    /*[patientsGrid addLegendFooterWithRefreshingBlock:^{
        [self requestPatientsDataByPage:currentPage + 1 keyword :@""];
    }];*/
    
    [patientsGrid addLegendHeaderWithRefreshingBlock:^{
        [self requestPatientsDataByPage:1 keyword : @""];
    }];
    
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCell" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    [patientsGrid registerNib:[UINib nibWithNibName:@"MSGPatientGridCelliPhone" bundle:nil] forCellWithReuseIdentifier:@"MSGPatientGrid"];
    
    [menuTable registerNib:[UINib nibWithNibName:@"DashboardPatientTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardDoctor"];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"DOCUMENTS";
    
    
    /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
   // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    //self.navigationItem.rightBarButtonItem = notiButtonItem;
}

- (IBAction)goBackToChose:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    [self.revealViewController revealToggle:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //[SVProgressHUD showWithStatus:@"Loading..."];
   /* [[AppController sharedInstance] getAllDoctors:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [_patientsArray removeAllObjects];
            }
            [_patientsArray addObjectsFromArray:conditions];
            [menuTable reloadData];
        }
        
        [menuTable.footer endRefreshing];
        [menuTable.header endRefreshing];
        
    }];*/
    
        [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getSharedDocuments:@"" keyword:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patients) {
        [SVProgressHUD dismiss];
        if (success) {
            sharedDocumentUnread = 0;
               [_patientsArray removeAllObjects];
            [patientsGrid reloadData];
            [_patientsArray addObjectsFromArray:patients];
            [menuTable reloadData];
            
            
        }
        
        [menuTable.footer endRefreshing];
        [menuTable.header endRefreshing];
        
    }];

}

- (IBAction)goToNotifications:(id)sender {
    NotificationsDoctorViewController *vc = [[NotificationsDoctorViewController alloc] initWithNibName:@"NotificationsDoctorViewController" bundle:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _patientsArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE) {
        MSGPatientGridCelliPhone *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        SharedDocuments *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        
        Doctor *doc = [Doctor getFromUserDefault];
        
        int docid = [doc.uid intValue];
        int sdocid = [patientInfo.fromdoc intValue];
        
        if (sdocid == docid) {
              [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.toprofimg]];
        } else {
            [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.fromprofimg]];
        }
        //[cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
        
        cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
        cell.profileIMG.layer.masksToBounds = YES;
        
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
      /*  NSString *isOnline = @"Offline";
        if ([patientInfo.isOnline intValue] == 1) {
            isOnline = @"Online";
        } else if ([patientInfo.isOnline intValue] == 2) {
            isOnline = @"Offline";
        }*/
        
      //  cell.nameLabel.text = [NSString stringWithFormat:@"Dr %@ %@", patientInfo.firstname, patientInfo.lastname];
        //  cell.messageCountLabel.text = patientInfo.msgCount;
        cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        
        cell.smallCircleIMG.hidden = true;
        cell.messageCountLabel.hidden = true;
        
        
        
        return cell;
    } else {
        MSGPatientGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSGPatientGrid" forIndexPath:indexPath];
        
        
        Doctors *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
        
        [cell.profileIMG setImageWithURL:[NSURL URLWithString:patientInfo.profileimage]];
        
        cell.profileIMG.layer.cornerRadius = cell.profileIMG.frame.size.width/2;
        cell.profileIMG.layer.masksToBounds = YES;
        // cell.profileIMG.layer.borderColor = [UIColor whiteColor].CGColor;
        // cell.profileIMG.layer.borderWidth = 3.0;
        NSString *isOnline = @"Offline";
        if ([patientInfo.isOnline intValue] == 1) {
            isOnline = @"Online";
        } else if ([patientInfo.isOnline intValue] == 2) {
            isOnline = @"Offline";
        }
        
        cell.nameLabel.text = [NSString stringWithFormat:@"Dr %@ %@", patientInfo.firstname, patientInfo.lastname];
        //  cell.messageCountLabel.text = patientInfo.msgCount;
        cell.nameLabel.textColor = [UIColor colorWithRed:78.0f/255.0f green:78.0f/255.0f blue:78.0f/255.0f alpha:1.0f];
        
        cell.smallCircleIMG.hidden = true;
        cell.messageCountLabel.hidden = true;
        
        
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    /* Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
     [[AppController sharedInstance] inviteMessaging:patientInfo.postid completion:^(BOOL success, NSString *message) {
     if (success) {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Massage invitation sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
     [alert show];
     }
     }];*/
    
    Doctors *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    
    [[AppController sharedInstance] shareEyeExam:patientID todoc:patientInfo.uid postid:eyeExamID completion:^(BOOL success, NSString *message) {
        if (success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Eye exam shared" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
    }];
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
    DashboardPatientTableViewCell *cell = (DashboardPatientTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardDoctor"];
    
    
    SharedDocuments *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    
    Doctor *doc = [Doctor getFromUserDefault];
    
    int docid = [doc.uid intValue];
    int sdocid = [patientInfo.fromdoc intValue];
    
    
    cell.cellImageView.layer.cornerRadius = cell.cellImageView.frame.size.width/2;
    cell.cellImageView.layer.masksToBounds = YES;
    cell.cellImageView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.cellImageView.layer.borderWidth = 1.0f;
    
    
    //  cell.costLabel.text = [NSString stringWithFormat:@"%@ tokens", patientInfo.ccost];
    
    if (sdocid == docid) {
       cell.nameLabel.text = [NSString stringWithFormat:@"To %@ %@",patientInfo.tofirstname, patientInfo.tolastname];
        
        [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.toprofimg]];
            
    } else {
        cell.nameLabel.text = [NSString stringWithFormat:@"From %@ %@",patientInfo.fromfirstname, patientInfo.fromlastname];
        
        [cell.cellImageView setImageWithURL:[NSURL URLWithString:patientInfo.fromprofimg]];
        
    }
    
    if ([patientInfo.type isEqual:@"EyeExam"]) {
        cell.specialityLabel.text = [NSString stringWithFormat:@"Eye exam form"];
    } else {
        cell.specialityLabel.text = [NSString stringWithFormat:@"Other"];
    }

    
    int isRead = [patientInfo.read intValue];
    
    
    
   
    
    if ([patientInfo.read intValue] == 1) {
        cell.costLabel.text = @"Read";
        cell.costLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
    } else if (isRead == 0) {
        cell.costLabel.text = @"Unread";
        cell.costLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    } else {
        cell.costLabel.text = @"";
    }
    // cell.nameLabel.text = imageName;
    
    cell.clipsToBounds = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0f;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
     SharedDocuments *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    
    Doctor *doc = [Doctor getFromUserDefault];
    
    int docid = [doc.uid intValue];
    int sdocid = [patientInfo.fromdoc intValue];
    
    if (docid == sdocid) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SharedDocuments *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    
    Doctor *doc = [Doctor getFromUserDefault];
    
    int docid = [doc.uid intValue];
    int sdocid = [patientInfo.fromdoc intValue];
    
    if (docid == sdocid) {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] deleteSharedDocument:patientInfo.nid completion:^(BOOL success, NSString *message) {
        
            [SVProgressHUD dismiss];
            if (success)
            {
                [self requestPatientsDataByPage:0 keyword:@""];
            }
            else
            {
                [UIAlertView showWithTitle:@"Failed" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            }
            
            
        }];

    } else {
      
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /* Doctors *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
     [[AppController sharedInstance] inviteDoctorMessaging:patientInfo.uid completion:^(BOOL success, NSString *message, NSString *sessionid) {
     if (success) {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Message invitation sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
     [alert show];
     }
     }];*/
  
    
    SharedDocuments *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
    
    if ([patientInfo.type isEqual:@"EyeExam"]) {
        Doctor *doc = [Doctor getFromUserDefault];
        
        int docid = [doc.uid intValue];
        int sdocid = [patientInfo.fromdoc intValue];
        
        int isRead = [patientInfo.read intValue];
        if (isRead == 0 & docid != sdocid) {
            [[AppController sharedInstance] markDocumentRead:patientInfo.nid completion:^(BOOL success, NSString *message) {
               
                if (success) {
                    
                }
                
            }];
        }
        
        
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getSingleEyeExam:patientInfo.postid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *patient) {
        [SVProgressHUD dismiss];
        if (success) {
            if (patient.count > 0) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];

                EyeExam2 *eyeExam = [patient objectAtIndex:0];
                if (eyeExam.formimage1.length > 0) {
                    
                    EyeExamImageViewController  *vc = [[EyeExamImageViewController alloc] initWithNibName:@"EyeExamImageViewController" bundle:nil];
                    
                    
                    
                    
                    vc.patientID = patientInfo.patientid;
                    vc.eyeExam = eyeExam;
                    [self.navigationController pushViewController:vc animated:YES];
                } else {
                    EyeExam2VC  *vc = [[EyeExam2VC alloc] initWithNibName:@"EyeExam2VC" bundle:nil];
                    
                    
                    
                    
                     vc.patientID = patientInfo.patientid;
                    vc.eyeExam = eyeExam;
                    
                    
                    // vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:YES];
                   
                }

                
            }
            
            
        }
        
    }];
        
    }
    
}








- (void)refreshPatientList {
    [self requestPatientsDataByPage:1 keyword : _searchBar.text];
}

#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestPatientsDataByPage:1 keyword : _searchBar.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self requestPatientsDataByPage:1 keyword : searchText];
}


@end
