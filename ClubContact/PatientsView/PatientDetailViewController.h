//
//  PatientDetailViewController.h
//  ClubContact
//
//  Created by wangkun on 15/3/11.
//  Copyright (c) 2015年 askpi. All rights reserved.
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
#import "EyeExam.h"
#import "AddEyeExamFormViewController.h"
#import "EyeExamViewController.h"
#import "AddEyeExam2VC.h"
#import "EyeExam2VC.h"
#import "FreeDrawingViewController.h"
#import "DrawingEyeExamViewController.h"
#import "EyeExamImageViewController.h"
#import "AmslerGridViewController.h"
#import "SendPatientRecordsDoctor.h"
#import "PickerCellsController.h"
#import "HSDatePickerViewController.h"
#import "AppointmentDashTableViewCell.h"
#import "MedicationPListViewController.h"
#import "ConditionListNewViewController.h"
#import "AllergyListNewViewController.h"
#import "NoteNewsViewController.h"
#import "EyeExamListViewController.h"
@protocol PatientsDetailDelegate <NSObject>   //define delegate protocol
- (void) refreshPatientList;  //define delegate method to be implemented within another class
@end


@interface PatientDetailViewController :  BaseViewController<UITableViewDataSource, UITableViewDelegate, AddConditionsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MPMediaPickerControllerDelegate, IQAudioRecorderControllerDelegate, PatientsTableViewCellDelegate, AddAppointmentViewControllerDelegate, AppointmentDetailProtocol, EditPatientDelegate, AddAllergyDelegate, ConditionsListDelegate,  DrugsListDelegate, UITextFieldDelegate, CountryPickerDelegate>
@property (strong, nonatomic) Patient *patient;
@property (nonatomic, weak) id <PatientsDetailDelegate> delegate;
@property (strong, nonatomic) DrugSearchAPIClient *client;
@property (strong, nonatomic) AllergenSearchAPIClient *allergenClient;
@property (nonatomic, strong) PickerCellsController *pickersController;

@property (nonatomic) BOOL isSharedProfile;


@end


