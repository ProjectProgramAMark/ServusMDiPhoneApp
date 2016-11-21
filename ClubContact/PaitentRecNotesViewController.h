//
//  PaitentRecNotesViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AppController.h"
#import "PatientRecordAboutCell.h"
#import "PatientMedication.h"
#import "Condition.h"
#import "Allergen.h"
#import "Note.h"
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
#import "AddAllergyViewController.h"
#import "PatientDrugDetailsViewController.h"
#import "DrugsViewController.h"
#import "EditPatientiPhoneViewController.h"
#import "CalendarDetailViewController.h"
#import "CreateNewEventViewController.h"
#import "CountryPicker.h"
#import "ConditionsTableViewCell.h"

@interface PaitentRecNotesViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> { IBOutlet UIImageView *profileIMG;
    IBOutlet UIImageView *profileBackIMG;
    
    
    IBOutlet UITableView *menuTable;
    
     IBOutlet UIView *menuButton;
    
}

@property (strong, nonatomic) NSMutableArray *patientsArray;
@property (nonatomic, retain) Doctors *doctor;
@property (nonatomic, retain) PatientLinks *patientInfo;
@property (nonatomic, retain) Patient *profPatient;



@end
