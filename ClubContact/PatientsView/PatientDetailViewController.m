//
//  PatientDetailViewController.m
//  ClubContact
//
//  Created by wangkun on 15/3/11.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import "PatientDetailViewController.h"
#import "AboutTableViewCell.h"

#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"
#import "SWRevealViewController.h"

#define kDetailPatientsCellID   @"patientCell"
#define kAboutCellID            @"aboutCell"
#define kNormalCellID           @"normalCell"
#define kDetailNoteCellID       @"noteCell"

@interface PatientDetailViewController () <CreateNewEventViewDelegate, PatientDrugDetailsDelegate> {
    UIPopoverController *popover2;
    BOOL isProfileUpdate;
    IBOutlet UIView *statView;
    
    IBOutlet UIImageView *profileIMGView2;
    IBOutlet UIImageView *profileIMGView3;
    IBOutlet UILabel *refillNOLabel2;
    IBOutlet UILabel *messageNOLabel2;
    IBOutlet UILabel *appointmentNOLabel2;
    IBOutlet UILabel *nameLabel2;
    IBOutlet UILabel *jobLabel2;
    IBOutlet UIDatePicker *datePick;
    UIPickerView *countryPicker;
    IBOutlet UISegmentedControl *genderPicker;
    IBOutlet UIView *datePickerContainer;
    BOOL isEnterNote;
    
    IBOutlet UILabel *conditionsLabel;
    IBOutlet UILabel *notesLabel;
    IBOutlet UILabel *allergiesLabel;
    IBOutlet UILabel *medicationLabel;
    IBOutlet UILabel *eyeExamLabel;
    
    IBOutlet UILabel *dobLabel;
    IBOutlet UILabel *ssnLabel;
    IBOutlet UILabel *addressLabel;
    IBOutlet UILabel *cityLabel;
    IBOutlet UILabel *countryLabel;
    IBOutlet UILabel *stateLabel;
    IBOutlet UILabel *genderLabel;
    IBOutlet UILabel *emailLabel;
    IBOutlet UILabel *phoneLabel;
    
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UIView *appointmentBox;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation PatientDetailViewController

@synthesize delegate;

@synthesize client;
@synthesize allergenClient;
@synthesize pickersController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"PATIENT PROFILE";
    
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
   
    
    isProfileUpdate = false;
    isEnterNote = true;
    
      self.client = [[DrugSearchAPIClient alloc] init];
    self.allergenClient = [[AllergenSearchAPIClient alloc] init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [_tableView registerNib:[UINib nibWithNibName:@"AppointmentDashTableViewCell" bundle:nil] forCellReuseIdentifier:kPatientsCellID];
    

    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
  
  /*  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    _tableView.tableHeaderView = statView;*/
      // [self.revealViewController revealToggle:nil];
    SWRevealViewController *revealController = [self revealViewController];
    
    
   // [revealController panGestureRecognizer];
   // [revealController tapGestureRecognizer];
    self.tableView.separatorColor = [UIColor clearColor];
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


- (IBAction)sharePatientRecord:(id)sender {
    SendPatientRecordsDoctor *vc = [[SendPatientRecordsDoctor  alloc] initWithNibName:@"SendPatientRecordsDoctor" bundle:nil];;
    vc.profPatient = _patient;
    
    [self.navigationController pushViewController:vc animated:YES];
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
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    

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
    profileIMGView2.layer.borderColor = [UIColor blackColor].CGColor;
    profileIMGView2.layer.borderWidth = 1.0;
    
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    //[profileIMGView3 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
    if (_patient.occupation != nil) {
         jobLabel2.text = [NSString stringWithFormat:@"%@", _patient.occupation];
    } else {
         jobLabel2.text = @"";
    }
   // jobLabel2.text = [NSString stringWithFormat:@"%@", _patient.occupation];
    
    addressLabel.text = [NSString stringWithFormat:@"Address: %@ %@", _patient.street1, _patient.street2];
    cityLabel.text = [NSString stringWithFormat:@"City: %@", _patient.city];
    stateLabel.text = [NSString stringWithFormat:@"State: %@", _patient.state];
    countryLabel.text =[NSString stringWithFormat:@"Country: %@", _patient.country];
    
    NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[_patient.dob integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    dobLabel.text = [NSString stringWithFormat:@"DOB: %@",[formatter stringFromDate:dob]];
    
    if ([_patient.gender isEqual:@"M"]) {
        genderLabel.text = @"Gender: Male";
        
    } else {
        genderLabel.text = @"Gender: Female";
    }
    
    ssnLabel.text = [NSString stringWithFormat:@"SSN: %@", _patient.ssnDigits];
    emailLabel.text = [NSString stringWithFormat:@"Email: %@",_patient.email];
    phoneLabel.text = [NSString stringWithFormat:@"Phone: %@",_patient.telephone];
    

    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (void)refreshAllData
{
    [self getPatientContion];
    [self getPatientNotes];
    [self getPatientAppointments];
    [self getPatientAllergy];
    [self getPatientMedication];
    [self getPatientEyeExam];
}

- (void)getPatientContion {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllConditionByPatient:_patient.postid
                                            docid:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions)
    {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.conditions removeAllObjects];
            [_patient.conditions addObjectsFromArray:conditions];
          //  [_tableView reloadData];
            
            if (conditions.count > 1) {
                messageNOLabel2.text = [NSString stringWithFormat:@"%i Conditions", (int)conditions.count];
            } else {
                messageNOLabel2.text = [NSString stringWithFormat:@"%i Condition", (int)conditions.count ];
            }
            
            conditionsLabel.text = [NSString stringWithFormat:@"%lu Conditions", (unsigned long)_patient.conditions.count];
        }
    }];

}

- (void)getPatientNotes
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllNotesByPatient:_patient.postid
                                        docid:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *notes)
    {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.notes removeAllObjects];
            [_patient.notes addObjectsFromArray:notes];
           // [_tableView reloadData];
            notesLabel.text = [NSString stringWithFormat:@"%lu Notes", (unsigned long)_patient.notes.count];
        }
    }];
}

- (void)getPatientAppointments
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllAppointmensByPatient:_patient.postid docid:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.appointments removeAllObjects];
            [_patient.appointments addObjectsFromArray:conditions];
            [_tableView reloadData];
            
            float tempApptHeight = 180;
            float tempApptOrigin = 0;
            
            if (_patient.appointments.count == 0) {
                tempApptOrigin = 0.0f;
                tempApptHeight = 0.0f;
                appointmentBox.hidden = true;
            } else {
                tempApptOrigin = 761.0f;
                appointmentBox.hidden = false;
                if (_patient.appointments.count == 1) {
                    tempApptHeight = 65.0f + (48.0f * 1);
                    
                } else if (_patient.appointments.count == 2) {
                    tempApptHeight = 65.0f + (48.0f * 2);
                } else {
                    tempApptHeight = 65.0f + (48.0f * 3);
                }
            }
            
            appointmentBox.frame = CGRectMake(appointmentBox.frame.origin.x, tempApptOrigin , appointmentBox.frame.size.width, tempApptHeight);
            
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
    [[AppController sharedInstance] getAllAllergenByPatient:_patient.postid docid:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.allergies removeAllObjects];
            [_patient.allergies addObjectsFromArray:conditions];
           // [_tableView reloadData];
            allergiesLabel.text = [NSString stringWithFormat:@"%lu Allergies", (unsigned long)_patient.allergies.count];
        }
        
    }];
}



- (void)getPatientEyeExam
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllEyeExamsByPatient2:_patient.postid docid:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [_patient.eyeexam removeAllObjects];
            [_patient.eyeexam addObjectsFromArray:conditions];
            //[_tableView reloadData];
             eyeExamLabel.text = [NSString stringWithFormat:@"%lu Eye Exams", (unsigned long)_patient.eyeexam.count];
        }
        
    }];
}

-(void)getPatientMedication {
     [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllMedicationByPatient:_patient.postid docid:_patient.docid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
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
            
            medicationLabel.text = [NSString stringWithFormat:@"%lu Prescriptions", (unsigned long)_patient.medications.count];
        }
    }];
}

- (IBAction)gotMedicationList:(id)sender {
   // Patient *patientInfo = [_patientsArray objectAtIndex:cellIndexPath.row];
    MedicationPListViewController  *vc = [[MedicationPListViewController alloc] init];
    vc.patient = _patient;
    vc.isSharedProfile = self.isSharedProfile;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goToConditionList:(id)sender {
    ConditionListNewViewController  *vc = [[ConditionListNewViewController alloc] init];
    vc.patient = _patient;
    vc.isSharedProfile = self.isSharedProfile;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)goToAllergies:(id)sender {
   AllergyListNewViewController  *vc = [[AllergyListNewViewController alloc] init];
    vc.patient = _patient;
    vc.isSharedProfile = self.isSharedProfile;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)goToNotes:(id)sender {
   NoteNewsViewController  *vc = [[NoteNewsViewController alloc] init];
    vc.patient = _patient;
    vc.isSharedProfile = self.isSharedProfile;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToEyeExam:(id)sender {
    EyeExamListViewController  *vc = [[EyeExamListViewController alloc] init];
    vc.patient = _patient;
    vc.isSharedProfile = self.isSharedProfile;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)addNewCelendarEven:(id)sender {
    if (self.isSharedProfile == false) {
    
    CreateNewEventViewController *vc = [[CreateNewEventViewController alloc] initWithNibName:@"CreateNewEventViewController" bundle:nil];
    // vc.appointment = event.appointment;
    vc.delegate =self;
    vc.patientID = _patient.postid;
    vc.patientFullName = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
    [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - PatientsTableViewCellDelegate
- (void)PatientsTableViewCellRefreshButtonClicked:(PatientsTableViewCell *)cell
{
    [self refreshAllData];
}




- (IBAction)changeProfilePicture:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Update Patient Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
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
    
        [self presentViewController:actionSheet animated:YES completion:nil];
    

}

- (void)PatientsTableViewCellImageButtonClicked:(PatientsTableViewCell *)cell {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Update Patient Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
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
    [self presentViewController:actionSheet animated:YES completion:nil];

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
    return 1;
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
            rowNumber = 13;
            break;
        }
        case 1:
        {
            rowNumber = [_patient.medications count] + 1;
            break;
        }
        case 2:
        {
            rowNumber = _patient.conditions.count  + 1;
            break;
        }
        case 3:
        {
            rowNumber = [_patient.allergies count] + 1;
            break;
        }
        case 4:
        {
            rowNumber = [_patient.notes count] + 1;
            break;
        }
        case 5:
        {
            rowNumber = [_patient.appointments count]  + 1;
            break;
        }
        case 6:
        {
            rowNumber = [_patient.eyeexam count]  + 1;
            break;
        }
        default:
        {
            rowNumber = 0;
            break;
        }
    }
    
    
    
    return _patient.appointments.count;
}

#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";

    /*switch (section)
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
        case 6:
        {
            title = @"Eye Exams";
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
    
    AppointmentDashTableViewCell *cell = (AppointmentDashTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
    
    Appointments *noteDic = [_patient.appointments objectAtIndex:indexPath.row];
    
    double unixTimeStamp =[noteDic.fromdate doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSDate* destinationDate = sourceDate;
    
    
    NSString *paitentName = [NSString stringWithFormat:@"Appointment with %@ %@", noteDic.firstname, noteDic.lastname];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM dd yyyy h:MM a"];
    cell.dateLabel.text = [formatter stringFromDate:destinationDate];
    
    cell.nameLabel.text = paitentName;
    
    return cell;

    
    /*if(indexPath.section == 0)
    {
        AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAboutCellID];
       
            cell = [[AboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:kAboutCellID];
            cell.keyLabel.text = [self aboutTitleByRow:indexPath.row];
            cell.valueLabel.text = [self aboutValueByRow:indexPath.row];
        cell.valueLabel.tag = indexPath.row + 100;
        
        if (indexPath.row == 10) {
            countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
            countryPicker.delegate = self;
            cell.valueLabel.inputView = countryPicker;
        }
        
        if (indexPath.row == 2) {
           
            //cell.valueLabel.inputView = datePick;
        }
        
        if (_tableView.editing == true) {
            if (indexPath.row != 2) {
            cell.valueLabel.borderStyle = UITextBorderStyleBezel;
            cell.valueLabel.enabled = true;
            cell.valueLabel.delegate = self;
                
            }
        } else {
              cell.valueLabel.enabled = false;
        }
        
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
                cell.textLabel.numberOfLines = 0;
                if (IS_IPHONE) {
                    cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
                }
                
            }
        } else {
            cell.textLabel.text = @"Add...";
            if (IS_IPHONE) {
                cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
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
                    cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
                }
            } else {

                Condition *patientInfo = [_patient.conditions objectAtIndex:indexPath.row];
                cell.textLabel.text = patientInfo.conditionName;
                if (IS_IPHONE) {
                    cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
                }
                
            }
        } else {
            cell.textLabel.text = @"Add...";
            if (IS_IPHONE) {
                cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
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
                cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
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
                    cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
                }

            } else {
                
                Appointments *patientInfo = [_patient.appointments objectAtIndex:indexPath.row];
                cell.textLabel.text = patientInfo.apptitle;
                //cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
                if (IS_IPHONE) {
                    cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
                }

                
            }
        } else {
            cell.textLabel.text = @"Add...";
            if (IS_IPHONE) {
                cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
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
                    cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
                }

            } else {
                
                Allergen *patientInfo = [_patient.allergies objectAtIndex:indexPath.row];
                cell.textLabel.text = patientInfo.PicklistDesc;
                if (IS_IPHONE) {
                    cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
                }

                
            }
        } else {
            cell.textLabel.text = @"Add...";
            if (IS_IPHONE) {
                cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
            }

        }
        return cell;
    }
    else if (indexPath.section == 6) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:kNormalCellID];
        }
        
        if (_patient.eyeexam.count > 0)
        {
            if (_patient.eyeexam.count == indexPath.row)
            {
                
                cell.textLabel.text = @"Add...";
                if (IS_IPHONE) {
                    cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
                }
                
            } else {
                
                EyeExam2 *eyeExam = [_patient.eyeexam objectAtIndex:indexPath.row];
                NSTimeInterval timestamp = [eyeExam.created doubleValue];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
                NSDateFormatter *dateFormat = [NSDateFormatter new];
                [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
                NSString *dateString = [dateFormat stringFromDate:date];
                cell.textLabel.text = dateString;
                if (IS_IPHONE) {
                    cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
                }
                
                
            }
        } else {
            cell.textLabel.text = @"Add...";
            if (IS_IPHONE) {
                cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
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
                cell.textLabel.font = [UIFont fontWithName:@"Myriad Pro" size:13.0f];//[UIFont systemFontOfSize:13.0f];
            }

        }
        return cell;
    }*/
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
            title = _patient.firstName;
            break;
        }
        case 1:
        {
            title = _patient.lastName;
            break;
        }
        case 2:
        {
            NSDate *dob = [NSDate dateWithTimeIntervalSince1970:[_patient.dob integerValue]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"dd MMMM yyyy"];
            title = [formatter stringFromDate:dob];
            break;
        }
        case 3:
        {
            title = _patient.occupation;
            break;
        }
        case 4:
        {
            title = _patient.gender;
            break;
        }
        case 5:
        {
            title = [NSString stringWithFormat:@"%@", _patient.street1];
            break;
        }
        case 6:
        {
            title = [NSString stringWithFormat:@"%@", _patient.street2];
            break;
        }
        case 7:
        {
            title = [NSString stringWithFormat:@"%@", _patient.city];
            break;
        }
        case 8:
        {
            title = [NSString stringWithFormat:@"%@", _patient.state];
            break;
        }
        case 9:
        {
            title = [NSString stringWithFormat:@"%@", _patient.country];
            break;
        }
        case 10:
        {
            title = _patient.telephone;
            break;
        }
        case 11:
        {
            title = _patient.email;
            break;
        }
        case 12:
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
            title = @"First Name";
            break;
        }
        case 1:
        {
            title = @"Last Name";
            break;
        }
        case 2:
        {
            title = @"Date of Birth";
            break;
        }
        case 3:
        {
            title = @"Job";
            break;
        }
        case 4:
        {
            title = @"Gender";
            break;
        }
        case 5:
        {
            title = @"Street 1";
            break;
        }
        case 6:
        {
            title = @"Street 2";
            break;
        }
        case 7:
        {
            title = @"City";
            break;
        }
        case 8:
        {
            title = @"State";
            break;
        }
        case 9:
        {
            title = @"Country";
            break;
        }
        case 10:
        {
            title = @"Phone";
            break;
        }
        case 11:
        {
            title = @"Email";
            break;
        }
        case 12:
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
    
    
    Appointments *appointment = [_patient.appointments objectAtIndex:indexPath.row];
    if (appointment)
    {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] deleteDoctorAppointment:appointment.appid completion:^(BOOL success, NSString *message) {
            
            [SVProgressHUD dismiss];
            if (success)
            {
                [self getPatientAppointments];
            }
            else
            {
                [UIAlertView showWithTitle:@"Failed" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
            }
            
            
        }];
    }

    
    // Remove the row from data model
   /* if (indexPath.section == 4)
    {
        if (indexPath.row < _patient.notes.count)
        {
            Note *note = [_patient.notes objectAtIndex:indexPath.row];
            if (note)
            {
                [SVProgressHUD showWithStatus:@"Loading..."];
                [[AppController sharedInstance] deleteProfileNote:note.noteID
                                                       completion:^(BOOL success, NSString *message)
                {
                    [SVProgressHUD dismiss];                    
                    if (success)
                    {
                        [self getPatientNotes];
                    }
                    else
                    {
                        [UIAlertView showWithTitle:@"Failed" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                    }
                }];
            }
        }
    }
    else if(indexPath.section == 2)
    {
        if (indexPath.row < _patient.conditions.count)
        {
            Condition *condition = [_patient.conditions objectAtIndex:indexPath.row];
            if (condition)
            {
                [SVProgressHUD showWithStatus:@"Loading..."];
                [[AppController sharedInstance] deleteProfileCondition:condition.nodeID
                                                            completion:^(BOOL success, NSString *message)
                {
                    [SVProgressHUD dismiss];
                    if (success)
                    {
                        [self getPatientContion];
                    }
                    else
                    {
                        [UIAlertView showWithTitle:@"Failed" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                    }
                }];
            }
        }
    }
    else if(indexPath.section == 5)
    {
        if (indexPath.row < _patient.appointments.count)
        {
            Appointments *appointment = [_patient.appointments objectAtIndex:indexPath.row];
            if (appointment)
            {
                [SVProgressHUD showWithStatus:@"Loading..."];
                [[AppController sharedInstance] deleteDoctorAppointment:appointment.appid completion:^(BOOL success, NSString *message) {
                    
                    [SVProgressHUD dismiss];
                    if (success)
                    {
                        [self getPatientAppointments];
                    }
                    else
                    {
                        [UIAlertView showWithTitle:@"Failed" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                    }

                    
                }];
            }
        }
    } else if(indexPath.section == 3)
    {
        if (indexPath.row < _patient.allergies.count)
        {
            Allergen *allergy = [_patient.allergies objectAtIndex:indexPath.row];
            if (allergy)
            {
                [SVProgressHUD showWithStatus:@"Loading..."];
                [[AppController sharedInstance] deleteProfileAllergy:allergy.postid  completion:^(BOOL success, NSString *message) {
                    
                    [SVProgressHUD dismiss];
                    if (success)
                    {
                        [self getPatientAllergy];
                    }
                    else
                    {
                        [UIAlertView showWithTitle:@"Failed" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                    }
                    
                    
                }];
            }
        }
    } else if(indexPath.section == 6)
    {
        if (indexPath.row < _patient.eyeexam.count)
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
    }*/
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
            return UITableViewCellEditingStyleDelete;
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
    return 48.0f;
    
    if(indexPath.section == 0)
    {
        return kAboutTableViewCellHeight;
    }
    else if(indexPath.section == 1)
    {
        
        int  rowHeigh = 30.0f;
        if (_patient.medications.count > 0)
        {
            if (_patient.medications.count == indexPath.row)
            {
                
               
                
            } else {
                
                PatientMedication *patientInfo = [_patient.medications objectAtIndex:indexPath.row];
             
                
                CGSize sizeOfText = [[NSString stringWithFormat:@"%@ (%@)", patientInfo.medname, patientInfo.requests] boundingRectWithSize: CGSizeMake(windowWidth, MAXFLOAT)
                                                        options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                     attributes: [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Helvetica" size:13.0]
                                                                                             forKey:NSFontAttributeName]
                                                        context: nil].size;
                
               rowHeigh = 30 + sizeOfText.height;

                
            }
        }
        
      
        return rowHeigh;

    } else
    {
        return 30;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    Appointments *noteDic = [_patient.appointments objectAtIndex:indexPath.row];
    CalendarDetailViewController *vc = [[CalendarDetailViewController alloc] initWithNibName:@"CalendarDetailViewController" bundle:nil];
    vc.appointment = noteDic;
    
    [self.navigationController pushViewController:vc animated:YES];
    
  /*  NSLog(@"indexPath.section : %d", indexPath.section);
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
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

            
        }
    } else if (indexPath.section == 1)
    {
        if (_patient.medications.count > 0) {
            if (_patient.medications.count == indexPath.row) {
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"New Medication" message:@"Select an option" preferredStyle:UIAlertControllerStyleActionSheet];
                
                
                UIAlertAction *conditionAction = [UIAlertAction actionWithTitle:@"Prescribe by condition" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                    ConditionListViewController *vc = (ConditionListViewController *)[sb instantiateViewControllerWithIdentifier:@"ConditionListViewController"];
                    
                    vc.patient = _patient;
                    vc.delegate = self;
                    
                    if (IS_IPHONE) {
                       // [self.navigationController pushViewController:vc animated:YES];
                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                        [self presentViewController:nav animated:YES completion:nil];
                    } else {
                    
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    
                    
                    UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                    
                    [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                        
                    }
                    
                    
                }];
                
                UIAlertAction *medicationAction = [UIAlertAction actionWithTitle:@"Prescribe by medication" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                    DrugsViewController *vc = (DrugsViewController *)[sb instantiateViewControllerWithIdentifier:@"DrugsViewController"];
                    vc.selectedConditions = [[NSMutableArray alloc] init];
                    vc.selectedAllergens = _patient.allergies;
                    vc.patient = _patient;
                    vc.delegate = self;
                    vc.isMedPres = true;
                    
                   // UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    
                    if (IS_IPHONE) {
                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                        [self presentViewController:nav animated:YES completion:nil];
                    } else {
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    
                    
                    UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                    
                    [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                        
                    }
                    
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
            } else {
                PatientMedication *medication = [_patient.medications objectAtIndex:indexPath.row];
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                PatientDrugDetailsViewController *vc = (PatientDrugDetailsViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDrugDetailsViewController"];
                
                vc.patient = _patient;
                vc.medication = medication;
                vc.delegate = self;
                
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
            
            
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"New Medication" message:@"Select an option" preferredStyle:UIAlertControllerStyleActionSheet];
            
            
            UIAlertAction *conditionAction = [UIAlertAction actionWithTitle:@"Prescribe by condition" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                ConditionListViewController *vc = (ConditionListViewController *)[sb instantiateViewControllerWithIdentifier:@"ConditionListViewController"];
                
                vc.patient = _patient;
                vc.delegate = self;
                
                if (IS_IPHONE) {
                  //  [self.navigationController pushViewController:vc animated:YES];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self presentViewController:nav animated:YES completion:nil];
                } else {
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                
                
                UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                
                [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                    
                }
                
                
            }];
            
            UIAlertAction *medicationAction = [UIAlertAction actionWithTitle:@"Prescribe by medication" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                DrugsViewController *vc = (DrugsViewController *)[sb instantiateViewControllerWithIdentifier:@"DrugsViewController"];
                vc.selectedConditions = [[NSMutableArray alloc] init];
                vc.selectedAllergens = _patient.allergies;
                vc.patient = _patient;
                vc.delegate = self;
                vc.isMedPres = true;
                
                if (IS_IPHONE) {
                   // [self.navigationController pushViewController:vc animated:YES];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self presentViewController:nav animated:YES completion:nil];
                } else {
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                
                
                UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                
                [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                    
                }
                
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
    }
    else if (indexPath.section == 2)
    {
        if (_patient.conditions.count > 0) {
            if (_patient.conditions.count == indexPath.row) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                AddConditionsViewController *vc = (AddConditionsViewController *)[sb instantiateViewControllerWithIdentifier:@"AddConditionsViewController"];
                
                vc.patientID = _patient.postid;
                
                vc.delegate = self;
                
                if (IS_IPHONE) {
                    // [self.navigationController pushViewController:vc animated:YES];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self presentViewController:nav animated:YES completion:nil];
                } else {
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                
                
                UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                
                [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                    
                }
            }
        } else if (indexPath.row == 0) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            AddConditionsViewController *vc = (AddConditionsViewController *)[sb instantiateViewControllerWithIdentifier:@"AddConditionsViewController"];
            
            vc.patientID = _patient.postid;
            
            
            
            vc.delegate = self;
            
            if (IS_IPHONE) {
                // [self.navigationController pushViewController:vc animated:YES];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [self presentViewController:nav animated:YES completion:nil];
            } else {
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            
            UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
            
            [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                
            }
        }

    } else if (indexPath.section == 3)
    {
        if (_patient.allergies.count > 0) {
            if (_patient.allergies.count == indexPath.row) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                AddAllergyViewController  *vc = (AddAllergyViewController *)[sb instantiateViewControllerWithIdentifier:@"AddAllergyViewController"];
                
                vc.patientID = _patient.postid;
                
                vc.delegate = self;
                
                if (IS_IPHONE) {
                    // [self.navigationController pushViewController:vc animated:YES];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self presentViewController:nav animated:YES completion:nil];
                }else {
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                
                
                UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                
                [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                    
                }
            }
        } else if (indexPath.row == 0) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            AddAllergyViewController  *vc = (AddAllergyViewController *)[sb instantiateViewControllerWithIdentifier:@"AddAllergyViewController"];
            
            vc.patientID = _patient.postid;
            
            vc.delegate = self;
            
            if (IS_IPHONE) {
                // [self.navigationController pushViewController:vc animated:YES];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [self presentViewController:nav animated:YES completion:nil];
            }else {
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            
            UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
            
            [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                
            }
        }
    }
    else if (indexPath.section == 4)
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
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                Appointments *noteDic = [_patient.appointments objectAtIndex:indexPath.row];
                CalendarDetailViewController *vc = (CalendarDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"CalendarDetailViewController"];
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
    }else if (indexPath.section == 6)
    {
        if (_patient.eyeexam.count > 0) {
            if (_patient.eyeexam.count == indexPath.row) {
                 [self addNewEyeExam];
                
            } else {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
            EyeExam2 *eyeExam = [_patient.eyeexam objectAtIndex:indexPath.row];
                if (eyeExam.formimage1.length > 0) {
                    
                    EyeExamImageViewController  *vc = (EyeExamImageViewController *)[sb instantiateViewControllerWithIdentifier:@"EyeExamImageViewController"];
                    
                    
                    
                    
                    vc.patientID = _patient.postid;
                    vc.eyeExam = eyeExam;
                    [self.navigationController pushViewController:vc animated:YES];
                } else {
                EyeExam2VC  *vc = (EyeExam2VC *)[sb instantiateViewControllerWithIdentifier:@"EyeExam2VC"];
                
                
                
                
                vc.patientID = _patient.postid;
                vc.eyeExam = eyeExam;
                
                
                // vc.delegate = self;
                
                if (IS_IPHONE) {
                    // [self.navigationController pushViewController:vc animated:YES];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    [self presentViewController:nav animated:YES completion:nil];
                }else {
                    
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                    
                    
                    UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                    
                    [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                    
                }
                }
            }
        } else if (indexPath.row == 0) {
            [self addNewEyeExam];
                   }
    }
    
*/
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)refreshPationInfo {
    [self getPatientContion];
}


- (void)addNewEyeExam {
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
             UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
             AddEyeExam2VC  *vc = (AddEyeExam2VC *)[sb instantiateViewControllerWithIdentifier:@"AddEyeExam2VC"];
             
             vc.patientID = _patient.postid;
             
             // vc.delegate = self;
             
             if (IS_IPHONE) {
                 // [self.navigationController pushViewController:vc animated:YES];
                 UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                 [self presentViewController:nav animated:YES completion:nil];
             }else {
                 
                 UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                 
                 
                 UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                 
                 [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                 
             }

            
         }
         else if (buttonIndex == 2)
         {
             //Photo
             UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
             DrawingEyeExamViewController  *vc = (DrawingEyeExamViewController *)[sb instantiateViewControllerWithIdentifier:@"DrawingEyeExamViewController"];
             
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

#pragma  mark - NOTEs
- (void)showNoteChooseTypePopup
{
    [UIAlertView showWithTitle:@"Choose Note Type:"
                       message:nil
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"Text", @"Photo", @"Audio", @"Draw"]
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
        } else if (buttonIndex == 4)
        {
            //Audio
            [self showDrawInputPopup];
        }
    }];
}

- (void)showDrawInputPopup
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    FreeDrawingViewController  *vc = (FreeDrawingViewController *)[sb instantiateViewControllerWithIdentifier:@"FreeDrawingViewController"];
    
    vc.patientID = _patient.postid;
    
    // vc.delegate = self;
    

    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)showNoteTextInputPopup
{
    __block NSString *stringNoteText = @"";
    [UIAlertView showWithTitle:@"Input Note:"
                       message:nil
                         style:UIAlertViewStylePlainTextInput
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"OK"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              stringNoteText = [alertView textFieldAtIndex:0].text;
                              //[noteString length];
                             // [self addTextNote:noteString];
                              [UIAlertView showWithTitle:@"Note Title:"
                                                 message:nil
                                                   style:UIAlertViewStylePlainTextInput
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@[@"OK"]
                                                tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                    if (buttonIndex == 1)
                                                    {
                              
                                                        NSString *noteTitle = [alertView textFieldAtIndex:0].text;
                                                        [self addTextNote:stringNoteText title:noteTitle];
                                                        
                                                    }}];
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
    [UIAlertView showWithTitle:@"Note Title:"
                       message:nil
                         style:UIAlertViewStylePlainTextInput
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"OK"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              
                              NSString *noteTitle = [alertView textFieldAtIndex:0].text;
                              //[self addTextNote:stringNoteText title:noteTitle];
                              [[AppController sharedInstance] addProfilePhotoNote:image
                                                                        ToPatient:_patient.postid
                                                                            title:noteTitle
                                                                       completion:^(BOOL success, NSString *message)
                               {
                                    [self.view endEditing:true];
                                   if (success)
                                   {
                                       [self getPatientNotes];
                                   }
                                   [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                               }];
                              
                          }}];

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

- (void)addTextNote:(NSString *)textNote title:(NSString *)title
{
    [[AppController sharedInstance] addProfileTextNote:textNote
                                             ToPatient:_patient.postid
                                                 title:title
                                            completion:^(BOOL success, NSString *message)
     {
          [self.view endEditing:true];
         if (success)
         {
             [self getPatientNotes];
         }

         [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
     }];
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
    
    [UIAlertView showWithTitle:@"Note Title:"
                       message:nil
                         style:UIAlertViewStylePlainTextInput
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"OK"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              
                              NSString *noteTitle = [alertView textFieldAtIndex:0].text;
                              [[AppController sharedInstance] addProfileAudioNote:audioFilePath
                                                                        ToPatient:_patient.postid
                                                                            title:noteTitle
                                                                       completion:^(BOOL success, NSString *message)
                               {
                                   [self.view endEditing:true];
                                   if (success)
                                   {
                                       [self getPatientNotes];
                                   }
                                   [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                               }];
                              
                          }}];
}

#pragma mark - Update Profile Image

- (void)updateProfileImage:(UIImage *)img
{
    [[AppController sharedInstance] updatePatientIMG:_patient.postid img:img WithCompletion:^(BOOL success, NSString *message) {
        NSString *title = @"succeed";
         [self.view endEditing:true];
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
    if (textField.tag == 102) {
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
        
    } else if (textField.tag == 105) {
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
        _patient.firstName = textField.text;
    } else if (textField.tag == 101) {
        [textField resignFirstResponder];
        _patient.lastName = textField.text;
    } else if (textField.tag == 102) {
         [textField resignFirstResponder];
        
    } else if (textField.tag == 103) {
         [textField resignFirstResponder];
        _patient.occupation = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 104) {
         [textField resignFirstResponder];
    } else if (textField.tag == 105) {
         [textField resignFirstResponder];
        _patient.street1 = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 106) {
         [textField resignFirstResponder];
        _patient.street2 = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 107) {
         [textField resignFirstResponder];
        _patient.city = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 108) {
         [textField resignFirstResponder];
        _patient.state = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 109) {
        [textField resignFirstResponder];
        
    } else if (textField.tag == 110) {
         [textField resignFirstResponder];
        _patient.telephone = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 111) {
        [textField resignFirstResponder];
        _patient.email = textField.text;
        [_tableView reloadData];
    } else if (textField.tag == 112) {
         [textField resignFirstResponder];
        _patient.ssnDigits = textField.text;
        [_tableView reloadData];
    }
    
    return YES;
}




- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        //  [textField resignFirstResponder];
        _patient.firstName = textField.text;
    } else if (textField.tag == 101) {
        //[textField resignFirstResponder];
        _patient.lastName = textField.text;
        // [_tableView reloadData];
    } else if (textField.tag == 102) {
      //  [textField resignFirstResponder];
        
    } else if (textField.tag == 103) {
        //[textField resignFirstResponder];
        _patient.occupation = textField.text;
       // [_tableView reloadData];
    } else if (textField.tag == 104) {
        //[textField resignFirstResponder];
    } else if (textField.tag == 105) {
       // [textField resignFirstResponder];
        _patient.street1 = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 106) {
      //  [textField resignFirstResponder];
        _patient.street2 = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 107) {
      //  [textField resignFirstResponder];
        _patient.city = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 108) {
      //  [textField resignFirstResponder];
        _patient.state = textField.text;
       // [_tableView reloadData];
    } else if (textField.tag == 109) {
       // [textField resignFirstResponder];
        
    } else if (textField.tag == 110) {
        //[textField resignFirstResponder];
        _patient.telephone = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 111) {
      //  [textField resignFirstResponder];
        _patient.email = textField.text;
        //[_tableView reloadData];
    } else if (textField.tag == 112) {
     //   [textField resignFirstResponder];
        _patient.ssnDigits = textField.text;
        //[_tableView reloadData];
    }

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        //  [textField resignFirstResponder];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    } else if (textField.tag == 101) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

        
    } else if (textField.tag == 102) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    } else if (textField.tag == 103) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    } else if (textField.tag == 104) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

        
    } else if (textField.tag == 105) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    } else if (textField.tag == 106) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

        
    } else if (textField.tag == 107) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    } else if (textField.tag == 108) {
       
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    } else if (textField.tag == 109) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:9 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];

    } else if (textField.tag == 110) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
 
    } else if (textField.tag == 111) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:11 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    } else if (textField.tag == 112) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:12 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    
    return YES;
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

- (void)hsDatePickerPickedDate:(NSDate *)date {
    
    NSTimeInterval t = [date timeIntervalSince1970];
    
    _patient.dob = [NSString stringWithFormat:@"%i",(int)t];
  
    [_tableView reloadData];
    
}
@end
