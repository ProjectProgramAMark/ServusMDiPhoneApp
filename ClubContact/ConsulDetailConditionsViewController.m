//
//  ConsulDetailConditionsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/31/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "ConsulDetailConditionsViewController.h"

@interface ConsulDetailConditionsViewController ()

@end

@implementation ConsulDetailConditionsViewController


@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize consultation;
@synthesize patientsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"NewGreenTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    self.title = @"CONDITIONS";
    
   
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    // [menuTable reloadData];
    [self getPatientContion];
}



- (void)getPatientContion {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllConditionByPMasterID:consultation.pid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            
            [patientsArray removeAllObjects];
            
            [patientsArray addObjectsFromArray:conditions];
            [menuTable reloadData];
        }
        
        
    }];
    
    
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return patientsArray.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // if (_addedConditionsArray.count > 0) {
    if (indexPath.section == 0) {
        return NO;
    } else {
        return NO;
    }
    /* } else {
     return NO;
     }*/
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewGreenTableViewCell *cell = (NewGreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Condition *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo2.conditionName];
    cell.nameLabel.numberOfLines = 0;
    cell.imgView.image = [UIImage imageNamed:@"virus9"];
    cell.arrowRightIMG.hidden = true;

    
    return cell;
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70.0f;
    
}





- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        if (patientsArray.count > 0) {
            if (indexPath.section == 0) {
                Condition *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
                [[AppController sharedInstance] deletePMasterCondition:patientInfo2.nodeID completion:^(BOOL success, NSString *message) {
                    if (success) {
                        
                    }
                }];
                
                
                [patientsArray removeObjectAtIndex:indexPath.row];
                @try {
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    // [conditionTable reloadData];
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
                // [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                //  [conditionTable reloadData];
                
                
            }
            
        }
        
    }
    
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)addNewCondition:(id)sender {
    AddConditionToPMasterViewController *vc = [[AddConditionToPMasterViewController alloc] initWithNibName:@"AddConditionToPMasterViewController" bundle:nil];
    //  vc.patientInfo = patientInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
