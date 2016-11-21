//
//  SendPrescriptionController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drug.h"
#import "MonoGraph.h"
#import "PatientEdicationAPIClient.h"
#import "Ingrediant.h"
#import "Chameleon.h"
#import "Allergen.h"
#import "Condition.h"
#import "AppController.h"
#import "ContradictionAPIClient.h"
#import "PharmacySelectController.h"
#import "Pharmacy.h"

@class SendPrescriptionController;             //define class, so protocol can see MyClass
@protocol SendPrescriptionDelegate <NSObject>   //define delegate protocol
- (void) refreshMedicationAdd;  //define delegate method to be implemented within another class
@end

@interface SendPrescriptionController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {
    
    IBOutlet UILabel *drugName;
    IBOutlet UITextField *componentText;
    IBOutlet UITextField *refillText;
    IBOutlet UITextField *amountText;
    IBOutlet UIButton *pharmacyButton;;
    IBOutlet UILabel *doseText;
     IBOutlet UITextField *doseStrengthText;
    
    BOOL isPasscode;
    
    BOOL isPharm;
}

@property (nonatomic) NSMutableArray *selectedConditions;

@property (nonatomic) NSMutableArray *patientConditions;

@property (nonatomic) NSMutableArray *selectedAllergens;
@property (nonatomic) NSMutableArray *contradictedConditions;

@property (nonatomic) NSMutableArray *monoGraphArray;

@property (nonatomic) Drug *drug;

@property (nonatomic, retain) Patient *patient;

@property (nonatomic, retain) Pharmacy *pharmacy;

@property (nonatomic, weak) id <SendPrescriptionDelegate> delegate;


@end
