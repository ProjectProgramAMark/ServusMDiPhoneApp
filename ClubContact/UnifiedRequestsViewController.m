//
//  UnifiedRequestsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/4/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "UnifiedRequestsViewController.h"
#import "SWRevealViewController.h"
#import "Chameleon.h"

@interface UnifiedRequestsViewController () <AppRequestDetailiPhoneDelegate, ConsultationDetailiPhoneDelegate>

@end

@implementation UnifiedRequestsViewController

@synthesize requestsArray;
@synthesize tableView;
@synthesize patient;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
   // self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    self.title = @"REQUESTS";
    
    requestsArray = [[NSMutableArray alloc] init];
    
    [tableView registerNib:[UINib nibWithNibName:@"UnifiedReqTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshUnifiedRequests];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.revealViewController revealCloseAnimated:true];
}

- (IBAction)goBack:(id)sender {
    [self.revealViewController revealToggle:sender];
}


- (void)refreshUnifiedRequests {
     [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getRequestUnified:@"1" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        
        if (success)
        {
            
            [requestsArray addObjectsFromArray:conditions];
            [tableView reloadData];
               [self performSelector:@selector(hideTableViewCells) withObject:nil afterDelay:0.3];
        }
        
       
    }];
}


- (void)hideTableViewCells {
    for (int i = 0; i <= requestsArray.count; i++)
    {
        NSLog(@"%d", i);
        NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UnifiedReqTableViewCell *cell = (UnifiedReqTableViewCell *)[tableView cellForRowAtIndexPath:cellIndexPath];
        [cell hideUtilityButtonsAnimated:NO];
        
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return requestsArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UnifiedReqTableViewCell  *cell = (UnifiedReqTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    UnifiedRequests *uReq = [requestsArray objectAtIndex:indexPath.row];
    
    if ([uReq.type isEqual:@"msgsession"]) {
        
        
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Messaging request from: %@ %@",uReq.firstname, uReq.lastname];
        //cell.specialityLabel.text = [NSString stringWithFormat:@"%@", patientInfo.lastmessage];
        //cell.timeLabel.text = [NSString stringWithFormat:@"%@", patientInfo.createdago];
        
        cell.imgView.image = [UIImage imageNamed:@"chatIcon2"];
        
        
        if ([uReq.status isEqual:@"0"]) {
            cell.statusLabel.text = @"Pending";
            cell.statusLabel.textColor = [UIColor flatGrayColor];
        } else if ([uReq.status isEqual:@"1"]) {
            cell.statusLabel.text = @"Accepted";
            cell.statusLabel.textColor =  [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
        } else if ([uReq.status isEqual:@"2"]) {
            cell.statusLabel.text = @"Declined";
            cell.statusLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        } else if ([uReq.status isEqual:@"3"]) {
            cell.statusLabel.text = @"Closed";
            cell.statusLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        }
        
        double unixTimeStamp =[uReq.created doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        
        NSDate* destinationDate = sourceDate;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
        cell.dateLabel.text = [formatter stringFromDate:destinationDate];

        
        
        // cell.name
        
        
    } else if ([uReq.type isEqual:@"apprequest"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Appointment request from: %@ %@",uReq.firstname, uReq.lastname];
        //cell.specialityLabel.text = [NSString stringWithFormat:@"%@", patientInfo.lastmessage];
        //cell.timeLabel.text = [NSString stringWithFormat:@"%@", patientInfo.createdago];
        
        cell.imgView.image = [UIImage imageNamed:@"days4"];
        
        
        cell.statusLabel.text = @"Pending";
        cell.statusLabel.textColor = [UIColor flatGrayColor];
        
        double unixTimeStamp =[uReq.created doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        
        NSDate* destinationDate = sourceDate;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
        cell.dateLabel.text = [formatter stringFromDate:destinationDate];
        
    } else if ([uReq.type isEqual:@"consultation"]) {
        cell.topTitleLabel.text = [NSString stringWithFormat:@"Consultation request from: %@ %@",uReq.firstname, uReq.lastname];
        //cell.specialityLabel.text = [NSString stringWithFormat:@"%@", patientInfo.lastmessage];
        //cell.timeLabel.text = [NSString stringWithFormat:@"%@", patientInfo.createdago];
        
        cell.imgView.image = [UIImage imageNamed:@"videoChatIcon2"];
        
        
        
        if ([uReq.status isEqual:@"0"]) {
            cell.statusLabel.text = @"Pending";
            cell.statusLabel.textColor = [UIColor lightGrayColor];
            
        } else if ([uReq.status isEqual:@"1"]) {
            cell.statusLabel.text = @"Accepted";
            cell.statusLabel.textColor = [UIColor colorWithRed:101.0f/255.0f green:195.0f/255.0f blue:164.0f/255.0f alpha:1.0f];
            
        } else if ([uReq.status isEqual:@"2"]) {
            cell.statusLabel.text = @"Declined";
            cell.statusLabel.textColor = [UIColor colorWithRed:213.0f/255.0f green:96.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
;
            
        }

        
        double unixTimeStamp =[uReq.created doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        
        NSDate* destinationDate = sourceDate;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
        cell.dateLabel.text = [formatter stringFromDate:destinationDate];
    }

    cell.delegate = self;
    

    cell.leftUtilityButtons = [self leftButtons];
//    cell.rightUtilityButtons = [self rightButtons];

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UnifiedRequests *uReq = [requestsArray objectAtIndex:indexPath.row];
    
    if ([uReq.type isEqual:@"msgsession"]) {

        if ([uReq.status isEqual:@"2"]) {
           // [self showAlertViewWithMessage:@"Consultation request does not exist" withTag:0 withTitle:@"" andViewController:self isCancelButton:false];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Declined Session" message:@"You declied this chat request" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
            return;
        } else if ([uReq.status isEqual:@"3"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Closed Session" message:@"This session is closed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        } else if ([uReq.status isEqual:@"0"]) {
            
            MessagePatientsList *vc = [[MessagePatientsList alloc] initWithNibName:@"MessagePatientsList" bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.revealViewController pushFrontViewController:navigationController animated:YES];
            
        }
        
        [SVProgressHUD showWithStatus:@"Please wait..."];
        Doctor *doc = [Doctor getFromUserDefault];
        [[AppController sharedInstance] getMSGSessionsByID:doc.uid sessionID:uReq.nid WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
            [SVProgressHUD dismiss];
            if (success) {
                [self refreshUnifiedRequests];
                if ([msgsession.mstatus intValue] == 3) {
                    //[repeatTimer2 invalidate];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Closed Session" message:@"This session is closed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                 
                } else {
                    
                    
                    MessagingViewController *vc = [[MessagingViewController alloc] initWithNibName:@"MessagingViewController" bundle:nil];
                    vc.msgSession = msgsession;
                    // vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:true];
                }
                
                
            }
        }];
        

        
    }  else if ([uReq.type isEqual:@"apprequest"]) {
        
        [SVProgressHUD showWithStatus:@"Please wait..."];
        [[AppController sharedInstance] getRequestAppointmensIndividual:@"" postid:uReq.nid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
             [SVProgressHUD dismiss];
            if (success) {
                if (conditions.count > 0) {
                    RequestAppointments *reqApp = [conditions objectAtIndex:0];
                    AppRequestiPhoneViewController *vc = [[AppRequestiPhoneViewController alloc] initWithNibName:@"AppRequestiPhoneViewController" bundle:nil];
                    
                    
                    vc.appRequest = reqApp;
                    
                    vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:true];
                    
                  

                    
                }
            }
            
        }];;
        
    } else if ([uReq.type isEqual:@"consultation"]) {
          [SVProgressHUD showWithStatus:@"Please wait..."];
        [[AppController sharedInstance] getConsultationIndividual:@"" postid:uReq.nid  WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            [SVProgressHUD dismiss];
            if (success)
            {
                if (conditions.count > 0) {
                    Consulatation *conApp = [conditions objectAtIndex:0];
                    
                     ConsultationDetailiPhone *vc = [[ConsultationDetailiPhone alloc] initWithNibName:@"ConsultationDetailiPhone" bundle:nil];
                    
                    vc.consultation = conApp;
                    
                    vc.delegate = self;
                    
                    [self.navigationController pushViewController:vc animated:YES];

                    
                    
                } else {
                    [self showAlertViewWithMessage:@"Consultation request does not exist" withTag:0 withTitle:@"" andViewController:self isCancelButton:false];
                }
                
                
            }
            
           
        }];

        
    } else if ([uReq.type isEqual:@"consultation"]) {
        
        
    }
    
    
}


- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:99.0f/255.0f green:203.0f/255.0f blue:159.0f/255.0f alpha:1.0f]
                                               title:@"Accept"];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:225.0f/255.0f green:93.0f/255.0f blue:91.0f/255.0f alpha:1.0f]
                                               title:@"Decline"];
    
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:226.0f/255.0f green:191.0f/255.0f blue:99.0f/255.0f alpha:1.0f]
                                               title:@"Ignore"];
    
    
    
    return leftUtilityButtons;
}




#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    // Delete button was pressed
    NSIndexPath *cellIndexPath = [tableView indexPathForCell:cell];
    
    //  [_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
    //[menuTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [cell hideUtilityButtonsAnimated:true];
    //  if ([patientInfo.mstatus isEqual:@"0"]) {
    switch (index) {
        case 0: {
            //  NSLog(@"left button 0 was pressed");
            
            UnifiedRequests *uReq = [requestsArray objectAtIndex:cellIndexPath.row];
            
            if ([uReq.type isEqual:@"msgsession"]) {
                
                 if (![uReq.status isEqual:@"0"]) {
                     
                     return;
                 }
                
                [SVProgressHUD showWithStatus:@"Please wait..."];
                [[AppController sharedInstance] acceptMSGSession:uReq.patientid sessionID:uReq.nid completion:^(BOOL success, NSString *message)  {
                    if (success) {
                        //  [self acceptedSession:msgSession];
                        //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                        Doctor *doc = [Doctor getFromUserDefault];
                        [[AppController sharedInstance] getMSGSessionsByID:doc.uid sessionID:uReq.nid WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
                            [SVProgressHUD dismiss];
                            if (success) {
                                      [self refreshUnifiedRequests];
                                if ([msgsession.mstatus intValue] == 3) {
                                    //[repeatTimer2 invalidate];
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Closed Session" message:@"This session is closed by the patient" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                    [alert show];
                                } else {
                                    
                                  
                                    MessagingViewController *vc = [[MessagingViewController alloc] initWithNibName:@"MessagingViewController" bundle:nil];
                                    vc.msgSession = msgsession;
                                    // vc.delegate = self;
                                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                                    [self presentViewController:nav animated:YES completion:nil];
                                }
                                
                                
                            }
                        }];

                        
                     
                        
                        
                    } else {
                         [SVProgressHUD dismiss];
                    }
                }];

                
                
            }  else if ([uReq.type isEqual:@"apprequest"]) {
                
              
                [SVProgressHUD showWithStatus:@"Please wait..."];
                [[AppController sharedInstance] acceptRequestAppointment:uReq.nid completion:^(BOOL success, NSString *message) {
                    [SVProgressHUD dismiss];
                    [self refreshUnifiedRequests];
                }];
                
            } else if ([uReq.type isEqual:@"consultation"]) {
                
                
                if (![uReq.status isEqual:@"0"]) {
                    
                    return;
                }
                
                 [SVProgressHUD showWithStatus:@"Please wait..."];
                [[AppController sharedInstance] acceptConsultation:uReq.nid completion:^(BOOL success, NSString *message) {
                    if (success) {
                        [SVProgressHUD dismiss];
                        [self refreshUnifiedRequests];
                    }
                }];

                
                
            }
            
            
        } break;
        case 1: {
            // NSLog(@"left button 1 was pressed");
             UnifiedRequests *uReq = [requestsArray objectAtIndex:cellIndexPath.row];
            
            if ([uReq.type isEqual:@"msgsession"]) {
                
                if (![uReq.status isEqual:@"0"]) {
                    
                    return;
                }
                
                [SVProgressHUD showWithStatus:@"Please wait..."];
                [[AppController sharedInstance] declineMSGSession:uReq.patientid sessionID:uReq.nid completion:^(BOOL success, NSString *message){
                    if (success) {
                        //  [self acceptedSession:msgSession];
                        //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                        
                        
                        
                            [SVProgressHUD dismiss];
                        [self refreshUnifiedRequests];
                        
                    } else {
                        [SVProgressHUD dismiss];
                    }
                }];
                
                
                
            } else if ([uReq.type isEqual:@"apprequest"]) {
                
              
                [SVProgressHUD showWithStatus:@"Please wait..."];
                [[AppController sharedInstance] declineRequestAppointment:uReq.nid completion:^(BOOL success, NSString *message) {
                    [SVProgressHUD dismiss];
                    [self refreshUnifiedRequests];
                }];
                
            } else if ([uReq.type isEqual:@"consultation"]) {
                
                
                
                if (![uReq.status isEqual:@"0"]) {
                    
                    return;
                }
                
                
                [SVProgressHUD showWithStatus:@"Please wait..."];
                [[AppController sharedInstance ] declineConsultation:uReq.nid completion:^(BOOL success, NSString *message) {
                    if (success) {
                        [SVProgressHUD dismiss];
                        [self refreshUnifiedRequests];
                    }
                }];

                
            }
            
            
        }  break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
    
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
            
        case 0:
        {
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [tableView indexPathForCell:cell];
            
            
            
            //  [_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
            //[menuTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [cell hideUtilityButtonsAnimated:true];
        /*    MSGSession *patientInfo = [_patientsArray objectAtIndex:cellIndexPath.row];
            
            if ([patientInfo.mstatus isEqual:@"1"]) {
                [[AppController sharedInstance] closeMSGSession:patientInfo.pid sessionID:patientInfo.postid completion:^(BOOL success, NSString *message)  {
                    
                    if (success) {
                        //[self.navigationController popViewControllerAnimated:YES];
                        //[self.delegate refreshPatientsInfo3];
                        
                        UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"" message:@"You closed this chat session" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alertTest show];
                        
                        
                        [self requestPatientsDataByPage:1 keyword : @""];
                    }
                    
                    
                }];*/
                
            
            
            
            
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}



- (void)refreshPationInfo {
    [self refreshUnifiedRequests];
}






@end
