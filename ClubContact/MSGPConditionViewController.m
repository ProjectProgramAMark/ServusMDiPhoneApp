//
//  MSGPConditionViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/21/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "MSGPConditionViewController.h"

@interface MSGPConditionViewController ()

@end

@implementation MSGPConditionViewController




@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize patientsArray;
@synthesize patientID;

- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    
    
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
    
    //self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"ConditionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    self.title = @"CONDITIONS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController  popViewControllerAnimated:YES];
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
    [[AppController sharedInstance] getAllConditionByPMaster2:patientID WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
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
        return YES;
    } else {
        return NO;
    }
    /* } else {
     return NO;
     }*/
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ConditionsTableViewCell    *cell = (ConditionsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    
    // PatientMedication *patientInfo2 = [profPatient.medications objectAtIndex:indexPath.row];
    Condition *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo2.conditionName];
    
    
    cell.backgroundColor = [UIColor clearColor];
    cell.clipsToBounds = YES;
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
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
