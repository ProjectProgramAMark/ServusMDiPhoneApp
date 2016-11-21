//
//  ConsulDetailAllergyViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/31/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "ConsulDetailAllergyViewController.h"

@interface ConsulDetailAllergyViewController ()

@end

@implementation ConsulDetailAllergyViewController


@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize patientsArray;
@synthesize consultation;

- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    
      
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"NewGreenTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    ;
    self.title = @"ALLERGIES";
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
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
    [self getPatientAllergy];
}



- (void)getPatientAllergy {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllAllergenByPMMasterByID:consultation.pid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
        [SVProgressHUD dismiss];
        if (success)
        {
            
            [patientsArray removeAllObjects];
            
            [patientsArray addObjectsFromArray:conditions];
            [menuTable reloadData];
        }
        
        
    }];}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return patientsArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewGreenTableViewCell *cell = (NewGreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Allergen *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo2.PicklistDesc];
    cell.nameLabel.numberOfLines = 0;
    cell.imgView.image = [UIImage imageNamed:@"fruits11"];
    cell.arrowRightIMG.hidden = true;
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70.0f;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        if (patientsArray.count > 0) {
            if (indexPath.section == 0) {
                Allergen *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
                [patientsArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                [[AppController sharedInstance] deletePMasterAllergen:patientInfo2.postid completion:^(BOOL success, NSString *message) {
                    if (success) {
                        
                    }
                }];
            }
            
        }
        
    }
    
    
}

- (IBAction)addNewAllergy:(id)sender {
   // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    AddAllergyToPMasterViewController *vc = [[ AddAllergyToPMasterViewController alloc] initWithNibName:@"AddAllergyToPMasterViewController" bundle:nil];
    //  vc.patientInfo = patientInfo;
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
