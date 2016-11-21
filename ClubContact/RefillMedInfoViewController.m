//
//  RefillMedInfoViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "RefillMedInfoViewController.h"

@interface RefillMedInfoViewController ()

@end

@implementation RefillMedInfoViewController

@synthesize drug;
@synthesize selectedAllergens;
@synthesize selectedConditions;
@synthesize monoGraphArray;
@synthesize patientConditions;
@synthesize monoClient;
@synthesize patient;
@synthesize concClient;
@synthesize contradictedConditions;
@synthesize medication;
@synthesize drugClient;
@synthesize patientLink;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
 
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    monoGraphArray = [[NSMutableArray alloc] init];
    patientConditions = [[NSMutableArray alloc] init];
    contradictedConditions = [[NSMutableArray alloc] init ];
    
    self.monoClient = [[PatientEdicationAPIClient alloc] init];
    self.concClient = [[ContradictionAPIClient alloc] init];
    self.drugClient = [[DrugSearchAPIClient alloc] init];
    
    self.title = @"MEDICATION DETAILS";
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                     target:self
                                     action:@selector(cancelPrescription)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    UIBarButtonItem *refillButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"REFILL" style:UIBarButtonItemStylePlain target:self action:@selector(requestRefill:)];
    refillButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = refillButton;
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self getDrugsInfo];
    [self getMonoGraphStuff];
}

- (void)cancelPrescription {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)requestRefill:(id)sender {
    UIAlertController *actionSheet2 = [UIAlertController alertControllerWithTitle:@"Refill Request" message:@"Do you want to send a refill request for this medication" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesCode = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[AppController sharedInstance] sendRefillRequest:patientLink.postid doctor:patientLink.docid medication:medication.postid completion:^(BOOL success, NSString *message) {
            if (success) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Refill request sent" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [self.delegate refreshRefillMedication];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];

      
    }];
    
   
    UIAlertAction *cancelAction2 = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    [actionSheet2 addAction:yesCode];
    [actionSheet2 addAction:cancelAction2];
    
    [self presentViewController:actionSheet2 animated:YES completion:nil];
}

- (void)getMonoGraphStuff {
    [self.monoClient searchForPatientEdication:medication.medid
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
  /*  [[AppController sharedInstance] getAllConditionByPatient:patient.postid
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
     }];*/
    [[AppController sharedInstance] getAllConditionByPatient2:patientLink.postid doctor:patientLink.docid  WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions)
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
                    if ([dictionary2.DrugDesc isEqual:medication.medname]) {
                        [contradictedConditions addObject:dictionary2];
                        
                        [drugDetailTable reloadData];
                    }
                }
                
            }
            
        }];
        
    }
    
    
}

- (void)getDrugsInfo {
    
    [self.drugClient searchForDrugByID:medication.medid completion:^(Drug *results, NSError *error) {
        if(!error){
            drug = [[Drug alloc] init];
            drug = results;
            [drugDetailTable reloadData];
            
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView   {
    
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int rownum = 0;
    
    if (section == 0) {
        rownum = 2;
    } else if (section == 1) {
        if (drug) {
            rownum = 3;
        } else {
            rownum = 1;
        }
        
    }  else if (section == 2) {
        rownum = medication.conditions.count;
    }  else if (section == 3) {
        rownum = medication.allergy.count;
    }  else if (section == 4) {
        
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
        
    } else if (section == 5) {
        
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
        
        
    } else if (section == 6) {
        
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
        
        
    } else if (section == 7) {
        if (drug) {
            rownum = drug.Ingredients.count;
            
        } else {
            rownum = 0;
        }
    } else if (section == 8) {
        rownum = medication.refillArray.count;
    }
    
    
    return rownum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float rowHeigh = 50.0f;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            rowHeigh = 80.0f;
        }
        
    } else if (indexPath.section == 4) {
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
        
        // rowHeigh = 340.0f;
    }else if (indexPath.section == 5) {
        //rowHeigh = 380.0f;
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
        
    }else if (indexPath.section == 6) {
        //   rowHeigh = 380.0f;
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
        secTitle = @"Drug";
    } else if (section == 1) {
        secTitle = @"Dose";
    } else if (section == 2) {
        secTitle = @"Conditions";
    }  else if (section == 3) {
        secTitle = @"Allergens";
    }  else if (section == 4) {
        secTitle = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"U"]) {
                secTitle = @"Purpose";
            }
            
        }
    } else if (section == 5) {
        secTitle = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"S"]) {
                secTitle = @"Side Effects";
            }
            
        }
    } else if (section == 6) {
        secTitle = @"";
        for (MonoGraph *dictionary in monoGraphArray) {
            if ([dictionary.SectionCode isEqual:@"H"]) {
                secTitle = @"How To Use";
            }
            
        }
    }  else if (section == 7) {
        secTitle = @"Ingrediants";
    }  else if (section == 8) {
        secTitle = @"Refill Requests";
    }
    
    return secTitle;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        if (indexPath.row == 0) {
            cell.textLabel.text = medication.medname;
            cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
        } else if (indexPath.row == 1) {
            
            double unixTimeStamp =[medication.prescribedDate doubleValue];
            NSTimeInterval _interval=unixTimeStamp;
            NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
            NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
            NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
            
            NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
            NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
            NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
            
            NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
            
            NSString *dateString = [NSDateFormatter localizedStringFromDate:destinationDate
                                                                  dateStyle:NSDateFormatterShortStyle
                                                                  timeStyle:NSDateFormatterShortStyle];
            
            cell.textLabel.text = [NSString stringWithFormat:@"Prescribed: %@", dateString];
            
        }
        
        return cell;
    } else if (indexPath.section == 1)  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"Strength: %@ %@", medication.dose, medication.doseunit];
        } else if (indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"Dose Form: %@", drug.doseFormDesc];
            
        } else if (indexPath.row == 2) {
            cell.textLabel.text = [NSString stringWithFormat:@"Route: %@", drug.RouteDesc];
            
        }
        
        return cell;
    } else if  (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        Condition *condition = [medication.conditions objectAtIndex:0];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", condition.conditionName];
        
        return cell;
    } else if  (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        Allergen *allergen = [medication.allergy objectAtIndex:0];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", allergen.PicklistDesc];
        
        return cell;
    } else if (indexPath.section == 4)  {
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
    } else if (indexPath.section == 5)  {
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
    }  else if (indexPath.section == 6)  {
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
    }  else if (indexPath.section == 7)  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        
        BOOL isWarning = false;
        
        Ingrediant *ingr = [drug.Ingredients objectAtIndex:indexPath.row];
        
        for (Allergen *dictionary in medication.allergy) {
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
    } else if  (indexPath.section == 8) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"DrugName"];
        Refills *refill = [medication.refillArray objectAtIndex:indexPath.row];
        
        double unixTimeStamp =[refill.sentdate doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
        NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        NSString *dateString = [NSDateFormatter localizedStringFromDate:destinationDate
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        
        NSString *refillStatus = @"Pending";
        
        if ([refill.refillstatus intValue] == 0) {
            refillStatus = @"Pending";
        } else if ([refill.refillstatus intValue] == 1) {
            refillStatus = @"Accepted";
        } else if ([refill.refillstatus intValue] == 2) {
            refillStatus = @"Declined";
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"Sent: %@ (%@)", dateString, refillStatus];
        
        //cell.textLabel.text = [NSString stringWithFormat:@"Date %@", condition.conditionName];
        
        return cell;
    }  /* else if (indexPath.section == 6)  {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
        reuseIdentifier:@"DrugName"];
        
        // BOOL isWarning = false;
        
        Contradiction *conc = [contradictedConditions objectAtIndex:indexPath.row];
        
        
        
        NSString *usesText = [NSString stringWithFormat:@"%@ (%@)",conc.HitConditionDesc, conc.SeverityDesc];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@", usesText];
        cell.textLabel.numberOfLines = 0;
        
        
        
        return cell;
        }*/  else  {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrugName"];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"DrugName"];
            cell.textLabel.text = @"Nothing";
            return cell;
        }
    
    
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [drugDetailTable deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 8) {
        
       /* if (IS_IPHONE) {
            Refills *refill = [medication.refillArray objectAtIndex:indexPath.row];
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            RefillDetailiPhoneViewController *vc = (RefillDetailiPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"RefillDetailiPhoneViewController"];
            
            vc.patient = patient;
            //  vc.delegate = self;
            vc.patientMedication = medication;
            vc.refill = refill;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            Refills *refill = [medication.refillArray objectAtIndex:indexPath.row];
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            RefillDetailsViewController *vc = (RefillDetailsViewController *)[sb instantiateViewControllerWithIdentifier:@"RefillDetailsViewController"];
            
            vc.patient = patient;
            //  vc.delegate = self;
            vc.patientMedication = medication;
            vc.refill = refill;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
            
        }*/
        
    }
    
}

- (void)refreshRefillMedication {
    [self.delegate refreshRefillMedication];
}

@end
