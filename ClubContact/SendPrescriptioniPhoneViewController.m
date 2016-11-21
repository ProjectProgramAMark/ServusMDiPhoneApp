//
//  SendPrescriptioniPhoneViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SendPrescriptioniPhoneViewController.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"

@interface SendPrescriptioniPhoneViewController () <PharmacySelecterDelegate>

@end

@implementation SendPrescriptioniPhoneViewController


@synthesize drug;
@synthesize patientConditions;
@synthesize selectedAllergens;
@synthesize selectedConditions;
@synthesize patient;
@synthesize pharmacy;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    refillText.delegate = self;
    componentText.delegate = self;
    amountText.delegate = self;
    
   
    
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
    

    
    self.title = @"SEND PRESCRIPTION";
    
   // [pharmacyButton setBackgroundColor:[UIColor flatBlueColor]];
    
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    
    isPharm = false;
    isPasscode = false;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, doseStrengthText.frame.size.height)];
    leftView.backgroundColor = doseStrengthText.backgroundColor;
    doseStrengthText.leftView = leftView;
    doseStrengthText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, refillText.frame.size.height)];
    leftView2.backgroundColor = refillText.backgroundColor;
    refillText.leftView = leftView2;
    refillText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, amountText.frame.size.height)];
    leftView3.backgroundColor = amountText.backgroundColor;
    amountText.leftView = leftView3;
    amountText.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *leftView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, componentText.frame.size.height)];
    leftView4.backgroundColor = componentText.backgroundColor;
    componentText.leftView = leftView4;
    componentText.leftViewMode = UITextFieldViewModeAlways;
    

    
}

- (void)viewDidAppear:(BOOL)animated {
    awesomeStuffContainer.frame = CGRectMake(0, 0, windowWidth, awesomeStuffContainer.frame.size.height);
    [awesomeScrollView addSubview:awesomeStuffContainer];
    awesomeScrollView.contentSize = awesomeStuffContainer.frame.size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    drugName.text = drug.dispensableDrugDesc;
   // doseText.text = [NSString stringWithFormat:@"%@ %@",drug.MedStrength, drug.MedStrengthUnit];
    doseStrengthText.text = [NSString stringWithFormat:@"%@",drug.MedStrength];
    doseText.text = [NSString stringWithFormat:@"%@", drug.MedStrengthUnit];
    
    profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
    profileIMGView2.layer.masksToBounds = YES;
    //profileIMGView2.layer.borderColor = [UIColor whiteColor].CGColor;
    //profileIMGView2.layer.borderWidth = 3.0;
    
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: patient.profilepic]];
    //[profileIMGView3 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", patient.firstName, patient.lastName];
    jobLabel2.text = [NSString stringWithFormat:@"%@", patient.occupation];
    
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}

- (IBAction)endPrescription:(id)sender {
    if (doseStrengthText.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the dose amount" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    } else if (refillText.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter refill amount" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    } else if (componentText.text.length == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter component" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }  else if (amountText.text.length == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter amount" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }  else if (isPharm == false ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select a pharmacy" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Passcode"
                                                        message:@"Enter your passcode"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Done", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        isPasscode = true;
        
        /*  NSMutableString  *idAllValues2 = [[NSMutableString alloc] init];
         NSMutableString  *idAllValues3 = [[NSMutableString alloc] init];
         for (Condition  *objListInfo in  self.selectedConditions) {
         
         [idAllValues2 appendString:[NSString stringWithFormat:@"%@,",objListInfo.conditionName]];
         }
         
         for (Allergen  *objListInfo in  self.selectedAllergens) {
         
         [idAllValues3 appendString:[NSString stringWithFormat:@"%@,",objListInfo.PicklistDesc]];
         }
         
         NSString  *idValues = @"";
         NSString  *idValues2 = @"";
         
         if ([idAllValues2 length] > 1) {
         
         
         idValues = [idAllValues2 substringToIndex:[idAllValues2 length]-1];
         
         }
         
         
         if ([idAllValues3 length] > 1) {
         
         
         idValues2 = [idAllValues3 substringToIndex:[idAllValues3 length]-1];
         
         }
         
         
         [[AppController sharedInstance] addPrescription:patient.postid drug:drug pharmacy:pharmacy conditions:idValues allergies:idValues2 component:componentText.text refill:refillText.text amount:amountText.text completion:^(BOOL success, NSString *message) {
         
         if (success == true) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Prescription Sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
         [alert show];
         [self.delegate refreshMedicationAdd];
         [self dismissViewControllerAnimated:YES completion:nil];
         }
         
         }];*/
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

- (IBAction)getPharmacy:(id)sender {
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    PharmacySelectController *vc = [[PharmacySelectController alloc] initWithNibName:@"PharmacySelectController" bundle:nil];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return true;
}


- (void)pharmacySelected:(Pharmacy *)pharm {
    pharmacy = [[Pharmacy alloc] init];
    pharmacy = pharm;
    isPharm = true;
    [pharmacyButton setTitle:pharmacy.pharmName forState:UIControlStateNormal];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (isPasscode == true) {
            isPasscode = false;
            
            NSMutableString  *idAllValues2 = [[NSMutableString alloc] init];
            NSMutableString  *idAllValues3 = [[NSMutableString alloc] init];
            for (Condition  *objListInfo in  self.selectedConditions) {
                
                [idAllValues2 appendString:[NSString stringWithFormat:@"%@,",objListInfo.conditionName]];
            }
            
            for (Allergen  *objListInfo in  self.selectedAllergens) {
                
                [idAllValues3 appendString:[NSString stringWithFormat:@"%@,",objListInfo.PicklistDesc]];
            }
            
            NSString  *idValues = @"";
            NSString  *idValues2 = @"";
            
            if ([idAllValues2 length] > 1) {
                
                
                idValues = [idAllValues2 substringToIndex:[idAllValues2 length]-1];
                
            }
            
            
            if ([idAllValues3 length] > 1) {
                
                
                idValues2 = [idAllValues3 substringToIndex:[idAllValues3 length]-1];
                
            }
            
            NSString *passcodeString = [alertView textFieldAtIndex:0].text;
            
                 drug.MedStrength = doseStrengthText.text;
            
            [[AppController sharedInstance] addPrescription:patient.postid drug:drug pharmacy:pharmacy conditions:idValues allergies:idValues2 component:componentText.text refill:refillText.text amount:amountText.text passcode:passcodeString completion:^(BOOL success, NSString *message) {
                
                if (success == true) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Prescription Sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                    [self.delegate refreshMedicationAdd];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                }
                
            }];
            
        }
    }
}


@end
