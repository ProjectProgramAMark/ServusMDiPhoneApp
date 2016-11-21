//
//  EyeExamListViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/1/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "EyeExamListViewController.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"

@interface EyeExamListViewController ()

@end

@implementation EyeExamListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"EYE EXAM";
    
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
    
    [_tableView registerNib:[UINib nibWithNibName:@"NewGreenTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   [self getPatientEyeExam];
    
    profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
    profileIMGView2.layer.masksToBounds = YES;
    profileIMGView2.layer.borderColor = [UIColor blackColor].CGColor;
    profileIMGView2.layer.borderWidth = 1.0f;
     
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    //[profileIMGView3 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
    jobLabel2.text = [NSString stringWithFormat:@"%@", _patient.occupation];
    
    
    
    
    
}


- (void)getPatientEyeExam
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllEyeExamsByPatient2:_patient.postid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.eyeexam removeAllObjects];
            [_patient.eyeexam addObjectsFromArray:conditions];
            [_tableView reloadData];
            //eyeExamLabel.text = [NSString stringWithFormat:@"%lu Eye Exams", (unsigned long)_patient.eyeexam.count];
        }
        
    }];
}


- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


- (IBAction)addNewEyeExam:(id)sender {
    [UIAlertView showWithTitle:@"Choose Format:"
                       message:nil
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"Tabs", @"Free Write"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
     {
         if (buttonIndex == 0)
         {
             //cancel, do nothing
             
         }
         else if (buttonIndex == 1)
         {
             //Text
            // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
             AddEyeExam2VC  *vc = [[AddEyeExam2VC alloc] initWithNibName:@"AddEyeExam2VC" bundle:nil];
             
             vc.patientID = _patient.postid;
             
             // vc.delegate = self;
             [self.navigationController pushViewController:vc animated:YES];
             
             
             
         }
         else if (buttonIndex == 2)
         {
             //Photo
            DrawingEyeExamViewController  *vc = [[DrawingEyeExamViewController alloc] initWithNibName:@"DrawingEyeExamViewController" bundle:nil];
             
             vc.patientID = _patient.postid;
             [self.navigationController pushViewController:vc animated:YES];
             
         }
         else if (buttonIndex == 3)
         {
             //Audio
             
         } else if (buttonIndex == 4)
         {
             //Audio
             
         }
     }];
    
    
}



#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _patient.eyeexam.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewGreenTableViewCell *cell = (NewGreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
   /* EyeExam *patientInfo = [_patient.eyeexam objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.conditionName];
    cell.nameLabel.numberOfLines = 0;*/
    cell.imgView.image = [UIImage imageNamed:@"eyeball15"];
    
    EyeExam2 *eyeExam = [_patient.eyeexam objectAtIndex:indexPath.row];
    NSTimeInterval timestamp = [eyeExam.created doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSString *dateString = [dateFormat stringFromDate:date];
    cell.nameLabel.text  = dateString;
        
    
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
    
    EyeExam2 *eyeExam = [_patient.eyeexam objectAtIndex:indexPath.row];
    if (eyeExam)
    {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] deleteGenericNodeDoc:eyeExam.postid completion:^(BOOL success, NSString *message) {
            
            [SVProgressHUD dismiss];
            if (success)
            {
                [self getPatientEyeExam];
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
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    EyeExam2 *eyeExam = [_patient.eyeexam objectAtIndex:indexPath.row];
    if (eyeExam.formimage1.length > 0) {
        
      //  EyeExamImageViewController  *vc = (EyeExamImageViewController *)[sb instantiateViewControllerWithIdentifier:@"EyeExamImageViewController"];
        
         EyeExamImageViewController  *vc = [[EyeExamImageViewController alloc] initWithNibName:@"EyeExamImageViewController" bundle:nil];
        
        
        vc.patientID = _patient.postid;
        vc.eyeExam = eyeExam;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        EyeExam2VC  *vc = [[EyeExam2VC alloc] initWithNibName:@"EyeExam2VC" bundle:nil];
        
        
        
        
        vc.patientID = _patient.postid;
        vc.eyeExam = eyeExam;
        [self.navigationController pushViewController:vc animated:YES];
        
       
        
        
    }
    
    
    
}


- (void)refreshPationInfo {
    [self getPatientEyeExam];
}


@end
