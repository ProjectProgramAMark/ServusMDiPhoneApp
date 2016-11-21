//
//  EyeExamViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 9/5/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "EyeExamViewController.h"

@interface EyeExamViewController ()

@end

@implementation EyeExamViewController


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
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                  target:self
                                  action:@selector(addEyeExam:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    
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
   // return 10;
    if (catType == 0) {
        return 2;
    } else if (catType == 1) {
        return 2;
    } else if (catType == 2) {
        return 2;
    }  else if (catType == 3) {
        return 1;
    }  else if (catType == 4) {
        return 1;
    }  else if (catType == 5) {
        return 2;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNumber = 0;
    
    
    if (catType == 0) {
        rowNumber = 8;
    } else if (catType == 1) {
        rowNumber = 10;
    } else if (catType == 2) {
        rowNumber = 5;
    } else if (catType == 3) {
        rowNumber = 11;
    } else if (catType == 4) {
        rowNumber = 8;
        
    } else if (catType == 5) {
        
        if (section == 0) {
            rowNumber = 3;
        } else if (section == 1) {
            rowNumber = 5;
        }
    }
    
    /*switch (section)
    {
            
        case 0:
        {
            rowNumber = 8;
            break;
        }
        case 1:
        {
            rowNumber = 8;
            break;
        }
        case 2:
        {
            rowNumber = 10;
            break;
        }
        case 3:
        {
            rowNumber = 10;
            break;
        }
        case 4:
        {
            rowNumber = 5;
            break;
        }
        case 5:
        {
            rowNumber = 5;
            break;
        }
        case 6:
        {
            rowNumber = 11;
            break;
        }
        case 7:
        {
            rowNumber = 8;
            break;
        }
        case 8:
        {
            rowNumber = 3;
            break;
        }
        case 9:
        {
            rowNumber = 5;
            break;
        }
        default:
        {
            rowNumber = 8;
            break;
        }
    }
    */
    
    
    return rowNumber;
}



#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    
    if (catType == 0) {
        if (section == 0) {
            title = @"OD Anterior";
        } else if (section == 1) {
            title = @"OS Anterior";
        }
    } else if (catType == 1) {
        if (section == 0) {
            title = @"OD Posterior";
        } else if (section == 1) {
            title = @"OS Posterior";
        }
    } else if (catType == 2) {
        if (section == 0) {
            title = @"Glasses RX";
        } else if (section == 1) {
            title = @"Glasses RX 2";
        }
    } else if (catType == 3) {
        title = @"Contacts RX";
    } else if (catType == 4) {
        title = @"Additional Testing";
        
    } else if (catType == 5) {
        
        if (section == 0) {
            title = @"Recommendations";
        } else if (section == 1) {
            title = @"Other";
        }
    }
    
   /* switch (section)
    {
            
        case 0:
        {
            title = @"OD Anterior";
            break;
        }
        case 1:
        {
            title = @"OS Anterior";
            break;
        }
        case 2:
        {
            title = @"OD Posterior";
            break;
        }
        case 3:
        {
            title = @"OS Posterior";
            break;
        }
        case 4:
        {
            title = @"Glasses RX";
            break;
        }
        case 5:
        {
            title = @"Glasses RX 2";
            break;
        }
        case 6:
        {
            title = @"Contacts RX";
            break;
        }
        case 7:
        {
            title = @"Additional Testing";
            break;
        }
        case 8:
        {
            title = @"Recommendations";
            break;
        }
        case 9:
        {
            title = @"Other";
            break;
        }
        default:
        {
            title = @"";
            break;
        }
    }*/
    return title;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAboutCellID];
     PatientRecordAboutCell    *cell = (PatientRecordAboutCell *)[tableView dequeueReusableCellWithIdentifier:kAboutCellID];
    
    cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
    cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
    
     cell.clipsToBounds = YES;
    
    if (catType == 0) {
        if (indexPath.section == 0) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self odAnteriorTitleByRow:indexPath.row], [self odAnteriorValueByRow:indexPath.row]];
        } else if (indexPath.section == 1) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self oSAnteriorTitleByRow:indexPath.row], [self oSAnteriorValueByRow:indexPath.row]];
        }
    } else if (catType == 1) {
        if (indexPath.section == 0) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self odPosteriorTitleByRow:indexPath.row], [self odPosteriorValueByRow:indexPath.row]];
        } else if (indexPath.section == 1) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self oSPosteriorTitleByRow:indexPath.row], [self oSPosteriorValueByRow:indexPath.row]];
        }
    } else if (catType == 2) {
        if (indexPath.section == 0) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self glassRX1TitleByRow:indexPath.row], [self glassRX1ValueByRow:indexPath.row]];
        } else if (indexPath.section == 1) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self glassRX2TitleByRow:indexPath.row], [self glassRX2ValueByRow:indexPath.row]];
        }
    } else if (catType == 3) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self contactsRXTitleByRow:indexPath.row], [self contactsRXValueByRow:indexPath.row]];
    } else if (catType == 4) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self additionalTestingTitleByRow:indexPath.row], [self additionalTestingValueByRow:indexPath.row]];
        
    } else if (catType == 5) {
        
        if (indexPath.section == 0) {
            cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self reccomendTitleByRow:indexPath.row], [self reccomendValueByRow:indexPath.row]];
            
        } else if (indexPath.section == 1) {
           cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self otherTitleByRow:indexPath.row], [self otherValueByRow:indexPath.row]];
        }
    }
    
   /* if (indexPath.section == 0) {
        
      
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self odAnteriorTitleByRow:indexPath.row], [self odAnteriorValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        
        
    } else  if (indexPath.section == 1) {
        
        
        
        
       
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self oSAnteriorTitleByRow:indexPath.row], [self oSAnteriorValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        
    } else  if (indexPath.section == 2) {
        
        
        
        
        //  cell.valueLabel.text = [self odPosteriorTitleByRow:indexPath.row];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self odPosteriorTitleByRow:indexPath.row], [self odPosteriorValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        
        
        
    } else  if (indexPath.section == 3) {
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self oSPosteriorTitleByRow:indexPath.row], [self oSPosteriorValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        
    } else  if (indexPath.section == 4) {
        
        
       
        
       
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self glassRX1TitleByRow:indexPath.row], [self glassRX1ValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        
        
    }else  if (indexPath.section == 5) {
        
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self glassRX2TitleByRow:indexPath.row], [self glassRX2ValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        
        
    }else  if (indexPath.section == 6) {
        
        
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self contactsRXTitleByRow:indexPath.row], [self contactsRXValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        
        
    } else  if (indexPath.section == 7) {
        
        
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self additionalTestingTitleByRow:indexPath.row], [self additionalTestingValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        
        
    } else  if (indexPath.section == 8) {
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self reccomendTitleByRow:indexPath.row], [self reccomendValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        
    } else  if (indexPath.section == 9) {
        
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@",[self otherTitleByRow:indexPath.row], [self otherValueByRow:indexPath.row]];
        
        cell.cellImageView.image = [UIImage imageNamed:@"eye-iconExam"];
        cell.nameLabel.textColor = [UIColor colorWithRed:129.0f/255.0f green:198.0f/255.0f blue:216.0f/255.0f alpha:1.0f];
        
        cell.clipsToBounds = YES;
        //  cell.valueLabel.text = [self otherTitleByRow:indexPath.row];
    }
    */
    
    /*if (cell.valueLabel.tag == 100) {
     eyeExam.odan_lidslashes = cell.valueLabel.text;
     
     } else  if (cell.valueLabel.tag == 101) {
     eyeExam.odan_conjuctiva = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 102) {
     eyeExam.odan_sclera = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 103) {
     eyeExam.odan_angles = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 104) {
     eyeExam.odan_cornea = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 105) {
     eyeExam.odan_iris = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 106) {
     eyeExam.odan_ac = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 107) {
     eyeExam.odan_lens = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 200) {
     eyeExam.osan_lids = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 201) {
     eyeExam.osan_conjuctiva = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 202) {
     eyeExam.osan_sclera = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 203) {
     eyeExam.osan_angles = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 204) {
     eyeExam.osan_cornea = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 205) {
     eyeExam.osan_iris = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 206) {
     eyeExam.osan_ac = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 207) {
     eyeExam.osan_lens = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 300) {
     eyeExam.odpos_media = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 301) {
     eyeExam.odpos_cs = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 302) {
     eyeExam.odpos_shape = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 303) {
     eyeExam.odpost_rim = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 304) {
     eyeExam.odpos_vp = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 305) {
     eyeExam.odpos_postpole = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 306) {
     eyeExam.odpos_av = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 307) {
     eyeExam.odpos_alr = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 308) {
     eyeExam.odpos_macula = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 309) {
     eyeExam.odpos_periphery = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 400) {
     eyeExam.ospos_media = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 401) {
     eyeExam.ospos_cs = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 402) {
     eyeExam.ospos_shape = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 403) {
     eyeExam.ospost_rim = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 404) {
     eyeExam.ospos_vp = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 405) {
     eyeExam.ospos_postpole = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 406) {
     eyeExam.ospos_av = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 407) {
     eyeExam.ospos_alr = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 408) {
     eyeExam.ospos_macula = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 409) {
     eyeExam.ospos_periphery = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 500) {
     eyeExam.glassrx_type = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 501) {
     eyeExam.glassrx_od = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 502) {
     eyeExam.glassrx_os = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 503) {
     eyeExam.glassrx_prism = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 504) {
     eyeExam.glassrx_add = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 600) {
     eyeExam.glassrx2_type = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 601) {
     eyeExam.glassrx2_od = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 602) {
     eyeExam.glassrx2_os = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 603) {
     eyeExam.glassrx2_prism = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 604) {
     eyeExam.glassrx2_add = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 700) {
     eyeExam.contactsrx_type = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 701) {
     eyeExam.contactsrx_od = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 702) {
     eyeExam.contactsrx_os = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 703) {
     eyeExam.contactsrx_bc = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 704) {
     eyeExam.contactsrx_diam = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 705) {
     eyeExam.contactsrx_brand = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 706) {
     eyeExam.contactsrx_wt = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 707) {
     eyeExam.contactsrx_color = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 708) {
     eyeExam.contactsrx_solution = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 709) {
     eyeExam.contactsrx_enzyme = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 710) {
     eyeExam.contactsrx_amount = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 800) {
     eyeExam.adtest_topography = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 801) {
     eyeExam.adtest_cycloplegia = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 802) {
     eyeExam.adtest_tonometry = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 803) {
     eyeExam.adtest_fields = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 804) {
     eyeExam.adtest_retinal = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 805) {
     eyeExam.adtest_clcheck = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 806) {
     eyeExam.adtest_medfollow = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 807) {
     eyeExam.adtest_exam = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 900) {
     eyeExam.rec_hindex = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 901) {
     eyeExam.rec_bfcal = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 902) {
     eyeExam.rec_progressive= cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 1000) {
     eyeExam.assesment = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 1001) {
     eyeExam.additionalintructi = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 1002) {
     eyeExam.corrospondence = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 1003) {
     eyeExam.copychart = cell.valueLabel.text;
     } else  if (cell.valueLabel.tag == 1004) {
     eyeExam.od = cell.valueLabel.text;
     }
     
     */
    
    
    return cell;
    
}




- (NSString *)odAnteriorValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.odan_lidslashes;
            break;
        }
        case 1:
        {
            title = eyeExam.odan_conjuctiva;
            break;
        }
        case 2:
        {
            title = eyeExam.odan_sclera;
            break;
        }
        case 3:
        {
            title = eyeExam.odan_angles;
            break;
        }
        case 4:
        {
            title = eyeExam.odan_cornea;
            break;
        }
        case 5:
        {
            title = eyeExam.odan_iris;
            break;
        }
        case 6:
        {
            title = eyeExam.odan_ac;
            break;
        }
        case 7:
        {
            title = eyeExam.odan_lens;
            break;
        }default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)odAnteriorTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
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
            title = @"Sclera";
            break;
        }
        case 3:
        {
            title = @"Angles";
            break;
        }
        case 4:
        {
            title = @"Cornea";
            break;
        }
        case 5:
        {
            title = @"Iris/Pupil";
            break;
        }
        case 6:
        {
            title = @"A/C";
            break;
        }
        case 7:
        {
            title = @"Lens/Media";
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





- (NSString *)oSAnteriorValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.osan_lids;
            break;
        }
        case 1:
        {
            title = eyeExam.osan_conjuctiva;
            break;
        }
        case 2:
        {
            title = eyeExam.osan_sclera;
            break;
        }
        case 3:
        {
            title = eyeExam.osan_angles;
            break;
        }
        case 4:
        {
            title = eyeExam.osan_cornea;
            break;
        }
        case 5:
        {
            title = eyeExam.osan_iris;
            break;
        }
        case 6:
        {
            title = eyeExam.osan_ac;
            break;
        }
        case 7:
        {
            title = eyeExam.osan_lens;
            break;
        }default:
        {
            title = @"";
            break;
        }
            
            
    }
    
    return title;
}

- (NSString *)oSAnteriorTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
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
            title = @"Sclera";
            break;
        }
        case 3:
        {
            title = @"Angles";
            break;
        }
        case 4:
        {
            title = @"Cornea";
            break;
        }
        case 5:
        {
            title = @"Iris/Pupil";
            break;
        }
        case 6:
        {
            title = @"A/C";
            break;
        }
        case 7:
        {
            title = @"Lens/Media";
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




- (NSString *)odPosteriorValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.odpos_media;
            break;
        }
        case 1:
        {
            title = eyeExam.odpos_cs;
            break;
        }
        case 2:
        {
            title = eyeExam.odpos_shape;
            break;
        }
        case 3:
        {
            title = eyeExam.odpost_rim;
            break;
        }
        case 4:
        {
            title = eyeExam.odpos_vp;
            break;
        }
        case 5:
        {
            title = eyeExam.odpos_postpole;
            break;
        }
        case 6:
        {
            title = eyeExam.odpos_av;
            break;
        }
        case 7:
        {
            title = eyeExam.odpos_alr;
            break;
        }
        case 8:
        {
            title = eyeExam.odpos_macula;
            break;
        }
        case 9:
        {
            title = eyeExam.odpos_periphery;
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

- (NSString *)odPosteriorTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Media";
            break;
        }
        case 1:
        {
            title = @"C/D's";
            break;
        }
        case 2:
        {
            title = @"Shape/Type";
            break;
        }
        case 3:
        {
            title = @"Rim Tissue";
            break;
        }
        case 4:
        {
            title = @"VP";
            break;
        }
        case 5:
        {
            title = @"Post. Pole";
            break;
        }
        case 6:
        {
            title = @"A/V";
            break;
        }
        case 7:
        {
            title = @"ALR";
            break;
        }
        case 8:
        {
            title = @"Macula/FLR";
            break;
        }
        case 9:
        {
            title = @"Periphery";
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



- (NSString *)oSPosteriorValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.ospos_media;
            break;
        }
        case 1:
        {
            title = eyeExam.ospos_cs;
            break;
        }
        case 2:
        {
            title = eyeExam.ospos_shape;
            break;
        }
        case 3:
        {
            title = eyeExam.ospost_rim;
            break;
        }
        case 4:
        {
            title = eyeExam.ospos_vp;
            break;
        }
        case 5:
        {
            title = eyeExam.ospos_postpole;
            break;
        }
        case 6:
        {
            title = eyeExam.ospos_av;
            break;
        }
        case 7:
        {
            title = eyeExam.ospos_alr;
            break;
        }
        case 8:
        {
            title = eyeExam.ospos_macula;
            break;
        }
        case 9:
        {
            title = eyeExam.ospos_periphery;
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

- (NSString *)oSPosteriorTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Media";
            break;
        }
        case 1:
        {
            title = @"C/D's";
            break;
        }
        case 2:
        {
            title = @"Shape/Type";
            break;
        }
        case 3:
        {
            title = @"Rim Tissue";
            break;
        }
        case 4:
        {
            title = @"VP";
            break;
        }
        case 5:
        {
            title = @"Post. Pole";
            break;
        }
        case 6:
        {
            title = @"A/V";
            break;
        }
        case 7:
        {
            title = @"ALR";
            break;
        }
        case 8:
        {
            title = @"Macula/FLR";
            break;
        }
        case 9:
        {
            title = @"Periphery";
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







- (NSString *)glassRX1ValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.glassrx_type;
            break;
        }
        case 1:
        {
            title = eyeExam.glassrx_od;
            break;
        }
        case 2:
        {
            title = eyeExam.glassrx_os;
            break;
        }
        case 3:
        {
            title = eyeExam.glassrx_prism;
            break;
        }
        case 4:
        {
            title = eyeExam.glassrx_add;
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

- (NSString *)glassRX1TitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Type";
            break;
        }
        case 1:
        {
            title = @"OD";
            break;
        }
        case 2:
        {
            title = @"OS";
            break;
        }
        case 3:
        {
            title = @"Prism";
            break;
        }
        case 4:
        {
            title = @"Add";
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




- (NSString *)glassRX2ValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.glassrx2_type;
            break;
        }
        case 1:
        {
            title = eyeExam.glassrx2_od;
            break;
        }
        case 2:
        {
            title = eyeExam.glassrx2_os;
            break;
        }
        case 3:
        {
            title = eyeExam.glassrx2_prism;
            break;
        }
        case 4:
        {
            title = eyeExam.glassrx2_add;
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

- (NSString *)glassRX2TitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Type";
            break;
        }
        case 1:
        {
            title = @"OD";
            break;
        }
        case 2:
        {
            title = @"OS";
            break;
        }
        case 3:
        {
            title = @"Prism";
            break;
        }
        case 4:
        {
            title = @"Add";
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







- (NSString *)contactsRXValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.contactsrx_type;
            break;
        }
        case 1:
        {
            title = eyeExam.contactsrx_od;
            break;
        }
        case 2:
        {
            title = eyeExam.contactsrx_os;
            break;
        }
        case 3:
        {
            title = eyeExam.contactsrx_bc;
            break;
        }
        case 4:
        {
            title = eyeExam.contactsrx_diam;
            break;
        }
        case 5:
        {
            title = eyeExam.contactsrx_brand;
            break;
        }
        case 6:
        {
            title = eyeExam.contactsrx_wt;
            break;
        }
        case 7:
        {
            title = eyeExam.contactsrx_color;
            break;
        }
        case 8:
        {
            title = eyeExam.contactsrx_solution;
            break;
        }
        case 9:
        {
            title = eyeExam.contactsrx_enzyme;
            break;
        }
        case 10:
        {
            title = eyeExam.contactsrx_amount;
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

- (NSString *)contactsRXTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Type";
            break;
        }
        case 1:
        {
            title = @"OD";
            break;
        }
        case 2:
        {
            title = @"OS";
            break;
        }
        case 3:
        {
            title = @"BC";
            break;
        }
        case 4:
        {
            title = @"Diam";
            break;
        }
        case 5:
        {
            title = @"Brand/Type";
            break;
        }
        case 6:
        {
            title = @"WT";
            break;
        }
        case 7:
        {
            title = @"Color";
            break;
        }
        case 8:
        {
            title = @"Solution";
            break;
        }
        case 9:
        {
            title = @"Enzyme";
            break;
        }
        case 10:
        {
            title = @"Amount";
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







- (NSString *)additionalTestingValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.adtest_topography;
            break;
        }
        case 1:
        {
            title = eyeExam.adtest_cycloplegia;
            break;
        }
        case 2:
        {
            title = eyeExam.adtest_tonometry;
            break;
        }
        case 3:
        {
            title = eyeExam.adtest_fields;
            break;
        }
        case 4:
        {
            title = eyeExam.adtest_retinal;
            break;
        }
        case 5:
        {
            title = eyeExam.adtest_clcheck;
            break;
        }
        case 6:
        {
            title = eyeExam.adtest_medfollow;
            break;
        }
        case 7:
        {
            title = eyeExam.adtest_exam;
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

- (NSString *)additionalTestingTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Topography";
            break;
        }
        case 1:
        {
            title = @"Cycloplegia";
            break;
        }
        case 2:
        {
            title = @"Tonometry";
            break;
        }
        case 3:
        {
            title = @"Fields";
            break;
        }
        case 4:
        {
            title = @"Retinal Photo";
            break;
        }
        case 5:
        {
            title = @"CL Check";
            break;
        }
        case 6:
        {
            title = @"Med. Follow";
            break;
        }
        case 7:
        {
            title = @"Exam";
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








- (NSString *)otherValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.assesment;
            break;
        }
        case 1:
        {
            title = eyeExam.additionalintructi;
            break;
        }
        case 2:
        {
            title = eyeExam.corrospondence;
            break;
        }
        case 3:
        {
            title = eyeExam.copychart;
            break;
        }
        case 4:
        {
            title = eyeExam.od;
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

- (NSString *)otherTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Assessment";
            break;
        }
        case 1:
        {
            title = @"Additional Instructions";
            break;
        }
        case 2:
        {
            title = @"Correspondence";
            break;
        }
        case 3:
        {
            title = @"Copy Chart";
            break;
        }
        case 4:
        {
            title = @"O.D.";
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





- (NSString *)reccomendValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = eyeExam.rec_hindex;
            break;
        }
        case 1:
        {
            title = eyeExam.rec_bfcal;
            break;
        }
        case 2:
        {
            title = eyeExam.rec_progressive;
            break;
        }
        case 3:
        {
            title = eyeExam.copychart;
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

- (NSString *)reccomendTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Hi-Index/Asph";
            break;
        }
        case 1:
        {
            title = @"ST Bifocal";
            break;
        }
        case 2:
        {
            title = @"Progressive";
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
        eyeExam.odan_lidslashes = textField.text;
        
    } else  if (textField.tag == 101) {
        eyeExam.odan_conjuctiva = textField.text;
    } else  if (textField.tag == 102) {
        eyeExam.odan_sclera = textField.text;
    } else  if (textField.tag == 103) {
        eyeExam.odan_angles = textField.text;
    } else  if (textField.tag == 104) {
        eyeExam.odan_cornea = textField.text;
    } else  if (textField.tag == 105) {
        eyeExam.odan_iris = textField.text;
    } else  if (textField.tag == 106) {
        eyeExam.odan_ac = textField.text;
    } else  if (textField.tag == 107) {
        eyeExam.odan_lens = textField.text;
    } else  if (textField.tag == 200) {
        eyeExam.osan_lids = textField.text;
    } else  if (textField.tag == 201) {
        eyeExam.osan_conjuctiva = textField.text;
    } else  if (textField.tag == 202) {
        eyeExam.osan_sclera = textField.text;
    } else  if (textField.tag == 203) {
        eyeExam.osan_angles = textField.text;
    } else  if (textField.tag == 204) {
        eyeExam.osan_cornea = textField.text;
    } else  if (textField.tag == 205) {
        eyeExam.osan_iris = textField.text;
    } else  if (textField.tag == 206) {
        eyeExam.osan_ac = textField.text;
    } else  if (textField.tag == 207) {
        eyeExam.osan_lens = textField.text;
    } else  if (textField.tag == 300) {
        eyeExam.odpos_media = textField.text;
    } else  if (textField.tag == 301) {
        eyeExam.odpos_cs = textField.text;
    } else  if (textField.tag == 302) {
        eyeExam.odpos_shape = textField.text;
    } else  if (textField.tag == 303) {
        eyeExam.odpost_rim = textField.text;
    } else  if (textField.tag == 304) {
        eyeExam.odpos_vp = textField.text;
    } else  if (textField.tag == 305) {
        eyeExam.odpos_postpole = textField.text;
    } else  if (textField.tag == 306) {
        eyeExam.odpos_av = textField.text;
    } else  if (textField.tag == 307) {
        eyeExam.odpos_alr = textField.text;
    } else  if (textField.tag == 308) {
        eyeExam.odpos_macula = textField.text;
    } else  if (textField.tag == 309) {
        eyeExam.odpos_periphery = textField.text;
    } else  if (textField.tag == 400) {
        eyeExam.ospos_media = textField.text;
    } else  if (textField.tag == 401) {
        eyeExam.ospos_cs = textField.text;
    } else  if (textField.tag == 402) {
        eyeExam.ospos_shape = textField.text;
    } else  if (textField.tag == 403) {
        eyeExam.ospost_rim = textField.text;
    } else  if (textField.tag == 404) {
        eyeExam.ospos_vp = textField.text;
    } else  if (textField.tag == 405) {
        eyeExam.ospos_postpole = textField.text;
    } else  if (textField.tag == 406) {
        eyeExam.ospos_av = textField.text;
    } else  if (textField.tag == 407) {
        eyeExam.ospos_alr = textField.text;
    } else  if (textField.tag == 408) {
        eyeExam.ospos_macula = textField.text;
    } else  if (textField.tag == 409) {
        eyeExam.ospos_periphery = textField.text;
    } else  if (textField.tag == 500) {
        eyeExam.glassrx_type = textField.text;
    } else  if (textField.tag == 501) {
        eyeExam.glassrx_od = textField.text;
    } else  if (textField.tag == 502) {
        eyeExam.glassrx_os = textField.text;
    } else  if (textField.tag == 503) {
        eyeExam.glassrx_prism = textField.text;
    } else  if (textField.tag == 504) {
        eyeExam.glassrx_add = textField.text;
    } else  if (textField.tag == 600) {
        eyeExam.glassrx2_type = textField.text;
    } else  if (textField.tag == 601) {
        eyeExam.glassrx2_od = textField.text;
    } else  if (textField.tag == 602) {
        eyeExam.glassrx2_os = textField.text;
    } else  if (textField.tag == 603) {
        eyeExam.glassrx2_prism = textField.text;
    } else  if (textField.tag == 604) {
        eyeExam.glassrx2_add = textField.text;
    } else  if (textField.tag == 700) {
        eyeExam.contactsrx_type = textField.text;
    } else  if (textField.tag == 701) {
        eyeExam.contactsrx_od = textField.text;
    } else  if (textField.tag == 702) {
        eyeExam.contactsrx_os = textField.text;
    } else  if (textField.tag == 703) {
        eyeExam.contactsrx_bc = textField.text;
    } else  if (textField.tag == 704) {
        eyeExam.contactsrx_diam = textField.text;
    } else  if (textField.tag == 705) {
        eyeExam.contactsrx_brand = textField.text;
    } else  if (textField.tag == 706) {
        eyeExam.contactsrx_wt = textField.text;
    } else  if (textField.tag == 707) {
        eyeExam.contactsrx_color = textField.text;
    } else  if (textField.tag == 708) {
        eyeExam.contactsrx_solution = textField.text;
    } else  if (textField.tag == 709) {
        eyeExam.contactsrx_enzyme = textField.text;
    } else  if (textField.tag == 710) {
        eyeExam.contactsrx_amount = textField.text;
    } else  if (textField.tag == 800) {
        eyeExam.adtest_topography = textField.text;
    } else  if (textField.tag == 801) {
        eyeExam.adtest_cycloplegia = textField.text;
    } else  if (textField.tag == 802) {
        eyeExam.adtest_tonometry = textField.text;
    } else  if (textField.tag == 803) {
        eyeExam.adtest_fields = textField.text;
    } else  if (textField.tag == 804) {
        eyeExam.adtest_retinal = textField.text;
    } else  if (textField.tag == 805) {
        eyeExam.adtest_clcheck = textField.text;
    } else  if (textField.tag == 806) {
        eyeExam.adtest_medfollow = textField.text;
    } else  if (textField.tag == 807) {
        eyeExam.adtest_exam = textField.text;
    } else  if (textField.tag == 900) {
        eyeExam.rec_hindex = textField.text;
    } else  if (textField.tag == 901) {
        eyeExam.rec_bfcal = textField.text;
    } else  if (textField.tag == 902) {
        eyeExam.rec_progressive= textField.text;
    } else  if (textField.tag == 1000) {
        eyeExam.assesment = textField.text;
    } else  if (textField.tag == 1001) {
        eyeExam.additionalintructi = textField.text;
    } else  if (textField.tag == 1002) {
        eyeExam.corrospondence = textField.text;
    } else  if (textField.tag == 1003) {
        eyeExam.copychart = textField.text;
    } else  if (textField.tag == 1004) {
        eyeExam.od = textField.text;
    }
    
    [self.tableView reloadData];
    
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
