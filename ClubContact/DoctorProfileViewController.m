//
//  DoctorProfileViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DoctorProfileViewController.h"
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

@interface DoctorProfileViewController (){
    UIPopoverController *popover2;
    BOOL isProfileUpdate;
    BOOL isPasscodeUpdate;
    BOOL isPasscodeUpdate2;
    BOOL isPasscodeUpdate3;
    BOOL isPasscodeUpdate4;
    IBOutlet UIView *statView;
    IBOutlet UIImageView *profileIMGView2;
    UIPickerView *countryPicker;
    IBOutlet UILabel *nameLabel;
    IBOutlet UIImageView *profileIMGView3;
    NSString *oldPassword;
    IBOutlet UILabel *hospitalLabel;
    
    IBOutlet UIView *awesomeStuffContainer;
    IBOutlet UIScrollView *awesomeScrollView;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    
    IBOutlet UILabel *usernameLabel;
    IBOutlet UILabel *emailLabel;
    IBOutlet UILabel *miLabel;
    IBOutlet UILabel *suffixLabel;
    IBOutlet UILabel *npiLabel;
    IBOutlet UILabel *deaLabel;
    IBOutlet UILabel *meLabel;
    IBOutlet UILabel *schoolLabel;
    IBOutlet UILabel *specialityLabel;
    IBOutlet UILabel *chargeLabel;
    IBOutlet UILabel *tokensLabel;
    IBOutlet UILabel *availabilityLabel;
    IBOutlet UILabel *yearsLabel;
    
    IBOutlet UILabel *officeNameLabel;
    IBOutlet UILabel *officeAddressLabel;
    IBOutlet UILabel *officeCityLabel;
    IBOutlet UILabel *officeCountryLabel;
    IBOutlet UILabel *officeStateLabel;
    IBOutlet UILabel *officeZipLabel;
    IBOutlet UILabel *officeTelephoneLabel;
    
    IBOutlet UIImageView *signatureImageView;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DoctorProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"DOCTOR PROFILE";
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(rightNaviButtonClicked)];
    isProfileUpdate = false;
    isPasscodeUpdate = false;
    isPasscodeUpdate2 = false;
    isPasscodeUpdate3 = false;
    isPasscodeUpdate4 = false;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self refreshAllData];
    
    
    [_tableView registerClass:[SignatureTableViewCell class] forCellReuseIdentifier:@"SignatureCell"];
    
    if (IS_IPHONE) {
        // statView.hidden = true;
        statView.hidden = false;
        statView.frame = CGRectMake(0, 0, windowWidth, 157.0f);
       // _tableView.frame = CGRectMake(0, 157.0f, windowWidth, windowHeight - 157.0f);
        
    } else {
        statView.hidden = false;
        statView.frame = CGRectMake(0, 0, windowWidth, 157.0f);
      //  _tableView.frame = CGRectMake(0, 157.0f, windowWidth, windowHeight - 157.0f);
    }

     _tableView.frame = CGRectMake(0, 0.0f, windowWidth, windowHeight);
    
    
    
    // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(rightNaviButtonClicked)];
    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
     /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;*/
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
   // _tableView.tableHeaderView =statView;

    
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (IBAction)goBackToChose:(id)sender {
  //  [self.navigationController popViewControllerAnimated:YES];
     [self.revealViewController revealToggle:sender];
}


- (IBAction)goToEdit:(id)sender {
    DoctorEditNewViewController *vc = [[DoctorEditNewViewController alloc] initWithNibName:@"DoctorEditNewViewController" bundle:nil];
    vc.doctor = _doctor;
    [self.navigationController pushViewController:vc animated:true];
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
        
        if (_doctor.firstname.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the first name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.lastname.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the last name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.mi.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the M.I." withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.suffix.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the Suffix" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.dea.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the D.E.A" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        }  else if (_doctor.npi.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the N.P.I." withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.me.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the M.E." withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.officename.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the office name" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.officeaddress.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the office address" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        }  else if (_doctor.officecity.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the office city" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.officestate.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the office state" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.officezip.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the office zip code" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.officecountry.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the office country" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.telephone.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the telephone number" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        } else if (_doctor.speciality.length == 0) {
            [self showAlertViewWithMessage:@"Please enter the specialty" withTag:100 withTitle:@"Missing Value" andViewController:self isCancelButton:NO];
        }else {
       
            [[AppController sharedInstance] updateDoctor:_doctor WithCompletion:^(BOOL success, NSString *message) {
                NSString *title = @"succeed";
                if (success == false)
                {
                    title = @"failed";
                } else {
                   // [self.delegate doctorEditDone:doctor1];
                }
                
                
                //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
               // [self dismissViewControllerAnimated:YES completion:nil];
            }];
            
            
            
        }
        
        
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                           target:self
                                                                                           action:@selector(rightNaviButtonClicked)];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshAllData {
      [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getDoctorProfile:@"" WithCompletion:^(BOOL success, NSString *message, Doctors *doctorProfile) {
        [SVProgressHUD dismiss];
        if (success)
        {
            _doctor = doctorProfile;
            [profileIMGView2 setImageWithURL:[NSURL URLWithString:_doctor.profileimage]];
            profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
            profileIMGView2.layer.masksToBounds = YES;
            profileIMGView2.layer.borderColor = [UIColor blackColor].CGColor;
            profileIMGView2.layer.borderWidth = 1.0;
            //[profileIMGView3 setImageWithURL:[NSURL URLWithString:_doctor.profileimage]];
            nameLabel.text = [NSString stringWithFormat:@"Dr. %@ %@", _doctor.firstname, _doctor.lastname];
            hospitalLabel.text = _doctor.residency;
            usernameLabel.text = [NSString stringWithFormat:@"Username: %@", _doctor.username];
            emailLabel.text = [NSString stringWithFormat:@"Email: %@", _doctor.email];
            miLabel.text = [NSString stringWithFormat:@"M.I.: %@", _doctor.mi];
            suffixLabel.text = [NSString stringWithFormat:@"Suffix: %@", _doctor.suffix];
            deaLabel.text = [NSString stringWithFormat:@"D.E.A.: %@", _doctor.dea];
            npiLabel.text = [NSString stringWithFormat:@"N.P.I.: %@", _doctor.npi];
            meLabel.text = [NSString stringWithFormat:@"M.E.: %@", _doctor.me];
            schoolLabel.text = [NSString stringWithFormat:@"School: %@", _doctor.school];
            specialityLabel.text = [NSString stringWithFormat:@"Specialty: %@", _doctor.speciality];
            chargeLabel.text = [NSString stringWithFormat:@"Charge: %@", _doctor.ccost];
            tokensLabel.text = [NSString stringWithFormat:@"Tokens: %@", _doctor.tokens];
            usernameLabel.text = [NSString stringWithFormat:@"Username: %@", _doctor.username];
            yearsLabel.text = [NSString stringWithFormat:@"Years: %@", _doctor.yearsExperience];
            
            if ([_doctor.isOnline intValue] == 1) {
                
                 availabilityLabel.text = [NSString stringWithFormat:@"Availability: On"];
            } else {
                 availabilityLabel.text = [NSString stringWithFormat:@"Availability: Off"];
            }
            
            officeNameLabel.text = [NSString stringWithFormat:@"Office Name: %@", _doctor.officename];
            officeAddressLabel.text = [NSString stringWithFormat:@"Address: %@", _doctor.officeaddress];
            officeCityLabel.text = [NSString stringWithFormat:@"City: %@", _doctor.officecity];
            officeCountryLabel.text = [NSString stringWithFormat:@"Office Country: %@", _doctor.officecountry];
            officeZipLabel.text = [NSString stringWithFormat:@"Zip code: %@", _doctor.officezip];
            officeStateLabel.text = [NSString stringWithFormat:@"State: %@", _doctor.officestate];
            officeTelephoneLabel.text = [NSString stringWithFormat:@"Telephone: %@", _doctor.telephone];
            

            [signatureImageView setImageWithURL:[NSURL URLWithString:_doctor.signature]];
          //  [_tableView reloadData];
        }
    }];
}


#pragma mark - PatientsTableViewCellDelegate
- (void)DoctorTableViewCellRefreshButtonClicked:(DoctorTableViewCell *)cell
{
    [self refreshAllData];
}


- (IBAction)changeProfilePick:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Update Profile Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
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
    
    if (IS_IPHONE) {
        [self presentViewController:actionSheet animated:YES completion:nil];
    } else {
      
    }
    

}

- (void)DoctorTableViewCellImageButtonClicked:(DoctorTableViewCell *)cell {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Update Profile Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
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
    
    if (IS_IPHONE) {
        [self presentViewController:actionSheet animated:YES completion:nil];
    } else {
        UIPopoverPresentationController *popPresenter = [actionSheet
                                                         popoverPresentationController];
        popPresenter.sourceView = cell;
        popPresenter.sourceRect = cell.bounds;
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
    
   
    
}



#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowNumber = 0;
    
    if (_doctor == nil) {
        rowNumber = 0;
        return rowNumber;
    }
    
    switch (section)
    {
       
        case 0:
        {
            rowNumber = 16;
            break;
        }
        case 1:
        {
            rowNumber = 7;
            break;
        }
        case 2:
        {
            rowNumber = 1;
            break;
        }case 3:
        {
            rowNumber = 1;
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
            title = @"Office";
            break;
        }
        case 2:
        {
            title = @"Signature";
            break;
        }case 3:
        {
            title = @"Payment";
            break;
        }
    }
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if (indexPath.section == 0)
    {
        DoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDetailPatientsCellID];
        
        
            cell = [[DoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:kDetailPatientsCellID] ;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.hideRefreshButton = FALSE;
            cell.delegate = self;
    
        
        cell.doctor = _doctor;
        
        return cell;
    }  else*/ if(indexPath.section == 0)
    {
        AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAboutCellID];
        //if (cell == nil)
        //{
        cell = [[AboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:kAboutCellID];
        cell.keyLabel.text = [self aboutTitleByRow:indexPath.row];
        cell.valueLabel.text = [self aboutValueByRow:indexPath.row];
        cell.valueLabel.enabled = false;
        cell.valueLabel.tag = indexPath.row + 100;
        
        if (_tableView.editing == true) {
            if (indexPath.row == 1) {
                cell.valueLabel.borderStyle = UITextBorderStyleBezel;
                cell.valueLabel.enabled = true;
                cell.valueLabel.delegate = self;
            } else  if (indexPath.row == 2) {
                cell.valueLabel.borderStyle = UITextBorderStyleBezel;
                cell.valueLabel.enabled = true;
                cell.valueLabel.delegate = self;
            } else  if (indexPath.row == 3) {
                cell.valueLabel.borderStyle = UITextBorderStyleBezel;
                cell.valueLabel.enabled = true;
                cell.valueLabel.delegate = self;
            } else  if (indexPath.row == 4) {
                cell.valueLabel.borderStyle = UITextBorderStyleBezel;
                cell.valueLabel.enabled = true;
                cell.valueLabel.delegate = self;
            } else  if (indexPath.row == 5) {
                cell.valueLabel.borderStyle = UITextBorderStyleBezel;
                cell.valueLabel.enabled = true;
                cell.valueLabel.delegate = self;
            } else  if (indexPath.row == 6) {
                cell.valueLabel.borderStyle = UITextBorderStyleBezel;
                cell.valueLabel.enabled = true;
                cell.valueLabel.delegate = self;
            } else  if (indexPath.row == 7) {
                cell.valueLabel.borderStyle = UITextBorderStyleBezel;
                cell.valueLabel.enabled = true;
                cell.valueLabel.delegate = self;
            } else  if (indexPath.row == 8) {
                cell.valueLabel.borderStyle = UITextBorderStyleBezel;
                cell.valueLabel.enabled = true;
                cell.valueLabel.delegate = self;
            } else  if (indexPath.row == 9) {
                cell.valueLabel.borderStyle = UITextBorderStyleBezel;
                cell.valueLabel.enabled = true;
                cell.valueLabel.delegate = self;
            }
        }
        //}
        return cell;
        
    }   else if(indexPath.section == 1)
    {
        AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAboutCellID];
        //if (cell == nil)
        //{
        cell = [[AboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:kAboutCellID];
        cell.keyLabel.text = [self aboutTitleByRow2:indexPath.row];
        cell.valueLabel.text = [self aboutValueByRow2:indexPath.row];
        cell.valueLabel.enabled = false;
        cell.valueLabel.tag = indexPath.row + 200;
        
        if (_tableView.editing == true) {
            cell.valueLabel.borderStyle = UITextBorderStyleBezel;
            cell.valueLabel.enabled = true;
            cell.valueLabel.delegate = self;
            
            if (indexPath.row == 5) {
                countryPicker = [[CountryPicker alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
                countryPicker.delegate = self;
                cell.valueLabel.inputView = countryPicker;
            }
        }
        //}
        return cell;
        
    }   else if(indexPath.section == 2)
    {
        
        if (_doctor.signature.length == 0) {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:kNormalCellID];
            cell.textLabel.text = @"Add New";
            
             return cell;
        } else {
            
            SignatureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignatureCell"];
            cell = [[SignatureTableViewCell alloc] init];
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:(@"SignatureTableViewCell") owner:self options:nil];
            cell=[nib objectAtIndex:0];
            
            [cell.signatureIMG setImageWithURL:[NSURL URLWithString:_doctor.signature]];
           
            //cell.b
            
             return cell;
        }
      
     
    }  else if (indexPath.section == 3)
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kNormalCellID];
        cell.textLabel.text = @"Contact support@myfidem.com";
        
        return cell;
    }

    
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNormalCellID];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:kNormalCellID];
            cell.textLabel.text = @"";
        }
        return cell;
    }
    
}



- (NSString *)aboutValueByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = _doctor.username;
            break;
        }
        case 1:
        {
            title = _doctor.email;
            break;
        }
        case 2:
        {
            title = _doctor.mi;
            break;
        }
        case 3:
        {
            title = _doctor.suffix;
            break;
        }
        case 4:
        {
            title = _doctor.dea;
            break;
        }
        case 5:
        {
            title = _doctor.npi;
            break;
        }
        case 6:
        {
            title = _doctor.me;
            break;
        }
        case 7:
        {
            title = _doctor.yearsExperience;
            break;
        }
        case 8:
        {
            title = _doctor.school;
            break;
        }
        case 9:
        {
            title = _doctor.residency;
            break;
        }
        case 10:
        {
            title = @"*******";
            break;
        }
        case 11:
        {
            title = _doctor.speciality;
            break;
        }
        case 12:
        {
            title = _doctor.ccost;
            break;
        }
        case 13:
        {
            title = _doctor.tokens;
            break;
        }
        case 14:
        {
            title = @"*******";
            break;
        }
        case 15:
        {
            if ([_doctor.isOnline intValue] == 1) {
                title = @"On";
            } else {
                 title = @"Off";
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

- (NSString *)aboutTitleByRow:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Username";
            break;
        }
        case 1:
        {
            title = @"Email";
            break;
        }
        case 2:
        {
            title = @"M.I";
            break;
        }
        case 3:
        {
            title = @"Suffix";
            break;
        }
        case 4:
        {
            title = @"D.E.A";
            break;
        }
        case 5:
        {
            title = @"N.P.I";
            break;
        }
        case 6:
        {
            title = @"M.E.";
            break;
        }
        case 7:
        {
            title = @"Years";
            break;
        }
        case 8:
        {
            title = @"School";
            break;
        }
        case 9:
        {
            title = @"Residency";
            break;
        }
        case 10:
        {
            title = @"Password";
            break;
        }
        case 11:
        {
            title = @"Specialty";
            break;
        }
        case 12:
        {
            title = @"Charge";
            break;
        }
        case 13:
        {
            title = @"Tokens";
            break;
        }
        case 14:
        {
            title = @"Passcode";
            break;
        }
        case 15:
        {
            title = @"Availability";
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

- (NSString *)aboutValueByRow2:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = _doctor.officename;
            break;
        }
        case 1:
        {
            title = _doctor.officeaddress;
            break;
        }
        case 2:
        {
            title = _doctor.officecity;
            break;
        }
        case 3:
        {
            title = _doctor.officestate;
            break;
        }
        case 4:
        {
            title = _doctor.officezip;
            break;
        }
        case 5:
        {
            title = _doctor.officecountry;
            break;
        }
        case 6:
        {
            title = _doctor.telephone;
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

- (NSString *)aboutTitleByRow2:(NSInteger)row
{
    NSString *title = @"";
    switch (row)
    {
        case 0:
        {
            title = @"Office Name";
            break;
        }
        case 1:
        {
            title = @"Address";
            break;
        }
        case 2:
        {
            title = @"City";
            break;
        }
        case 3:
        {
            title = @"State";
            break;
        }
        case 4:
        {
            title = @"Zipcode";
            break;
        }
        case 5:
        {
            title = @"Country";
            break;
        }
        case 6:
        {
            title = @"Telephone";
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if (indexPath.section == 0)
    {
        return kPatientsTableViewCellHeight;
    }
    else*/ if(indexPath.section == 0)
    {
        return kAboutTableViewCellHeight;
    } else if(indexPath.section == 1)
    {
        return kAboutTableViewCellHeight;
    } else if(indexPath.section == 2)
    {
        return 70;
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
        
        if (indexPath.row == 10) {
            /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Passcode"
             message:@"Enter your new passcode"
             delegate:self
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@"Done", nil];
             alert.alertViewStyle = UIAlertViewStylePlainTextInput;
             [alert show];*/
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Password"
                                                            message:@"Enter your old password"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Next", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
            
            isPasscodeUpdate3 = true;
        } else  if (indexPath.row == 14) {
           /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Passcode"
                                                            message:@"Enter your new passcode"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Done", nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert show];*/
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Passcode"
                                                            message:@"Enter your old passcode (Leave blank if you do not have one)"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Next", nil];
            alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            [alert show];
            
            isPasscodeUpdate = true;
        } else if (indexPath.row == 15) {
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Availability" message:@"Set your availability" preferredStyle:UIAlertControllerStyleActionSheet];
            
            
            UIAlertAction *avAction = [UIAlertAction actionWithTitle:@"On" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
               [[AppController sharedInstance] updateDocAvailability:@"1" completion:^(BOOL success, NSString *message) {
                   if (success) {
                       [self refreshAllData];
                   }
               }];
                
                
            }];
            
            UIAlertAction *unAction = [UIAlertAction actionWithTitle:@"Off" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [[AppController sharedInstance] updateDocAvailability:@"0" completion:^(BOOL success, NSString *message) {
                    if (success) {
                        [self refreshAllData];
                    }
                }];
                
                
                
            }];
            
            
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                //  [self dismissViewControllerAnimated:self completion:nil];
            }];
            
            [actionSheet addAction:avAction];
            [actionSheet addAction:unAction];
            [actionSheet addAction:cancelAction];
            
            if (IS_IPHONE) {
                [self presentViewController:actionSheet animated:YES completion:nil];
            } else {
                UIPopoverPresentationController *popPresenter = [actionSheet
                                                                 popoverPresentationController];
                popPresenter.sourceView = self.navigationController.view;
                popPresenter.sourceRect = CGRectMake(windowWidth/2 - 150.0f, 0, 300, 400);
                [self presentViewController:actionSheet animated:YES completion:nil];

            }
            
        } else if (indexPath.row == 10) {
            
            
        }else {
            
            /*if (IS_IPHONE) {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                EditDoctoriPhoneViewController *vc = (EditDoctoriPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"EditDoctoriPhoneViewController"];
                
                vc.doctor = _doctor;
                vc.delegate = self;
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                
                
                [self presentViewController:nav animated:YES completion:nil];
            } else {
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
                EditDoctorViewController *vc = (EditDoctorViewController *)[sb instantiateViewControllerWithIdentifier:@"EditDoctorViewController"];
                
                vc.doctor = _doctor;
                vc.delegate = self;
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                
                
                UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
                
                [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }*/
            
            _tableView.editing = true;
            [self.tableView reloadData];
      
            
        }
    } else if (indexPath.section == 1) {
         if (IS_IPHONE) {
             UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
             EditDoctoriPhoneViewController *vc = (EditDoctoriPhoneViewController *)[sb instantiateViewControllerWithIdentifier:@"EditDoctoriPhoneViewController"];
             
             vc.doctor = _doctor;
             vc.delegate = self;
             
             UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
             
             
             [self presentViewController:nav animated:YES completion:nil];
         } else {
             UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
             EditDoctorViewController *vc = (EditDoctorViewController *)[sb instantiateViewControllerWithIdentifier:@"EditDoctorViewController"];
             
             vc.doctor = _doctor;
             vc.delegate = self;
             
             UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
             
             
             UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:nav];
             
             [popVC presentPopoverFromRect:self.navigationController.navigationBar.frame  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
         }
      
    }else if (indexPath.section == 2) {
        [self showPersonalSignatureView:^{
            [self removeBlurView];
            _personalSignatureView.hidden = YES;
            
            UIImage *signature = [_personalSignatureView.signatureView getSignatureImage];
           
            [[AppController sharedInstance] updateDoctorSig:@"" img:signature WithCompletion:^(BOOL success, NSString *message) {
                [self refreshAllData];
            }];
        }];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     return UITableViewCellEditingStyleNone;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (isProfileUpdate == false) {
        
        
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


- (void)updateProfileImage:(UIImage *)img
{
    [[AppController sharedInstance] updateDoctorIMG:@"" img:img WithCompletion:^(BOOL success, NSString *message) {
        NSString *title = @"succeed";
        if (success == false)
        {
            title = @"failed";
        } else {
            [self refreshAllData];
        }
        
        
        //[self showAlertViewWithMessage:message withTag:100 withTitle:title andViewController:self isCancelButton:NO];
        //[self dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

- (void)doctorEditDone:(Doctors *)patientinfo {
    [self refreshAllData];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (isPasscodeUpdate == true) {
        isPasscodeUpdate = false;
        if (buttonIndex == 1) {
            
            
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
            [SVProgressHUD showWithStatus:@"Checking..."];
            [[AppController sharedInstance] checkDoctorPasscode:passcodeString completion:^(BOOL success, NSString *message) {
                [SVProgressHUD dismiss];
                if (success) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Passcode"
                                                                    message:@"Enter your new passcode"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                          otherButtonTitles:@"Done", nil];
                    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
                    [alert show];
                    
                    isPasscodeUpdate2 = true;
                    
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid passcode" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
                
                
            }];
            
        } else {
            isPasscodeUpdate = false;
        }
    } else if (isPasscodeUpdate2 == true) {
        isPasscodeUpdate2 = false;
         if (buttonIndex == 1) {
        NSString *passcodeString = [alertView textFieldAtIndex:0].text;
        [SVProgressHUD showWithStatus:@"Updating..."];
        [[AppController sharedInstance] updateDoctorPasscode:passcodeString completion:^(BOOL success, NSString *message) {
             [SVProgressHUD dismiss];
            if (success) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Passcode succesfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
         }
        
    }else if (isPasscodeUpdate3 == true) {
        isPasscodeUpdate3 = false;
         if (buttonIndex == 1) {
        oldPassword = [alertView textFieldAtIndex:0].text;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Password"
                                                        message:@"Enter your new password"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Done", nil];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert show];
        
        isPasscodeUpdate4 = true;
         }
    }else if (isPasscodeUpdate4 == true) {
        isPasscodeUpdate4 = false;
        if (buttonIndex == 1) {
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
            [SVProgressHUD showWithStatus:@"Updating..."];
            [[AppController sharedInstance] changePasswordForDoctor:@"" password:passcodeString oldpassword:oldPassword WithCompletion:^(BOOL success, NSString *message) {
                
                [SVProgressHUD dismiss];
                if (success) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Password succesfully updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                }
            }];

        }
        
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 101) {
        [textField resignFirstResponder];
        _doctor.email = textField.text;
    } else if (textField.tag == 102) {
        [textField resignFirstResponder];
        _doctor.mi = textField.text;
    } else if (textField.tag == 103) {
        [textField resignFirstResponder];
        _doctor.suffix = textField.text;
    } else if (textField.tag == 104) {
        [textField resignFirstResponder];
        _doctor.dea = textField.text;
    } else if (textField.tag == 105) {
        [textField resignFirstResponder];
        _doctor.npi = textField.text;
    } else if (textField.tag == 106) {
        [textField resignFirstResponder];
        _doctor.me = textField.text;
    } else if (textField.tag == 107) {
        [textField resignFirstResponder];
        _doctor.yearsExperience = textField.text;
    } else if (textField.tag == 108) {
        [textField resignFirstResponder];
        _doctor.school = textField.text;
    } else if (textField.tag == 109) {
        [textField resignFirstResponder];
        _doctor.residency = textField.text;
    } else if (textField.tag == 200) {
        [textField resignFirstResponder];
        _doctor.officename = textField.text;
    } else if (textField.tag == 201) {
        [textField resignFirstResponder];
        _doctor.officeaddress = textField.text;
    } else if (textField.tag == 202) {
        [textField resignFirstResponder];
        _doctor.officecity = textField.text;
    } else if (textField.tag == 203) {
        [textField resignFirstResponder];
        _doctor.officestate = textField.text;
    } else if (textField.tag == 204) {
        [textField resignFirstResponder];
        _doctor.officezip = textField.text;
    } else if (textField.tag == 205) {
        [textField resignFirstResponder];
      //  _doctor.officecountry = textField.text;
    } else if (textField.tag == 206) {
        [textField resignFirstResponder];
        _doctor.telephone = textField.text;
    }
    
    return  true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 101) {
       // [textField resignFirstResponder];
        _doctor.email = textField.text;
    } else if (textField.tag == 102) {
      //  [textField resignFirstResponder];
        _doctor.mi = textField.text;
    } else if (textField.tag == 103) {
      //  [textField resignFirstResponder];
        _doctor.suffix = textField.text;
    } else if (textField.tag == 104) {
     //   [textField resignFirstResponder];
        _doctor.dea = textField.text;
    } else if (textField.tag == 105) {
       // [textField resignFirstResponder];
        _doctor.npi = textField.text;
    } else if (textField.tag == 106) {
      //  [textField resignFirstResponder];
        _doctor.me = textField.text;
    }else if (textField.tag == 107) {
     
        _doctor.yearsExperience = textField.text;
    } else if (textField.tag == 108) {
      
        _doctor.school = textField.text;
    } else if (textField.tag == 109) {
        
        _doctor.residency = textField.text;
    } else if (textField.tag == 200) {
      //  [textField resignFirstResponder];
        _doctor.officename = textField.text;
    } else if (textField.tag == 201) {
      //  [textField resignFirstResponder];
        _doctor.officeaddress = textField.text;
    } else if (textField.tag == 202) {
     //   [textField resignFirstResponder];
        _doctor.officecity = textField.text;
    } else if (textField.tag == 203) {
     //   [textField resignFirstResponder];
        _doctor.officestate = textField.text;
    } else if (textField.tag == 204) {
      //  [textField resignFirstResponder];
        _doctor.officezip = textField.text;
    } else if (textField.tag == 205) {
     //   [textField resignFirstResponder];
        //  _doctor.officecountry = textField.text;
    } else if (textField.tag == 206) {
       // [textField resignFirstResponder];
        _doctor.telephone = textField.text;
    }

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 101) {
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
        
    } else if (textField.tag == 200) {
       [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    } else if (textField.tag == 201) {
       [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    } else if (textField.tag == 202) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    } else if (textField.tag == 203) {
      
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else if (textField.tag == 204) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
       
        
    } else if (textField.tag == 205) {
       [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    } else if (textField.tag == 206) {
      [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    return YES;
}

#pragma mark - UIPickerViewDataSource
- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    _doctor.officecountry = name;
    [_tableView reloadData];
}


@end
