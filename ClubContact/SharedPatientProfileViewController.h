//
//  SharedPatientProfileViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/31/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "Condition.h"
#import "ConditionListViewController.h"
#import "AddConditionsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "IQAudioRecorderController.h"
#import "PatientsTableViewCell.h"
#import "NoteTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "FFAddEventPopoverController.h"
#import "AddAppointmentViewController.h"
#import "AppointmentDetailViewController.h"
#import "FFEvent.h"
#import "AppointmentDetailViewController.h"
#import "EditPatientViewController.h"
#import "DrugSearchAPIClient.h"
#import "AllergenSearchAPIClient.h"
#import "Allergen.h"
#import "AddAllergyViewController.h"
#import "PatientMedication.h"
#import "PatientDrugDetailsViewController.h"
#import "DrugsViewController.h"
#import "EditPatientiPhoneViewController.h"
#import "CalendarDetailViewController.h"
#import "CreateNewEventViewController.h"
#import "CountryPicker.h"


@protocol SharedPatientProfileViewControllerDelegate <NSObject>   //define delegate protocol
- (void) refreshPatientList;  //define delegate method to be implemented within another class
@end

@interface SharedPatientProfileViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, AddConditionsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MPMediaPickerControllerDelegate, IQAudioRecorderControllerDelegate, PatientsTableViewCellDelegate, AddAppointmentViewControllerDelegate, AppointmentDetailProtocol, EditPatientDelegate, AddAllergyDelegate, ConditionsListDelegate, DrugsListDelegate, UITextFieldDelegate, CountryPickerDelegate>
@property (strong, nonatomic) Patient *patient;
@property (nonatomic, weak) id <SharedPatientProfileViewControllerDelegate> delegate;
@property (strong, nonatomic) DrugSearchAPIClient *client;
@property (strong, nonatomic) AllergenSearchAPIClient *allergenClient;

@end
