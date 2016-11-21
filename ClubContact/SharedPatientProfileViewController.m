//
//  SharedPatientProfileViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/31/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SharedPatientProfileViewController.h"
#import "AboutTableViewCell.h"

#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"

#define kDetailPatientsCellID   @"patientCell"
#define kAboutCellID            @"aboutCell"
#define kNormalCellID           @"normalCell"
#define kDetailNoteCellID       @"noteCell"

@interface SharedPatientProfileViewController () <PatientDrugDetailsDelegate> {
    UIPopoverController *popover2;
    BOOL isProfileUpdate;
    IBOutlet UIView *statView;
    
    IBOutlet UIImageView *profileIMGView2;
    IBOutlet UIImageView *profileIMGView3;
    IBOutlet UILabel *refillNOLabel2;
    IBOutlet UILabel *messageNOLabel2;
    IBOutlet UILabel *appointmentNOLabel2;
    IBOutlet UILabel *nameLabel2;
    IBOutlet UIDatePicker *datePick;
    UIPickerView *countryPicker;
    IBOutlet UISegmentedControl *genderPicker;
    IBOutlet UIView *datePickerContainer;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation SharedPatientProfileViewController


@synthesize delegate;

@synthesize client;
@synthesize allergenClient;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"PATIENT PROFILE";
  //  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(rightNaviButtonClicked)];
    isProfileUpdate = false;
    
    self.client = [[DrugSearchAPIClient alloc] init];
    self.allergenClient = [[AllergenSearchAPIClient alloc] init];
    
    if (IS_IPHONE) {
        // statView.hidden = true;
        statView.hidden = false;
        statView.frame = CGRectMake(0, 0, windowWidth, 157.0f);
        _tableView.frame = CGRectMake(0, 157.0f, windowWidth, windowHeight - 157.0f);
        
    } else {
        // statView.hidden = true;
        statView.hidden = false;
        statView.frame = CGRectMake(0, 0, windowWidth, 157.0f);
        _tableView.frame = CGRectMake(0, 157.0f, windowWidth, windowHeight - 157.0f);
    }
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)rightNaviButtonClicked
{
    _tableView.editing = !_tableView.editing;
    [_tableView reloadData];
    UIBarButtonSystemItem item ;
    if (_tableView.editing)
    {
        item =UIBarButtonSystemItemDone;
    }
    else
    {
        item =UIBarButtonSystemItemEdit;
        
        if (_patient.firstName.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the first name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_patient.lastName.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the last name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_patient.email.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the email" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_patient.telephone.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the phone number" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_patient.ssnDigits.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the last 4 digits of SSN" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else {
            
            [[AppController sharedInstance] updatePatient:_patient WithCompletion:^(BOOL success, NSString *message) {
                NSString *title = @"succeed";
                if (success == false)
                {
                    title = @"failed";
                } else {
                    //     [self.delegate patientEditDone:patient1];
                }
                
                
                //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
                //   [self dismissViewControllerAnimated:YES completion:nil];
            }];
            
        }
        
        
        
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                           target:self
                                                                                           action:@selector(rightNaviButtonClicked)];
    
    
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshAllData];
    
    profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
    profileIMGView2.layer.masksToBounds = YES;
    profileIMGView2.layer.borderColor = [UIColor whiteColor].CGColor;
    profileIMGView2.layer.borderWidth = 3.0;
    
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    [profileIMGView3 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
}

- (void)refreshAllData
{
    [self getPatientContion];
    [self getPatientNotes];
    [self getPatientAppointments];
    [self getPatientAllergy];
    [self getPatientMedication];
}

- (void)getPatientContion {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllConditionByPatient2:_patient.postid doctor:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions)
     
     {
         [SVProgressHUD dismiss];
         if (success)
         {
             [_patient.conditions removeAllObjects];
             [_patient.conditions addObjectsFromArray:conditions];
             [_tableView reloadData];
             
             if (conditions.count > 1) {
                 messageNOLabel2.text = [NSString stringWithFormat:@"%i Conditions", (int)conditions.count];
             } else {
                 messageNOLabel2.text = [NSString stringWithFormat:@"%i Condition", (int)conditions.count ];
             }
         }
     }];
    
}

- (void)getPatientNotes
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllNotesByPatient2:_patient.postid doctor:_patient.docid
                                           WithCompletion:^(BOOL success, NSString *message, NSMutableArray *notes)
     {
         [SVProgressHUD dismiss];
         if (success)
         {
             [_patient.notes removeAllObjects];
             [_patient.notes addObjectsFromArray:notes];
             [_tableView reloadData];
         }
     }];
}

- (void)getPatientAppointments
{
    [SVProgressHUD showWithStatus:@"Loading..."];
       [[AppController sharedInstance] getAllAppointmensByPatient2:_patient.postid doctor:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.appointments removeAllObjects];
            [_patient.appointments addObjectsFromArray:conditions];
            [_tableView reloadData];
            
            if (conditions.count > 1) {
                appointmentNOLabel2.text = [NSString stringWithFormat:@"%i Appointments", (int)conditions.count];
            } else {
                appointmentNOLabel2.text = [NSString stringWithFormat:@"%i Appointments", (int)conditions.count];
            }
        }
    }];
}

- (void)getPatientAllergy
{
    [SVProgressHUD showWithStatus:@"Loading..."];
     [[AppController sharedInstance] getAllAllergenByPatient2:_patient.postid doctor:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions)  {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.allergies removeAllObjects];
            [_patient.allergies addObjectsFromArray:conditions];
            [_tableView reloadData];
        }
        
    }];
}

-(void)getPatientMedication {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllMedicationByPatient2:_patient.postid doctor:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.medications removeAllObjects];
            [_patient.medications addObjectsFromArray:conditions];
            [_tableView reloadData];
            
            if (conditions.count > 1) {
                refillNOLabel2.text = [NSString stringWithFormat:@"%i Prescriptions", (int)conditions.count];
            } else {
                refillNOLabel2.text = [NSString stringWithFormat:@"%i Prescriptions", (int)conditions.count];
            }
        }
    }];
}


#pragma mark - PatientsTableViewCellDelegate
- (void)PatientsTableViewCellRefreshButtonClicked:(PatientsTableViewCell *)cell
{
    [self refreshAllData];
}


- (IBAction)changeProfilePicture:(id)sender {
  /*  UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Update Patient Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isProfileUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isProfileUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        
        
        
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //  [self dismissViewControllerAnimated:self completion:nil];
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];*/
    
    
}

- (void)PatientsTableViewCellImageButtonClicked:(PatientsTableViewCell *)cell {
   /* UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Update Patient Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isProfileUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        isProfileUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        
        
        
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //  [self dismissViewControllerAnimated:self completion:nil];
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    
    UIPopoverPresentationController *popPresenter = [actionSheet
                                                     popoverPresentationController];
    popPresenter.sourceView = cell;
    popPresenter.sourceRect = cell.bounds;
    [self presentViewController:actionSheet animated:YES completion:nil];*/
    
}

- (void)patientEditDone:(Patient *)patientinfo {
    _patient.firstName = patientinfo.firstName;
    _patient.lastName = patientinfo.lastName;
    _patient.email = patientinfo.email;
    _patient.telephone = patientinfo.telephone;
    _patient.gender = patientinfo.gender;
    _patient.street1 = patientinfo.street1;
    _patient.street2 = patientinfo.firstName;
    _patient.city = patientinfo.city;
    _patient.zipcode = patientinfo.zipcode;
    _patient.state = patientinfo.state;
    _patient.country = patientinfo.country;
    _patient.dob = patientinfo.dob;
    _patient.occupation = patientinfo.occupation;
    _patient.ssnDigits = patientinfo.ssnDigits;
    [self refreshAllData];
    [self.delegate refreshPatientList];
}

#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNumber = 0;
    /* switch (section)
     {
     case 0:
     {
     rowNumber = 1;
     break;
     }
     case 1:
     {
     rowNumber = 11;
     break;
     }
     case 2:
     {
     rowNumber = [_patient.medications count] + 1;
     break;
     }
     case 3:
     {
     rowNumber = _patient.conditions.count  + 1;
     break;
     }
     case 4:
     {
     rowNumber = [_patient.allergies count] + 1;
     break;
     }
     case 5:
     {
     rowNumber = [_patient.notes count] + 1;
     break;
     }
     case 6:
     {
     rowNumber = [_patient.appointments count]  + 1;
     break;
     }
     default:
     {
     rowNumber = 0;
     break;
     }
     }*/
    
    switch (section)
    {
            
        case 0:
        {
            rowNumber = 11;
            break;
        }
        case 1:
        {
            rowNumber = [_patient.medications count];
            break;
        }
        case 2:
        {
            rowNumber = _patient.conditions.count ;
            break;
        }
        case 3:
        {
            rowNumber = [_patient.allergies count];
            break;
        }
        case 4:
        {
            rowNumber = [_patient.notes count] ;
            break;
        }
        case 5:
        {
            rowNumber = [_patient.appointments count]  ;
            break;
        }
        default:
        {
            rowNumber = 0;
            break;
        }
    }
    
    
    
    return rowNumber;
}

#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    switch (section)
    {
            
        case 0:
        {
            title = @"About";
            break;
        }
        case 1:
        {
            title = @"Medication";
            break;
        }
        case 2:
        {
            title = @"Conditions";
            break;
        }
        case 3:
        {
            title = @"Allergies";
            break;
        }
        case 4:
        {
            title = @"Notes";
            break;
        }
        case 5:
        {
            title = @"Appointments";
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if (indexPath.section == 0)
     {
     PatientsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDetailPatientsCellID];
     
     if (cell == nil)
     {
     cell = [[PatientsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
     reuseIdentifier:kDetailPatientsCellID] ;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.hideRefreshButton = FALSE;
     cell.delegate = self;
     }
     
     cell.patient = _patient;
     
     return cell;
     }
     else*/ if(indexPath.section == 0)
     {
         AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAboutCellID];
         //if (cell == nil)
         //{
         cell = [[AboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:kAboutCellID];
         cell.keyLabel.text = [self aboutTitleByRow:indexPath.row];
         cell.valueLabel.text = [self aboutValueByRow:indexPath.row];
         cell.valueLabel.tag = indexPath.row + 100;
         
         if (indexPath.row == 7) {
             countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
             countryPicker.delegate = self;
             cell.valueLabel.inputView = countryPicker;
         }
         
         if (indexPath.row == 0) {
             
             //cell.valueLabel.inputView = datePick;
         }
         
         if (_tableView.editing == true) {
             cell.valueLabel.borderStyle = UITextBorderStyleBezel;
             cell.valueLabel.enabled = true;
             cell.valueLabel.delegate = self;
         } else {
             cell.valueLabel.enabled = false;
         }
         //}
         return cell;
     } else if (indexPath.section == 1) {
         
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
         if (cell == nil)
         {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:kNormalCellID];
         }
         
         if (_patient.medications.count > 0)
         {
             if (_patient.medications.count == indexPath.row)
             {
                 
                 cell.textLabel.text = @"Add...";
                 
                 if (IS_IPHONE) {
                     cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
                 }
                 
             } else {
                 
                 PatientMedication *patientInfo = [_patient.medications objectAtIndex:indexPath.row];
                 cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", patientInfo.medname, patientInfo.requests];
                 if (IS_IPHONE) {
                     cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
                 }
                 
             }
         } else {
             cell.textLabel.text = @"Add...";
             if (IS_IPHONE) {
                 cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
             }
         }
         return cell;
     }
     else if (indexPath.section == 2) {
         
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
         if (cell == nil)
         {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:kNormalCellID];
         }
         
         if (_patient.conditions.count > 0)
         {
             if (_patient.conditions.count == indexPath.row)
             {
                 
                 cell.textLabel.text = @"Add...";
                 if (IS_IPHONE) {
                     cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
                 }
             } else {
                 
                 Condition *patientInfo = [_patient.conditions objectAtIndex:indexPath.row];
                 cell.textLabel.text = patientInfo.conditionName;
                 if (IS_IPHONE) {
                     cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
                 }
                 
             }
         } else {
             cell.textLabel.text = @"Add...";
             if (IS_IPHONE) {
                 cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
             }
         }
         return cell;
     }
     else if (indexPath.section == 4)
     {
         //NOTES
         
         
         if (indexPath.row < _patient.notes.count)
         {
             NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDetailNoteCellID];
             if (cell == nil)
             {
                 cell = [[NoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:kDetailNoteCellID];
             }
             cell.note = [_patient.notes objectAtIndex:indexPath.row];
             
             return cell;
         }
         else
         {
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
             if (cell == nil)
             {
                 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:kNormalCellID];
             }
             cell.textLabel.text = @"Add...";
             if (IS_IPHONE) {
                 cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
             }
             
             return cell;
         }
         
         //return cell;
     } else if (indexPath.section == 5) {
         
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
         if (cell == nil)
         {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:kNormalCellID];
         }
         
         if (_patient.appointments.count > 0)
         {
             if (_patient.appointments.count == indexPath.row)
             {
                 
                 cell.textLabel.text = @"Add...";
                 if (IS_IPHONE) {
                     cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
                 }
                 
             } else {
                 
                 Appointments *patientInfo = [_patient.appointments objectAtIndex:indexPath.row];
                 cell.textLabel.text = patientInfo.apptitle;
                 //cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
                 if (IS_IPHONE) {
                     cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
                 }
                 
                 
             }
         } else {
             cell.textLabel.text = @"Add...";
             if (IS_IPHONE) {
                 cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
             }
             
         }
         return cell;
     } else if (indexPath.section == 3) {
         
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
         if (cell == nil)
         {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:kNormalCellID];
         }
         
         if (_patient.allergies.count > 0)
         {
             if (_patient.allergies.count == indexPath.row)
             {
                 
                 cell.textLabel.text = @"Add...";
                 if (IS_IPHONE) {
                     cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
                 }
                 
             } else {
                 
                 Allergen *patientInfo = [_patient.allergies objectAtIndex:indexPath.row];
                 cell.textLabel.text = patientInfo.PicklistDesc;
                 if (IS_IPHONE) {
                     cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
                 }
                 
                 
             }
         } else {
             cell.textLabel.text = @"Add...";
             if (IS_IPHONE) {
                 cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
             }
             
         }
         return cell;
     }
    
    
     else
     {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
         if (cell == nil)
         {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:kNormalCellID];
             cell.textLabel.text = @"Add....";
             if (IS_IPHONE) {
                 cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
             }
             
         }
         return cell;
     }
}

- (NSString *)normalCellTitleByIndex:(NSIndexPath *)indexPath
{
    NSString *title = @"";
    switch (indexPath.section)
    {
        case 1:
        {
            //@"Medication";
            if (indexPath.row >=[_patient.medications count])
            {
                title = @"+Add...";
            }
            else
            {
                title = [_patient.medications objectAtIndex:indexPath.row];
            }
            break;
        }
        case 2:
        {
            //@"Conditions";
            if (indexPath.row >=[_patient.conditions count])
            {
                title = @"+Add...";
            }
            else
            {
                //title = [_patient.conditions objectAtIndex:indexPath.row];
                
                Condition *patientInfo = [_patient.conditions objectAtIndex:indexPath.row];
                //  cell.textLabel.text = patientInfo.conditionName;
                title =patientInfo.conditionName;
            }
            break;
        }
        case 3:
        {
            //@"Allergies";
            if (indexPath.row >=[_patient.allergies count])
            {
                title = @"+Add...";
            }
            else
            {
                title = [_patient.allergies objectAtIndex:indexPath.row];
            }
            break;
        }
        case 4:
        {
            //@"Notes";
            if (indexPath.row ==[_patient.notes count] )
            {
                title = @"+Add...";
            }
            else
            {
                title = @"";
            }
            break;
        }
        case 5:
        {
            //@"Appointments";
            if (indexPath.row >=[_patient.appointments count])
            {
                title = @"+Add...";
            }
            else
            {
                Appointments *appointment = [_patient.appointments objectAtIndex:indexPath.row];
                title = appointment.apptitle;
            }
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


- (NSString *)aboutValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[_patient.dob integerValue]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd MMMM yyyy"];
            title = [formatter stringFromDate:dob];
            break;
        }
        case 1:
        {
            title = _patient.occupation;
            break;
        }
        case 2:
        {
            title = _patient.gender;
            break;
        }
        case 3:
        {
            title = [NSString stringWithFormat:@"%@", _patient.street1];
            break;
        }
        case 4:
        {
            title = [NSString stringWithFormat:@"%@", _patient.street2];
            break;
        }
        case 5:
        {
            title = [NSString stringWithFormat:@"%@", _patient.city];
            break;
        }
        case 6:
        {
            title = [NSString stringWithFormat:@"%@", _patient.state];
            break;
        }
        case 7:
        {
            title = [NSString stringWithFormat:@"%@", _patient.country];
            break;
        }
        case 8:
        {
            title = _patient.telephone;
            break;
        }
        case 9:
        {
            title = _patient.email;
            break;
        }
        case 10:
        {
            title = _patient.ssnDigits;
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

- (NSString *)aboutTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Date of Birth";
            break;
        }
        case 1:
        {
            title = @"Job";
            break;
        }
        case 2:
        {
            title = @"Gender";
            break;
        }
        case 3:
        {
            title = @"Street 1";
            break;
        }
        case 4:
        {
            title = @"Street 2";
            break;
        }
        case 5:
        {
            title = @"City";
            break;
        }
        case 6:
        {
            title = @"State";
            break;
        }
        case 7:
        {
            title = @"Country";
            break;
        }
        case 8:
        {
            title = @"Phone";
            break;
        }
        case 9:
        {
            title = @"Email";
            break;
        }
        case 10:
        {
            title = @"SSN";
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        
    }
    
    if (indexPath.section < 1)
    {
        return UITableViewCellEditingStyleNone;
    }
    else
    {
        NSMutableArray *dataArrary = [NSMutableArray array];
        switch (indexPath.section)
        {
            case 1:
            {
                //@"Medication";
                dataArrary = _patient.medications;
                break;
            }
            case 2:
            {
                //@"Conditions";
                dataArrary = _patient.conditions;
                break;
            }
            case 3:
            {
                //@"Allergies";
                dataArrary = _patient.allergies;
                break;
            }
            case 4:
            {
                //@"Notes";
                dataArrary = _patient.notes;
                break;
            }
            case 5:
            {
                //@"Appointments";
                dataArrary = _patient.appointments;
                break;
            }
            default:
            {
                break;
            }
        }
        
        if (indexPath.row > [dataArrary count] - 1)
        {
            return UITableViewCellEditingStyleNone;
        }
        else
        {
            return UITableViewCellEditingStyleNone;

        }
        
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if (indexPath.section == 0)
     {
     return kPatientsTableViewCellHeight;
     }
     else if(indexPath.section == 1)
     {
     return kAboutTableViewCellHeight;
     }
     else
     {
     return 30;
     }
     */
    
    if(indexPath.section == 0)
    {
        return kAboutTableViewCellHeight;
    }
    else
    {
        return 30;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.section : %d", indexPath.section);
    if (indexPath.section == 0) {
        if (IS_IPHONE) {
           /* UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            EditPatientiPhoneViewController *vc = (EditPatientiPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"EditPatientiPhoneViewController"];
            
            vc.patient = _patient;
            vc.delegate = self;
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            
            [self presentViewController:nav animated:YES completion:nil];*/
            
            
            
        } else {
          /*  UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            EditPatientViewController *vc = (EditPatientViewController *)[sb instantiateViewControllerWithIdentifier:@"EditPatientViewController"];
            
            vc.patient = _patient;
            vc.delegate = self;
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            
            UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
            
            [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];*/
            
        }
    } else if (indexPath.section == 1)
    {
        if (_patient.medications.count > 0) {
            if (_patient.medications.count == indexPath.row) {
                
            } else {
                PatientMedication *medication = [_patient.medications objectAtIndex:indexPath.row];
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                PatientDrugDetailsViewController *vc = (PatientDrugDetailsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDrugDetailsViewController"];
                
                vc.patient = _patient;
                vc.medication = medication;
                vc.delegate = self;
                vc.isSharedRecord = true;
                
                if (IS_IPHONE) {
                    //  [self.navigationController pushViewController:vc animated:YES];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self presentViewController:nav animated:YES completion:nil];
                } else {
                    
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    
                    
                    UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                    
                    [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                    
                }
            }
        } else if (indexPath.row == 0) {
    
        }
    }
    if (indexPath.section == 4)
    {
        //NOTE
        if (indexPath.row >= _patient.notes.count)
        {
            [self showNoteChooseTypePopup];
        }
        else
        {
            NoteTableViewCell *noteCell = (NoteTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            if (noteCell.type == NoteTableViewCellText)
            {
                [[TextPopup popUpViewText:noteCell.note.notetext] showInKeyWindow];
            }
            else if(noteCell.type == NoteTableViewCellImage)
            {
                [self showRemoteImage:noteCell.note.noteimage];
            }
            else if(noteCell.type == NoteTableViewCellRecording)
            {
                [self playRemoteAudio:noteCell.note.noterecording];
            }
        }
    } else if (indexPath.section == 5)
    {
        //NOTE
        if (indexPath.row >= _patient.appointments.count)
        {
            //   [self showNoteChooseTypePopup];
            
            if (IS_IPHONE) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                
                // CKCalendarEvent *test = [self.data objectForKey:date];
                CreateNewEventViewController *vc = (CreateNewEventViewController *)[sb instantiateViewControllerWithIdentifier:@"CreateNewEventViewController"];
                // vc.appointment = event.appointment;
                vc.delegate =self;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                
                NSString *patientFullname = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
                
                AddAppointmentViewController *popoverControllerAdd = [[AddAppointmentViewController alloc] init];
                [popoverControllerAdd setProtocol:self];
                popoverControllerAdd.patientFullName = patientFullname;
                popoverControllerAdd.patientID = _patient.postid;
                [popoverControllerAdd setPatientFullName:patientFullname];
                [ popoverControllerAdd.patientButton setTitle:patientFullname forState:UIControlStateNormal];
                
                popoverControllerAdd.preferredContentSize =  CGSizeMake(300., 700.);
                
                UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popoverControllerAdd];
                //popover.con = CGSizeMake(300., 700.);
                
                [popover presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view  permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                
            }
        }
        else
        {
            
            if (IS_IPHONE) {
                Appointments *noteDic = [_patient.appointments objectAtIndex:indexPath.row];
                CalendarDetailViewController *vc = [[CalendarDetailViewController alloc] initWithNibName:@"CalendarDetailViewController" bundle:nil];
                vc.appointment = noteDic;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            } else {
                
                Appointments *noteDic = [_patient.appointments objectAtIndex:indexPath.row];
                double unixTimeStamp =[noteDic.fromdate doubleValue];
                NSTimeInterval _interval=unixTimeStamp;
                NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
                NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
                NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
                
                NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
                NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
                NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
                
                NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
                
                
                double unixTimeStamp2 =[noteDic.todate doubleValue];
                NSTimeInterval _interval2=unixTimeStamp2;
                NSDate* sourceDate2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
                NSTimeZone* sourceTimeZone2 = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
                NSTimeZone* destinationTimeZone2 = [NSTimeZone systemTimeZone];
                
                NSInteger sourceGMTOffset2 = [sourceTimeZone secondsFromGMTForDate:sourceDate2];
                NSInteger destinationGMTOffset2 = [destinationTimeZone2 secondsFromGMTForDate:sourceDate2];
                NSTimeInterval interval2 = destinationGMTOffset2 - sourceGMTOffset2;
                
                NSDate* destinationDate2 = [[NSDate alloc] initWithTimeInterval:interval2 sinceDate:sourceDate2];
                
                NSString *paitentName = [NSString stringWithFormat:@"%@ %@", noteDic.firstname, noteDic.lastname];
                
                
                FFEvent *event1 = [FFEvent new];
                [event1 setStringCustomerName: paitentName];
                [event1 setNumCustomerID:[NSNumber numberWithInt:[noteDic.patientid intValue] ]];
                [event1 setDateDay:destinationDate];
                [event1 setDateTimeBegin:destinationDate];
                [event1 setDateTimeEnd:destinationDate2];
                [event1 setCusFirstname:noteDic.firstname];
                [event1 setCusLastname:noteDic.lastname];
                [event1 setCusTitle:noteDic.apptitle];
                [event1 setCusNotes:noteDic.appnotes];
                [event1 setCusID:noteDic.appid];
                [event1 setCusEmail:noteDic.patientemail];
                [event1 setCusTele:noteDic.patienttele];
                // [event1 setArrayWithGuests:[NSMutableArray arrayWithArray:@[@[@111, @"Guest 2", @"email2@email.com"], @[@111, @"Guest 4", @"email4@email.com"], @[@111, @"Guest 5", @"email5@email.com"], @[@111, @"Guest 7", @"email7@email.com"]]]];
                
                AppointmentDetailViewController *popoverControllerAdd = [[AppointmentDetailViewController alloc] init];
                
                popoverControllerAdd.view.frame = CGRectMake(0, 0, 360, 500);
                [popoverControllerAdd setProtocol:self];
                [popoverControllerAdd setEvent:event1];
                
                popoverControllerAdd.preferredContentSize =  CGSizeMake(360., 500.);
                
                popover2 = [[UIPopoverController alloc] initWithContentViewController:popoverControllerAdd];
                //popover.con = CGSizeMake(300., 700.);
                
                //[popover2 presentPopoverFromRect:[tableView cellForRowAtIndexPath:indexPath].frame inView:self.view  permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                [popover2 presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view  permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                
            }
            
        }
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)refreshPationInfo {
    [self getPatientContion];
}

#pragma  mark - NOTEs
- (void)showNoteChooseTypePopup
{
    [UIAlertView showWithTitle:@"Choose Note Type:"
                       message:nil
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"Text", @"Photo", @"Audio"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
     {
         if (buttonIndex == 0)
         {
             //cancel, do nothing
             
         }
         else if (buttonIndex == 1)
         {
             //Text
             [self showNoteTextInputPopup];
         }
         else if (buttonIndex == 2)
         {
             //Photo
             [self showNotePhotoInputPopup];
         }
         else if (buttonIndex == 3)
         {
             //Audio
             [self showNoteAudioInputPopup];
         }
     }];
}

- (void)showNoteTextInputPopup
{
    [UIAlertView showWithTitle:@"Input Note:"
                       message:nil
                         style:UIAlertViewStylePlainTextInput
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"OK"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              NSString *noteString = [alertView textFieldAtIndex:0].text;
                              [noteString length];
                              [self addTextNote:noteString];
                          }
                      }];
}

- (void)showNotePhotoInputPopup
{
    [UIAlertView showWithTitle:@"Pick Photo From:"
                       message:nil
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"Camera", @"Photo Library"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              [self takePhotoFrom:UIImagePickerControllerSourceTypeCamera];
                          }
                          else if (buttonIndex == 2)
                          {
                              [self takePhotoFrom:UIImagePickerControllerSourceTypePhotoLibrary];
                          }
                      }];
}

- (void)takePhotoFrom:(UIImagePickerControllerSourceType)type
{
    if ([UIImagePickerController isSourceTypeAvailable:type])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        [UIAlertView showWithTitle:nil
                           message:@"Source is not available."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:nil];
    }
}

- (void)showNoteAudioInputPopup
{
    [UIAlertView showWithTitle:@"Pick Audio From:"
                       message:nil
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"Recording"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              [self recordingAudio];
                          }
                          else if (buttonIndex == 2)
                          {
                              [self takeAudioFrom:MPMediaTypeAnyAudio];
                          }
                      }];
}

- (void)takeAudioFrom:(MPMediaType)type
{
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:type];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = NO;
    [self presentViewController:mediaPicker animated:YES completion:nil];
}

- (void)recordingAudio
{
    IQAudioRecorderController *controller = [[IQAudioRecorderController alloc] init];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)playRemoteAudio:(NSString *)audioLink
{
    // Initialize the movie player view controller with a video URL string
    MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:audioLink]] ;
    
    // Remove the movie player view controller from the "playback did finish" notification observers
    [[NSNotificationCenter defaultCenter] removeObserver:playerVC
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:playerVC.moviePlayer];
    
    // Register this class as an observer instead
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:playerVC.moviePlayer];
    
    // Set the modal transition style of your choice
    playerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    // Present the movie player view controller
    [self presentMoviePlayerViewControllerAnimated:playerVC];
    
    // Start playback
    [playerVC.moviePlayer prepareToPlay];
    [playerVC.moviePlayer play];
}

- (void)showRemoteImage:(NSString *)imageLink
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    imageLink = [imageLink stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
    NSURL *imageURL = [NSURL URLWithString:imageLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.center = self.view.center;
        imageView.backgroundColor = [UIColor redColor];
        imageView.image = responseObject;
        [EXPhotoViewer showImageFrom:imageView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [UIAlertView showWithTitle:@"Failed"
                           message:@"Image download failed."
                 cancelButtonTitle:@"Ok"
                 otherButtonTitles:nil tapBlock:nil];
    }];
    [requestOperation start];
    
    
    
}
#pragma mark - Add Note API
- (void)addImageNote:(UIImage *)image
{
   /* [[AppController sharedInstance] addProfilePhotoNote:image
                                              ToPatient:_patient.postid
                                             completion:^(BOOL success, NSString *message)
     {
         if (success)
         {
             [self getPatientNotes];
         }
         [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
     }];*/
}

- (void)addTextNote:(NSString *)textNote
{
    /*[[AppController sharedInstance] addProfileTextNote:textNote
                                             ToPatient:_patient.postid
                                            completion:^(BOOL success, NSString *message)
     {
         if (success)
         {
             [self getPatientNotes];
         }
         
         [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
     }];*/
}

- (void)addAudioNote:(NSString *)audioFilePath
{
    /*[[AppController sharedInstance] addProfileAudioNote:audioFilePath
                                              ToPatient:_patient.postid
                                             completion:^(BOOL success, NSString *message)
     {
         if (success)
         {
             [self getPatientNotes];
         }
         [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
     }];*/
}

#pragma mark - Update Profile Image

- (void)updateProfileImage:(UIImage *)img
{
    [[AppController sharedInstance] updatePatientIMG:_patient.postid img:img WithCompletion:^(BOOL success, NSString *message) {
        NSString *title = @"succeed";
        if (success == false)
        {
            title = @"failed";
        } else {
            [self.delegate refreshPatientList];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (isProfileUpdate == false) {
        
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        [self addImageNote:chosenImage];
    } else {
        isProfileUpdate = false;
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        [picker dismissViewControllerAnimated:YES completion:NULL];
        [self updateProfileImage:chosenImage];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - MPMediaPickerControllerDelegate
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker
  didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //TODO: ADD Audio to note
    NSLog(@"You picked : %@",mediaItemCollection);
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IQAudioRecorderControllerDelegate

-(void)audioRecorderController:(IQAudioRecorderController*)controller didFinishWithAudioAtPath:(NSString*)filePath
{
    [self addAudioNote:filePath];
}

-(void)audioRecorderControllerDidCancel:(IQAudioRecorderController*)controller
{
    
}

#pragma mark - movieFinishedCallback
- (void)movieFinishedCallback:(NSNotification*)aNotification
{
    // Obtain the reason why the movie playback finished
    NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    // Dismiss the view controller ONLY when the reason is not "playback ended"
    if ([finishReason intValue] != MPMovieFinishReasonPlaybackEnded)
    {
        MPMoviePlayerController *moviePlayer = [aNotification object];
        
        // Remove this class from the observers
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:moviePlayer];
        
        // Dismiss the view controller
        [self dismissMoviePlayerViewControllerAnimated];
    }
}

- (void)refreshCalendar {
    [self getPatientAppointments];
    [popover2 dismissPopoverAnimated:YES];
}

- (void)refreshPatientAllergy {
    [self getPatientAllergy];
}

- (void)refreshMedicationAdd {
    [self getPatientMedication];
}

- (void)refreshRefillMedication {
    [self getPatientMedication];
}

- (void)createdNewEvent {
    [self getPatientAppointments];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        [textField resignFirstResponder];
        datePick.hidden = false;
        datePickerContainer.hidden = false;
        double unixTimeStamp =[_patient.dob doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
        NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        datePick.date = destinationDate;
        
        /*         UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Date of birth" message:@"\n\n\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
         
         
         
         UIAlertAction *contactAction = [UIAlertAction actionWithTitle:@"Select Date" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         // __strong ViewController *sself = wself;
         
         }];
         
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
         
         }];
         
         UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 200, 300)];
         datePick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
         datePick.datePickerMode = UIDatePickerModeDate;
         [v addSubview:datePick];
         // [actionSheet.view setBounds:CGRectMake(7, 180, self.view.frame.size.width, 470)];
         [actionSheet.view addSubview:v];
         [actionSheet addAction:contactAction];
         [actionSheet addAction:cancelAction];
         
         
         
         [self presentViewController:actionSheet animated:YES completion:nil];*/
        
    } else if (textField.tag == 102) {
        [textField resignFirstResponder];
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Gender" message:@"Select the gender" preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction *maleAction = [UIAlertAction actionWithTitle:@"Male" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // __strong ViewController *sself = wself;
            _patient.gender = @"M";
            [_tableView reloadData];
        }];
        
        UIAlertAction *femaleAction = [UIAlertAction actionWithTitle:@"Female" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // __strong ViewController *sself = wself;
            _patient.gender = @"F";
            [_tableView reloadData];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        [actionSheet addAction:maleAction];
        [actionSheet addAction:femaleAction];
        [actionSheet addAction:cancelAction];
        
        
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 100) {
        [textField resignFirstResponder];
        
    } else if (textField.tag == 101) {
        [textField resignFirstResponder];
        _patient.occupation = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 102) {
        [textField resignFirstResponder];
    } else if (textField.tag == 103) {
        [textField resignFirstResponder];
        _patient.street1 = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 104) {
        [textField resignFirstResponder];
        _patient.street2 = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 105) {
        [textField resignFirstResponder];
        _patient.city = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 106) {
        [textField resignFirstResponder];
        _patient.state = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 107) {
        [textField resignFirstResponder];
        
    } else if (textField.tag == 108) {
        [textField resignFirstResponder];
        _patient.telephone = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 109) {
        [textField resignFirstResponder];
        _patient.email = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 110) {
        [textField resignFirstResponder];
        _patient.ssnDigits = textField.text;
        [_tableView reloadData];
    }
    
    return YES;
}




- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        //  [textField resignFirstResponder];
        
    } else if (textField.tag == 101) {
        //[textField resignFirstResponder];
        _patient.occupation = textField.text;
        // [_tableView reloadData];
    } else if (textField.tag == 102) {
        //[textField resignFirstResponder];
    } else if (textField.tag == 103) {
        // [textField resignFirstResponder];
        _patient.street1 = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 104) {
        //  [textField resignFirstResponder];
        _patient.street2 = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 105) {
        //  [textField resignFirstResponder];
        _patient.city = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 106) {
        //  [textField resignFirstResponder];
        _patient.state = textField.text;
        // [_tableView reloadData];
    } else if (textField.tag == 107) {
        // [textField resignFirstResponder];
        
    } else if (textField.tag == 108) {
        //[textField resignFirstResponder];
        _patient.telephone = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 109) {
        //  [textField resignFirstResponder];
        _patient.email = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 110) {
        //   [textField resignFirstResponder];
        _patient.ssnDigits = textField.text;
        //[_tableView reloadData];
    }
    
}


#pragma mark - UIPickerViewDataSource
- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    _patient.country = name;
    [_tableView reloadData];
}

- (IBAction)cancelDatePick:(id)sender {
    datePickerContainer.hidden = true;
}

- (IBAction)selectDatePick:(id)sender {
    datePickerContainer.hidden = true;
    
    NSTimeInterval t = [datePick.date timeIntervalSince1970];
    
    
    _patient.dob = [NSString stringWithFormat:@"%i",(int)t];
    datePick.hidden = true;
    [_tableView reloadData];
}


@end
