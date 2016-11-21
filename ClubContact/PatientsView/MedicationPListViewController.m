//
//  MedicationPListViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/1/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "MedicationPListViewController.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"


@interface MedicationPListViewController () <PatientDrugDetailsDelegate, ConditionsListDelegate, DrugsListDelegate>

@end

@implementation MedicationPListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"MEDICATION";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
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
    [self getPatientMedication];
    
    profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
    profileIMGView2.layer.masksToBounds = YES;
    profileIMGView2.layer.borderColor = [UIColor blackColor].CGColor;
    profileIMGView2.layer.borderWidth = 1.0;
    
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    //[profileIMGView3 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
    jobLabel2.text = [NSString stringWithFormat:@"%@", _patient.occupation];
    
    
    
    
    
}



- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)prescribeMedication:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"New Medication" message:@"Select an option" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *conditionAction = [UIAlertAction actionWithTitle:@"Prescribe by condition" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        ConditionListViewController *vc = [[ConditionListViewController alloc] initWithNibName:@"ConditionListViewController" bundle:nil];
        
        vc.patient = _patient;
        vc.delegate = self;
        
       /* if (IS_IPHONE) {
            // [self.navigationController pushViewController:vc animated:YES];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        } else {
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            
            UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
            
            [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
        }*/
        [self.navigationController pushViewController:vc animated:true];
        
        
    }];
    
    UIAlertAction *medicationAction = [UIAlertAction actionWithTitle:@"Prescribe by medication" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
      //  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
        DrugsViewController *vc = [[DrugsViewController alloc] initWithNibName:@"DrugsViewController" bundle:nil];
        vc.selectedConditions = [[NSMutableArray alloc] init];
        vc.selectedAllergens = _patient.allergies;
        vc.patient = _patient;
        vc.delegate = self;
        vc.isMedPres = true;
        
        // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
       /* if (IS_IPHONE) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
        } else {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            
            UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
            
            [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
        }*/
        [self.navigationController pushViewController:vc animated:true];
        
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



-(void)getPatientMedication {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllMedicationByPatient:_patient.postid docid:_patient.docid  WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.medications removeAllObjects];
            [_patient.medications addObjectsFromArray:conditions];
            [_tableView reloadData];
           
        }
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


#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _patient.medications.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewGreenTableViewCell *cell = (NewGreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    PatientMedication *patientInfo = [_patient.medications objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", patientInfo.medname, patientInfo.requests];
    cell.nameLabel.numberOfLines = 0;
    cell.imgView.image = [UIImage imageNamed:@"refillIcon"];
    
    return cell;

    
}

#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    return title;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PatientMedication *medication = [_patient.medications objectAtIndex:indexPath.row];
   // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
   // PatientDrugDetailsViewController *vc = (PatientDrugDetailsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDrugDetailsViewController"];
    PatientDrugDetailsViewController *vc = [[PatientDrugDetailsViewController alloc] initWithNibName:@"PatientDrugDetailsViewController" bundle:nil];
    
    vc.patient = _patient;
    vc.medication = medication;
    vc.delegate = self;
    vc.isRefill = self.isRefill;
    /*UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];*/
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)refreshRefillMedication {
    [self getPatientMedication];
}

- (IBAction)profileClick:(id)sender {
    if (self.isRefill == true) {
        PatientDetailViewController *vc = [[PatientDetailViewController alloc] initWithNibName:@"PatientDetailViewController" bundle:nil];
        vc.patient = _patient;
      //  vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



@end
