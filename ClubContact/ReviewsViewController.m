//
//  ReviewsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/28/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "ReviewsViewController.h"

@interface ReviewsViewController ()

@end

@implementation ReviewsViewController

@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize patientsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    
  //  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addReviewToDoctor:)];
   // self.navigationItem.rightBarButtonItem = addButton;
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"RatingTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    self.title = @"REVIEWS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    [self getDoctorRating];
}



- (void)getDoctorRating {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllDoctorRating:doctor.uid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions, NSString *totalrating)
     {
         [SVProgressHUD dismiss];
         if (success)
         {
             [patientsArray removeAllObjects];
             [patientsArray addObjectsFromArray:conditions];
             [menuTable reloadData];
             
             self.title = [NSString stringWithFormat:@"RATING %@/5", totalrating];
             
           
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




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RatingTableViewCell *cell = (RatingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    cell.cellImageView.image = [UIImage imageNamed:@"medicine-box-icon.png"];
    
    // PatientMedication *patientInfo2 = [profPatient.medications objectAtIndex:indexPath.row];
    Rating *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[patientInfo2.created integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    
    NSData *newdata=[patientInfo2.review dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *lastCom = [[NSString alloc] initWithData:newdata encoding:NSNonLossyASCIIStringEncoding];
   
    cell.ratingLabel.text = lastCom;
    cell.nameLabel.text  = [NSString stringWithFormat:@"- %@ %@ on %@", patientInfo2.docfname, patientInfo2.doclname, [formatter stringFromDate:dob]];
    cell.starsLabel.text = [NSString stringWithFormat:@"Rating: %@/5", patientInfo2.stars];
   
    cell.clipsToBounds = YES;
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
      float rowHeigh = 80.0f;
    
    
     Rating *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
    
    
    NSData *newdata=[patientInfo2.review dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *lastCom = [[NSString alloc] initWithData:newdata encoding:NSNonLossyASCIIStringEncoding];
    
    
    CGSize sizeOfText = [lastCom boundingRectWithSize: CGSizeMake(windowWidth - 50.0f, MAXFLOAT)
                                            options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                         attributes: [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:15.0]
                                                                                 forKey:NSFontAttributeName]
                                            context: nil].size;
    
  
    
    rowHeigh = 80 + sizeOfText.height;
    return rowHeigh;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
        Rating *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
    PatientLogin *login = [PatientLogin getFromUserDefault];
    if ([login.uid isEqual:patientInfo2.uid]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Rating *patientInfo2 = [patientsArray objectAtIndex:indexPath.row];
        
        [[AppController sharedInstance] deleteDoctorRating:patientInfo2.postid completion:^(BOOL success, NSString *message) {
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
        
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addReviewToDoctor:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    AddReviewDoctorViewController *vc = [[AddReviewDoctorViewController alloc] initWithNibName:@"AddReviewDoctorViewController" bundle:nil];
    vc.doctor = doctor;
    
    [self.navigationController pushViewController:vc animated:YES];
}



@end
