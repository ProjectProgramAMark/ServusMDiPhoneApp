//
//  DrugDetailViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DrugDetailViewController.h"

@interface DrugDetailViewController () <SendPrescriptionDelegate, SendPrescriptioniPhoneDelegate>

@end

@implementation DrugDetailViewController

@synthesize drug;
@synthesize selectedAllergens;
@synthesize selectedConditions;
@synthesize monoGraphArray;
@synthesize patientConditions;
@synthesize monoClient;
@synthesize patient;
@synthesize concClient;
@synthesize contradictedConditions;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    drugDetailTable.delegate = self;
    drugDetailTable.dataSource = self;
    
    monoGraphArray = [[NSMutableArray alloc] init];
    patientConditions = [[NSMutableArray alloc] init];
    contradictedConditions = [[NSMutableArray alloc] init ];
    
    self.monoClient = [[PatientEdicationAPIClient alloc] init];
    self.concClient = [[ContradictionAPIClient alloc] init];
    
    self.title = @"MEDICATION DETAILS";
    
   
   /* UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(goToSendPrescription)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
     UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
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
    

    
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self getMonoGraphStuff];
    [self getPatientConditions];
}


- (IBAction)goToSendPrescription:(id)sender {
    SendPrescriptioniPhoneViewController *vc =[[SendPrescriptioniPhoneViewController alloc] initWithNibName:@"SendPrescriptioniPhoneViewController" bundle:nil];
    vc.selectedConditions = selectedConditions;
    vc.selectedAllergens = selectedAllergens;
    vc.patient = patient;
    vc.drug = drug;
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];}

- (void)getMonoGraphStuff {
    [self.monoClient searchForPatientEdication:drug.DispensableDrugID
                        completion:^(NSArray *results, NSError *error) {
                            //   self.searchButton.enabled = YES;
                            
                            //NSTimeInterval duration = [NSDate date].timeIntervalSinceReferenceDate - start;
                            if(!error){
                                //self.durationLabel.text = [NSString stringWithFormat:@"%f secs", duration];
                                //self.successLabel.text = [self statusString:YES];
                                monoGraphArray = [NSMutableArray array];
                                monoGraphArray  = [results copy];
                                [drugDetailTable reloadData];
                                
                                //[self.searchField resignFirstResponder];
                            }else{
                                /*self.successLabel.text = [self statusString:NO];
                                 self.medications = @[];
                                 [self.tableView reloadData];*/
                            }
                            
                        }];

}

- (void)getPatientConditions {
   // [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllConditionByPatient:patient.postid
                                              WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions)
     {
        // [SVProgressHUD dismiss];
         if (success)
         {
             [patientConditions removeAllObjects];
             [patientConditions   addObjectsFromArray:conditions];
           //  [_tableView reloadData];
             
             [self getDiseaseContradictions];
         }
     }];
    
}
         
- (void)getDiseaseContradictions {
    contradictedConditions = [[NSMutableArray alloc] init ];
     for (Condition *dictionary in patientConditions) {
         [self.concClient searchForContradiction:dictionary.conditionCode completion:^(NSArray *results, NSError *error) {
             
             NSMutableArray *tempArray = [NSMutableArray array];
             tempArray  = [results copy];
             
             for (Contradiction *dictionary2 in tempArray) {
                 if ([dictionary2.DrugConceptType isEqual:@"DispensableDrug"]) {
                     if ([dictionary2.DrugDesc isEqual:drug.dispensableDrugDesc]) {
                         [contradictedConditions addObject:dictionary2];
                         
                         [drugDetailTable reloadData];
                     }
                 }
                 
             }
             
         }];
         
     }
    
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView   {
    
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int rownum = 1;
    
    if (section == 0) {
        rownum = 1;
    } else if (section == 1) {
        rownum = 3;
    } else if (section == 2) {
        
        if (monoGraphArray.count > 0) {
            rownum = 0;
            for (MonoGraph *dictionary in monoGraphArray) {
                if ([dictionary.SectionCode isEqual:@"U"]) {
                     rownum = 1;
                }
                
            }
            
            
        } else {
            rownum = 0;
        }
        
    } else if (section == 3) {
        
        if (monoGraphArray.count > 0) {
            rownum = 0;
            for (MonoGraph *dictionary in monoGraphArray) {
                if ([dictionary.SectionCode isEqual:@"S"]) {
                    rownum = 1;
                }
                
            }
            
            
        } else {
            rownum = 0;
        }
        
        
    } else if (section == 4) {
        
        if (monoGraphArray.count > 0) {
            rownum = 0;
            for (MonoGraph *dictionary in monoGraphArray) {
                if ([dictionary.SectionCode isEqual:@"H"]) {
                    rownum = 1;
                }
                
            }
            
            
        } else {
            rownum = 0;
        }
        
        
    } else if (section == 5) {
        rownum = drug.Ingredients.count;
    } else if (section == 6) {
        rownum = contradictedConditions.count;
    }

    
    return rownum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    float rowHeigh = 50.0f;
    if (indexPath.section == 0) {
        rowHeigh = 80.0f;
    } else if (indexPath.section == 2) {
        
        NSString *monoU = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"U"]) {
                monoU = dictionary.descText;
            }
            
        }
        
        CGSize sizeOfText = [monoU boundingRectWithSize: CGSizeMake(500, MAXFLOAT)
                                                                      options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                                   attributes: [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:15.0]
                                                                                                           forKey:NSFontAttributeName]
                                                                      context: nil].size;
        
        rowHeigh = 130 + sizeOfText.height;
    }else if (indexPath.section == 3) {
        NSString *monoU = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"S"]) {
                monoU = dictionary.descText;
            }
            
        }
        
        CGSize sizeOfText = [monoU boundingRectWithSize: CGSizeMake(500, MAXFLOAT)
                                                options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                             attributes: [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:15.0]
                                                                                     forKey:NSFontAttributeName]
                                                context: nil].size;
        
        rowHeigh = 130 + sizeOfText.height;

    }else if (indexPath.section == 4) {
        NSString *monoU = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"H"]) {
                monoU = dictionary.descText;
            }
            
        }
        
        CGSize sizeOfText = [monoU boundingRectWithSize: CGSizeMake(500, MAXFLOAT)
                                                options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                             attributes: [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:15.0]
                                                                                     forKey:NSFontAttributeName]
                                                context: nil].size;
        
        rowHeigh = 130 + sizeOfText.height;

    }
    
    return rowHeigh;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *secTitle = @"";
    
    if (section == 0) {
        secTitle = @"Drug Name";
    } else if (section == 1) {
       secTitle = @"Dose";
    } else if (section == 2) {
        secTitle = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"U"]) {
                secTitle = @"Purpose";
            }
            
        }
    } else if (section == 3) {
        secTitle = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"S"]) {
                secTitle = @"Side Effects";
            }
            
        }
    } else if (section == 4) {
        secTitle = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"H"]) {
                secTitle = @"How To Use";
            }
            
        }
    } else if (section == 5) {
        secTitle = @"Ingrediants";
    } else if (section == 5) {
        secTitle = @"Contradictions";
    }
    
    return secTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"DrugName"];
    cell.textLabel.text = drug.dispensableDrugDesc;
        cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
         return cell;
    } else if (indexPath.section == 1)  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        if (indexPath.row == 0) {
             cell.textLabel.text = [NSString stringWithFormat:@"Strength: %@ %@", drug.MedStrength, drug.MedStrengthUnit];
        } else if (indexPath.row == 1) {
             cell.textLabel.text = [NSString stringWithFormat:@"Dose Form: %@", drug.doseFormDesc];
            
        } else if (indexPath.row == 2) {
            cell.textLabel.text = [NSString stringWithFormat:@"Route: %@", drug.RouteDesc];
            
        }
        
        return cell;
    } else if (indexPath.section == 2)  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        
        NSString *usesText = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"U"]) {
                usesText = dictionary.descText;
            }
            
        }
        
        
        //MonoGraph *mono = [monoGraphArray objectAtIndex:4];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", usesText];
        cell.textLabel.numberOfLines = 0;
        
        
        return cell;
    } else if (indexPath.section == 3)  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        
        NSString *usesText = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"S"]) {
                usesText = dictionary.descText;
            }
            
        }
        
        
        //MonoGraph *mono = [monoGraphArray objectAtIndex:4];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", usesText];
        cell.textLabel.numberOfLines = 0;
        
        
        return cell;
    }  else if (indexPath.section == 4)  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        
        NSString *usesText = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"H"]) {
                usesText = dictionary.descText;
            }
            
        }
        
        
        //MonoGraph *mono = [monoGraphArray objectAtIndex:4];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", usesText];
        cell.textLabel.numberOfLines = 0;
        
        
        return cell;
    }  else if (indexPath.section == 5)  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        
        BOOL isWarning = false;
        
        Ingrediant *ingr = [drug.Ingredients objectAtIndex:indexPath.row];
        
        for (Allergen *dictionary in selectedAllergens) {
            if ([dictionary.PicklistDesc isEqual:ingr.IngredientDesc]) {
                isWarning = true;
            }
            
        }
        
        NSString *usesText = ingr.IngredientDesc;
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", usesText];
        cell.textLabel.numberOfLines = 0;
        
        if (isWarning == true) {
            cell.backgroundColor = [UIColor flatRedColor];
        }
        
        
        return cell;
    }  else if (indexPath.section == 6)  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        
       // BOOL isWarning = false;
        
        Contradiction *conc = [contradictedConditions objectAtIndex:indexPath.row];
        
        
        
        NSString *usesText = [NSString stringWithFormat:@"%@ (%@)",conc.HitConditionDesc, conc.SeverityDesc];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", usesText];
        cell.textLabel.numberOfLines = 0;
        
        
        
        return cell;
    }  else  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        cell.textLabel.text = @"Nothing";
        return cell;
    }
    
    
    
}

- (void)refreshMedicationAdd {
    [self.delegate refreshMedicationAdd];
}

@end
