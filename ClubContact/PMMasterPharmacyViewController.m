//
//  PMMasterPharmacyViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 8/21/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PMMasterPharmacyViewController.h"

@interface PMMasterPharmacyViewController ()

@end

@implementation PMMasterPharmacyViewController


@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize patientsArray;

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
    

    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"PharmacyNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    self.title = @"PHARMACIES";
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
    [self getPatientPhamrcy];
}



- (void)getPatientPhamrcy{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllPharmacyByPMMaster:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
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
    
    PharmacyNewTableViewCell   *cell = (PharmacyNewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    Pharmacy *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = patientInfo2.pharmName;
    cell.addressLabel.text = patientInfo2.address;
    
    cell.clipsToBounds = YES;
    
    return cell;
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}





- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        if (patientsArray.count > 0) {
            if (indexPath.section == 0) {
                Pharmacy *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
                [patientsArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                  [SVProgressHUD showWithStatus:@"Deleting..."];
                [[AppController sharedInstance] deletePMasterPharmacy:patientInfo2.postid completion:^(BOOL success, NSString *message) {
                    [SVProgressHUD dismiss];
                    if (success) {
                        
                    }
                }];

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
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    AddConditionToPMasterViewController *vc = (AddConditionToPMasterViewController *)[sb instantiateViewControllerWithIdentifier:@"AddConditionToPMasterViewController"];
    //  vc.patientInfo = patientInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
