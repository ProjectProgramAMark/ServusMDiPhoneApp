//
//  AppController.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AppController.h"
#import "DeviceInfo.h"
#import "Doctor.h"
#import "Patient.h"
#import "Note.h"

#define kAPIBaseURL     @"https://api.myfidem.com/api/"

//#define kAPIBaseURL     @"http://173.82.2.240/api/"
//#define kAPIBaseURL2     @"http://173.82.2.240"

static AppController *sharedInstance = nil;

@implementation AppController

+ (AppController *)sharedInstance
{
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppController alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - API Service
- (void)deleteProfileNote:(NSString *)noteID
                   completion:(void (^)(BOOL success, NSString *message))block
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:noteID forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deletenotes",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}

- (void)deleteProfileCondition:(NSString *)conditionID
               completion:(void (^)(BOOL success, NSString *message))block
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:conditionID forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deletecondition",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}

- (void)addProfileTextNote:(NSString *)textNote
                 ToPatient:(NSString *)patientID
                     title:(NSString *)title
                completion:(void (^)(BOOL success, NSString *message))block
{
    NSDictionary *noteDic = @{@"notetext" : textNote, @"notetitle" : title};
    [self addProfileNote:noteDic ToPatient:patientID completion:block];
}

- (void)addProfilePhotoNote:(UIImage *)photo
                 ToPatient:(NSString *)patientID
                      title:(NSString *)title
                completion:(void (^)(BOOL success, NSString *message))block
{
    NSString *base64EncodeString = [self base64EncodeDataWithImage:photo];
    NSDictionary *noteDic = @{@"postimage" : base64EncodeString, @"notetitle" : title};
    [self addProfileNote:noteDic ToPatient:patientID completion:block];
}

- (void)addProfileAudioNote:(NSString *)audioFilePath
                  ToPatient:(NSString *)patientID
                      title:(NSString *)title
                 completion:(void (^)(BOOL success, NSString *message))block
{
    NSData *audioData = [NSData dataWithContentsOfFile:audioFilePath];
    NSString *base64EncodeString = [audioData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *noteDic = @{@"recording" : base64EncodeString, @"notetitle" : title};
    [self addProfileNote:noteDic ToPatient:patientID completion:block];
}

- (void)addProfileNote:(NSDictionary *)notesDic
             ToPatient:(NSString *)patientID
            completion:(void (^)(BOOL success, NSString *message))block
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    NSMutableDictionary *postDic = [notesDic mutableCopy];
    
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientID forKey:@"patientid"];
    
    NSString *url = [NSString stringWithFormat:@"%@addNotes2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}


- (void)getAllNotesByPatient:(NSString*)patientid
              WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *notes))block
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientNotes",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"notes"];
            for (NSDictionary *noteDic in data)
            {
                Note *note = [[Note alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}




- (void)getAllNotesByPatient:(NSString*)patientid
                       docid:(NSString *)docid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *notes))block
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientNotes",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"notes"];
            for (NSDictionary *noteDic in data)
            {
                Note *note = [[Note alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}



- (void)getAllNotesByPatient2:(NSString *)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    //Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientNotes",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"notes"];
            for (NSDictionary *noteDic in data)
            {
                Note *note = [[Note alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}





- (void)updateNoteTitle:(NSString *)notetitle postid:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *))block {

    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:postid forKey:@"postid"];
    [postDic setObject:notetitle forKey:@"notetitle"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@editNoteTitle",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}



- (void)getAllAppointmens:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
 
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDoctorAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    

    
}





- (void)getAllFutureAppointmens:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getFutureAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}




- (void)getAllAppointmens2:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
  //  Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docuid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDoctorAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}



- (void)getAllAppointmensByPatient:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}



- (void)getAllAppointmensByPatient:(NSString *)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}






- (void)getAllAppointmensByPatient2:(NSString *)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}






- (void)addAppointment:(NSString *)patientid fromdate:(NSString *)from todate:(NSString *)to titletext:(NSString *)apptitle notetext:(NSString *)appnote completion:(void (^)(BOOL, NSString *))block {
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    [postDic setObject:from forKey:@"fromdate"];
    [postDic setObject:to forKey:@"todate"];
    [postDic setObject:apptitle forKey:@"aptitle"];
    [postDic setObject:appnote forKey:@"apnotes"];
    
    NSString *url = [NSString stringWithFormat:@"%@addAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

    
}


- (void)deleteDoctorAppointment:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
 
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deleteAppointment",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}



- (void)getRequestAppointmens:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getRequestAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                RequestAppointments *note = [[RequestAppointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}




- (void)getRequestUnified:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getUnifiedRequests",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                UnifiedRequests *note = [[UnifiedRequests alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}






- (void)getRequestAppointmensIndividual:(NSString *)docuid postid:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:postid forKey:@"postid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getReqAppIndividual",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                RequestAppointments *note = [[RequestAppointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}






- (void)declineRequestAppointment:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deleteAppRequest",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}

- (void)acceptRequestAppointment:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@acceptAppointment",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}



- (void)getDoctorProfile:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, Doctors *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
     [postDic setObject:doc.uid forKey:@"otherUserId"];
   
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getdoctor",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        Doctors  *doctors;
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSDictionary *data = responseObject;
            doctors = [[Doctors alloc] initWithDic:data];
            
            if (block)
            {
                block(success, message, doctors);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, doctors);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            Doctors  *doctors;
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], doctors);
        }
    }];
}



- (void)getDoctorProfileForID:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, Doctors *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
  //  Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docuid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"otherUserId"];
    
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getdoctor",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        Doctors  *doctors;
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSDictionary *data = responseObject;
            doctors = [[Doctors alloc] initWithDic:data];
            
            if (block)
            {
                block(success, message, doctors);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, doctors);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            Doctors  *doctors;
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], doctors);
        }
    }];
}




- (void)updateDoctorIMG:(NSString *)docuid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block {
    NSString *patientIMGString =  [self base64EncodeDataWithImage:patientImage];
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientIMGString forKey:@"profileimage"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updateDoctorIMG",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}

- (void)updateDoctorSig:(NSString *)docuid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block {
    NSString *patientIMGString =  [self base64EncodeDataWithImage:patientImage];
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientIMGString forKey:@"signature"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updateDoctorSig",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}


- (void)updateDoctor:(Doctors *)patientInfo WithCompletion:(void (^)(BOOL, NSString *))block {
    
    NSMutableDictionary *postDic = [self dictionWithDoctors:patientInfo];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updateDoctor3",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}

- (void)checkPhysciansWithLastname:(NSString *)lastName andNPI:(NSString *)npi completion:(void (^)(BOOL success, NSString *message))block
{
    [[APIService sharedInstance] checkPhysciansWithLastname:lastName andNPI:npi completion:^(NSDictionary *responseDict) {
        BOOL success = false;
        NSString *message = @"";
      //  if ([responseDict[@"code"] isEqualToString:@"200"])
        NSDictionary *meta = responseDict[@"meta"];
        int rowCount = [[meta objectForKey:@"rowCount"] intValue];
        if (rowCount == 1)
        {
            message = @"Registration Success";
            success = true;
        } else {
            message = @"We cannot verify you as physician please try again or contact us.";
        }
        
        if (block) {
            block (success, message);
        }
    }];
}


- (void)registerPatient:(Patient *)patientInfo WithCompletion:(void (^)(BOOL success, NSString *message))block
{
    NSMutableDictionary *postDic = [self dictionWithPatient:patientInfo];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@registerpatient2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}

- (void)updatePatient:(Patient *)patientInfo WithCompletion:(void (^)(BOOL success, NSString *message))block
{
    NSMutableDictionary *postDic = [self dictionWithPatient2:patientInfo];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updatePatient2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}

- (void)updatePatientIMG:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block {
    
   // UIImage *tempimage = UIImageJPEGRepresentation(patientImage, 0.5f);
    
    NSString *patientIMGString =  [self base64EncodeDataWithImage:patientImage];
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"postid"];
    [postDic setObject:patientIMGString forKey:@"profileimage"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updateProfileIMG",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}

- (void)getAllPatiensByPage:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllPatiens",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"posts"];
            for (NSDictionary *patientDic in data)
            {
                Patient *patient = [[Patient alloc] initWithDic:patientDic];
                [patients addObject:patient];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}


- (void)getAllPatiensByPage2:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllPatiens2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"posts"];
            for (NSDictionary *patientDic in data)
            {
                Patient *patient = [[Patient alloc] initWithDic:patientDic];
                [patients addObject:patient];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}


- (void)getAllPatiensByPage3:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllPatiens4",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"posts"];
            for (NSDictionary *patientDic in data)
            {
                Patient *patient = [[Patient alloc] initWithDic:patientDic];
                [patients addObject:patient];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}




- (void)getAllPatiensByPage4:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllPatiens5",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"posts"];
            for (NSDictionary *patientDic in data)
            {
                Patient *patient = [[Patient alloc] initWithDic:patientDic];
                [patients addObject:patient];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}




- (void)getAllConditionByPage:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllConditions",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"conditions"];
            for (NSDictionary *patientDic in data)
            {
                Condition *condition = [[Condition alloc] initWithDic:patientDic];
                [conditions addObject:condition];
            }
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}




- (void)getAllConditionByPage2:(NSString*)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *patiens))block;
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllConditions",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"conditions"];
            for (NSDictionary *patientDic in data)
            {
                Condition *condition = [[Condition alloc] initWithDic:patientDic];
                [conditions addObject:condition];
            }
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}





- (void)getAllConditionByPatient:(NSString*)patientid  WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];

    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientCondition",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"conditions"];
            for (NSDictionary *patientDic in data)
            {
                Condition *condition = [[Condition alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

    
}





- (void)getAllConditionByPatient:(NSString*)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL success, NSString *message, NSMutableArray *conditions))block;
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientCondition",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"conditions"];
            for (NSDictionary *patientDic in data)
            {
                Condition *condition = [[Condition alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}




- (void)getAllConditionByPatient2:(NSString *)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    //Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientCondition",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"conditions"];
            for (NSDictionary *patientDic in data)
            {
                Condition *condition = [[Condition alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}


- (void)addConditionToPatient:(NSString *)patientid conditionname:(NSString *)condition conditioncode:(NSString *)conditioncode WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block;
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    [postDic setObject:condition forKey:@"conditionname"];
    [postDic setObject:conditioncode forKey:@"conditionid"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addCondition",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
           
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

}

- (void)getAllAllergenByPatient:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientAllergy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"allergy"];
            for (NSDictionary *patientDic in data)
            {
                Allergen *condition = [[Allergen alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

}




- (void)getAllAllergenByPatient:(NSString *)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    //Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientAllergy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"allergy"];
            for (NSDictionary *patientDic in data)
            {
                Allergen *condition = [[Allergen alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
}




- (void)getAllEyeExamsByPatient:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientEyeExam",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"eyeexam"];
            for (NSDictionary *patientDic in data)
            {
                EyeExam *condition = [[EyeExam alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
}


- (void)getAllEyeExamsByPatient2:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientEyeExamNew",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"eyeexam"];
            for (NSDictionary *patientDic in data)
            {
                EyeExam2 *condition = [[EyeExam2 alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
}





- (void)getAllEyeExamsByPatient2:(NSString *)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientEyeExamNew",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"eyeexam"];
            for (NSDictionary *patientDic in data)
            {
                EyeExam2 *condition = [[EyeExam2 alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
}






- (void)getAllAllergenByPatient2:(NSString *)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
  //  Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientAllergy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"allergy"];
            for (NSDictionary *patientDic in data)
            {
                Allergen *condition = [[Allergen alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
}



- (void)addAllergenToPatient:(NSString *)patientid name:(NSString *)name pickid:(NSString *)allergyid type:(NSString *)allergytype h7id:(NSString *)h7id htype:(NSString *)htype WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    [postDic setObject:name forKey:@"name"];
    [postDic setObject:allergyid forKey:@"allergyid"];
    [postDic setObject:allergytype forKey:@"type"];
    [postDic setObject:h7id forKey:@"hidentifier"];
    [postDic setObject:htype forKey:@"htype"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addAllergy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
            
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    

    
}



- (void)deleteGenericNodeDoc:(NSString *)nodeID completion:(void (^)(BOOL, NSString *))block{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:nodeID forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deletegenericnode",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}


- (void)deleteProfileAllergy:(NSString *)allergyID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:allergyID forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deleteallergy",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}

- (void)getMessagesByPatient:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getmessage",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"messages"];
            for (NSDictionary *patientDic in data)
            {
                Messages *messages = [[Messages alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}


- (void)getMessagesForDoc:(NSString *)patientid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getmessagedoc",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"messages"];
            for (NSDictionary *patientDic in data)
            {
                Messages *messages = [[Messages alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}


- (void)getMessagesBySession:(NSString *)patientid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getmessage4",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"messages"];
            for (NSDictionary *patientDic in data)
            {
                Messages *messages = [[Messages alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}


- (void)getMSGSessionsByID:(NSString *)docuid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, MSGSession *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
     [postDic setObject:doc.uid forKey:@"docid"];
    [postDic setObject:sessionID forKey:@"postid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getChatSession",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        MSGSession *messages = [[MSGSession alloc] init];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
          //  NSArray *data = responseObject[@"msgsessions"];
            messages = [[MSGSession alloc] initWithDic:responseObject];
            
         //   messages.postid = responseObject[@"postid"];
          //   messages.mstatus = responseObject[@"mstatus"];
           /* for (NSDictionary *patientDic in data)
            {
                MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [[MSGSession alloc] init]);
        }
    }];
}

- (void)getAllMSGSessions:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
   // [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getChatSessionCombined",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"msgsessions"];
            for (NSDictionary *patientDic in data)
            {
                MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

}


- (void)addMessageToPatient:(NSString *)patientid messagetext:(NSString *)message msgimg:(UIImage *)messageImage WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSString *msgIMGString = @"";
    
    if (messageImage) {
        msgIMGString = [self base64EncodeDataWithImage2:messageImage];
    }
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"from"];
    [postDic setObject:patientid forKey:@"to"];
    [postDic setObject:message forKey:@"message"];
    [postDic setObject:@"" forKey:@"recording"];
    [postDic setObject:msgIMGString forKey:@"postimage"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@sendmessage",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
            
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    

}

- (void)addMessageToPatient2:(NSString *)patientid messagetext:(NSString *)message msgimg:(UIImage *)messageImage sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSString *msgIMGString = @"";
    
    if (messageImage) {
        msgIMGString = [self base64EncodeDataWithImage2:messageImage];
    }
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"from"];
    [postDic setObject:patientid forKey:@"to"];
    [postDic setObject:message forKey:@"message"];
    [postDic setObject:@"" forKey:@"recording"];
    [postDic setObject:msgIMGString forKey:@"postimage"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@sendmessage2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
            
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}


- (void)acceptMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"patientid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    NSString *url = [NSString stringWithFormat:@"%@acceptMSGSession",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}

- (void)declineMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"patientid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    NSString *url = [NSString stringWithFormat:@"%@declineMSGSession",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}

- (void)closeMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"patientid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    NSString *url = [NSString stringWithFormat:@"%@closesessiond",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}


- (void)inviteMessaging:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"patientid"];
    
    NSString *url = [NSString stringWithFormat:@"%@inviteMessaging",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}


- (void)inviteDoctorMessaging:(NSString *)appid completion:(void (^)(BOOL, NSString *, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"docid"];
    [postDic setObject:@"" forKey:@"notes"];
    
    NSString *url = [NSString stringWithFormat:@"%@addDocMSGSession",  kAPIBaseURL];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        NSString *sessionid = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            sessionid = responseObject[@"nid"];
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message, sessionid);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], @"");
        }
    }];

}

- (void)getDocMSGSessions:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    // [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDocChatSessions",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"msgsessions"];
            for (NSDictionary *patientDic in data)
            {
                MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    

}

- (void)getMyDocMSGSessions:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    // [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getMyDocChatSessions",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"msgsessions"];
            for (NSDictionary *patientDic in data)
            {
                MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    

}

- (void)getDocMSGSessionsByID:(NSString *)docuid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, MSGSession *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"docid"];
    [postDic setObject:sessionID forKey:@"postid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDocChatSession",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        MSGSession *messages = [[MSGSession alloc] init];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //  NSArray *data = responseObject[@"msgsessions"];
            messages = [[MSGSession alloc] initWithDic:responseObject];
            
            //   messages.postid = responseObject[@"postid"];
            //   messages.mstatus = responseObject[@"mstatus"];
            /* for (NSDictionary *patientDic in data)
             {
             MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
             [patients addObject:messages];
             }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [[MSGSession alloc] init]);
        }
    }];

}

- (void)acceptDocMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"patientid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    NSString *url = [NSString stringWithFormat:@"%@acceptDocSession",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}

- (void)declineDocMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"patientid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    NSString *url = [NSString stringWithFormat:@"%@declineDocSession",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}


- (void)closeDocMSGSession:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"patientid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    NSString *url = [NSString stringWithFormat:@"%@closedocchat",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}


- (void)addMessageToDoc:(NSString *)patientid messagetext:(NSString *)message msgimg:(UIImage *)messageImage sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSString *msgIMGString = @"";
    
    if (messageImage) {
        msgIMGString = [self base64EncodeDataWithImage2:messageImage];
    }
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"from"];
    [postDic setObject:patientid forKey:@"to"];
    [postDic setObject:message forKey:@"message"];
    [postDic setObject:@"" forKey:@"recording"];
    [postDic setObject:msgIMGString forKey:@"postimage"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@sendmessagedoc",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
            
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}

- (void)getSearchPharmacy:(NSString *)location WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    //[postDic setObject:doc.uid forKey:@"uid"];
    //[postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&types=pharmacy&key=AIzaSyChQU-HrMF4atknKCG3YLeT-vhM5hRJXkA",  location];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"results"];
            for (NSDictionary *patientDic in data)
            {
                Pharmacy *messages = [[Pharmacy alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

}

- (void)addPrescription:(NSString *)patientid drug:(Drug *)drug pharmacy:(Pharmacy *)pharmcy conditions:(NSString *)conditions allergies:(NSString *)allergy component:(NSString *)component refill:(NSString *)refill amount:(NSString *)amount passcode:(NSString *)passcode completion:(void (^)(BOOL, NSString *))block {
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    [postDic setObject:drug.dispensableDrugDesc forKey:@"name"];
    [postDic setObject:drug.DispensableDrugID forKey:@"medid"];
    [postDic setObject:drug.MedStrength forKey:@"dose"];
    [postDic setObject:drug.MedStrengthUnit forKey:@"doseunit"];
    [postDic setObject:pharmcy.pharmName forKey:@"pharmname"];
    [postDic setObject:pharmcy.address forKey:@"pharmaddress"];
    [postDic setObject:refill forKey:@"refills"];
    [postDic setObject:component forKey:@"components"];
    [postDic setObject:amount forKey:@"amount"];
    [postDic setObject:conditions forKey:@"addedcon"];
    [postDic setObject:allergy forKey:@"addedallergy"];
    [postDic setObject:passcode forKey:@"passcode"];
    
    NSString *url = [NSString stringWithFormat:@"%@sendprescription2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];


}


- (void)getAllMedicationByPatient:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientMedication",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"medication"];
            for (NSDictionary *noteDic in data)
            {
                PatientMedication *note = [[PatientMedication alloc] initWithDic:noteDic];
                
                NSMutableArray *condtions = [NSMutableArray array];
                NSArray *data2 = noteDic[@"conditions"];
                
                for (NSDictionary *noteDic2 in data2)
                {
                    Condition *condition = [[Condition alloc] initWithDic:noteDic2];
                    [condtions addObject:condition];
                }
                
                NSMutableArray *allergies = [NSMutableArray array];
                NSArray *data3 = noteDic[@"allergies"];
                
                for (NSDictionary *noteDic3 in data3)
                {
                    Allergen *allergy = [[Allergen alloc] initWithDic:noteDic3];
                    [allergies addObject:allergy];
                }
                
                NSMutableArray *refills = [NSMutableArray array];
                NSArray *data4 = noteDic[@"refilllist"];
                
                for (NSDictionary *noteDic4 in data4)
                {
                    Refills *refill= [[Refills alloc] initWithDic:noteDic4];
                    [refills addObject:refill];
                }
                
                note.conditions = condtions;
                note.allergy = allergies;
                note.refillArray = refills;
                [notes addObject:note];
                
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

    
}





- (void)getAllMedicationByPatient:(NSString *)patientid docid:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientMedication",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"medication"];
            for (NSDictionary *noteDic in data)
            {
                PatientMedication *note = [[PatientMedication alloc] initWithDic:noteDic];
                
                NSMutableArray *condtions = [NSMutableArray array];
                NSArray *data2 = noteDic[@"conditions"];
                
                for (NSDictionary *noteDic2 in data2)
                {
                    Condition *condition = [[Condition alloc] initWithDic:noteDic2];
                    [condtions addObject:condition];
                }
                
                NSMutableArray *allergies = [NSMutableArray array];
                NSArray *data3 = noteDic[@"allergies"];
                
                for (NSDictionary *noteDic3 in data3)
                {
                    Allergen *allergy = [[Allergen alloc] initWithDic:noteDic3];
                    [allergies addObject:allergy];
                }
                
                NSMutableArray *refills = [NSMutableArray array];
                NSArray *data4 = noteDic[@"refilllist"];
                
                for (NSDictionary *noteDic4 in data4)
                {
                    Refills *refill= [[Refills alloc] initWithDic:noteDic4];
                    [refills addObject:refill];
                }
                
                note.conditions = condtions;
                note.allergy = allergies;
                note.refillArray = refills;
                [notes addObject:note];
                
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}






- (void)getAllMedicationByPatient2:(NSString *)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientMedication",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"medication"];
            for (NSDictionary *noteDic in data)
            {
                PatientMedication *note = [[PatientMedication alloc] initWithDic:noteDic];
                
                NSMutableArray *condtions = [NSMutableArray array];
                NSArray *data2 = noteDic[@"conditions"];
                
                for (NSDictionary *noteDic2 in data2)
                {
                    Condition *condition = [[Condition alloc] initWithDic:noteDic2];
                    [condtions addObject:condition];
                }
                
                NSMutableArray *allergies = [NSMutableArray array];
                NSArray *data3 = noteDic[@"allergies"];
                
                for (NSDictionary *noteDic3 in data3)
                {
                    Allergen *allergy = [[Allergen alloc] initWithDic:noteDic3];
                    [allergies addObject:allergy];
                }
                
                NSMutableArray *refills = [NSMutableArray array];
                NSArray *data4 = noteDic[@"refilllist"];
                
                for (NSDictionary *noteDic4 in data4)
                {
                    Refills *refill= [[Refills alloc] initWithDic:noteDic4];
                    [refills addObject:refill];
                }
                
                note.conditions = condtions;
                note.allergy = allergies;
                note.refillArray = refills;
                [notes addObject:note];
                
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}




- (void)acceptRefill:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@acceptRefill",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}

- (void)declineRefill:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@declineRefill",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}

- (void)getAllConsultations:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDConsultations",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"consultations"];
            for (NSDictionary *noteDic in data)
            {
                Consulatation *note = [[Consulatation alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    

}



- (void)getConsultationIndividual:(NSString *)docuid postid:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:postid forKey:@"postid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDConsultationsIndividual",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"consultations"];
            for (NSDictionary *noteDic in data)
            {
                Consulatation *note = [[Consulatation alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}






- (void)acceptConsultation:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@acceptConsultation",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}

- (void)declineConsultation:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@declineConsultation",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}

- (void)inviteConsultation:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:appid forKey:@"patientid"];
    
    NSString *url = [NSString stringWithFormat:@"%@inviteConsultation",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}

- (void)getAllDoctors:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
     [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllDoctors",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"doctors"];
            for (NSDictionary *patientDic in data)
            {
                Doctors *doctors = [[Doctors alloc] initWithDic:patientDic];
                [patients addObject:doctors];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    

}





- (void)getAllDoctors2:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin  *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllDoctors",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"doctors"];
            for (NSDictionary *patientDic in data)
            {
                Doctors *doctors = [[Doctors alloc] initWithDic:patientDic];
                [patients addObject:doctors];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}




- (void)getAllDoctors3:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor  *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllDoctors",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"doctors"];
            for (NSDictionary *patientDic in data)
            {
                Doctors *doctors = [[Doctors alloc] initWithDic:patientDic];
                [patients addObject:doctors];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}


- (void)updateOnlineStatus:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
  //  [postDic setObject:appid forKey:@"patientid"];
    
    NSString *url = [NSString stringWithFormat:@"%@onlineupdate",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}

- (void)updateDoctorPasscode:(NSString *)passcode completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:passcode forKey:@"passcode"];
    
    NSString *url = [NSString stringWithFormat:@"%@updateDoctorPasscode",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}

- (void)loginDoctorWithPassword:(NSString *)password Email: (NSString *)email Completion:(void (^)(BOOL success, NSString *message))block
{
    DeviceInfo *device = [DeviceInfo getFromUserDefault];
    NSMutableDictionary *postDic = [self dictionWithPassword:password Email:email andDevice:device];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;

    
    NSString *url = [NSString stringWithFormat:@"%@login3",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            message = @"Registration Success";
            Doctor *doc = [Doctor getFromUserDefault];
            if (doc == nil) {
                doc = [Doctor new];
            }
            //You should store the uid, username, email, firstname, lastname, profileimage & signature in the app. These will be used to call other apis.
            doc.uid = responseObject[@"uid"];
            doc.email = responseObject[@"email"];
            doc.username = responseObject[@"username"];
            doc.firstname = responseObject[@"firstname"];
            doc.lastname = responseObject[@"lastname"];
            doc.profileimage = responseObject[@"profileimage"];
            doc.signature = responseObject[@"signature"];

            [doc saveToUserDefault];
            
            
            success = true;
        } else {
            message = responseObject[@"responseMessage"];
        }
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}


- (void)getLoginTypePassword:(NSString *)password Email:(NSString *)email Completion:(void (^)(BOOL, NSString *, NSString *))block
{
    DeviceInfo *device = [DeviceInfo getFromUserDefault];
    NSMutableDictionary *postDic = [self dictionWithPassword:password Email:email andDevice:device];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    
    NSString *url = [NSString stringWithFormat:@"%@logintype",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        NSString *loginType = @"1";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            message = @"Registration Success";
            loginType = responseObject[@"profiletype"];
            
            
            
            success = true;
        } else {
            message = responseObject[@"responseMessage"];
        }
        
        if (block)
        {
            block(success, message, loginType);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], @"");
        }
    }];
    
}




- (void)getRecoverPassword:(NSString *)username Email:(NSString *)email Completion:(void (^)(BOOL, NSString *))block
{
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    [postDic setObject:email forKey:@"email"];
    [postDic setObject:username forKey:@"username"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    
    NSString *url = [NSString stringWithFormat:@"%@forgotpassword2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
  
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            message = @"Registration Success";
          //  loginType = responseObject[@"profiletype"];
            
            
            
            success = true;
        } else {
            message = responseObject[@"responseMessage"];
        }
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}






- (void)loginPatientWithPassword:(NSString *)password Email:(NSString *)email Completion:(void (^)(BOOL, NSString *))block
{
    DeviceInfo *device = [DeviceInfo getFromUserDefault];
    NSMutableDictionary *postDic = [self dictionWithPassword:password Email:email andDevice:device];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@loginpatientportal2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            message = @"Login Success";
            PatientLogin *doc = [PatientLogin getFromUserDefault];
            if (doc == nil) {
                doc = [PatientLogin new];
            }
            //You should store the uid, username, email, firstname, lastname, profileimage & signature in the app. These will be used to call other apis.
            doc.uid = responseObject[@"uid"];
            doc.email = responseObject[@"email"];
            doc.username = responseObject[@"username"];
            doc.firstname = responseObject[@"firstname"];
            doc.lastname = responseObject[@"lastname"];
            doc.profileimage = responseObject[@"profileimage"];
            //doc.signature = responseObject[@"signature"];
            
            [doc saveToUserDefault];
            
                       
            
            success = true;
        } else {
            message = responseObject[@"responseMessage"];
        }
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}

- (void)linkPatientRecord:(NSString *)password patientid:(NSString *)patientid Completion:(void (^)(BOOL, NSString *))block {
    
   // DeviceInfo *device = [DeviceInfo getFromUserDefault];
    PatientLogin *patient = [PatientLogin getFromUserDefault];
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    [postDic setObject:patient.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    [postDic setObject:password forKey:@"passcode"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@linkPatientRecord",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            message = @"Success";
            
            success = true;
        } else {
            message = responseObject[@"responseMessage"];
        }
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
    
}



- (void)transferPatientRecord:(NSString *)patientid Completion:(void (^)(BOOL, NSString *))block {
    
    // DeviceInfo *device = [DeviceInfo getFromUserDefault];
    Doctor *patient = [Doctor getFromUserDefault];
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    [postDic setObject:patient.uid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"otherid"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@transferPatient",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            message = @"Success";
            
            success = true;
        } else {
            message = responseObject[@"responseMessage"];
        }
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
    
}





- (void)registerWithAccoutCompletion:(void (^)(BOOL success, NSString *message, NSString *userid))block
{
    Account *account = [self getPhysicianFromUserDefault];
    DeviceInfo *device = [DeviceInfo getFromUserDefault];
    NSMutableDictionary *postDic = [self dictionWithAccount:account andDevice:device];

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    //@"http://ec2-52-11-89-91.us-west-2.compute.amazonaws.com/api/register2";
    NSString *url = [NSString stringWithFormat:@"%@registerNewDoctor2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {

        BOOL success = false;
        NSString *message = @"";
        NSString *uid = @"";
        if ([responseObject[@"responseCode"] intValue] == 200)
        {
            message = @"Registration Success";
            success = true;
            uid =  responseObject[@"uid"];
        } else {
            message = responseObject[@"responseMessage"];
        }
        
        if (block)
        {
            block(success, message, uid );
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], @"");
        }
    }];
}

- (void)registerPatientMaster:(PatientRegister *)patientInfo WithCompletion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [self dictionWithPatientRegister:patientInfo];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@registerNewPatient2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}



- (void)addEyeExamForPatient:(EyeExam *)eyeExam WithCompletion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [self dictionWithEyeExam:eyeExam];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addEyeExam",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}

- (void)addEyeExamForms:(UIImage *)photo form2:(UIImage *)photo2 form3:(UIImage *)photo3 ToPatient:(NSString *)patientID completion:(void (^)(BOOL, NSString *))block {
    NSString *base64EncodeString = [self base64EncodeDataWithImage:photo];
    NSString *base64EncodeString2 = [self base64EncodeDataWithImage:photo2];
    NSString *base64EncodeString3 = [self base64EncodeDataWithImage:photo3];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:patientID forKey:@"patientid"];
    [postDic setObject:base64EncodeString forKey:@"form1"];
    [postDic setObject:base64EncodeString2 forKey:@"form2"];
    [postDic setObject:base64EncodeString3 forKey:@"form3"];
    
    NSString *url = [NSString stringWithFormat:@"%@addEyeExamForms",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

    
}


- (void)addEyeExamForPatient2:(EyeExam2 *)eyeExam WithCompletion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [self dictionWithEyeExamNew:eyeExam];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addEyeExamNew",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}




- (void)registerPatientWithAccoutCompletion:(void (^)(BOOL, NSString *))block
{
    PatientRegister *account = [self getPatientFromUserDefault];
    DeviceInfo *device = [DeviceInfo getFromUserDefault];
    NSMutableDictionary *postDic = [self dictionWithPatientRegister:account];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    //@"http://ec2-52-11-89-91.us-west-2.compute.amazonaws.com/api/register2";
    NSString *url = [NSString stringWithFormat:@"%@register3",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"code"] isEqualToString:@"200"])
        {
            message = @"Registration Success";
            success = true;
        } else {
            message = responseObject[@"message"];
        }
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}





- (void)getMyDoctorRating:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *, NSString *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"docid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDoctorReviews",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        NSString *totrating = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"posts"];
            for (NSDictionary *patientDic in data)
            {
                Rating *condition = [[Rating alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            totrating = responseObject[@"rating"];
            
            if (block)
            {
                block(success, message, patients, totrating);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients, totrating);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array], @"");
        }
    }];

}




- (void)getAllSharedPatiensByPage:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:page forKey:@"pagenumber"];
    [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAllSharedPatiens",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"posts"];
            for (NSDictionary *patientDic in data)
            {
                Patient *patient = [[Patient alloc] initWithDic:patientDic];
                [patients addObject:patient];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

    
}







- (void)getSharedDocuments:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
  //  [postDic setObject:page forKey:@"pagenumber"];
  //  [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getSharedDocuments",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"documents"];
            for (NSDictionary *patientDic in data)
            {
                SharedDocuments *patient = [[SharedDocuments alloc] initWithDic:patientDic];
                [patients addObject:patient];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}



- (void)getDoctorTransactions:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    //  [postDic setObject:page forKey:@"pagenumber"];
    //  [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDoctorTransactions",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"transactions"];
            for (NSDictionary *patientDic in data)
            {
                Transactions *patient = [[Transactions alloc] initWithDic:patientDic];
                [patients addObject:patient];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}





- (void)getPatientTransaction:(NSString *)page keyword:(NSString *)keyword WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    //  [postDic setObject:page forKey:@"pagenumber"];
    //  [postDic setObject:keyword forKey:@"search"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDoctorTransactions",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"transactions"];
            for (NSDictionary *patientDic in data)
            {
                Transactions *patient = [[Transactions alloc] initWithDic:patientDic];
                [patients addObject:patient];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}








- (void)markDocumentRead:(NSString *)otherid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:otherid forKey:@"postid"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@readDocument",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
    
}



- (void)shareEyeExam:(NSString *)patientid todoc:(NSString *)todoc postid:(NSString *)postid  completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:postid forKey:@"postid"];
    [postDic setObject:patientid forKey:@"patientid"];
     [postDic setObject:todoc forKey:@"todoc"];
    
    NSString *url = [NSString stringWithFormat:@"%@addSharedDocument",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
    
}

- (void)getSingleEyeExam:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:postid forKey:@"postid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getEyeExamSingle",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"eyeexam"];
            for (NSDictionary *noteDic in data)
            {
                EyeExam2 *note = [[EyeExam2 alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}



- (void)deleteSharedDocument:(NSString *)postid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:postid forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deletedocument",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}





- (void)updateDocAvailability:(NSString *)appid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
      [postDic setObject:appid forKey:@"avail"];
    
    NSString *url = [NSString stringWithFormat:@"%@updateDoctorAvail",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}

- (void)deletePMasterPharmacy:(NSString *)conditionID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:conditionID forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deletepmpharm",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}


- (void)getAllPharmacyByPMMaster:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPMPharmacy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"pharmacy"];
            for (NSDictionary *patientDic in data)
            {
                Pharmacy *condition = [[Pharmacy alloc] initWithDic2:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    

    
}






- (void)getAllPharmacyByPMMaster2:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPMPharmacy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"pharmacy"];
            for (NSDictionary *patientDic in data)
            {
                Pharmacy *condition = [[Pharmacy alloc] initWithDic2:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
    
}




- (void)addPharmacyToPMaster:(NSString *)patientid pharmname:(NSString *)pharmname pharmaddress:(NSString *)pharmadd WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    [postDic setObject:pharmname forKey:@"pharmname"];
    [postDic setObject:pharmadd forKey:@"pharmaddress"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addPMPhamracy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
            
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

    
}

#pragma mark - linked patients


- (void)getLinkPatients:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {

        NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
        PatientLogin  *doc = [PatientLogin getFromUserDefault];
        [postDic setObject:doc.uid forKey:@"uid"];
 
        [postDic setObject:@"" forKey:@"search"];
        
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
        
        NSString *url = [NSString stringWithFormat:@"%@getLinkedPatients",  kAPIBaseURL];
        
        [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            BOOL success = false;
            
            NSMutableArray *patients = [NSMutableArray array];
            
            NSString *message = @"";
            if ([responseObject[@"responseCode"] integerValue] == 200)
            {
                success = true;
                NSArray *data = responseObject[@"posts"];
                for (NSDictionary *patientDic in data)
                {
                    PatientLinks *doctors = [[PatientLinks alloc] initWithDic:patientDic];
                    [patients addObject:doctors];
                }
                
                if (block)
                {
                    block(success, message, patients);
                }
            }
            else
            {
                message = responseObject[@"responseMessage"];
                
                if (block)
                {
                    block(success, message, patients);
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (block) {
                block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
            }
        }];
        

}






- (void)getLinkPatientsIndividual:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin  *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    [postDic setObject:patientid forKey:@"postid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getLinkedPatientIndividual",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"posts"];
            for (NSDictionary *patientDic in data)
            {
                PatientLinks *doctors = [[PatientLinks alloc] initWithDic:patientDic];
                [patients addObject:doctors];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}





- (void)getPatientProfile:(NSString *)docid keyword:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
 
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientProfile",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"posts"];
            for (NSDictionary *patientDic in data)
            {
                Patient *patient = [[Patient alloc] initWithDic:patientDic];
                [patients addObject:patient];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

    
}

- (void)sendRefillRequest:(NSString *)patientid doctor:(NSString *)docid medication:(NSString *)medid completion:(void (^)(BOOL, NSString *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
  //  Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    [postDic setObject:medid forKey:@"medid"];
    
    NSString *url = [NSString stringWithFormat:@"%@addRefill",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

    
}

- (void)getPMasterByID:(NSString *)pid WithCompletion:(void (^)(BOOL, NSString *, PMaster *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"otherUserId"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@get_pmaster",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
      //  NSMutableArray *patients = [NSMutableArray array];
        
        PMaster *messages = [[PMaster alloc] init];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //  NSArray *data = responseObject[@"msgsessions"];
            messages = [[PMaster alloc] initWithDic:responseObject];
            
            //   messages.postid = responseObject[@"postid"];
            //   messages.mstatus = responseObject[@"mstatus"];
            /* for (NSDictionary *patientDic in data)
             {
             MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
             [patients addObject:messages];
             }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [[MSGSession alloc] init]);
        }
    }];

}



- (void)getPMasterByID2:(NSString *)pid WithCompletion:(void (^)(BOOL, NSString *, PMaster *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];

    [postDic setObject:pid forKey:@"uid"];
    [postDic setObject:pid forKey:@"otherUserId"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@get_pmaster",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        //  NSMutableArray *patients = [NSMutableArray array];
        
        PMaster *messages = [[PMaster alloc] init];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //  NSArray *data = responseObject[@"msgsessions"];
            messages = [[PMaster alloc] initWithDic:responseObject];
            
            //   messages.postid = responseObject[@"postid"];
            //   messages.mstatus = responseObject[@"mstatus"];
            /* for (NSDictionary *patientDic in data)
             {
             MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
             [patients addObject:messages];
             }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [[MSGSession alloc] init]);
        }
    }];
    
}

- (void)getPMasterBankDetails:(NSString *)pid WithCompletion:(void (^)(BOOL, NSString *, BankDetails *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"otherUserId"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getbankdetails",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        //  NSMutableArray *patients = [NSMutableArray array];
        
        BankDetails *messages = [[BankDetails alloc] init];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //  NSArray *data = responseObject[@"msgsessions"];
            messages = [[BankDetails alloc] initWithDic:responseObject];
            
            //   messages.postid = responseObject[@"postid"];
            //   messages.mstatus = responseObject[@"mstatus"];
            /*for (NSDictionary *patientDic in data)
             {
             MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
             [patients addObject:messages];
             }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [[BankDetails alloc] init]);
        }
    }];
    
}

- (void)addWithdrawalRequest:(BankDetails *)bankdetails WithCompletion:(void (^)(BOOL, NSString *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    //[postDic setObject:patientid forKey:@"postid"];
    [postDic setObject:bankdetails.bankname forKey:@"bankname"];
    [postDic setObject:bankdetails.bankaddress forKey:@"bankaddress"];
    [postDic setObject:bankdetails.accno forKey:@"accno"];
    [postDic setObject:bankdetails.accname forKey:@"accname"];
    [postDic setObject:bankdetails.routeno forKey:@"routingno"];
     [postDic setObject:bankdetails.withdraw forKey:@"credits"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addwithdrawal",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

    
}

- (void)updatePMasterIMG:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block {
    
    
    NSString *patientIMGString =  [self base64EncodeDataWithImage:patientImage];
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    //Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    //[postDic setObject:patientid forKey:@"postid"];
    [postDic setObject:patientIMGString forKey:@"profileimage"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updatePMasterIMG",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

    
    
}

- (void)updatePMasterID:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block {
    
    
    NSString *patientIMGString =  [self base64EncodeDataWithImage:patientImage];
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    //Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    //[postDic setObject:patientid forKey:@"postid"];
    [postDic setObject:patientIMGString forKey:@"profileimage"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updatePMasterID",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}

- (void)updateParentID:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block {
    
    
    NSString *patientIMGString =  [self base64EncodeDataWithImage:patientImage];
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    //Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    //[postDic setObject:patientid forKey:@"postid"];
    [postDic setObject:patientIMGString forKey:@"profileimage"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updateParentID",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}




- (void)updatePMasterInsurance:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block {
    
    
    NSString *patientIMGString =  [self base64EncodeDataWithImage2:patientImage];
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    //Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    //[postDic setObject:patientid forKey:@"postid"];
    [postDic setObject:patientIMGString forKey:@"profileimage"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updatePMasterInsurance",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
    
    
    
}



- (void)updatePMasterInsuranceBack:(NSString *)patientid img:(UIImage *)patientImage WithCompletion:(void (^)(BOOL, NSString *))block {
    
    
    NSString *patientIMGString =  [self base64EncodeDataWithImage2:patientImage];
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    //Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    //[postDic setObject:patientid forKey:@"postid"];
    [postDic setObject:patientIMGString forKey:@"profileimage"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updatePMasterInsuranceBack",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}




- (void)getAllConsultations2:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"docid"];
    [postDic setObject:@"" forKey:@"search"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPConsultations",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"consultations"];
            for (NSDictionary *noteDic in data)
            {
                Consulatation *note = [[Consulatation alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}




- (void)updatePMaster:(PMaster *)patientInfo WithCompletion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:patientInfo.postid forKey:@"uid"];
    [postDic setObject:patientInfo.street1 forKey:@"address"];
    [postDic setObject:patientInfo.city forKey:@"officecity"];
    [postDic setObject:patientInfo.state forKey:@"officestate"];
    [postDic setObject:patientInfo.zipcode forKey:@"officezip"];
    [postDic setObject:patientInfo.country forKey:@"officecountry"];
    [postDic setObject:patientInfo.email forKey:@"email"];
    [postDic setObject:patientInfo.telephone forKey:@"telephone"];
     [postDic setObject:patientInfo.dob forKey:@"dob"];
     [postDic setObject:patientInfo.gender forKey:@"gender"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updatePMasterDoctor3",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}






- (void)updateParent:(PMaster *)patientInfo WithCompletion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:patientInfo.postid forKey:@"uid"];
    [postDic setObject:patientInfo.parentfirstname forKey:@"firstname"];
    [postDic setObject:patientInfo.parentlastname forKey:@"lastname"];
    [postDic setObject:patientInfo.parentphone forKey:@"phone"];
    [postDic setObject:patientInfo.parentemail forKey:@"email"];
    [postDic setObject:patientInfo.parentssn forKey:@"last4ssn"];
    [postDic setObject:patientInfo.parentdob forKey:@"dob"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@updateParent",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        
        if (block)
        {
            block(success, message);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}



- (void)addConsultation:(NSString *)docid fromdate:(NSString *)from tnotetext:(NSString *)appnote completion:(void (^)(BOOL, NSString *))block {
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    NSString *linkString = [NSString stringWithFormat:@"http://free.gotomeeting.com/%f",[[NSDate date] timeIntervalSince1970]];
    
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docid forKey:@"docid"];
    [postDic setObject:appnote forKey:@"notes"];
    [postDic setObject:from  forKey:@"starttime"];
     [postDic setObject:linkString  forKey:@"link"];
    
    
    NSString *url =  [NSString stringWithFormat:@"%@addConsulation",  kAPIBaseURL];;
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}


- (void)getMesRecSession:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"docid"];
    // [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getChatSessions",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"msgsessions"];
            for (NSDictionary *patientDic in data)
            {
                MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

}

- (void)getMessagesBySession2:(NSString *)patientid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"patientid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getmessage3",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"messages"];
            for (NSDictionary *patientDic in data)
            {
                Messages *messages = [[Messages alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

    
}



- (void)getMSGSessionsByID2:(NSString *)docuid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, MSGSession *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docuid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"docid"];
    [postDic setObject:sessionID forKey:@"postid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getChatSession",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        MSGSession *messages = [[MSGSession alloc] init];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //  NSArray *data = responseObject[@"msgsessions"];
            messages = [[MSGSession alloc] initWithDic:responseObject];
            
            //   messages.postid = responseObject[@"postid"];
            //   messages.mstatus = responseObject[@"mstatus"];
            /* for (NSDictionary *patientDic in data)
             {
             MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
             [patients addObject:messages];
             }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [[MSGSession alloc] init]);
        }
    }];
}




- (void)addMessageToPatientRec:(NSString *)patientid messagetext:(NSString *)message msgimg:(UIImage *)messageImage sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSString *msgIMGString = @"";
    
    if (messageImage) {
        msgIMGString = [self base64EncodeDataWithImage2:messageImage];
    }
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"from"];
    [postDic setObject:patientid forKey:@"to"];
    [postDic setObject:message forKey:@"message"];
    [postDic setObject:@"" forKey:@"recording"];
    [postDic setObject:msgIMGString forKey:@"postimage"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@sendmessagep2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
            
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}



- (void)closeMSGSessionRec:(NSString *)docuid sessionID:(NSString *)sessionID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:docuid forKey:@"uid"];
    [postDic setObject:doc.uid forKey:@"patientid"];
    [postDic setObject:sessionID forKey:@"sessionID"];
    
    NSString *url = [NSString stringWithFormat:@"%@closesessionp",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
}

- (void)getMSGSessionsByID3:(NSString *)docuid sessionID:(NSString *)sessionID WithCompletion:(void (^)(BOOL, NSString *, MSGSession *))block{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"docid"];
    [postDic setObject:@"" forKey:@"notes"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addMSGSession",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        MSGSession *messages = [[MSGSession alloc] init];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //  NSArray *data = responseObject[@"msgsessions"];
            messages = [[MSGSession alloc] initWithDic:responseObject];
            
            //   messages.postid = responseObject[@"postid"];
            //   messages.mstatus = responseObject[@"mstatus"];
            /* for (NSDictionary *patientDic in data)
             {
             MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
             [patients addObject:messages];
             }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [[MSGSession alloc] init]);
        }
    }];

}

- (void)createNewMSGSession:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"docid"];
    [postDic setObject:@"" forKey:@"notes"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addMSGSession",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *messages = @"";
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //  NSArray *data = responseObject[@"msgsessions"];
            messages = responseObject[@"nid"];
            
            //   messages.postid = responseObject[@"postid"];
            //   messages.mstatus = responseObject[@"mstatus"];
            /* for (NSDictionary *patientDic in data)
             {
             MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
             [patients addObject:messages];
             }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [[MSGSession alloc] init]);
        }
    }];
}


- (void)getAllMedicationByPatientForRefill:(NSString *)patientid doctor:(NSString *)docid patient:(PatientLinks *)plink WithCompletion:(void (^)(BOOL, NSString *, PatientLinks *, NSMutableArray *))block{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    // Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientMedication",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"medication"];
            for (NSDictionary *noteDic in data)
            {
                PatientMedication *note = [[PatientMedication alloc] initWithDic:noteDic];
                
                NSMutableArray *condtions = [NSMutableArray array];
                NSArray *data2 = noteDic[@"conditions"];
                
                for (NSDictionary *noteDic2 in data2)
                {
                    Condition *condition = [[Condition alloc] initWithDic:noteDic2];
                    [condtions addObject:condition];
                }
                
                NSMutableArray *allergies = [NSMutableArray array];
                NSArray *data3 = noteDic[@"allergies"];
                
                for (NSDictionary *noteDic3 in data3)
                {
                    Allergen *allergy = [[Allergen alloc] initWithDic:noteDic3];
                    [allergies addObject:allergy];
                }
                
                NSMutableArray *refills = [NSMutableArray array];
                NSArray *data4 = noteDic[@"refilllist"];
                
                for (NSDictionary *noteDic4 in data4)
                {
                    Refills *refill= [[Refills alloc] initWithDic:noteDic4];
                    [refills addObject:refill];
                }
                
                note.conditions = condtions;
                note.allergy = allergies;
                note.refillArray = refills;
                [notes addObject:note];
                
            }
            
            if (block)
            {
                block(success, message, plink, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message,plink, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], nil, [NSMutableArray array]);
        }
    }];
    

}





- (void)getAllMedicationForPatients:(NSString *)patientid doctor:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    // Doctor *doc = [Doctor getFromUserDefault];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];

    //[postDic setObject:docid forKey:@"uid"];
    //[postDic setObject:patientid forKey:@"patientid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPatientMedicationAll",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"medication"];
            for (NSDictionary *noteDic in data)
            {
                PatientMedication *note = [[PatientMedication alloc] initWithDic:noteDic];
                
                NSMutableArray *condtions = [NSMutableArray array];
                NSArray *data2 = noteDic[@"conditions"];
                
                for (NSDictionary *noteDic2 in data2)
                {
                    Condition *condition = [[Condition alloc] initWithDic:noteDic2];
                    [condtions addObject:condition];
                }
                
                NSMutableArray *allergies = [NSMutableArray array];
                NSArray *data3 = noteDic[@"allergies"];
                
                for (NSDictionary *noteDic3 in data3)
                {
                    Allergen *allergy = [[Allergen alloc] initWithDic:noteDic3];
                    [allergies addObject:allergy];
                }
                
                NSMutableArray *refills = [NSMutableArray array];
                NSArray *data4 = noteDic[@"refilllist"];
                
                for (NSDictionary *noteDic4 in data4)
                {
                    Refills *refill= [[Refills alloc] initWithDic:noteDic4];
                    [refills addObject:refill];
                }
                
                note.conditions = condtions;
                note.allergy = allergies;
                note.refillArray = refills;
                [notes addObject:note];
                
            }
            
            if (block)
            {
                block(success, message,  notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message,  notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}





- (void)getAllConditionByPMaster:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];

    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPMCondition",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"conditions"];
            for (NSDictionary *patientDic in data)
            {
                Condition *condition = [[Condition alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

    
}



- (void)getAllConditionByPMaster2:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPMCondition",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"conditions"];
            for (NSDictionary *patientDic in data)
            {
                Condition *condition = [[Condition alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}


- (void)addConditionToPMaster:(NSString *)patientid conditionname:(NSString *)condition conditioncode:(NSString *)conditioncode WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
   
    [postDic setObject:condition forKey:@"conditionname"];
    [postDic setObject:conditioncode forKey:@"conditionid"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addPMCondition",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
            
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}

- (void)deletePMasterCondition:(NSString *)conditionID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:conditionID forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deletepmcondition",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}

- (void)getAllAllergenByPMMaster:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
  
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPMAllergy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"allergy"];
            for (NSDictionary *patientDic in data)
            {
                Allergen *condition = [[Allergen alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    

    
}




- (void)getAllAllergenByPMMaster2:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
   // PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPMAllergy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"allergy"];
            for (NSDictionary *patientDic in data)
            {
                Allergen *condition = [[Allergen alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}


- (void)addAllergenToPMaster:(NSString *)patientid name:(NSString *)name pickid:(NSString *)allergyid type:(NSString *)allergytype h7id:(NSString *)h7id htype:(NSString *)htype WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:name forKey:@"name"];
    [postDic setObject:allergyid forKey:@"allergyid"];
    [postDic setObject:allergytype forKey:@"type"];
    [postDic setObject:h7id forKey:@"hidentifier"];
    [postDic setObject:htype forKey:@"htype"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addPMAllergy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
            
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

    
}

- (void)deletePMasterAllergen:(NSString *)conditionID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:conditionID forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deletepmallergy",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}


- (void)getDoctorProfile2:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, Doctors *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
 //   Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docuid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"otherUserId"];
    
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getdoctor",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        Doctors  *doctors;
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSDictionary *data = responseObject;
            doctors = [[Doctors alloc] initWithDic:data];
            
            if (block)
            {
                block(success, message, doctors);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, doctors);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            Doctors  *doctors;
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], doctors);
        }
    }];

}


- (void)addConsultation2:(NSString *)docid fromdate:(NSString *)from tnotetext:(NSString *)appnote pharmcyname:(NSString *)pharmname pharmancyaddress:(NSString *)pharmadd  completion:(void (^)(BOOL, NSString *))block {
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    NSString *linkString = [NSString stringWithFormat:@"http://free.gotomeeting.com/"];
    
    
    NSString *primaryPhysician =  [[NSUserDefaults standardUserDefaults] valueForKey:@"primaryPhysician"];
   NSString *patientTele =  [[NSUserDefaults standardUserDefaults] valueForKey:@"patientTele"];
   NSString *patientChose =  [[NSUserDefaults standardUserDefaults] valueForKey:@"whatChose"];
   
    
    
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docid forKey:@"docid"];
    [postDic setObject:appnote forKey:@"notes"];
    [postDic setObject:from  forKey:@"starttime"];
    [postDic setObject:linkString  forKey:@"link"];
    [postDic setObject:pharmname forKey:@"pharmname"];
    [postDic setObject:pharmadd  forKey:@"pharmadd"];
    [postDic setObject:patientChose  forKey:@"whatwould"];
    [postDic setObject:patientTele forKey:@"telephone"];
    [postDic setObject:primaryPhysician  forKey:@"primaryphysician"];
    
    
    NSString *url =  [NSString stringWithFormat:@"%@addConsulation2",  kAPIBaseURL];;
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}

- (void)createShareRecord:(NSString *)docuid patientid:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSString *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"docid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addShareRecord",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *messages = @"";
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //  NSArray *data = responseObject[@"msgsessions"];
           // messages = responseObject[@"nid"];
            
            //   messages.postid = responseObject[@"postid"];
            //   messages.mstatus = responseObject[@"mstatus"];
            /* for (NSDictionary *patientDic in data)
             {
             MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
             [patients addObject:messages];
             }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [[MSGSession alloc] init]);
        }
    }];

    
}



- (void)createShareRecordDoctor:(NSString *)docuid patientid:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSString *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docuid forKey:@"docid"];
    [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addShareRecord",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *messages = @"";
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //  NSArray *data = responseObject[@"msgsessions"];
            // messages = responseObject[@"nid"];
            
            //   messages.postid = responseObject[@"postid"];
            //   messages.mstatus = responseObject[@"mstatus"];
            /* for (NSDictionary *patientDic in data)
             {
             MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
             [patients addObject:messages];
             }*/
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, messages);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], @"");
        }
    }];
    
    
}


- (void)getAllDoctorRating:(NSString *)docid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *, NSString *))block {
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:docid forKey:@"docid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDoctorReviews",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        NSString *totrating = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"posts"];
            for (NSDictionary *patientDic in data)
            {
                Rating *condition = [[Rating alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            totrating = responseObject[@"rating"];
            
            if (block)
            {
                block(success, message, patients, totrating);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients, totrating);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array], @"");
        }
    }];
    

    
}

- (void)addRatingToDoctor:(NSString *)docid stars:(NSString *)stars review:(NSString *)review WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    [postDic setObject:docid forKey:@"docid"];
    [postDic setObject:review forKey:@"review"];
    [postDic setObject:stars forKey:@"stars"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@addRating",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *conditions = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            message = responseObject[@"responseMessage"];
            
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, conditions);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
}


- (void)deleteDoctorRating:(NSString *)ratingID completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:ratingID forKey:@"postid"];
    
    NSString *url = [NSString stringWithFormat:@"%@deleterating",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}


- (void)addPMAppointment:(NSString *)docid patient:(NSString *)patientid fromdate:(NSString *)from todate:(NSString *)to notetext:(NSString *)appnote completion:(void (^)(BOOL, NSString *))block {
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:docid forKey:@"uid"];
    [postDic setObject:patientid forKey:@"patientid"];
    [postDic setObject:from forKey:@"fromdate"];
    [postDic setObject:to forKey:@"todate"];
    [postDic setObject:appnote forKey:@"apnotes"];
    
    NSString *url = [NSString stringWithFormat:@"%@addAppRequest",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}

- (void)getAllConsultations3:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];

    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPConsultations2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"consultations"];
            for (NSDictionary *noteDic in data)
            {
                Consulatation *note = [[Consulatation alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];

    
}


- (void)getMesRecSessionAll:(NSString *)docuid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
  
    // [postDic setObject:patientid forKey:@"patientid"];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getChatSessions2",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"msgsessions"];
            for (NSDictionary *patientDic in data)
            {
                MSGSession *messages = [[MSGSession alloc] initWithDic:patientDic];
                [patients addObject:messages];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    

    
}

- (void)chargePayment:(NSDictionary *)paymentdict completion:(void (^)(BOOL, NSString *))block {

    NSString *url = [NSString stringWithFormat:@"http://api.myfidem.com/patient/charge2app.php"];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:paymentdict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}

- (void)getAllAppointmens3:(NSString *)docuid plink:(PatientLinks *)plink WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *, PatientLinks *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    //  Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:docuid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDoctorAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes, plink);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes, plink);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array],plink);
        }
    }];
    
    

}





- (void)getAllAppointmensForPatients:(NSString *)docuid  WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *)) block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getDoctorAppointmentAll",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}







- (void)getFutureAppointmensForPatients:(NSString *)docuid  WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *)) block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getFutureAppointmentsForPatient",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}













- (void)getAllConditionByPMasterID:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
  ///  PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:patientid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPMCondition",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"conditions"];
            for (NSDictionary *patientDic in data)
            {
                Condition *condition = [[Condition alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
}



- (void)getAllAllergenByPMMasterByID:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
  
    [postDic setObject:patientid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPMAllergy",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"allergy"];
            for (NSDictionary *patientDic in data)
            {
                Allergen *condition = [[Allergen alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}




- (void)updatePMasterPasscode:(NSString *)passcode completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:passcode forKey:@"passcode"];
    
    NSString *url = [NSString stringWithFormat:@"%@updateDoctorPasscode",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}

- (void)checkPMasterPasscode:(NSString *)passcode completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:passcode forKey:@"passcode"];
    
    NSString *url = [NSString stringWithFormat:@"%@checkPasscode",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}






- (void)checkDoctorPasscode:(NSString *)passcode completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:passcode forKey:@"passcode"];
    
    NSString *url = [NSString stringWithFormat:@"%@checkPasscode",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
    
}



- (void)getPNotifications:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPNotifications",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"notifications"];
            for (NSDictionary *patientDic in data)
            {
                Notifications *condition = [[Notifications alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    

    
}


- (void)getDNotifications:(NSString *)patientid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    
    Doctor *doc = [Doctor getFromUserDefault];
    
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getPNotifications",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *patients = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"notifications"];
            for (NSDictionary *patientDic in data)
            {
                Notifications *condition = [[Notifications alloc] initWithDic:patientDic];
                [patients addObject:condition];
            }
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, patients);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    
    
}



- (void)sendCallNotification:(NSString *)otherid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:otherid forKey:@"otherid"];
    
    NSString *url = [NSString stringWithFormat:@"%@sendCallNotification",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];

}


- (void)getSingleAppointmens:(NSString *)postid WithCompletion:(void (^)(BOOL, NSString *, NSMutableArray *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
      PatientLogin *doc = [PatientLogin getFromUserDefault];
    
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:postid forKey:@"postid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getAppointment",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            NSArray *data = responseObject[@"appointments"];
            for (NSDictionary *noteDic in data)
            {
                Appointments *note = [[Appointments alloc] initWithDic:noteDic];
                [notes addObject:note];
            }
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message, notes);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], [NSMutableArray array]);
        }
    }];
    
    

}






- (void)getMedicationByID:(NSString *)medID WithCompletion:(void (^)(BOOL, NSString *, PatientMedication *))block{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    [postDic setObject:medID forKey:@"medid"];
    
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    
    NSString *url = [NSString stringWithFormat:@"%@getMedicationByID3",  kAPIBaseURL];
    
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        BOOL success = false;
        
        NSMutableArray *notes = [NSMutableArray array];
        PatientMedication *note =  [[PatientMedication alloc] init];
        
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
            //NSArray *data = responseObject[@"medication"];
           // for (NSDictionary *noteDic in data)
           // {
                PatientMedication *note = [[PatientMedication alloc] initWithDic:responseObject];
                
                NSMutableArray *condtions = [NSMutableArray array];
                NSArray *data2 = responseObject[@"conditions"];
                
                for (NSDictionary *noteDic2 in data2)
                {
                    Condition *condition = [[Condition alloc] initWithDic:noteDic2];
                    [condtions addObject:condition];
                }
                
                NSMutableArray *allergies = [NSMutableArray array];
                NSArray *data3 = responseObject[@"allergies"];
                
                for (NSDictionary *noteDic3 in data3)
                {
                    Allergen *allergy = [[Allergen alloc] initWithDic:noteDic3];
                    [allergies addObject:allergy];
                }
                
                NSMutableArray *refills = [NSMutableArray array];
                NSArray *data4 = responseObject[@"refilllist"];
                
                for (NSDictionary *noteDic4 in data4)
                {
                    Refills *refill= [[Refills alloc] initWithDic:noteDic4];
                    [refills addObject:refill];
                }
                
                note.conditions = condtions;
                note.allergy = allergies;
                note.refillArray = refills;
           //     [notes addObject:note];
                
          //  }
            
            if (block)
            {
                block(success, message,  note);
            }
        }
        else
        {
            message = responseObject[@"responseMessage"];
            
            if (block)
            {
                block(success, message,note);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey], nil);
        }
    }];
    
    
}

- (void)markNotificationsRead:(NSString *)otherid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
   
    
    NSString *url = [NSString stringWithFormat:@"%@readPNotifications",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    

}





- (void)markNotificationsRead2:(NSString *)otherid completion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@readPNotifications",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
    
}



- (void)changePasswordForUser:(NSString *)uid password:(NSString *)password WithCompletion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    PatientLogin *doc = [PatientLogin getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
   
    [postDic setObject:password forKey:@"newpass"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@updatePassword",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}


- (void)changePasswordForDoctor:(NSString *)uid password:(NSString *)password oldpassword:(NSString *)oldpassword WithCompletion:(void (^)(BOOL, NSString *))block {
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    Doctor *doc = [Doctor getFromUserDefault];
    [postDic setObject:doc.uid forKey:@"uid"];
    
    [postDic setObject:password forKey:@"newpass"];
    [postDic setObject:oldpassword forKey:@"oldpass"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@updatePasswordDoctor",  kAPIBaseURL];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    [manager POST:url parameters:postDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL success = false;
        NSString *message = @"";
        if ([responseObject[@"responseCode"] integerValue] == 200)
        {
            success = true;
        }
        
        message = responseObject[@"responseMessage"];
        if (block) {
            block (success, message);
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(false, [[error userInfo] valueForKey:NSLocalizedRecoverySuggestionErrorKey]);
        }
    }];
    
}



- (NSString *)defaultAvatarIcon
{
    return [self avatarWithName:@"appiconlarge"];
}

- (NSString *)avatarWithName:(NSString *)imageName
{
    UIImage *avatarImage =[UIImage imageNamed:imageName];
    return [self base64EncodeDataWithImage:avatarImage];
}

- (NSString *)imageToString:(UIImage *)avatarImage
{
    //UIImage *avatarImage =[UIImage imageNamed:imageName];
    return [self base64EncodeDataWithImage:avatarImage];
}

- (NSString *)base64EncodeDataWithImage:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSString *)base64EncodeDataWithImage2:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5f);
    return [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSMutableDictionary *)dictionWithPassword:(NSString *)password
                                       Email: (NSString *)email
                                   andDevice:(DeviceInfo *)deviceInfo
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    [postDic setObject:email forKey:@"email"];
    [postDic setObject:password forKey:@"password"];
    
   // [postDic setObject:@"" forKey:@"deviceToken"];
    [postDic setObject:@"iOS" forKey:@"deviceType"];
    
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"notToken"];
    
    if (deviceToken) {
         [postDic setObject:deviceToken forKey:@"deviceToken"];
    } else {
       [postDic setObject:@"" forKey:@"deviceToken"];
    }
    
    if (deviceInfo.city)
    {
        [postDic setObject:deviceInfo.city forKey:@"city"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"city"];
    }
    
    if (deviceInfo.state)
    {
        [postDic setObject:deviceInfo.state forKey:@"state"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"state"];
    }
    
    if (deviceInfo.version)
    {
        [postDic setObject:deviceInfo.version forKey:@"version"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"version"];
    }
    
    if (deviceInfo.country)
    {
        //account don't have country
        [postDic setObject:deviceInfo.country forKey:@"country"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"country"];
    }
    
    return postDic;

}


- (NSMutableDictionary *)dictionWithAccount:(Account *)account andDevice:(DeviceInfo *)deviceInfo
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    if (account.email)
    {
        [postDic setObject:account.username forKey:@"name"];
        [postDic setObject:account.email forKey:@"email"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"name"];
        [postDic setObject:@"" forKey:@"email"];
    }
    
    
    if (account.firstName)
    {
        [postDic setObject:account.firstName forKey:@"firstname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"firstName"];
    }
    
    
    if (account.lastName)
    {
        [postDic setObject:account.lastName forKey:@"lastname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"lastname"];
    }

    
    if (account.ml)
    {
        [postDic setObject:account.ml forKey:@"middleinitial"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"middleinitial"];
    }

    [postDic setObject:@"" forKey:@"deviceToken"];
    [postDic setObject:@"iOS" forKey:@"deviceType"];
    [postDic setObject:[self defaultAvatarIcon] forKey:@"profileImg"];

    if (account.password)
    {
        [postDic setObject:account.password forKey:@"password"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"password"];
    }
    
    if (account.suffix)
    {
        [postDic setObject:account.suffix forKey:@"suffixtext"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"suffixtext"];
    }

    if (account.dea)
    {
        [postDic setObject:account.dea forKey:@"dea"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"dea"];
    }

    if (account.npi)
    {
        [postDic setObject:account.npi forKey:@"npi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"npi"];
    }

    if (account.me)
    {
        [postDic setObject:account.me forKey:@"mee"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"mee"];
    }
    
    if (account.comName)
    {
        [postDic setObject:account.comName forKey:@"officename"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officename"];
    }
    
    if (account.comAddress)
    {
        [postDic setObject:account.comAddress forKey:@"officeaddress"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officeaddress"];
    }
    
    if (account.comCity)
    {
        [postDic setObject:account.comCity forKey:@"officecity"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officecity"];
    }
    
    if (account.comState)
    {
        [postDic setObject:account.comState forKey:@"officestate"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officestate"];
    }
    
    if (account.comCountry)
    {
        //account don't have country
        [postDic setObject:account.comCountry forKey:@"officecountry"];
        [postDic setObject:account.comCountry forKey:@"country"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officecountry"];
        [postDic setObject:@"" forKey:@"country"];
    }
    
    if (account.comZipCode)
    {
        [postDic setObject:account.comZipCode forKey:@"officezip"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officezip"];
    }
    
    if (account.comPhoneNumber)
    {
        [postDic setObject:account.comPhoneNumber forKey:@"telephonenum"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"telephonenum"];
    }
    
    if (deviceInfo.ipaddress)
    {
        [postDic setObject:deviceInfo.ipaddress forKey:@"ipaddress"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ipaddress"];
    }
    
    if (deviceInfo.city)
    {
        [postDic setObject:deviceInfo.city forKey:@"city"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"city"];
    }
    
    if (deviceInfo.state)
    {
        [postDic setObject:deviceInfo.state forKey:@"state"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"state"];
    }

    if (deviceInfo.version)
    {
        [postDic setObject:deviceInfo.version forKey:@"version"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"version"];
    }
    
    if (account.signature)
    {
        [postDic setObject:[account.signature base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]
                    forKey:@"signature"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"signature"];
    }
    
    
    if (account.speciality)
    {
        [postDic setObject:account.speciality forKey:@"speciality"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"speciality"];
    }
    
    if (account.gender)
    {
        [postDic setObject:account.gender forKey:@"gender"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"gender"];
    }
    
    if (account.passcode)
    {
        [postDic setObject:account.passcode forKey:@"passcode"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"passcode"];
    }
    
    if (account.dob)
    {
        [postDic setObject:account.dob forKey:@"dob"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"dob"];
    }
    
    if (account.idcard)
    {
        [postDic setObject:account.idcard forKey:@"idcard"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"idcard"];
    }
    
    return [NSMutableDictionary dictionaryWithDictionary:postDic];
}

- (NSMutableDictionary *)dictionWithPatient:(Patient *)patient
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
 
    Doctor *doctorInfo = [Doctor getFromUserDefault];
    
    if (doctorInfo.uid)
    {
        [postDic setObject:doctorInfo.uid forKey:@"uid"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"uid"];
    }
    /*
     uid => This should be doctor's uid
     email => this should be patient's email
     firstname => Patients first name
     lastname => Patients last name
     postimage => Patients picture. It should be updated the same way as we upload the doctors profile pic.
     dob => Patients dob in unix time
     occupation => Patients occupation
     gender => Patients gender. Either "M" or "F"
     telephone => Patient's telephone number
     */
    if (patient.email)
    {
        [postDic setObject:patient.email forKey:@"email"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"email"];
    }
    
    
    if (patient.firstName)
    {
        [postDic setObject:patient.firstName forKey:@"firstname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"firstName"];
    }
    
    
    if (patient.lastName)
    {
        [postDic setObject:patient.lastName forKey:@"lastname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"lastname"];
    }
    
    
    if (patient.dob)
    {
        [postDic setObject:patient.dob forKey:@"dob"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"dob"];
    }
    
    if (patient.occupation)
    {
        [postDic setObject:patient.occupation forKey:@"occupation"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"occupation"];
    }
    
    if (patient.gender)
    {
        [postDic setObject:patient.gender forKey:@"gender"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"gender"];
    }
    
    if (patient.telephone)
    {
        [postDic setObject:patient.telephone forKey:@"telephone"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"telephone"];
    }
    /*
     street1 => Street 1 of patient's address
     street2 => Street 2 of patient's address
     city => This should be the city of the patient's address.
     state => This should be the state of the patient's address.
     country => This should be the country of the patient's address.
     zipcode => This should be the zipcode of the patient's address.
     */
    if (patient.street1)
    {
        [postDic setObject:patient.street1 forKey:@"street1"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"street1"];
    }

    if (patient.street2)
    {
        [postDic setObject:patient.street2 forKey:@"street2"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"street2"];
    }
    
    if (patient.city)
    {
        [postDic setObject:patient.city forKey:@"city"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"city"];
    }
    
    if (patient.state)
    {
        [postDic setObject:patient.state forKey:@"state"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"state"];
    }
    
    if (patient.country)
    {
        [postDic setObject:patient.country forKey:@"country"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"country"];
    }
    
    if (patient.zipcode)
    {
        [postDic setObject:patient.zipcode forKey:@"zipcode"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"zipcode"];
    }
    if ([patient.gender isEqual:@"F"]) {
        
       // [postDic setObject:[self avatarWithName:@"femalepatient"] forKey:@"postimage"];
        [postDic setObject:[self avatarWithName:@"femalesil"] forKey:@"postimage"];
        
    } else {
    
    
    [postDic setObject:[self avatarWithName:@"malesil"] forKey:@"postimage"];
        
    }
    
    if (patient.ssnDigits)
    {
        [postDic setObject:patient.ssnDigits forKey:@"lastssn"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"lastssn"];
    }
    
    return postDic;
}






- (NSMutableDictionary *)dictionWithPatientRegister:(PatientRegister *)patient
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
   // PatientRegister *doctorInfo = [PatientRegister get];
    
    if (patient.username)
    {
        [postDic setObject:patient.username forKey:@"name"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"name"];
    }
   
    if (patient.email)
    {
        [postDic setObject:patient.email forKey:@"email"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"email"];
    }
    
    
    if (patient.firstName)
    {
        [postDic setObject:patient.firstName forKey:@"firstname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"firstName"];
    }
    
    
    if (patient.lastName)
    {
        [postDic setObject:patient.lastName forKey:@"lastname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"lastname"];
    }
    
    
   
    if (patient.gender)
    {
        [postDic setObject:patient.gender forKey:@"gender"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"gender"];
    }
    
    if (patient.password)
    {
        [postDic setObject:patient.password forKey:@"password"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"password"];
    }
    
    if (patient.passcode)
    {
        [postDic setObject:patient.password forKey:@"passcode"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"passcode"];
    }
    
    if (patient.dob)
    {
        [postDic setObject:patient.dob forKey:@"dob"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"dob"];
    }
    
    if (patient.parentSSN)
    {
        [postDic setObject:patient.parentSSN forKey:@"parentssn"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"parentssn"];
    }
    
    if (patient.parentLastName)
    {
        [postDic setObject:patient.parentLastName forKey:@"parentlastname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"parentlastname"];
    }
  
    if (patient.parentFirstName)
    {
        [postDic setObject:patient.parentFirstName forKey:@"parentfirstname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"parentfirstname"];
    }
    
    if (patient.parentDob)
    {
        [postDic setObject:patient.parentDob forKey:@"parentdob"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"parentdob"];
    }
    
    
    if (patient.parentEmail)
    {
        [postDic setObject:patient.parentEmail forKey:@"parentemail"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"parentemail"];
    }
    
    if (patient.parentPhone)
    {
        [postDic setObject:patient.parentPhone forKey:@"parentphone"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"parentphone"];
    }
    
    if (patient.parentIDCard)
    {
        [postDic setObject:[self imageToString:patient.parentIDCard] forKey:@"parentid"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"parentid"];
    }
    
    if (patient.idCard)
    {
        [postDic setObject:[self imageToString:patient.idCard] forKey:@"idcard"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"idcard"];
    }
   
    if ([patient.gender isEqual:@"F"]) {
        [postDic setObject:[self avatarWithName:@"femalesil"] forKey:@"profileImg"];
        
    } else {
        
        
        [postDic setObject:[self avatarWithName:@"malesil"] forKey:@"profileImg"];
        
    }
    
        return postDic;
}





- (NSMutableDictionary *)dictionWithPatient2:(Patient *)patient
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    Doctor *doctorInfo = [Doctor getFromUserDefault];
    
    if (doctorInfo.uid)
    {
        [postDic setObject:doctorInfo.uid forKey:@"uid"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"uid"];
    }
    /*
     uid => This should be doctor's uid
     email => this should be patient's email
     firstname => Patients first name
     lastname => Patients last name
     postimage => Patients picture. It should be updated the same way as we upload the doctors profile pic.
     dob => Patients dob in unix time
     occupation => Patients occupation
     gender => Patients gender. Either "M" or "F"
     telephone => Patient's telephone number
     */
    if (patient.postid)
    {
        [postDic setObject:patient.postid forKey:@"postid"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"postid"];
    }
    
    if (patient.email)
    {
        [postDic setObject:patient.email forKey:@"email"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"email"];
    }
    
    
    if (patient.firstName)
    {
        [postDic setObject:patient.firstName forKey:@"firstname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"firstName"];
    }
    
    
    if (patient.lastName)
    {
        [postDic setObject:patient.lastName forKey:@"lastname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"lastname"];
    }
    
    
    if (patient.dob)
    {
        [postDic setObject:patient.dob forKey:@"dob"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"dob"];
    }
    
    if (patient.occupation)
    {
        [postDic setObject:patient.occupation forKey:@"occupation"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"occupation"];
    }
    
    if (patient.gender)
    {
        [postDic setObject:patient.gender forKey:@"gender"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"gender"];
    }
    
    if (patient.telephone)
    {
        [postDic setObject:patient.telephone forKey:@"telephone"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"telephone"];
    }
    /*
     street1 => Street 1 of patient's address
     street2 => Street 2 of patient's address
     city => This should be the city of the patient's address.
     state => This should be the state of the patient's address.
     country => This should be the country of the patient's address.
     zipcode => This should be the zipcode of the patient's address.
     */
    if (patient.street1)
    {
        [postDic setObject:patient.street1 forKey:@"street1"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"street1"];
    }
    
    if (patient.street2)
    {
        [postDic setObject:patient.street2 forKey:@"street2"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"street2"];
    }
    
    if (patient.city)
    {
        [postDic setObject:patient.city forKey:@"city"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"city"];
    }
    
    if (patient.state)
    {
        [postDic setObject:patient.state forKey:@"state"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"state"];
    }
    
    if (patient.country)
    {
        [postDic setObject:patient.country forKey:@"country"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"country"];
    }
    
    if (patient.zipcode)
    {
        [postDic setObject:patient.zipcode forKey:@"zipcode"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"zipcode"];
    }
    if ([patient.gender isEqual:@"F"]) {
        [postDic setObject:@"" forKey:@"postimage"];
        
    } else {
        
        
        [postDic setObject:@"" forKey:@"postimage"];
        
    }
    
    if (patient.ssnDigits)
    {
        [postDic setObject:patient.ssnDigits forKey:@"lastssn"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"lastssn"];
    }
    
    return postDic;
}



- (NSMutableDictionary *)dictionWithDoctors:(Doctors *)doctor
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    Doctor *doctorInfo = [Doctor getFromUserDefault];
    
    if (doctorInfo.uid)
    {
        [postDic setObject:doctorInfo.uid forKey:@"uid"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"uid"];
    }
   
    if (doctor.firstname)
    {
        [postDic setObject:doctor.firstname forKey:@"firstname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"firstname"];
    }
    
    if (doctor.lastname)
    {
        [postDic setObject:doctor.lastname forKey:@"lastname"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"lastname"];
    }
    
    if (doctor.me)
    {
        [postDic setObject:doctor.me forKey:@"me"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"me"];
    }
    
    if (doctor.mi)
    {
        [postDic setObject:doctor.mi forKey:@"mi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"mi"];
    }
    
    if (doctor.npi)
    {
        [postDic setObject:doctor.npi forKey:@"npi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"npi"];
    }
    if (doctor.dea)
    {
        [postDic setObject:doctor.dea forKey:@"dea"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"dea"];
    }
    if (doctor.suffix)
    {
        [postDic setObject:doctor.suffix forKey:@"suffix"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"suffix"];
    }
    
    if (doctor.officeaddress)
    {
        [postDic setObject:doctor.officeaddress forKey:@"address"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"address"];
    }
    
    if (doctor.officename)
    {
        [postDic setObject:doctor.officename forKey:@"officename"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officename"];
    }
    
    if (doctor.officecity)
    {
        [postDic setObject:doctor.officecity forKey:@"officecity"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officecity"];
    }

    if (doctor.officestate)
    {
        [postDic setObject:doctor.officestate forKey:@"officestate"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officestate"];
    }
    
    if (doctor.officezip)
    {
        [postDic setObject:doctor.officezip forKey:@"officezip"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officezip"];
    }
    
    if (doctor.officecountry)
    {
        [postDic setObject:doctor.officecountry forKey:@"officecountry"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"officecountry"];
    }
    
    if (doctor.email)
    {
        [postDic setObject:doctor.email forKey:@"email"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"email"];
    }
    
    if (doctor.telephone)
    {
        [postDic setObject:doctor.telephone forKey:@"telephone"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"telephone"];
    }
    
    if (doctor.speciality)
    {
        [postDic setObject:doctor.speciality forKey:@"speciality"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"speciality"];
    }
    
    if (doctor.yearsExperience)
    {
        [postDic setObject:doctor.yearsExperience forKey:@"years"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"years"];
    }
    
    
    if (doctor.school)
    {
        [postDic setObject:doctor.school forKey:@"school"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"school"];
    }
    
    if (doctor.residency)
    {
        [postDic setObject:doctor.residency forKey:@"residency"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"residency"];
    }
    
    
    
    
    
    
    [postDic setObject:@"" forKey:@"postimage"];
    
    return postDic;
}





//Eye Exam New
- (NSMutableDictionary *)dictionWithEyeExamNew:(EyeExam2 *)patient
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    Doctor *doctorInfo = [Doctor getFromUserDefault];
    
    if (doctorInfo.uid)
    {
        [postDic setObject:doctorInfo.uid forKey:@"uid"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"uid"];
    }
    
    if (patient.patientid)
    {
        [postDic setObject:patient.patientid forKey:@"patientid"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"patientid"];
    }
    
    if (patient.cc_examination)
    {
        [postDic setObject:patient.cc_examination forKey:@"ccxam"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ccxam"];
    }
    
    if (patient.cc_examtechnician)
    {
        [postDic setObject:patient.cc_examtechnician forKey:@"ccexamtechnician"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ccexamtechnician"];
    }
    
    if (patient.cc_chiefcompliant)
    {
        [postDic setObject:patient.cc_chiefcompliant forKey:@"chiefcompliant"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"chiefcompliant"];
    }
    
    if (patient.cc_hpivision)
    {
        [postDic setObject:patient.cc_hpivision forKey:@"hpivision"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"hpivision"];
    }
    
    
    if (patient.cc_hpioccular)
    {
        [postDic setObject:patient.cc_hpioccular forKey:@"hpioccular"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"hpioccular"];
    }
    
    if (patient.phx_patienthostiry)
    {
        [postDic setObject:patient.phx_patienthostiry forKey:@"patienthostiry"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"patienthostiry"];
    }
    
    if (patient.phx_occularmed)
    {
        [postDic setObject:patient.phx_occularmed forKey:@"occularmed"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"occularmed"];
    }
    
    if (patient.phx_sysmed)
    {
        [postDic setObject:patient.phx_sysmed forKey:@"sysmed"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"sysmed"];
    }
    
    if (patient.phx_sochis)
    {
        [postDic setObject:patient.phx_sochis forKey:@"phx_sochis"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"phx_sochis"];
    }
    
    if (patient.phx_rewhis)
    {
        [postDic setObject:patient.phx_rewhis forKey:@"phx_rewhis"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"phx_rewhis"];
    }
    
    
    if (patient.phx_allergy)
    {
        [postDic setObject:patient.phx_allergy forKey:@"phx_allergy"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"phx_allergy"];
    }
    
    if (patient.visrx_unadvalt)
    {
        [postDic setObject:patient.visrx_unadvalt forKey:@"visrx_unadvalt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unadvalt"];
    }
    
    if (patient.visrx_unadvabi)
    {
        [postDic setObject:patient.visrx_unadvabi forKey:@"visrx_unadvabi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unadvabi"];
    }
    
    if (patient.visrx_unadvart)
    {
        [postDic setObject:patient.visrx_unadvart forKey:@"visrx_unadvart"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unadvart"];
    }
    
    if (patient.visrx_unanvabi)
    {
        [postDic setObject:patient.visrx_unanvabi forKey:@"visrx_unanvabi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unanvabi"];
    }
    
    if (patient.visrx_unanvalt)
    {
        [postDic setObject:patient.visrx_unanvalt forKey:@"visrx_unanvalt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unanvalt"];
    }
    
    if (patient.visrx_unanvart)
    {
        [postDic setObject:patient.visrx_unanvart forKey:@"visrx_unanvart"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unanvart"];
    }
    
    if (patient.visrx_unaphlt)
    {
        [postDic setObject:patient.visrx_unaphlt forKey:@"visrx_unaphlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unaphlt"];
    }
    
    if (patient.visrx_unaphrt)
    {
        [postDic setObject:patient.visrx_unaphrt forKey:@"visrx_unaphrt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unaphrt"];
    }
    
    if (patient.visrx_unaphbi)
    {
        [postDic setObject:patient.visrx_unaphbi forKey:@"visrx_unaphbi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unaphbi"];
    }
    
    
    
    
    if (patient.visrx_autorefracti)
    {
        [postDic setObject:patient.visrx_autorefracti forKey:@"visrx_autorefracti"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_unaphbi"];
    }
    
    
    if (patient.visrx_retinoscopy)
    {
        [postDic setObject:patient.visrx_retinoscopy forKey:@"visrx_retinoscopy"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_retinoscopy"];
    }
    
    
    
    
    
    if (patient.visrx_psrsphlt)
    {
        [postDic setObject:patient.visrx_psrsphlt forKey:@"visrx_psrsphlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrsphlt"];
    }
    
    
    if (patient.visrx_psrsph)
    {
        [postDic setObject:patient.visrx_psrsph forKey:@"visrx_psrsph"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrsph"];
    }
    
    
    if (patient.visrx_psrcycle)
    {
        [postDic setObject:patient.visrx_psrcycle forKey:@"visrx_psrcycle"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrcycle"];
    }
    
    
    if (patient.visrx_psrcyclelt)
    {
        [postDic setObject:patient.visrx_psrcyclelt forKey:@"visrx_psrcyclelt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrcyclelt"];
    }
    
    
    
    if (patient.visrx_psraxis)
    {
        [postDic setObject:patient.visrx_psraxis forKey:@"visrx_psraxis"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psraxis"];
    }
    
    
    if (patient.visrx_psraxislt)
    {
        [postDic setObject:patient.visrx_psraxislt forKey:@"visrx_psraxislt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psraxislt"];
    }
    
    
    if (patient.visrx_psrhprism)
    {
        [postDic setObject:patient.visrx_psrhprism forKey:@"visrx_psrhprism"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrhprism"];
    }
    
    
    
    if (patient.visrx_psrhprismlt)
    {
        [postDic setObject:patient.visrx_psrhprismlt forKey:@"visrx_psrhprismlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrhprismlt"];
    }
    
    
    if (patient.visrx_psrvprism)
    {
        [postDic setObject:patient.visrx_psrvprism forKey:@"visrx_psrvprism"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrvprism"];
    }
    
    if (patient.visrx_psrvprismlt)
    {
        [postDic setObject:patient.visrx_psrvprismlt forKey:@"visrx_psrvprismlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrvprismlt"];
    }
    
    
    if (patient.visrx_psradd)
    {
        [postDic setObject:patient.visrx_psradd forKey:@"visrx_psradd"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psradd"];
    }
    
    
    if (patient.visrx_psraddlt)
    {
        [postDic setObject:patient.visrx_psraddlt forKey:@"visrx_psraddlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psraddlt"];
    }
    
    if (patient.visrx_psrdna)
    {
        [postDic setObject:patient.visrx_psrdna forKey:@"visrx_psrdna"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrdna"];
    }
    
    
    if (patient.visrx_psrdnalt)
    {
        [postDic setObject:patient.visrx_psrdnalt forKey:@"visrx_psrdnalt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrdnalt"];
    }
    
    
    if (patient.visrx_psrdnabi)
    {
        [postDic setObject:patient.visrx_psrdnabi forKey:@"visrx_psrdnabi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrdnabi"];
    }

    
    if (patient.visrx_psrnva)
    {
        [postDic setObject:patient.visrx_psrnva forKey:@"visrx_psrnva"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrnva"];
    }
    
    
    if (patient.visrx_psrnvalt)
    {
        [postDic setObject:patient.visrx_psrnvalt forKey:@"visrx_psrnvalt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrnvalt"];
    }
    
    
    if (patient.visrx_psrnvabi)
    {
        [postDic setObject:patient.visrx_psrnvabi forKey:@"visrx_psrnvabi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrnvabi"];
    }

    
    if (patient.visrx_psrphp)
    {
        [postDic setObject:patient.visrx_psrphp forKey:@"visrx_psrphp"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrphp"];
    }
    
    
    if (patient.visrx_psrphplt)
    {
        [postDic setObject:patient.visrx_psrphplt forKey:@"visrx_psrphplt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrphplt"];
    }
    
    
    if (patient.visrx_psrphpbi)
    {
        [postDic setObject:patient.visrx_psrphpbi forKey:@"visrx_psrphpbi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrphpbi"];
    }

    if (patient.visrx_psrprxdate)
    {
        [postDic setObject:patient.visrx_psrprxdate forKey:@"visrx_psrprxdate"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_psrprxdate"];
    }
    
    
    
    
    
    
    if (patient.visrx_subrxsphrt)
    {
        [postDic setObject:patient.visrx_subrxsphrt forKey:@"visrx_subrxsphrti"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxsphrt"];
    }
    
    
    if (patient.visrx_subrxsphlt)
    {
        [postDic setObject:patient.visrx_subrxsphlt forKey:@"visrx_subrxsphlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxsphlt"];
    }
    
    
    if (patient.visrx_subrxcycle)
    {
        [postDic setObject:patient.visrx_subrxcycle forKey:@"visrx_subrxcycle"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxcycle"];
    }
    
    
    if (patient.visrx_subrxcyclelt)
    {
        [postDic setObject:patient.visrx_subrxcyclelt forKey:@"visrx_subrxcyclelt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxcyclelt"];
    }
    
    
    
    if (patient.visrx_subrxaxis)
    {
        [postDic setObject:patient.visrx_subrxaxis forKey:@"visrx_subrxaxis"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxaxis"];
    }
    
    
    if (patient.visrx_subrxaxislt)
    {
        [postDic setObject:patient.visrx_subrxaxislt forKey:@"visrx_subrxaxislt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxaxislt"];
    }
    
    if (patient.visrx_subrxhprism)
    {
        [postDic setObject:patient.visrx_subrxhprism forKey:@"visrx_subrxhprism"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxhprism"];
    }
    
    
    if (patient.visrx_subrxhprisml)
    {
        [postDic setObject:patient.visrx_subrxhprisml forKey:@"visrx_subrxhprisml"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxhprisml"];
    }
    
    
    
    if (patient.visrx_subrxvprism)
    {
        [postDic setObject:patient.visrx_subrxvprism forKey:@"visrx_subrxvprism"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxvprism"];
    }
    
    
    if (patient.visrx_subrxvprisml)
    {
        [postDic setObject:patient.visrx_subrxvprisml forKey:@"visrx_subrxvprisml"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxvprisml"];
    }
    
    
    if (patient.visrx_subrxadd)
    {
        [postDic setObject:patient.visrx_subrxadd forKey:@"visrx_subrxadd"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxadd"];
    }
    
    
    if (patient.visrx_subrxaddlt)
    {
        [postDic setObject:patient.visrx_subrxaddlt forKey:@"visrx_subrxaddlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxaddlt"];
    }
    
    
    
    if (patient.visrx_subrxdva)
    {
        [postDic setObject:patient.visrx_subrxdva forKey:@"visrx_subrxdva"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxdva"];
    }
    
    
    if (patient.visrx_subrxdvalt)
    {
        [postDic setObject:patient.visrx_subrxdvalt forKey:@"visrx_subrxdvalt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxdvalt"];
    }
    
    
    if (patient.visrx_subrxnva)
    {
        [postDic setObject:patient.visrx_subrxnva forKey:@"visrx_subrxnva"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxnva"];
    }
    
    
    if (patient.visrx_subrxnvalt)
    {
        [postDic setObject:patient.visrx_subrxnvalt forKey:@"visrx_subrxnvalt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxnvalt"];
    }
    
    
    
    if (patient.visrx_subrxph)
    {
        [postDic setObject:patient.visrx_subrxph forKey:@"visrx_subrxph"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxph"];
    }
    
    
    if (patient.visrx_subrxphlt)
    {
        [postDic setObject:patient.visrx_subrxphlt forKey:@"visrx_subrxphlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_subrxphlt"];
    }
    
   
    
    
    
    //
    if (patient.visrx_fspecsph)
    {
        [postDic setObject:patient.visrx_fspecsph forKey:@"visrx_fspecsph"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecsph"];
    }
    
    
    if (patient.visrx_fspecsphlt)
    {
        [postDic setObject:patient.visrx_fspecsphlt forKey:@"visrx_fspecsphlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecsphlt"];
    }
    
    
    if (patient.visrx_fspeccycle)
    {
        [postDic setObject:patient.visrx_fspeccycle forKey:@"visrx_fspeccycle"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspeccycle"];
    }
    
    
    if (patient.visrx_fspeccyclelt)
    {
        [postDic setObject:patient.visrx_fspeccyclelt forKey:@"visrx_fspeccyclelt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspeccyclelt"];
    }
    
    //
    if (patient.visrx_fspecaxis)
    {
        [postDic setObject:patient.visrx_fspecaxis forKey:@"visrx_fspecaxis"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecaxis"];
    }
    
    
    if (patient.visrx_fspecaxislt)
    {
        [postDic setObject:patient.visrx_fspecaxislt forKey:@"visrx_fspecaxislt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecaxislt"];
    }
    
    
    if (patient.visrx_fspechprism)
    {
        [postDic setObject:patient.visrx_fspechprism forKey:@"visrx_fspechprism"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspechprism"];
    }
    
    
    if (patient.visrx_fspechprisml)
    {
        [postDic setObject:patient.visrx_fspechprisml forKey:@"visrx_fspechprisml"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspechprisml"];
    }
    
    //
    if (patient.visrx_fspecvprism)
    {
        [postDic setObject:patient.visrx_fspecvprism forKey:@"visrx_fspecvprism"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecvprism"];
    }
    
    
    if (patient.visrx_fspecvprisml)
    {
        [postDic setObject:patient.visrx_fspecvprisml forKey:@"visrx_fspecvprisml"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecvprisml"];
    }
    
    
    if (patient.visrx_fspecadd)
    {
        [postDic setObject:patient.visrx_fspecadd forKey:@"visrx_fspecadd"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecadd"];
    }
    
    
    if (patient.visrx_fspecaddlt)
    {
        [postDic setObject:patient.visrx_fspecaddlt forKey:@"visrx_fspecaddlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecaddlt"];
    }
    
//
    if (patient.visrx_fspecaddbi)
    {
        [postDic setObject:patient.visrx_fspecaddbi forKey:@"visrx_fspecaddbi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecaddbi"];
    }
    
    
    if (patient.visrx_fspecdva)
    {
        [postDic setObject:patient.visrx_fspecdva forKey:@"visrx_fspecdva"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecdva"];
    }
    
    
    if (patient.visrx_fspecdvalt)
    {
        [postDic setObject:patient.visrx_fspecdvalt forKey:@"visrx_fspecdvalt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecdvalt"];
    }
    
    
    if (patient.visrx_fspecdvabi)
    {
        [postDic setObject:patient.visrx_fspecdvabi forKey:@"visrx_fspecdvabi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecdvabi"];
    }
    
    //
    if (patient.visrx_fspecnva)
    {
        [postDic setObject:patient.visrx_fspecnva forKey:@"visrx_fspecnva"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecnva"];
    }
    
    
    if (patient.visrx_fspecnvalt)
    {
        [postDic setObject:patient.visrx_fspecnvalt forKey:@"visrx_fspecnvalt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecnvalt"];
    }
    
    
    if (patient.visrx_fspecnvabi)
    {
        [postDic setObject:patient.visrx_fspecnvabi forKey:@"visrx_fspecnvabi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecnvabi"];
    }
    
    
    if (patient.visrx_fspecph)
    {
        [postDic setObject:patient.visrx_fspecph forKey:@"visrx_fspecph"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecph"];
    }
    
    
    //
    if (patient.visrx_fspecphlt)
    {
        [postDic setObject:patient.visrx_fspecphlt forKey:@"visrx_fspecphlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecphlt"];
    }
    
    
    if (patient.visrx_fspecphbi)
    {
        [postDic setObject:patient.visrx_fspecphbi forKey:@"visrx_fspecphbi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecphbi"];
    }
    
    
    if (patient.visrx_fspecrxdate)
    {
        [postDic setObject:patient.visrx_fspecrxdate forKey:@"visrx_fspecrxdate"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecrxdate"];
    }
    
    
    if (patient.visrx_fspecexdate)
    {
        [postDic setObject:patient.visrx_fspecexdate forKey:@"visrx_fspecexdate"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"visrx_fspecexdate"];
    }
    
    
    
    
    //Surgery
    if (patient.vsurgery_imprerefr)
    {
        [postDic setObject:patient.vsurgery_imprerefr forKey:@"vsurgery_imprerefr"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"vsurgery_imprerefr"];
    }
    
    
    if (patient.vsurgery_impressco)
    {
        [postDic setObject:patient.vsurgery_impressco forKey:@"vsurgery_impressco"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"vsurgery_impressco"];
    }
    
    
    if (patient.vsurgery_trx)
    {
        [postDic setObject:patient.vsurgery_trx forKey:@"vsurgery_trx"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"vsurgery_trx"];
    }
    
    
    if (patient.vsurgery_tcon)
    {
        [postDic setObject:patient.vsurgery_tcon forKey:@"vsurgery_tcon"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"vsurgery_tcon"];
    }
    
    
    if (patient.vsurgery_pmconsel)
    {
        [postDic setObject:patient.vsurgery_pmconsel forKey:@"vsurgery_pmconsel"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"vsurgery_pmconsel"];
    }
    
    
    
    
    
    //Exam
    if (patient.exam_conjuctiva)
    {
        [postDic setObject:patient.exam_conjuctiva forKey:@"exam_conjuctiva"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exam_conjuctiva"];
    }
    
    if (patient.exam_technician)
    {
        [postDic setObject:patient.exam_technician forKey:@"exam_technician"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exam_technician"];
    }
    
    if (patient.exam_slitexam)
    {
        [postDic setObject:patient.exam_slitexam forKey:@"exam_slitexam"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exam_slitexam"];
    }
    if (patient.exam_exexam)
    {
        [postDic setObject:patient.exam_exexam forKey:@"exam_exexam"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exam_exexam"];
    }
    
    //
    if (patient.exam_crdgorxlt)
    {
        [postDic setObject:patient.exam_crdgorxlt forKey:@"exam_crdgorxlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exam_crdgorxlt"];
    }
    
    if (patient.exam_crdgorxrt)
    {
        [postDic setObject:patient.exam_crdgorxrt forKey:@"exam_crdgorxrt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exam_crdgorxrt"];
    }
    
    if (patient.exam_crdverlt)
    {
        [postDic setObject:patient.exam_crdverlt forKey:@"exam_crdverlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exam_crdverlt"];
    }
    if (patient.exam_crdverrt)
    {
        [postDic setObject:patient.exam_crdverrt forKey:@"exam_crdverrt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exam_crdverrt"];
    }
    
    
    if (patient.surgeryhistory)
    {
        [postDic setObject:patient.surgeryhistory forKey:@"surgeryhistory"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"surgeryhistory"];
    }
    
    if (patient.medicationhistory)
    {
        [postDic setObject:patient.medicationhistory forKey:@"medicationhistory"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"medicationhistory"];
    }
    
    if (patient.occularhostory)
    {
        [postDic setObject:patient.occularhostory forKey:@"occularhostory"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"occularhostory"];
    }
    
    if (patient.occularmedication)
    {
        [postDic setObject:patient.occularmedication forKey:@"occularmedication"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"occularmedication"];
    }
    
    
    if (patient.seondarycomplain)
    {
        [postDic setObject:patient.seondarycomplain forKey:@"seondarycomplain"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"seondarycomplain"];
    }
    
    if (patient.medicalsurgery)
    {
        [postDic setObject:patient.medicalsurgery forKey:@"medicalsurgery"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"medicalsurgery"];
    }
    
    if (patient.occularsurgery)
    {
        [postDic setObject:patient.occularsurgery forKey:@"occularsurgery"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"occularsurgery"];
    }
    
    if (patient.examcornea)
    {
        [postDic setObject:patient.examcornea forKey:@"examcornea"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"examcornea"];
    }
    
    if (patient.examlens)
    {
        [postDic setObject:patient.examlens forKey:@"examlens"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"examlens"];
    }
    
    if (patient.examac)
    {
        [postDic setObject:patient.examac forKey:@"examac"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"examac"];
    }
    
    if (patient.examiris)
    {
        [postDic setObject:patient.examiris forKey:@"examiris"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"examiris"];
    }
    
    if (patient.exmpupil)
    {
        [postDic setObject:patient.exmpupil forKey:@"exmpupil"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exmpupil"];
    }
    
    if (patient.assesfreetext)
    {
        [postDic setObject:patient.assesfreetext forKey:@"assesfreetext"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"assesfreetext"];
    }

    if (patient.examiopod)
    {
        [postDic setObject:patient.examiopod forKey:@"examiopod"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"examiopod"];
    }
    
    if (patient.examiopos)
    {
        [postDic setObject:patient.examiopos forKey:@"examiopos"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"examiopos"];
    }
    
    if (patient.exampachod)
    {
        [postDic setObject:patient.exampachod forKey:@"exampachod"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exampachod"];
    }
    
    if (patient.exampachos)
    {
        [postDic setObject:patient.exampachos forKey:@"exampachos"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"exampachos"];
    }
    
    if (patient.concentrationlt)
    {
        [postDic setObject:patient.concentrationlt forKey:@"concentrationlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"concentrationlt"];
    }
    
    if (patient.concentrationrt)
    {
        [postDic setObject:patient.concentrationrt forKey:@"concentrationrt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"concentrationrt"];
    }
    
    
    if (patient.amslergridrt)
    {
        [postDic setObject:patient.amslergridrt forKey:@"amslergridrt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"amslergridrt"];
    }
    
    if (patient.amslergridlt)
    {
        [postDic setObject:patient.amslergridlt forKey:@"amslergridlt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"amslergridlt"];
    }
    
    if (patient.assesmentslit)
    {
        [postDic setObject:patient.assesmentslit forKey:@"assesmentslit"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"assesmentslit"];
    }
    
    if (patient.assesmentvisiorrx)
    {
        [postDic setObject:patient.assesmentvisiorrx forKey:@"assesmentvisiorrx"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"assesmentvisiorrx"];
    }
    
    if (patient.assesmentretina)
    {
        [postDic setObject:patient.assesmentretina forKey:@"assesmentretina"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"assesmentretina"];
    }
    
    if (patient.planslit)
    {
        [postDic setObject:patient.planslit forKey:@"planslit"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"planslit"];
    }
    
    if (patient.planvisionrrx)
    {
        [postDic setObject:patient.planvisionrrx forKey:@"planvisionrrx"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"planvisionrrx"];
    }
    
    if (patient.planretina)
    {
        [postDic setObject:patient.planretina forKey:@"planretina"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"planretina"];
    }


    
    
    
    return postDic;
    

}





- (NSMutableDictionary *)dictionWithEyeExam:(EyeExam *)patient
{
    NSMutableDictionary *postDic = [NSMutableDictionary dictionary];
    
    Doctor *doctorInfo = [Doctor getFromUserDefault];
    
    if (doctorInfo.uid)
    {
        [postDic setObject:doctorInfo.uid forKey:@"uid"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"uid"];
    }
    
    if (patient.patientid)
    {
        [postDic setObject:patient.patientid forKey:@"patientid"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"patientid"];
    }
    
    
    //ODAN
    if (patient.odan_lidslashes)
    {
        [postDic setObject:patient.odan_lidslashes forKey:@"odan_lidslashes"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odan_lidslashes"];
    }
    
    if (patient.odan_conjuctiva)
    {
        [postDic setObject:patient.odan_conjuctiva forKey:@"odan_conjuctiva"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odan_conjuctiva"];
    }
    
    if (patient.odan_sclera)
    {
        [postDic setObject:patient.odan_sclera forKey:@"odan_sclera"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odan_sclera"];
    }
    
    if (patient.odan_cornea)
    {
        [postDic setObject:patient.odan_cornea forKey:@"odan_cornea"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odan_cornea"];
    }
    
    if (patient.odan_angles)
    {
        [postDic setObject:patient.odan_angles forKey:@"odan_angles"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odan_angles"];
    }
    
    if (patient.odan_iris)
    {
        [postDic setObject:patient.odan_iris forKey:@"odan_iris"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odan_iris"];
    }
    
    if (patient.odan_ac)
    {
        [postDic setObject:patient.odan_ac forKey:@"odan_ac"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odan_ac"];
    }
    
    if (patient.odan_lens)
    {
        [postDic setObject:patient.odan_lens forKey:@"odan_lens"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odan_lens"];
    }
    
    
    
    
    //OSAN
    if (patient.osan_lids)
    {
        [postDic setObject:patient.osan_lids forKey:@"osan_lids"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"osan_lids"];
    }
    
    if (patient.osan_conjuctiva)
    {
        [postDic setObject:patient.osan_conjuctiva forKey:@"osan_conjuctiva"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"osan_conjuctiva"];
    }
    
    if (patient.osan_sclera)
    {
        [postDic setObject:patient.osan_sclera forKey:@"osan_sclera"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"osan_sclera"];
    }
    
    if (patient.osan_cornea)
    {
        [postDic setObject:patient.osan_cornea forKey:@"osan_cornea"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"osan_cornea"];
    }
    
    if (patient.osan_angles)
    {
        [postDic setObject:patient.odan_angles forKey:@"osan_angles"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"osan_angles"];
    }
    
    if (patient.osan_iris)
    {
        [postDic setObject:patient.osan_iris forKey:@"osan_iris"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"osan_iris"];
    }
    
    if (patient.osan_ac)
    {
        [postDic setObject:patient.osan_ac forKey:@"osan_ac"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"osan_ac"];
    }
    
    if (patient.osan_lens)
    {
        [postDic setObject:patient.osan_lens forKey:@"osan_lens"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"osan_lens"];
    }
    
    
    
    
    
    
    //ODPOS
    if (patient.odpos_media)
    {
        [postDic setObject:patient.odpos_media forKey:@"odpos_media"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_media"];
    }
    
    if (patient.odpos_cs)
    {
        [postDic setObject:patient.odpos_cs forKey:@"odpos_cs"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_cs"];
    }
    
    if (patient.odpos_shape)
    {
        [postDic setObject:patient.odpos_shape forKey:@"odpos_shape"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_shape"];
    }
    
    if (patient.odpost_rim)
    {
        [postDic setObject:patient.odpost_rim forKey:@"odpos_rim"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_rim"];
    }
    
    if (patient.odpos_vp)
    {
        [postDic setObject:patient.odpos_vp forKey:@"odpos_vp"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_vp"];
    }
    
    if (patient.odpos_postpole)
    {
        [postDic setObject:patient.odpos_postpole forKey:@"odpos_postpole"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_postpole"];
    }
    
    if (patient.odpos_av)
    {
        [postDic setObject:patient.odpos_av forKey:@"odpos_av"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_av"];
    }
    
    if (patient.odpos_alr)
    {
        [postDic setObject:patient.odpos_alr forKey:@"odpos_alr"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_alr"];
    }
    
    if (patient.odpos_macula)
    {
        [postDic setObject:patient.odpos_macula forKey:@"odpos_macula"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_macula"];
    }
    
    if (patient.odpos_periphery)
    {
        [postDic setObject:patient.odpos_periphery forKey:@"odpos_periphery"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_periphery"];
    }
    
    

    
    //OSPOS
    if (patient.ospos_media)
    {
        [postDic setObject:patient.ospos_media forKey:@"ospos_media"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ospos_media"];
    }
    
    if (patient.ospos_cs)
    {
        [postDic setObject:patient.ospos_cs forKey:@"ospos_cs"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ospos_cs"];
    }
    
    if (patient.ospos_shape)
    {
        [postDic setObject:patient.ospos_shape forKey:@"ospos_shape"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ospos_shape"];
    }
    
    if (patient.ospost_rim)
    {
        [postDic setObject:patient.ospost_rim forKey:@"ospos_rim"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ospos_rim"];
    }
    
    if (patient.ospos_vp)
    {
        [postDic setObject:patient.ospos_vp forKey:@"ospos_vp"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ospos_vp"];
    }
    
    if (patient.ospos_postpole)
    {
        [postDic setObject:patient.ospos_postpole forKey:@"ospos_postpole"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ospos_postpole"];
    }
    
    if (patient.ospos_av)
    {
        [postDic setObject:patient.ospos_av forKey:@"ospos_av"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ospos_av"];
    }
    
    if (patient.ospos_alr)
    {
        [postDic setObject:patient.ospos_alr forKey:@"ospos_alr"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"odpos_alr"];
    }
    
    if (patient.ospos_macula)
    {
        [postDic setObject:patient.ospos_macula forKey:@"ospos_macula"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ospos_macula"];
    }
    
    if (patient.ospos_periphery)
    {
        [postDic setObject:patient.ospos_periphery forKey:@"ospos_periphery"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"ospos_periphery"];
    }
    
    

    
    
    //Assessment
    if (patient.assesment)
    {
        [postDic setObject:patient.assesment forKey:@"assesment"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"assesment"];
    }
    
    
    
    
    
    
    //Glass RX 1
    if (patient.glassrx_type)
    {
        [postDic setObject:patient.glassrx_type forKey:@"glassrx_type"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx_type"];
    }
    
    if (patient.glassrx_od)
    {
        [postDic setObject:patient.glassrx_od forKey:@"glassrx_od"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx_od"];
    }
    
    if (patient.glassrx_os)
    {
        [postDic setObject:patient.glassrx_os forKey:@"glassrx_os"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx_os"];
    }
    
    if (patient.glassrx_prism)
    {
        [postDic setObject:patient.glassrx_prism forKey:@"glassrx_prism"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx_prism"];
    }
    
    if (patient.glassrx_add)
    {
        [postDic setObject:patient.glassrx_add forKey:@"glassrx_add"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx_add"];
    }
    
    
    
    
    
    //Glass RX 2
    if (patient.glassrx2_type)
    {
        [postDic setObject:patient.glassrx2_type forKey:@"glassrx2_type"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx2_type"];
    }
    
    if (patient.glassrx2_od)
    {
        [postDic setObject:patient.glassrx2_od forKey:@"glassrx2_od"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx2_od"];
    }
    
    if (patient.glassrx2_os)
    {
        [postDic setObject:patient.glassrx2_os forKey:@"glassrx2_os"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx2_os"];
    }
    
    if (patient.glassrx2_prism)
    {
        [postDic setObject:patient.glassrx2_prism forKey:@"glassrx2_prism"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx2_prism"];
    }
    
    if (patient.glassrx2_add)
    {
        [postDic setObject:patient.glassrx2_add forKey:@"glassrx2_add"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"glassrx2_add"];
    }
    
    
    
    
    
    
    
    //Contacts RX
    
    if (patient.contactsrx_type)
    {
        [postDic setObject:patient.contactsrx_type forKey:@"contactsrx_type"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_type"];
    }
    
    if (patient.contactsrx_od)
    {
        [postDic setObject:patient.contactsrx_od forKey:@"contactsrx_od"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_od"];
    }
    
    if (patient.contactsrx_os)
    {
        [postDic setObject:patient.contactsrx_os forKey:@"contactsrx_os"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_os"];
    }
    
    if (patient.contactsrx_bc)
    {
        [postDic setObject:patient.contactsrx_bc forKey:@"contactsrx_bc"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_bc"];
    }
    
    
    if (patient.contactsrx_diam)
    {
        [postDic setObject:patient.contactsrx_diam forKey:@"contactsrx_diam"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_diam"];
    }
    
    if (patient.contactsrx_brand)
    {
        [postDic setObject:patient.contactsrx_brand forKey:@"contactsrx_brand"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_brand"];
    }
    
    if (patient.contactsrx_wt)
    {
        [postDic setObject:patient.contactsrx_wt forKey:@"contactsrx_wt"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_wt"];
    }
    
    if (patient.contactsrx_color)
    {
        [postDic setObject:patient.contactsrx_color forKey:@"contactsrx_color"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_color"];
    }
    
    if (patient.contactsrx_solution)
    {
        [postDic setObject:patient.contactsrx_solution forKey:@"contactsrx_solution"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_solution"];
    }
    
    if (patient.contactsrx_enzyme)
    {
        [postDic setObject:patient.contactsrx_enzyme forKey:@"contactsrx_enzyme"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_enzyme"];
    }
    
    if (patient.contactsrx_amount)
    {
        [postDic setObject:patient.contactsrx_amount forKey:@"contactsrx_amount"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"contactsrx_amount"];
    }
    

    
    
    
    
    
    
    //Additional Testing
    
    if (patient.adtest_topography)
    {
        [postDic setObject:patient.adtest_topography forKey:@"adtest_topography"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"adtest_topography"];
    }
    
    if (patient.adtest_cycloplegia)
    {
        [postDic setObject:patient.adtest_cycloplegia forKey:@"adtest_cycloplegia"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"adtest_cycloplegia"];
    }
    
    if (patient.adtest_tonometry)
    {
        [postDic setObject:patient.adtest_tonometry forKey:@"adtest_tonometry"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"adtest_tonometry"];
    }
    
    if (patient.adtest_fields)
    {
        [postDic setObject:patient.adtest_fields forKey:@"adtest_fields"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"adtest_fields"];
    }
    
    
    if (patient.adtest_retinal)
    {
        [postDic setObject:patient.adtest_retinal forKey:@"adtest_retinal"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"adtest_retinal"];
    }
    
    if (patient.adtest_clcheck)
    {
        [postDic setObject:patient.adtest_clcheck forKey:@"adtest_clcheck"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"adtest_clcheck"];
    }
    
    if (patient.adtest_medfollow)
    {
        [postDic setObject:patient.adtest_medfollow forKey:@"adtest_medfollow"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"adtest_medfollow"];
    }
    
    if (patient.adtest_exam)
    {
        [postDic setObject:patient.adtest_exam forKey:@"adtest_exam"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"adtest_exam"];
    }
    
    
    
    
    
    //Recommendations
    if (patient.rec_hindex)
    {
        [postDic setObject:patient.rec_hindex forKey:@"rec_hindex"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"rec_hindex"];
    }
    
    if (patient.rec_bfcal)
    {
        [postDic setObject:patient.rec_bfcal forKey:@"rec_bfcal"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"rec_bfcal"];
    }
    
    if (patient.rec_progressive)
    {
        [postDic setObject:patient.rec_progressive forKey:@"rec_progressive"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"rec_progressive"];
    }
    
    
    //Other
    if (patient.additionalintructi)
    {
        [postDic setObject:patient.additionalintructi forKey:@"additionalintructi"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"additionalintructi"];
    }
    
    if (patient.corrospondence)
    {
        [postDic setObject:patient.corrospondence forKey:@"corrospondence"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"corrospondence"];
    }
    
    if (patient.copychart)
    {
        [postDic setObject:patient.copychart forKey:@"copychart"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"copychart"];
    }
    
    if (patient.od)
    {
        [postDic setObject:patient.od forKey:@"od"];
    }
    else
    {
        [postDic setObject:@"" forKey:@"od"];
    }
    
    
    return postDic;
}



#pragma mark - Manager Account

- (void)storePhysicianToUserDefault:(Account *)account
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:account];
    [userDefault setObject:myEncodedObject forKey:kAccountUserDefault];
    [userDefault synchronize];
}


- (void)storePatientToUserDefault:(PatientRegister *)account
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:account];
    [userDefault setObject:myEncodedObject forKey:kPatientRegisterUserDefault];
    [userDefault synchronize];
}

- (Account *)getPhysicianFromUserDefault
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey:kAccountUserDefault];
    Account *gymAccount = [NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObject];
    return gymAccount;
}

- (PatientRegister *)getPatientFromUserDefault
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *myDecodedObject = [userDefault objectForKey:kPatientRegisterUserDefault];
    PatientRegister *gymAccount = [NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObject];
    return gymAccount;
}

@end
