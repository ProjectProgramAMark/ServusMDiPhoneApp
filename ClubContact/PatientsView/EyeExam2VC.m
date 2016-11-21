//
//  EyeExam2VC.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 9/22/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "EyeExam2VC.h"

@interface EyeExam2VC ()

@end

@implementation EyeExam2VC


@synthesize tableView;
@synthesize patientID;
@synthesize eyeExam;
@synthesize bottomTab;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"EYE EXAM";
    
    catType= 0;
    
    //  eyeExam = [[EyeExam alloc] initWithDic:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                  target:self
                                  action:@selector(addEyeExam:)];
    //self.navigationItem.rightBarButtonItem = addButton;
      UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareEyeExam:)];
    
    self.navigationItem.rightBarButtonItem = shareButton;*/
    
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
    
    [tableView registerNib:[UINib nibWithNibName:@"PatientRecordAboutCell" bundle:nil] forCellReuseIdentifier:kAboutCellID];
}

- (void)keyboardWillShow:(NSNotification *)sender
{
    CGSize kbSize = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
        [self.tableView setContentInset:edgeInsets];
        [self.tableView setScrollIndicatorInsets:edgeInsets];
    }];
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    NSTimeInterval duration = [[[sender userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
        [self.tableView setContentInset:edgeInsets];
        [self.tableView setScrollIndicatorInsets:edgeInsets];
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [tableView reloadData];
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)shareEyeExam:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    EyeExamShareViewController *vc = [[EyeExamShareViewController alloc] initWithNibName:@"EyeExamShareViewController" bundle:nil];
    
    
    
    
    vc.patientID = patientID;
    vc.eyeExamID = eyeExam.postid;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)addEyeExam:(id)sender {
    eyeExam.patientid = patientID;
    [SVProgressHUD showWithStatus:@"Adding..."];
    [[AppController sharedInstance] addEyeExamForPatient:eyeExam WithCompletion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        if (success)
        {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        // [conditionTable.footer endRefreshing];
        // [conditionTable.header endRefreshing];
    }];
}


#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (catType == 0) {
        return 3;
    } else if (catType == 1) {
        return 2;
    } else if (catType == 2) {
        return 5;
    }  else if (catType == 3) {
        return 5;
    }  else if (catType == 4) {
        return 3;
    }  else {
        return 0;
    }
    // return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNumber = 0;
    
   
    if (catType == 0) {
        if (section == 0) {
            rowNumber = 2;
        } else if (section == 1) {
            rowNumber = 2;
        } else if (section == 2) {
            rowNumber = 1;
        }
    } else if (catType == 1) {
        if (section == 0) {
            rowNumber = 6;
        } else {
            rowNumber = 1;
        }
    } else if (catType == 2) {
        if (section == 0) {
            if (unaidedSelect == true) {
                rowNumber = 6;
            } else {
                rowNumber = 1;
            }
         //   rowNumber = 6;
        } else if (section == 1) {
            if (presentingSelect == true) {
                rowNumber = 17;
            } else {
                rowNumber = 1;
            }
           // rowNumber = 17;
        }  else if (section == 2) {
               if (minfestSelect == true) {
                   rowNumber = 18;
               } else {
                   rowNumber = 1;
               }
              // rowNumber = 18;
           } else if (section == 3) {
               if (cycloplegicSelect == true) {
                   rowNumber = 18;
               } else {
                   rowNumber = 1;
               }
             //  rowNumber = 18;
           }
    } else if (catType == 3) {
        if (section == 0) {
            rowNumber = 4;
        } else if (section == 1) {
            rowNumber = 4;
        } else if (section == 2) {
            rowNumber = 2;
        } else if (section == 3) {
            rowNumber = 2;
        } else if (section == 4) {
            rowNumber = 7;
        }
    } else if (catType == 4) {
        if (section == 0) {
            rowNumber = 3;
        } else if (section == 1) {
            rowNumber = 3;
        } else if (section == 2) {
            rowNumber = 1;
        }
        
    }
    
    
    
    
    
    
    return rowNumber;
}



#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    if (catType == 0) {
        if (section == 0) {
            title = @"";
        } else if (section == 1) {
            title = @"";
        } else if (section == 2) {
            title = @"";
        }
    } else if (catType == 1) {
        if (section == 0) {
            title = @"";
        } else if (section == 1) {
            title = @"";
        }
    } else if (catType == 2) {
        if (section == 0) {
            title = @"Unaided Actuities";
        } else if (section == 1) {
            title = @"Presenting RX.";
        } /*else if (section == 2) {
           title = @"Objective RX";
           } */else if (section == 2) {
               title = @"Manifest RX";
           } else if (section == 3) {
               title = @"Clycloplegic RX";
           }
    } else if (catType == 3) {
        if (section == 0) {
            title = @"";
        } else if (section == 1) {
            title = @"CD Ratio";
        } else if (section == 2) {
            title = @"Amsler Grid";
        } else if (section == 3) {
             title = @"Confrontation";
        } else if (section == 4) {
            title = @"Slit Lamp Examination";
        }
    } else if (catType == 4) {
        if (section == 0) {
            title = @"Assessment";
        } else if (section == 1) {
            title = @"Plan";
        } else if (section == 2) {
            title = @"P.M.";
        }
        
    } else if (catType == 5) {
        
        if (section == 0) {
            title = @"Recommendations";
        } else if (section == 1) {
            title = @"Other";
        }
    }
    
    return title;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  /* 
   
   if (catType == 0) {
   if (indexPath.section == 0) {
   cell.nameLabel.text = [self ccReasonVisitValue:indexPath.row];
   cell.editText.text = [self ccReasonVisit:indexPath.row];
   cell.editText.tag = indexPath.row + 100;
   } else if (indexPath.section == 1) {
   cell.nameLabel.text = [self cComplianteValue:indexPath.row];
   cell.editText.text = [self cCompliante:indexPath.row];
   cell.editText.tag = indexPath.row + 200;
   } else if (indexPath.section == 2) {
   cell.nameLabel.text = [self hpiTitleByRow:indexPath.row];
   cell.editText.text = [self hpiValueByRow:indexPath.row];
   cell.editText.tag = indexPath.row + 300;
   }
   } else if (catType == 1) {
   if (indexPath.section == 0) {
   cell.nameLabel.text = [self patientHistoryTitleByRow:indexPath.row];
   cell.editText.text = [self patientHistoryValueByRow:indexPath.row];
   cell.editText.tag = indexPath.row + 400;
   } else if (indexPath.section == 1) {
   cell.nameLabel.text = [self reviewSystemTitle:indexPath.row];
   cell.editText.text = [self reviewSystemValue:indexPath.row];
   cell.editText.tag = indexPath.row + 500;
   }
   } else if (catType == 2) {
   if (indexPath.section == 0) {
   cell.nameLabel.text = [self vRXUnaidedActvitiesTitleByRow:indexPath.row];
   cell.editText.text = [self vRXUnaidedActvitiesValueByRow:indexPath.row];
   cell.editText.tag = indexPath.row + 600;
   } else if (indexPath.section == 1) {
   cell.nameLabel.text = [self presentSpecRXTitleByRow:indexPath.row];
   cell.editText.text = [self presentSpecRXValueByRow:indexPath.row];
   cell.editText.tag = indexPath.row + 700;
   }  else if (indexPath.section == 2) {
       cell.nameLabel.text = [self subjectiveRXTitleByRow:indexPath.row];
       cell.editText.text = [self subjectiveRXValueByRow:indexPath.row];
       cell.editText.tag = indexPath.row + 900;
   } else if (indexPath.section == 3) {
       cell.nameLabel.text = [self finalSpecRXTitleByRow:indexPath.row];
       cell.editText.text = [self finalSpecRXValueByRow:indexPath.row];
       cell.editText.tag = indexPath.row + 1000;
   }
} else if (catType == 3) {
    if (indexPath.section == 0) {
        cell.nameLabel.text = [self examValueOtherTitleByRow:indexPath.row];
        cell.editText.text = [self examValueOtherValueByRow:indexPath.row];
        cell.editText.tag = indexPath.row + 1600;
    } else if (indexPath.section == 1) {
        cell.nameLabel.text = [self examValueCDRatioTitleByRow:indexPath.row];
        cell.editText.text = [self examValueCDRatioValueByRow:indexPath.row];
        cell.editText.tag = indexPath.row + 1100;
    } else if (indexPath.section == 2) {
        cell.nameLabel.text = [self amslerGridTitleValue:indexPath.row];
        //cell.editText.text = [self examValueOtherValueByRow:indexPath.row];
        cell.editText.tag = indexPath.row + 1700;
        cell.editText.hidden = true;
    } else if (indexPath.section == 3) {
        cell.nameLabel.text = [self amslerGridTitleValue:indexPath.row];
        //cell.editText.text = [self examValueOtherValueByRow:indexPath.row];
        cell.editText.tag = indexPath.row + 1800;
        cell.editText.hidden = true;
    } else if (indexPath.section == 4) {
        cell.nameLabel.text = [self examExamTitleByRow:indexPath.row];
        cell.editText.text = [self examExamValueByRow:indexPath.row];
        cell.editText.tag = indexPath.row + 1200;
    }
} else if (catType == 4) {
    if (indexPath.section == 0) {
        cell.nameLabel.text = [self surgeryAssesTitleByRow:indexPath.row];
        cell.editText.text = [self surgeryAssesValueByRow:indexPath.row];
        cell.editText.tag = indexPath.row + 1300;
    } else if (indexPath.section == 1) {
        cell.nameLabel.text = [self planTitleByRow:indexPath.row];
        cell.editText.text = [self planValueByRow:indexPath.row];
        cell.editText.tag = indexPath.row + 1400;
    } else if (indexPath.section == 2) {
        cell.nameLabel.text = [self patientManTitleByRow:indexPath.row];
        cell.editText.text = [self patientManValueByRow:indexPath.row];
        cell.editText.tag = indexPath.row + 1500;
    }
    
} else if (catType == 5) {
    
    
}

    */

    PatientRecordAboutCell    *cell = (PatientRecordAboutCell *)[tableView dequeueReusableCellWithIdentifier:kAboutCellID];

    cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
    cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];

    cell.clipsToBounds = YES;

    if (catType == 0) {
        
        if (indexPath.section == 0) {
           
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self ccReasonVisitValue:indexPath.row], [self ccReasonVisit:indexPath.row]];
        } else if (indexPath.section == 1) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self cComplianteValue:indexPath.row], [self cCompliante:indexPath.row]];
            
        } else if (indexPath.section == 2) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self hpiTitleByRow:indexPath.row], [self hpiValueByRow:indexPath.row]];
            
        }
    } else if (catType == 1) {
        if (indexPath.section == 0) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self patientHistoryTitleByRow:indexPath.row], [self patientHistoryValueByRow:indexPath.row]];
        } else if (indexPath.section == 1) {
             cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self reviewSystemTitle:indexPath.row], [self reviewSystemValue:indexPath.row]];
            
        }

    } else if (catType == 2) {
        
        
        if (indexPath.section == 0) {
            if (unaidedSelect == true) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self vRXUnaidedActvitiesTitleByRow:indexPath.row], [self vRXUnaidedActvitiesValueByRow:indexPath.row]];
            } else {
                cell.nameLabel.text = [NSString stringWithFormat:@"Click to enlage"];
            }
           
        } else if (indexPath.section == 1) {
            if (presentingSelect == true) {
                
             cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self presentSpecRXTitleByRow:indexPath.row], [self presentSpecRXValueByRow:indexPath.row]];
                
            } else {
                cell.nameLabel.text = [NSString stringWithFormat:@"Click to enlage"];
            }
           
        } /* else if (indexPath.section == 2) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self objectRXTitleByRow:indexPath.row], [self objectRXValueByRow:indexPath.row]];
            
        }*/ else if (indexPath.section == 2) {
            if (minfestSelect == true) {
        
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self subjectiveRXTitleByRow:indexPath.row], [self subjectiveRXValueByRow:indexPath.row]];
            } else {
                cell.nameLabel.text = [NSString stringWithFormat:@"Click to enlage"];
            }
            
        } else if (indexPath.section == 3) {
            if (cycloplegicSelect == true) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self finalSpecRXTitleByRow:indexPath.row], [self finalSpecRXValueByRow:indexPath.row]];
            } else {
                cell.nameLabel.text = [NSString stringWithFormat:@"Click to enlage"];
            }
           
        }

    } else if (catType == 3) {
        

        
        
        if (indexPath.section == 0) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self examValueOtherTitleByRow:indexPath.row], [self examValueOtherValueByRow:indexPath.row]];
            
        } else if (indexPath.section == 1) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self examValueCDRatioTitleByRow:indexPath.row], [self examValueCDRatioValueByRow:indexPath.row]];
            
        } else if (indexPath.section == 2) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@",[self amslerGridTitleValue:indexPath.row]];
            
        }  else if (indexPath.section == 3) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@",[self amslerGridTitleValue:indexPath.row]];
            
        } else if (indexPath.section == 4) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self examExamTitleByRow:indexPath.row], [self examExamValueByRow:indexPath.row]];
           
        }
    } else if (catType == 4) {
        if (indexPath.section == 0) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self surgeryAssesTitleByRow:indexPath.row], [self surgeryAssesValueByRow:indexPath.row]];
            
        } else if (indexPath.section == 1) {
             cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self planTitleByRow:indexPath.row], [self planValueByRow:indexPath.row]];
          
        } else if (indexPath.section == 2) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self patientManTitleByRow:indexPath.row], [self patientManValueByRow:indexPath.row]];
            
        }

        
    } else if (catType == 5) {
        
    }
    
    
    
    
    
    return cell;
    
}



- (NSString *)amslerGridTitleValue:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"RT";
            break;
        }
        case 1:
        {
            title = @"LT";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}





- (NSString *)ccReasonVisit:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.cc_examination;
            break;
        }
        case 1:
        {
            title = eyeExam.cc_examtechnician;
            break;
        }
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)ccReasonVisitValue:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"P.C.P";
            break;
        }
        case 1:
        {
            title = @"Other Physician";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}




- (NSString *)cCompliante:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.cc_chiefcompliant;
            break;
        }
        case 1:
        {
            title = eyeExam.seondarycomplain;
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)cComplianteValue:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"C.C.";
            break;
        }
        case 1:
        {
            title = @"S.C.";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}




- (NSString *)hpiValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.cc_hpivision;
            break;
        }
        case 1:
        {
            title = eyeExam.cc_hpioccular;
            break;
        }
            
            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)hpiTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"H.P.I.";
            break;
        }
        case 1:
        {
            title = @"Ocular C.";
            break;
        }
            
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}





- (NSString *)patientHistoryValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.phx_patienthostiry;
            break;
        }
        case 1:
        {
            title = eyeExam.medicationhistory;
            break;
        }
        case 2:
        {
            title = eyeExam.medicationhistory;
            break;
        }
        case 3:
        {
            title = eyeExam.occularhostory;
            break;
        }
        case 4:
        {
            title = eyeExam.occularmedication;
            break;
        }
        case 5:
        {
            title = eyeExam.occularsurgery;
            break;
        }
        case 6:
        {
            title = eyeExam.phx_rewhis;
            break;
        }
            break;
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)patientHistoryTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"MHx";
            break;
        }
        case 1:
        {
            title = @"Meds";
            break;
        }
        case 2:
        {
            title = @"Med Sx";
            break;
        }
        case 3:
        {
            title = @"Oc Hx";
            break;
        }
        case 4:
        {
            title = @"Oc Meds";
            break;
        }
        case 5:
        {
            title = @"Oc Sx";
            break;
        }
        case 6:
        {
            title = @"Rew History";
            break;
        }
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}



- (NSString *)reviewSystemValue:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
      /*  case 0:
        {
            title = eyeExam.surgeryhistory;
            break;
        }*/
      /*  case 1:
        {
            title = eyeExam.occularsurgery;
            break;
        }*/
        case 0:
        {
            title = eyeExam.phx_allergy;
            break;
        }
            
            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)reviewSystemTitle:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        /*case 0:
        {
            title = @"Surgery Hx";
            break;
        }*/
        /*case 1:
        {
            title = @"Occular S.";
            break;
        }*/
            
        case 0:
        {
            title = @"Allergy";
            break;
        }
            
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}





- (NSString *)vRXUnaidedActvitiesValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.visrx_unadvart;
            break;
        }
        case 1:
        {
            title = eyeExam.visrx_unadvalt;
            break;
        }
            
        case 2:
        {
            title = eyeExam.visrx_unanvart;
            break;
        }
        case 3:
        {
            title = eyeExam.visrx_unanvalt;
            break;
        }
        case 4:
        {
            title = eyeExam.visrx_unaphrt;
            break;
        }
        case 5:
        {
            title = eyeExam.visrx_unaphlt;
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)vRXUnaidedActvitiesTitleByRow:(NSInteger)row
{
    
    
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"DVA OD";
            break;
        }
        case 1:
        {
            title = @"DVA OS";
            break;
        }
        case 2:
        {
            title = @"NVA OD";
            break;
        }
        case 3:
        {
            title = @"NVA OS";
            break;
        }
        case 4:
        {
            title = @"PH OD";
            break;
        }
        case 5:
        {
            title = @"PH OS";
            break;
        }
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}



- (NSString *)presentSpecRXValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.visrx_psrsph;
            break;
        }
        case 1:
        {
            title = eyeExam.visrx_psrsphlt;
            break;
        }
        case 2:
        {
            title = eyeExam.visrx_psrcycle;
            break;
        }
        case 3:
        {
            title = eyeExam.visrx_psrcyclelt;
            break;
        }
        case 4:
        {
            title = eyeExam.visrx_psraxis;
            break;
        }
        case 5:
        {
            title = eyeExam.visrx_psraxislt;
            break;
        }
        case 6:
        {
            title = eyeExam.visrx_psrhprism;
            break;
        }
        case 7:
        {
            title = eyeExam.visrx_psrhprismlt;
            break;
        }
        case 8:
        {
            title = eyeExam.visrx_psrvprism;
            break;
        }
        case 9:
        {
            title = eyeExam.visrx_psrvprismlt;
            break;
        }
        case 10:
        {
            title = eyeExam.visrx_psradd;
            break;
        }
        case 11:
        {
            title = eyeExam.visrx_psraddlt;
            break;
        }
        case 12:
        {
            title = eyeExam.visrx_psrdna;
            break;
        }
        case 13:
        {
            title = eyeExam.visrx_psrdnalt;
            break;
        }
            
        case 14:
        {
            title = eyeExam.visrx_psrnva;
            break;
        }
        case 15:
        {
            title = eyeExam.visrx_psrnvalt;
            break;
        }
            
        case 16:
        {
            title = eyeExam.visrx_psrphp;
            break;
        }
        case 17:
        {
            title = eyeExam.visrx_psrphplt;
            break;
        }
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)presentSpecRXTitleByRow:(NSInteger)row
{
    
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"SPH OD";
            break;
        }
        case 1:
        {
            title = @"SPH OS";
            break;
        }
        case 2:
        {
            title = @"CYL OD";
            break;
        }
        case 3:
        {
            title = @"CYL OS";
            break;
        }
        case 4:
        {
            title = @"AXIS OD";
            break;
        }
        case 5:
        {
            title = @"AXIS OS";
            break;
        }
        case 6:
        {
            title = @"H PRISM OD";
            break;
        }
        case 7:
        {
            title = @"H PRISM OS";
            break;
        }
        case 8:
        {
            title = @"V PRISM OD";
            break;
        }
        case 9:
        {
            title = @"V PRISM OS";
            break;
        }
        case 10:
        {
            title = @"ADD OD";
            break;
        }
        case 11:
        {
            title = @"ADD OS";
            break;
        }
        case 12:
        {
            title = @"DVA OD";
            break;
        }
        case 13:
        {
            title = @"DVA OS";
            break;
        }
        case 14:
        {
            title = @"NVA OD";
            break;
        }
        case 15:
        {
            title = @"NVA OS";
            break;
        }
            
        case 16:
        {
            title = @"PH OD";
            break;
        }
        case 17:
        {
            title = @"PH OS";
            break;
        }
            
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}







- (NSString *)subjectiveRXValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.visrx_subrxsphrt;
            break;
        }
        case 1:
        {
            title = eyeExam.visrx_subrxsphlt;
            break;
        }
        case 2:
        {
            title = eyeExam.visrx_subrxcycle;
            break;
        }
        case 3:
        {
            title = eyeExam.visrx_subrxcyclelt;
            break;
        }
        case 4:
        {
            title = eyeExam.visrx_subrxaxis;
            break;
        }
        case 5:
        {
            title = eyeExam.visrx_subrxaxislt;
            break;
        }
        case 6:
        {
            title = eyeExam.visrx_subrxhprism;
            break;
        }
        case 7:
        {
            title = eyeExam.visrx_subrxhprisml;
            break;
        }
        case 8:
        {
            title = eyeExam.visrx_subrxvprism;
            break;
        }
        case 9:
        {
            title = eyeExam.visrx_subrxvprisml;
            break;
        }
        case 10:
        {
            title = eyeExam.visrx_subrxadd;
            break;
        }
        case 11:
        {
            title = eyeExam.visrx_subrxaddlt;
            break;
        }
        case 12:
        {
            title = eyeExam.visrx_subrxdva;
            break;
        }
        case 13:
        {
            title = eyeExam.visrx_subrxdvalt;
            break;
        }
        case 14:
        {
            title = eyeExam.visrx_subrxnva;
            break;
        }
        case 15:
        {
            title = eyeExam.visrx_subrxnvalt;
            break;
        }
        case 16:
        {
            title = eyeExam.visrx_subrxph;
            break;
        }
        case 17:
        {
            title = eyeExam.visrx_subrxphlt;
            break;
        }
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)subjectiveRXTitleByRow:(NSInteger)row
{
    
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"SPH OD";
            break;
        }
        case 1:
        {
            title = @"SPH OS";
            break;
        }
        case 2:
        {
            title = @"CYL OD";
            break;
        }
        case 3:
        {
            title = @"CYL OS";
            break;
        }
        case 4:
        {
            title = @"AXIS OD";
            break;
        }
        case 5:
        {
            title = @"AXIS OS";
            break;
        }
        case 6:
        {
            title = @"H PRISM OD";
            break;
        }
        case 7:
        {
            title = @"H PRISM OS";
            break;
        }
        case 8:
        {
            title = @"V PRISM OD";
            break;
        }
        case 9:
        {
            title = @"V PRISM OS";
            break;
        }
        case 10:
        {
            title = @"ADD OD";
            break;
        }
        case 11:
        {
            title = @"ADD OS";
            break;
        }
            
        case 12:
        {
            title = @"DVA OD";
            break;
        }
        case 13:
        {
            title = @"DVA OS";
            break;
        }
        case 14:
        {
            title = @"NVA OD";
            break;
        }
        case 15:
        {
            title = @"NVA OS";
            break;
        }
        case 16:
        {
            title = @"PH OD";
            break;
        }
        case 17:
        {
            title = @"PH OS";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}




- (NSString *)finalSpecRXValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.visrx_fspecsph;
            break;
        }
        case 1:
        {
            title = eyeExam.visrx_fspecsphlt;
            break;
        }
        case 2:
        {
            title = eyeExam.visrx_fspeccycle;
            break;
        }
        case 3:
        {
            title = eyeExam.visrx_fspeccyclelt;
            break;
        }
        case 4:
        {
            title = eyeExam.visrx_fspecaxis;
            break;
        }
        case 5:
        {
            title = eyeExam.visrx_fspecaxislt;
            break;
        }
        case 6:
        {
            title = eyeExam.visrx_fspechprism;
            break;
        }
        case 7:
        {
            title = eyeExam.visrx_fspechprisml;
            break;
        }
        case 8:
        {
            title = eyeExam.visrx_fspecvprism;
            break;
        }
        case 9:
        {
            title = eyeExam.visrx_fspecvprisml;
            break;
        }
        case 10:
        {
            title = eyeExam.visrx_fspecadd;
            break;
        }
        case 11:
        {
            title = eyeExam.visrx_fspecaddlt;
            break;
        }
        case 12:
        {
            title = eyeExam.visrx_fspecdva;
            break;
        }
        case 13:
        {
            title = eyeExam.visrx_fspecdvalt;
            break;
        }
            
        case 14:
        {
            title = eyeExam.visrx_fspecnva;
            break;
        }
        case 15:
        {
            title = eyeExam.visrx_fspecnvalt;
            break;
        }
            
        case 16:
        {
            title = eyeExam.visrx_fspecph;
            break;
        }
        case 17:
        {
            title = eyeExam.visrx_fspecphlt;
            break;
        }
            /*case 20:
             {
             title = eyeExam.visrx_fspecphbi;
             break;
             }
             case 21:
             {
             title = eyeExam.visrx_fspecrxdate;
             break;
             }
             case 22:
             {
             title = eyeExam.visrx_fspecexdate;
             break;
             }*/
            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}






- (NSString *)finalSpecRXTitleByRow:(NSInteger)row
{
    
    
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"SPH OD";
            break;
        }
        case 1:
        {
            title = @"SPH OS";
            break;
        }
        case 2:
        {
            title = @"CYL OD";
            break;
        }
        case 3:
        {
            title = @"CYL OS";
            break;
        }
        case 4:
        {
            title = @"AXIS OD";
            break;
        }
        case 5:
        {
            title = @"AXIS OS";
            break;
        }
        case 6:
        {
            title = @"H PRISM OD";
            break;
        }
        case 7:
        {
            title = @"H PRISM OS";
            break;
        }
        case 8:
        {
            title = @"V PRISM OD";
            break;
        }
        case 9:
        {
            title = @"V PRISM OS";
            break;
        }
        case 10:
        {
            title = @"ADD OD";
            break;
        }
        case 11:
        {
            title = @"ADD OS";
            break;
        }
        case 12:
        {
            title = @"DVA OD";
            break;
        }
        case 13:
        {
            title = @"DVA OS";
            break;
        }
        case 14:
        {
            title = @"NVA OD";
            break;
        }
            
        case 15:
        {
            title = @"NVA OS";
            break;
        }
            
        case 16:
        {
            title = @"PH OD";
            break;
        }
        case 17:
        {
            title = @"PH OS";
            break;
        }
            /*case 20:
             {
             title = @"PH BI";
             break;
             }
             case 21:
             {
             title = @"RX DATE";
             break;
             }
             case 22:
             {
             title = @"EXP DATE";
             break;
             }
             */
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}




- (NSString *)objectRXValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.visrx_autorefracti;
            break;
        }
        case 1:
        {
            title = eyeExam.visrx_retinoscopy;
            break;
        }
            
            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)objectRXTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Auto Refraction";
            break;
        }
        case 1:
        {
            title = @"Retinoscopy";
            break;
        }
            
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}








- (NSString *)examValueCDRatioValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.exam_crdgorxrt;
            break;
        }
        case 1:
        {
            title = eyeExam.exam_crdverrt;
            break;
        }
        case 2:
        {
            title = eyeExam.exam_crdgorxlt;
            break;
        }
        case 3:
        {
            title = eyeExam.exam_crdverlt;
            break;
        }
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)examValueCDRatioTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"RT HORZ";
            break;
        }
        case 1:
        {
            title = @"RT VERT";
            break;
        }
        case 2:
        {
            title = @"LT HORZ";
            break;
        }
        case 3:
        {
            title = @"LT VERT";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}






- (NSString *)examValueOtherValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.examiopod;
            break;
        }
        case 1:
        {
            title = eyeExam.examiopos;
            break;
        }
        case 2:
        {
            title = eyeExam.exampachod;
            break;
        }
        case 3:
        {
            title = eyeExam.exampachos;
            break;
        }
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)examValueOtherTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"IOP OD";
            break;
        }
        case 1:
        {
            title = @"IOP OS";
            break;
        }
        case 2:
        {
            title = @"Pachymetry OD";
            break;
        }
        case 3:
        {
            title = @"Pachymetry OS";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}







- (NSString *)examExamValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
            
        /*case 0:
        {
            title = eyeExam.exam_slitexam;
            break;
        }*/
        case 0:
        {
            title = eyeExam.examlidslashes;
            break;
        }
        case 1:
        {
            title = eyeExam.exam_conjuctiva;
            break;
        }
        case 2:
        {
            title = eyeExam.examcornea;
            break;
        }
        case 3:
        {
            title = eyeExam.examlens;
            break;
        }
        case 4:
        {
            title = eyeExam.examac;
            break;
        }
        case 5:
        {
            title = eyeExam.examiris;
            break;
        }
        case 6:
        {
            title = eyeExam.exmpupil;
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)examExamTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
            
       /* case 0:
        {
            title = @"SLIT";
            break;
        }*/
        case 0:
        {
            title = @"Lids/Lashes";
            break;
        }
        case 1:
        {
            title = @"Conjuctiva";
            break;
        }
        case 2:
        {
            title = @"Cornea";
            break;
        }
        case 3:
        {
            title = @"Lens";
            break;
        }
        case 4:
        {
            title = @"A/C";
            break;
        }
        case 5:
        {
            title = @"Iris";
            break;
        }
        case 6:
        {
            title = @"Pupils";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}








- (NSString *)surgeryAssesValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.assesmentvisiorrx;
            break;
        }
        case 1:
        {
            title = eyeExam.assesmentslit;
            break;
        }
        case 2:
        {
            title = eyeExam.assesmentretina;
            break;
        }

            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)surgeryAssesTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Vision RX";
            break;
        }
        case 1:
        {
            title = @"Slit Lamp";
            break;
        }
        case 2:
        {
            title = @"Retina";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}





- (NSString *)planValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.planvisionrrx;
            break;
        }
        case 1:
        {
            title = eyeExam.planslit;
            break;
        }
        case 2:
        {
            title = eyeExam.planretina;
            break;
        }
            
            
            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)planTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Vision RX";
            break;
        }
        case 1:
        {
            title = @"Slit Lamp";
            break;
        }
        case 2:
        {
            title = @"Retina";
            break;
        }
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}




- (NSString *)patientManValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.vsurgery_pmconsel;
            break;
        }
            
            
        default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)patientManTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Education";
            break;
        }
            
            
        default:
        {
            title = @"";
            break;
        }
    }
    
    return title;
}




- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        eyeExam.cc_examination = textField.text;
        
    } else  if (textField.tag == 101) {
        eyeExam.cc_examtechnician = textField.text;
    } else  if (textField.tag == 200) {
        eyeExam.cc_chiefcompliant = textField.text;
    } else  if (textField.tag == 300) {
        eyeExam.cc_hpivision = textField.text;
    } else  if (textField.tag == 301) {
        eyeExam.cc_hpioccular = textField.text;
    } else  if (textField.tag == 400) {
        eyeExam.phx_patienthostiry = textField.text;
    } else  if (textField.tag == 401) {
        eyeExam.phx_occularmed = textField.text;
    } else  if (textField.tag == 402) {
        eyeExam.phx_sysmed = textField.text;
    } else  if (textField.tag == 403) {
        eyeExam.phx_sochis = textField.text;
    } else  if (textField.tag == 404) {
        eyeExam.phx_rewhis = textField.text;
    } else  if (textField.tag == 500) {
        eyeExam.phx_allergy = textField.text;
    } else  if (textField.tag == 600) {
        eyeExam.visrx_unadvart = textField.text;
    } else  if (textField.tag == 601) {
        eyeExam.visrx_unadvalt = textField.text;
    } else  if (textField.tag == 602) {
        eyeExam.visrx_unadvabi = textField.text;
    } else  if (textField.tag == 603) {
        eyeExam.visrx_unanvart = textField.text;
    } else  if (textField.tag == 604) {
        eyeExam.visrx_unanvalt = textField.text;
    } else  if (textField.tag == 605) {
        eyeExam.visrx_unanvabi = textField.text;
    } else  if (textField.tag == 606) {
        eyeExam.visrx_unaphrt = textField.text;
    } else  if (textField.tag == 607) {
        eyeExam.visrx_unaphlt = textField.text;
    } else  if (textField.tag == 608) {
        eyeExam.visrx_unaphbi = textField.text;
    } else  if (textField.tag == 700) {
        eyeExam.visrx_psrsph = textField.text;
    } else  if (textField.tag == 701) {
        eyeExam.visrx_psrsphlt = textField.text;
    } else  if (textField.tag == 702) {
        eyeExam.visrx_psrcycle = textField.text;
    } else  if (textField.tag == 703) {
        eyeExam.visrx_psrcyclelt = textField.text;
    } else  if (textField.tag == 704) {
        eyeExam.visrx_psraxis = textField.text;
    } else  if (textField.tag == 705) {
        eyeExam.visrx_psraxislt = textField.text;
    } else  if (textField.tag == 706) {
        eyeExam.visrx_psrhprism = textField.text;
    } else  if (textField.tag == 707) {
        eyeExam.visrx_psrhprismlt = textField.text;
    } else  if (textField.tag == 708) {
        eyeExam.visrx_psrvprism = textField.text;
    } else  if (textField.tag == 709) {
        eyeExam.visrx_psrvprismlt = textField.text;
    } else  if (textField.tag == 710) {
        eyeExam.visrx_psradd = textField.text;
    } else  if (textField.tag == 711) {
        eyeExam.visrx_psraddlt = textField.text;
    } else  if (textField.tag == 712) {
        eyeExam.visrx_psrdna = textField.text;
    } else  if (textField.tag == 713) {
        eyeExam.visrx_psrdnalt = textField.text;
    } else  if (textField.tag == 714) {
        eyeExam.visrx_psrdnabi = textField.text;
    } else  if (textField.tag == 715) {
        eyeExam.visrx_psrnva = textField.text;
    } else  if (textField.tag == 716) {
        eyeExam.visrx_psrnvalt = textField.text;
    } else  if (textField.tag == 717) {
        eyeExam.visrx_psrnvabi = textField.text;
    } else  if (textField.tag == 718) {
        eyeExam.visrx_psrphp = textField.text;
    } else  if (textField.tag == 719) {
        eyeExam.visrx_psrphplt = textField.text;
    } else  if (textField.tag == 720) {
        eyeExam.visrx_psrphpbi = textField.text;
    } else  if (textField.tag == 721) {
        eyeExam.visrx_psrprxdate = textField.text;
    } else  if (textField.tag == 800) {
        eyeExam.visrx_subrxsphrt = textField.text;
    } else  if (textField.tag == 801) {
        eyeExam.visrx_subrxsphlt = textField.text;
    } else  if (textField.tag == 802) {
        eyeExam.visrx_subrxcycle = textField.text;
    } else  if (textField.tag == 803) {
        eyeExam.visrx_subrxcyclelt= textField.text;
    } else  if (textField.tag == 804) {
        eyeExam.visrx_subrxaxis = textField.text;
    } else  if (textField.tag == 805) {
        eyeExam.visrx_subrxaxislt = textField.text;
    } else  if (textField.tag == 806) {
        eyeExam.visrx_subrxhprism = textField.text;
    } else  if (textField.tag == 807) {
        eyeExam.visrx_subrxhprisml = textField.text;
    } else  if (textField.tag == 808) {
        eyeExam.visrx_subrxvprism = textField.text;
    } else  if (textField.tag == 809) {
        eyeExam.visrx_subrxvprisml = textField.text;
    } else  if (textField.tag == 810) {
        eyeExam.visrx_subrxadd = textField.text;
    } else  if (textField.tag == 810) {
        eyeExam.visrx_subrxaddlt = textField.text;
    } else  if (textField.tag == 811) {
        eyeExam.visrx_subrxdva= textField.text;
    } else  if (textField.tag == 812) {
        eyeExam.visrx_subrxdvalt = textField.text;
    } else  if (textField.tag == 813) {
        eyeExam.visrx_subrxnva = textField.text;
    } else  if (textField.tag == 814) {
        eyeExam.visrx_subrxnvalt = textField.text;
    } else  if (textField.tag == 815) {
        eyeExam.visrx_subrxph = textField.text;
    } else  if (textField.tag == 817) {
        eyeExam.visrx_subrxphlt = textField.text;
    } else  if (textField.tag == 900) {
        eyeExam.visrx_fspecsph = textField.text;
    } else  if (textField.tag == 901) {
        eyeExam.visrx_fspecsphlt = textField.text;
    } else  if (textField.tag == 902) {
        eyeExam.visrx_fspeccycle = textField.text;
    } else  if (textField.tag == 903) {
        eyeExam.visrx_fspeccyclelt = textField.text;
    } else  if (textField.tag == 904) {
        eyeExam.visrx_fspecaxis = textField.text;
    } else  if (textField.tag == 905) {
        eyeExam.visrx_fspecaxislt = textField.text;
    } else  if (textField.tag == 906) {
        eyeExam.visrx_fspechprism = textField.text;
    } else  if (textField.tag == 907) {
        eyeExam.visrx_fspechprisml = textField.text;
    } else  if (textField.tag == 908) {
        eyeExam.visrx_fspecvprism = textField.text;
    } else  if (textField.tag == 909) {
        eyeExam.visrx_fspecvprisml = textField.text;
    } else  if (textField.tag == 910) {
        eyeExam.visrx_fspecadd = textField.text;
    } else  if (textField.tag == 911) {
        eyeExam.visrx_fspecaddlt = textField.text;
    } else  if (textField.tag == 912) {
        eyeExam.visrx_fspecdva = textField.text;
    } else  if (textField.tag == 913) {
        eyeExam.visrx_fspecdvalt = textField.text;
    } else  if (textField.tag == 914) {
        eyeExam.visrx_fspecdvabi = textField.text;
    } else  if (textField.tag == 915) {
        eyeExam.visrx_fspecnva = textField.text;
    } else  if (textField.tag == 916) {
        eyeExam.visrx_fspecnvalt = textField.text;
    } else  if (textField.tag == 917) {
        eyeExam.visrx_fspecnvabi = textField.text;
    } else  if (textField.tag == 918) {
        eyeExam.visrx_fspecph = textField.text;
    } else  if (textField.tag == 919) {
        eyeExam.visrx_fspecphlt = textField.text;
    } else  if (textField.tag == 920) {
        eyeExam.visrx_fspecphbi = textField.text;
    } else  if (textField.tag == 921) {
        eyeExam.visrx_fspecrxdate = textField.text;
    } else  if (textField.tag == 922) {
        eyeExam.visrx_fspecexdate = textField.text;
    }
    else  if (textField.tag == 1000) {
        eyeExam.exam_crdgorxrt = textField.text;
    } else  if (textField.tag == 1001) {
        eyeExam.exam_crdverrt = textField.text;
    } else  if (textField.tag == 1002) {
        eyeExam.exam_crdgorxlt = textField.text;
    } else  if (textField.tag == 1003) {
        eyeExam.exam_crdverlt = textField.text;
    }
    else  if (textField.tag == 1100) {
        eyeExam.exam_exexam = textField.text;
    } else  if (textField.tag == 1101) {
        eyeExam.exam_slitexam = textField.text;
    } else  if (textField.tag == 1102) {
        eyeExam.exam_conjuctiva = textField.text;
    }
    else  if (textField.tag == 1200) {
        eyeExam.vsurgery_impressco = textField.text;
    } else  if (textField.tag == 1201) {
        eyeExam.vsurgery_imprerefr = textField.text;
    } else  if (textField.tag == 1300) {
        eyeExam.vsurgery_trx = textField.text;
    } else  if (textField.tag == 1301) {
        eyeExam.vsurgery_tcon = textField.text;
    }
    else  if (textField.tag == 1400) {
        eyeExam.vsurgery_pmconsel = textField.text;
    }
    [self.tableView reloadData];
    
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (catType == 2) {
        if (indexPath.section == 0) {
            if (unaidedSelect == true) {
                unaidedSelect = false;
            } else {
                unaidedSelect = true;
            }
        } else if (indexPath.section == 1) {
            if (presentingSelect == true) {
                presentingSelect = false;
            } else {
                presentingSelect = true;
            }
        } else if (indexPath.section == 2) {
            if (minfestSelect == true) {
                minfestSelect= false;
            } else {
                minfestSelect = true;
            }
        } else if (indexPath.section ==3) {
            if (cycloplegicSelect == true) {
                cycloplegicSelect= false;
            } else {
                cycloplegicSelect = true;
            }
        }
        
        [self.tableView reloadData];
        
    } else if (catType == 3) {
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                
                AmslerGridViewController  *vc = (AmslerGridViewController  *)[sb instantiateViewControllerWithIdentifier:@"AmslerGridViewController"];
                vc.gridType = 1;
                vc.isEnabled = true;
                vc.dataString = eyeExam.amslergridrt;
                //vc.delegate = self;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            } else if (indexPath.row == 1) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                
                AmslerGridViewController  *vc = (AmslerGridViewController  *)[sb instantiateViewControllerWithIdentifier:@"AmslerGridViewController"];
                vc.gridType = 2;
                vc.isEnabled = false;
                vc.dataString = eyeExam.amslergridlt;
                //vc.delegate = self;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        } else if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                
                AmslerGridViewController  *vc = (AmslerGridViewController  *)[sb instantiateViewControllerWithIdentifier:@"AmslerGridViewController"];
                vc.gridType = 3;
                vc.isEnabled = false;
                vc.dataString = eyeExam.concentrationrt;
                //vc.delegate = self;
                
                [self.navigationController pushViewController:vc animated:YES];
            } else if (indexPath.row == 1) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                
                AmslerGridViewController  *vc = (AmslerGridViewController  *)[sb instantiateViewControllerWithIdentifier:@"AmslerGridViewController"];
                vc.gridType = 4;
                vc.isEnabled = false;
                vc.dataString = eyeExam.concentrationlt;
                //vc.delegate = self;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([bottomTab.items objectAtIndex:0] == item) {
        catType = 0;
        [tableView reloadData];
        
    } else if ([bottomTab.items objectAtIndex:1] == item) {
        catType = 1;
        [tableView reloadData];
        
    } else if ([bottomTab.items objectAtIndex:2] == item) {
        catType = 2;
        [tableView reloadData];
        
    } else if ([bottomTab.items objectAtIndex:3] == item) {
        catType = 3;
        [tableView reloadData];
        
    } else if ([bottomTab.items objectAtIndex:4] == item) {
        catType = 4;
        [tableView reloadData];
        
    } else if ([bottomTab.items objectAtIndex:5] == item) {
        catType = 5;
        [tableView reloadData];
        
    }
    
}

@end
