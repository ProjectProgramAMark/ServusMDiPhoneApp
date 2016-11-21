//
//  AppController.h
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIService.h"
#import "Account.h"
#import "Patient.h"
#import "Condition.h"
#import "Appointments.h"
#import "Doctors.h"
#import "Messages.h"
#import "Allergen.h"
#import "RequestAppointments.h"
#import "Pharmacy.h"
#import "Drug.h"
#import "PatientMedication.h"
#import "Refills.h"
#import "Consulatation.h"
#import "MSGSession.h"
#import "PatientLogin.h"
#import "PatientRegister.h"
#import "PatientLinks.h"
#import "PMaster.h"
#import "Rating.h"
#import "Notifications.h"
#import "Pharmacy.h"
#import "EyeExam.h"
#import "EyeExam2.h"
#import "SharedDocuments.h"
#import "Transactions.h"
#import "BankDetails.h"
#import "UnifiedRequests.h"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//#define IS_HEIGHT_GTE_667 [[UIScreen mainScreen ] bounds].size.height >= 667.0f
//#define IS_IPHONE_6 ( IS_IPHONE && IS_HEIGHT_GTE_667 )
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)

#define IS_IPHONE_6P_IOS8 (IS_IPHONE && ([[UIScreen mainScreen] nativeBounds].size.height/[[UIScreen mainScreen] nativeScale]) == 736.0f)

#define IS_IOS_7    (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)

#define windowHeight            [UIScreen mainScreen].bounds.size.height
#define windowWidth             [UIScreen mainScreen].bounds.size.width


@interface AppController : NSObject

+ (AppController *)sharedInstance;

#pragma mark - API Service
- (void)registerPatient:(Patient *)patientInfo WithCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)updatePatient:(Patient *)patientInfo WithCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)updatePatientIMG:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)checkPhysciansWithLastname:(NSString *)lastName andNPI:(NSString *)npi completion:(void (^)(BOOL success, NSString *message))block;

//- (void)registerWithAccoutCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)registerWithAccoutCompletion:(void (^)(BOOL success, NSString *message, NSString *userid))block;

- (void)loginDoctorWithPassword:(NSString *)password Email: (NSString *)email Completion:(void (^)(BOOL success, NSString *message))block;

- (void)getLoginTypePassword:(NSString *)password Email: (NSString *)email Completion:(void (^)(BOOL success, NSString *message, NSString *profileType))block;

- (void)getRecoverPassword:(NSString *)username Email:(NSString *)email Completion:(void (^)(BOOL, NSString *))block;

- (void)registerPatientWithAccoutCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)loginPatientWithPassword:(NSString *)password Email: (NSString *)email Completion:(void (^)(BOOL success, NSString *message))block;

- (void)linkPatientRecord:(NSString *)password patientid: (NSString *)patientid Completion:(void (^)(BOOL success, NSString *message))block;

- (void)transferPatientRecord:(NSString *)patientid Completion:(void (^)(BOOL, NSString *))block ;

- (void)getAllPatiensByPage:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;

- (void)getAllSharedPatiensByPage:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;

- (void)getAllPatiensByPage2:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;

- (void)getAllPatiensByPage3:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;

- (void)getAllPatiensByPage4:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;

- (void)getAllConditionByPage:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;


- (void)addConditionToPatient:(NSString*)patientid conditionname:(NSString *)condition conditioncode:(NSString *)conditioncode WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllConditionByPatient:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllConditionByPatient2:(NSString*)patientid doctor:(NSString *)docid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)addAllergenToPatient:(NSString*)patientid name:(NSString *)name pickid:(NSString *)allergyid  type:(NSString *)allergytype h7id:(NSString *)h7id htype:(NSString *)htype WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllAllergenByPatient:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;


- (void)getAllEyeExamsByPatient:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllEyeExamsByPatient2:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllEyeExamsByPatient2:(NSString *)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;


- (void)getAllAllergenByPatient2:(NSString*)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllAllergenByPatient:(NSString *)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)deleteProfileAllergy:(NSString *)allergyID
                    completion:(void (^)(BOOL success, NSString *message))block;


- (void)deleteGenericNodeDoc:(NSString *)nodeID
                  completion:(void (^)(BOOL success, NSString *message))block;
- (void)deleteSharedDocument:(NSString *)postid completion:(void (^)(BOOL, NSString *))block;

- (void)getMessagesByPatient:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getMessagesForDoc:(NSString*)patientid sessionID:(NSString *)sessionID   WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getMessagesBySession:(NSString*)patientid sessionID:(NSString *)sessionID  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getMessagesBySession2:(NSString*)patientid sessionID:(NSString *)sessionID  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllMSGSessions:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getMSGSessionsByID:(NSString *)docuid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL success, NSString *message, MSGSession *msgsession ))block;

- (void)addMessageToPatient:(NSString*)patientid messagetext:(NSString *)message msgimg:(UIImage *)messageImage WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)addMessageToPatient2:(NSString*)patientid messagetext:(NSString *)message msgimg:(UIImage *)messageImage sessionID:(NSString *)sessionID  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;


- (void)addMessageToDoc:(NSString*)patientid messagetext:(NSString *)message msgimg:(UIImage *)messageImage sessionID:(NSString *)sessionID  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)acceptMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block ;

- (void)declineMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block ;

- (void)closeMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block ;


- (void)acceptDocMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block ;

- (void)declineDocMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block ;

- (void)closeDocMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block ;


- (void)getDocMSGSessions:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getMyDocMSGSessions:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getDocMSGSessionsByID:(NSString *)docuid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL success, NSString *message, MSGSession *msgsession ))block;


- (void)inviteMessaging:(NSString *)appid
                completion:(void (^)(BOOL success, NSString *message))block;


- (void)inviteDoctorMessaging:(NSString *)appid
             completion:(void (^)(BOOL success, NSString *message, NSString *sessionid))block;


- (void)addProfileAudioNote:(NSString *)audioFilePath
                  ToPatient:(NSString *)patientID
                      title:(NSString *)title
                 completion:(void (^)(BOOL success, NSString *message))block;

- (void)addProfilePhotoNote:(UIImage *)photo
                  ToPatient:(NSString *)patientID
                      title:(NSString *)title
                 completion:(void (^)(BOOL success, NSString *message))block;


- (void)addProfileTextNote:(NSString *)textNote
                 ToPatient:(NSString *)patientID
                     title:(NSString *)title
                completion:(void (^)(BOOL success, NSString *message))block;

- (void)getAllNotesByPatient:(NSString*)patientid
              WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *notes))block;

- (void)getAllNotesByPatient:(NSString*)patientid
                       docid:(NSString *)docid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *notes))block;

- (void)getAllNotesByPatient2:(NSString*)patientid doctor:(NSString *)docid
              WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *notes))block;


- (void)deleteProfileCondition:(NSString *)conditionID
                    completion:(void (^)(BOOL success, NSString *message))block;


- (void)deleteProfileNote:(NSString *)noteID
               completion:(void (^)(BOOL success, NSString *message))block;

- (void)updateNoteTitle:(NSString *)notetitle postid:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *))block ;


- (void)getAllAppointmens:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllAppointmensForPatients:(NSString *)docuid  WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *)) block;

- (void)getAllAppointmensByPatient:(NSString *)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getAllFutureAppointmens:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getFutureAppointmensForPatients:(NSString *)docuid  WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *)) block;

- (void)getAllAppointmensByPatient:(NSString *)patientid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllAppointmensByPatient2:(NSString *)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)addAppointment:(NSString*)patientid fromdate:(NSString *)from todate:(NSString *)to titletext:(NSString *)apptitle notetext:(NSString *)appnote  completion:(void (^)(BOOL success, NSString *message))block;

- (void)getRequestAppointmens:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getRequestUnified:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getRequestAppointmensIndividual:(NSString *)docuid postid:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getAllMedicationByPatient:(NSString *)patientid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllMedicationByPatient:(NSString *)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getAllMedicationForPatients:(NSString *)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getAllMedicationByPatient2:(NSString *)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllMedicationByPatientForRefill:(NSString *)patientid doctor:(NSString *)docid patient:(PatientLinks *)plink WithCompletion:(void (^)(BOOL success, NSString *message, PatientLinks *patientLink, NSMutableArray *conditions))block;

- (void)getAllConsultations:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getConsultationIndividual:(NSString *)docuid postid:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)acceptConsultation:(NSString *)appid
                      completion:(void (^)(BOOL success, NSString *message))block;

- (void)declineConsultation:(NSString *)appid
                      completion:(void (^)(BOOL success, NSString *message))block;

- (void)inviteConsultation:(NSString *)appid
                 completion:(void (^)(BOOL success, NSString *message))block;


- (void)updateOnlineStatus:(NSString *)appid
                completion:(void (^)(BOOL success, NSString *message))block;

- (void)updateDoctor:(Doctors *)patientInfo WithCompletion:(void (^)(BOOL success, NSString *message))block;


- (void)deleteDoctorAppointment:(NSString *)appid
                    completion:(void (^)(BOOL success, NSString *message))block;

- (void)declineRequestAppointment:(NSString *)appid
                     completion:(void (^)(BOOL success, NSString *message))block;

- (void)acceptRequestAppointment:(NSString *)appid
                       completion:(void (^)(BOOL success, NSString *message))block;

- (void)acceptRefill:(NSString *)appid
                      completion:(void (^)(BOOL success, NSString *message))block;

- (void)declineRefill:(NSString *)appid
          completion:(void (^)(BOOL success, NSString *message))block;


- (void)updateDoctorPasscode:(NSString *)passcode
                     completion:(void (^)(BOOL success, NSString *message))block;


- (void)getDoctorProfile:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, Doctors *doctorProfile))block;

- (void)getDoctorProfileForID:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, Doctors *))block;

- (void)getAllDoctors:(NSString *)page keyword:(NSString*)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;
- (void)getAllDoctors2:(NSString *)page keyword:(NSString*)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)updateDoctorIMG:(NSString *)docuid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)updateDoctorSig:(NSString *)docuid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)getSearchPharmacy:(NSString *)location WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;


- (void)addPrescription:(NSString*)patientid drug:(Drug *)drug pharmacy:(Pharmacy *)pharmcy conditions:(NSString *)conditions allergies:(NSString *)allergy component:(NSString *)component refill:(NSString *)refill amount:(NSString *)amount passcode:(NSString *)passcode completion:(void (^)(BOOL success, NSString *message))block;

#pragma mark - patient links

- (void)getLinkPatients:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getLinkPatientsIndividual:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;


- (void)getPatientProfile:(NSString*)docid keyword:(NSString *)patientid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;

- (void)sendRefillRequest:(NSString *)patientid doctor:(NSString *)docid medication:(NSString *)medid
          completion:(void (^)(BOOL success, NSString *message))block;

- (void)getAllAppointmens2:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block; 

- (void)getPMasterByID:(NSString *)pid WithCompletion:(void (^)(BOOL success, NSString *message, PMaster *msgsession ))block;

- (void)getPMasterByID2:(NSString *)pid WithCompletion:(void (^)(BOOL, NSString *, PMaster *))block ;

- (void)getPMasterBankDetails:(NSString *)pid WithCompletion:(void (^)(BOOL success, NSString *message, BankDetails *msgsession ))block;

- (void)addWithdrawalRequest:(BankDetails *)bankdetails WithCompletion:(void (^)(BOOL, NSString *))block;

- (void)updatePMasterIMG:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)updatePMasterID:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block;

- (void)updateParentID:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block;

- (void)updatePMasterInsurance:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)updatePMasterInsuranceBack:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)updatePMaster:(PMaster *)patientInfo WithCompletion:(void (^)(BOOL success, NSString *message))block;
- (void)getAllConditionByPage2:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;

- (void)updateParent:(PMaster *)patientInfo WithCompletion:(void (^)(BOOL, NSString *))block;

- (void)getAllConditionByPatient:(NSString*)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllConsultations2:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllDoctors3:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)checkDoctorPasscode:(NSString *)passcode completion:(void (^)(BOOL, NSString *))block;

- (void)createShareRecordDoctor:(NSString *)docuid patientid:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSString *))block;

- (void)addConsultation:(NSString*)docid fromdate:(NSString *)from tnotetext:(NSString *)appnote  completion:(void (^)(BOOL success, NSString *message))block;

- (void)getMesRecSession:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getMSGSessionsByID2:(NSString *)docuid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, MSGSession *))block;

- (void)addMessageToPatientRec:(NSString *)patientid messagetext:(NSString *)message msgimg:(UIImage *)messageImage sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)closeMSGSessionRec:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block;

- (void)createNewMSGSession:(NSString *)docuid  WithCompletion:(void (^)(BOOL success, NSString *message, NSString *msgID ))block;

- (void)getMSGSessionsByID3:(NSString *)docuid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL success, NSString *message, MSGSession *msgsession ))block;

- (void)getAllConditionByPMaster:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)addConditionToPMaster:(NSString*)patientid conditionname:(NSString *)condition conditioncode:(NSString *)conditioncode WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;


- (void)addAllergenToPMaster:(NSString*)patientid name:(NSString *)name pickid:(NSString *)allergyid  type:(NSString *)allergytype h7id:(NSString *)h7id htype:(NSString *)htype WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllAllergenByPMMaster:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllPharmacyByPMMaster:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getAllPharmacyByPMMaster2:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block ;

- (void)addPharmacyToPMaster:(NSString*)patientid pharmname:(NSString *)pharmname pharmaddress:(NSString *)pharmadd WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)deletePMasterCondition:(NSString *)conditionID
                    completion:(void (^)(BOOL success, NSString *message))block;

- (void)deletePMasterPharmacy:(NSString *)conditionID
                    completion:(void (^)(BOOL success, NSString *message))block;


- (void)deletePMasterAllergen:(NSString *)conditionID
                    completion:(void (^)(BOOL success, NSString *message))block;

- (void)getDoctorProfile2:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, Doctors *doctorProfile))block;

- (void)addConsultation2:(NSString *)docid fromdate:(NSString *)from tnotetext:(NSString *)appnote pharmcyname:(NSString *)pharmname pharmancyaddress:(NSString *)pharmadd  completion:(void (^)(BOOL, NSString *))block;

- (void)createShareRecord:(NSString *)docuid patientid:(NSString *)patientid WithCompletion:(void (^)(BOOL success, NSString *message, NSString *msgID ))block;

- (void)getAllDoctorRating:(NSString*)docid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions, NSString *totalrating))block;


- (void)getMyDoctorRating:(NSString*)docid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions, NSString *totalrating))block;

- (void)addRatingToDoctor:(NSString *)docid stars:(NSString *)stars review:(NSString *)review WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)deleteDoctorRating:(NSString *)ratingID
                   completion:(void (^)(BOOL success, NSString *message))block;


- (void)addPMAppointment:(NSString*)docid patient:(NSString *)patientid fromdate:(NSString *)from todate:(NSString *)to  notetext:(NSString *)appnote  completion:(void (^)(BOOL success, NSString *message))block;

- (void)getAllConsultations3:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)getMesRecSessionAll:(NSString *)docuid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;

- (void)chargePayment:(NSDictionary *)paymentdict
                completion:(void (^)(BOOL success, NSString *message))block;

- (void)getAllAppointmens3:(NSString *)docuid plink:(PatientLinks *)plink WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *, PatientLinks *))block;

- (void)getAllConditionByPMasterID:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block ;

- (void)getAllConditionByPMaster2:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getAllAllergenByPMMasterByID:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block ;

- (void)getAllAllergenByPMMaster2:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)updateDocAvailability:(NSString *)appid
                completion:(void (^)(BOOL success, NSString *message))block;

- (void)updatePMasterPasscode:(NSString *)passcode completion:(void (^)(BOOL, NSString *))block ;
- (void)checkPMasterPasscode:(NSString *)passcode completion:(void (^)(BOOL, NSString *))block ;

- (void)getPNotifications:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block ;

- (void)getDNotifications:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)markNotificationsRead2:(NSString *)otherid completion:(void (^)(BOOL, NSString *))block;

- (void)sendCallNotification:(NSString *)otherid
           completion:(void (^)(BOOL success, NSString *message))block;

- (void)markNotificationsRead:(NSString *)otherid
                  completion:(void (^)(BOOL success, NSString *message))block;

- (void)markDocumentRead:(NSString *)otherid
                   completion:(void (^)(BOOL success, NSString *message))block;

- (void)getSingleEyeExam:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;


- (void)getDoctorTransactions:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getPatientTransaction:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getSharedDocuments:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)shareEyeExam:(NSString *)patientid todoc:(NSString *)todoc postid:(NSString *)postid  completion:(void (^)(BOOL, NSString *))block;

- (void)getSingleAppointmens:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;

- (void)getMedicationByID:(NSString *)medID WithCompletion:(void (^)(BOOL, NSString *, PatientMedication *))block;

- (void)registerPatientMaster:(PatientRegister *)patientInfo WithCompletion:(void (^)(BOOL success, NSString *message))block;

- (void)changePasswordForUser:(NSString *)uid password:(NSString *)password WithCompletion:(void (^)(BOOL success, NSString *message))block;


- (void)changePasswordForDoctor:(NSString *)uid password:(NSString *)password oldpassword:(NSString *)oldpassword WithCompletion:(void (^)(BOOL, NSString *))block;

- (void)addEyeExamForPatient:(EyeExam *)eyeExam WithCompletion:(void (^)(BOOL success, NSString *message))block;


- (void)addEyeExamForPatient2:(EyeExam2 *)eyeExam WithCompletion:(void (^)(BOOL success, NSString *message))block;



- (void)addEyeExamForms:(UIImage *)photo
                   form2:(UIImage *)photo2
                  form3:(UIImage *)photo3
                  ToPatient:(NSString *)patientID
                 completion:(void (^)(BOOL success, NSString *message))block;

// Manage account
- (void)storePhysicianToUserDefault:(Account *)account;
- (void)storePatientToUserDefault:(PatientRegister *)account;
- (Account *)getPhysicianFromUserDefault;
- (PatientRegister *)getPatientFromUserDefault;

@end
