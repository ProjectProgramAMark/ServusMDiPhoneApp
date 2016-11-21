//
//  ConditionListNewViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/1/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "ConditionListNewViewController.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"

@interface ConditionListNewViewController () <AddConditionsDelegate>

@end

@implementation ConditionListNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"CONDITIONS";
    
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
    if (self.isSharedProfile == false) {
        self.navigationItem.rightBarButtonItem = notiButtonItem;
        
    }
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"NewGreenTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getPatientContion];
    
    profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
    profileIMGView2.layer.masksToBounds = YES;
    profileIMGView2.layer.borderColor = [UIColor blackColor].CGColor;
    profileIMGView2.layer.borderWidth = 1.0;
    
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    //[profileIMGView3 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
    jobLabel2.text = [NSString stringWithFormat:@"%@", _patient.occupation];
    
    
    
    
    
}


- (void)getPatientContion {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllConditionByPatient:_patient.postid docid:_patient.docid 
                                              WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions)
     {
         [SVProgressHUD dismiss];
         if (success)
         {
             [_patient.conditions removeAllObjects];
             [_patient.conditions addObjectsFromArray:conditions];
               [_tableView reloadData];
             
             
        }
     }];
    
}



- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)addConditons:(id)sender {
    
    AddConditionsViewController *vc = [[AddConditionsViewController alloc] initWithNibName:@"AddConditionsViewController" bundle:nil];
    
    vc.patientID = _patient.postid;
    
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:true];
    
}



#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _patient.conditions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewGreenTableViewCell *cell = (NewGreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Condition *patientInfo = [_patient.conditions objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.conditionName];
    cell.nameLabel.numberOfLines = 0;
    cell.imgView.image = [UIImage imageNamed:@"virus9"];
    cell.arrowRightIMG.hidden = true;
    
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
    
    Condition *condition = [_patient.conditions objectAtIndex:indexPath.row];
    if (condition)
    {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] deleteProfileCondition:condition.nodeID
                                                    completion:^(BOOL success, NSString *message)
         {
             [SVProgressHUD dismiss];
             if (success)
             {
                 [self getPatientContion];
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
    
    return 70.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
}


- (void)refreshPationInfo {
    [self getPatientContion];
}



@end
