//
//  SendPrescriptionController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "SendPrescriptionController.h"

@interface SendPrescriptionController () <PharmacySelecterDelegate>

@end

@implementation SendPrescriptionController

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
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendPrescription)];
    self.navigationItem.rightBarButtonItem = nextButton;
    

    
   /* UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.title = @"SEND PRESCRIPTION";
    
   // [pharmacyButton setBackgroundColor:[UIColor flatBlueColor]];
    
    isPharm = false;
    isPasscode = false;
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    drugName.text = drug.dispensableDrugDesc;
    //doseText.text = [NSString stringWithFormat:@"%@ %@",drug.MedStrength, drug.MedStrengthUnit];
    doseStrengthText.text = [NSString stringWithFormat:@"%@",drug.MedStrength];
    doseText.text = [NSString stringWithFormat:@"%@", drug.MedStrengthUnit];
    
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.view endEditing:YES];
}

- (void)sendPrescription {
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
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    PharmacySelectController *vc = (PharmacySelectController *)[sb instantiateViewControllerWithIdentifier:@"PharmacySelectController"];
    
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
