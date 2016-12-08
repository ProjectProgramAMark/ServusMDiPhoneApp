//
//  AppDelegate.m
//  ClubContact
//
//  Created by Duong Nguyen on 2/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AppDelegate.h"
#import "DeviceInfo.h"
#import "DashboardV2ViewController.h"
#import "RearViewController.h"
@import Quickblox;


@interface AppDelegate ()

//@property (strong, nonatomic) DashboardV2ViewController *dashVC;

@end

@implementation AppDelegate


const CGFloat kQBRingThickness = 1.f;
const NSTimeInterval kQBAnswerTimeInterval = 60.f;
const NSTimeInterval kQBRTCDisconnectTimeInterval = 30.f;
const NSTimeInterval kQBDialingTimeInterval = 5.f;

const NSUInteger kQBApplicationID = 26279;
NSString *const kQBRegisterServiceKey = @"9yZhmvZtxwb3k9c";
NSString *const kQBRegisterServiceSecret = @"UJNGb9-CNYSXmbk";
NSString *const kQBAccountKey = @"yDZov8BxcCj43zXJ4MT4";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _calendarViewController = [FFCalendarViewController new];
  //  [_calendarViewController setProtocol:self];
    
    //setup Magical Record
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    [DeviceInfo updateDeviceInfo];
    
    [Flurry startSession:@"Y9K592Q8G7PSBFNJJNYN"];
    
    
    //[Stripe setDefaultPublishableKey:@"pk_test_9SqikXbyVPhsn6buFHi1vURh"];
    [Stripe setDefaultPublishableKey:@"pk_live_ya8lfMrJV4hOlY95n42e7frH"];
    
    //Quickblox preferences
    /* MARK'S CODE CHANGES */
    // [QBSettings setApplicationID:] = kQBApplicationID;
    [QBSettings setApplicationID:kQBApplicationID];
    
    /* MARK'S CODE CHANGES */
    // [QBConnection registerServiceKey:kQBRegisterServiceKey];
    [QBSettings setAuthKey:kQBRegisterServiceKey];
    // [QBConnection registerServiceSecret:kQBRegisterServiceSecret];
    [QBSettings setAuthSecret:kQBRegisterServiceSecret];
    
    /* END MARK'S CODE CHANGES */
    
    [QBSettings setAccountKey:kQBAccountKey];
    [QBSettings setLogLevel:QBLogLevelErrors];
    
    //QuickbloxWebRTC preferences
   /* [QBRTCConfig setAnswerTimeInterval:kQBAnswerTimeInterval];
    [QBRTCConfig setDisconnectTimeInterval:kQBRTCDisconnectTimeInterval];
    [QBRTCConfig setDialingTimeInterval:5];*/
    
    
    [QBSettings setLogLevel:QBLogLevelNothing];
    [QBSettings setAutoReconnectEnabled:YES];
    //QuickbloxWebRTC preferences
    
    [QBRTCConfig setAnswerTimeInterval:kQBAnswerTimeInterval];
    [QBRTCConfig setDisconnectTimeInterval:kQBRTCDisconnectTimeInterval];
    [QBRTCConfig setDialingTimeInterval:kQBDialingTimeInterval];
    [QBRTCClient initializeRTC];
    

    // Enable DTLS (Datagram Transport Layer Security)
    [QBRTCConfig setDTLSEnabled:YES];
    
    // Set custom ICE servers
   /* NSURL *stunUrl = [NSURL URLWithString:@"stun:turn.quickblox.com"];
    QBICEServer *stunServer =
    [QBICEServer serverWithURL:stunUrl username:@"quickblox" password:@"baccb97ba2d92d71e26eb9886da5f1e0"];
    
    NSURL *turnUDPUrl = [NSURL URLWithString:@"turn:turn.quickblox.com:3478?transport=udp"];
    QBICEServer *turnUDPServer =
    [QBICEServer serverWithURL:turnUDPUrl username:@"quickblox" password:@"baccb97ba2d92d71e26eb9886da5f1e0"];
    
    NSURL *turnTCPUrl = [NSURL URLWithString:@"turn:turn.quickblox.com:3478?transport=tcp"];
    QBICEServer* turnTCPServer =
    [QBICEServer serverWithURL:turnTCPUrl username:@"quickblox" password:@"baccb97ba2d92d71e26eb9886da5f1e0"];
    
    [QBRTCConfig setICEServers:@[stunServer, turnUDPServer, turnTCPServer]];*/
    
    NSString *password = @"baccb97ba2d92d71e26eb9886da5f1e0";
    NSString *userName = @"quickblox";
    
    QBRTCICEServer * stunServer = [QBRTCICEServer serverWithURL:@"stun:turn.quickblox.com"
                                                       username:@""
                                                       password:@""];
    
    QBRTCICEServer * turnUDPServer = [QBRTCICEServer serverWithURL:@"turn:turn.quickblox.com:3478?transport=udp"
                                                          username:userName
                                                          password:password];
    
    QBRTCICEServer * turnTCPServer = [QBRTCICEServer serverWithURL:@"turn:turn.quickblox.com:3478?transport=tcp"
                                                          username:userName
                                                          password:password];
    
    
     [QBRTCConfig setICEServers:@[stunServer, turnTCPServer, turnUDPServer]];
    
    [QBRTCConfig setMediaStreamConfiguration:[QBRTCMediaStreamConfiguration defaultConfiguration]];
    
    //Push notiification enabling
    if(IS_OS_8_OR_LATER) {
        
        /* UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert) categories:nil];
         [[UIApplication sharedApplication] registerUserNotificationSettings:settings];*/
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        //register to receive notifications
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate {
    return true;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
    
}

#pragma mark - Push notification managements app delegate.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // [[NSUserDefaults standardUserDefaults] setObject:token forKey:kDeviceToken];
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"notToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"Token = %@", token);
    
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    [[NSUserDefaults standardUserDefaults] setValue:@"deviceToken" forKey:@"notToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
        
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSString  *notificationType = [[userInfo objectForKey:@"server"] objectForKey:@"type"];
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        NSString *cancelTitle = @"Close";
        NSString *showTitle = @"Show";
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
       [AGPushNoteView showWithNotificationMessage:message];
        [AGPushNoteView setMessageAction:^(NSString *message) {
           
            if ([message containsString:@"consultation"]) {
                if (self.rearVC) {
                    [self.rearVC goToConsultationRequests:nil];
                }
            }
           
        }];
        
        if (self.dashVC) {
            [self.dashVC refreshAllDataForNoti];
        }
        
      /*  for (UIViewController* viewController in self.window.rootViewController.navigationController.viewControllers) {
            
            if ([viewController isKindOfClass:[DashboardV2ViewController class]] ) {
                //  viewContains = true;
                [(DashboardV2ViewController *)viewController refreshAllDataForNoti];
                
                
                
            } else {
                
            }
        }*/
        /*UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
            for (UIViewController* viewController in navigationController.viewControllers) {
                
                if ([viewController isKindOfClass:[DashboardV2ViewController class]] ) {
                    //  viewContains = true;
                    [(DashboardV2ViewController *)viewController refreshAllDataForNoti];
                    
                    
                    
                } else {
                    
                }
            }
        }
        */

    } else {
        //Do stuff that you would do if the application was not active
    }
  
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)updateDoctorOnline {
    [[AppController sharedInstance] updateOnlineStatus:@"" completion:^(BOOL success, NSString *message) {
        
    }];
}

#pragma mark - SharedInstance

+ (AppDelegate *)sharedInstance
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - GetCurrentViewController

- (UIViewController *)viewControllerWithIndentifier:(NSString *)identifier
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

/*- (NSArray *)calendarViewControllerAtIndexes:(NSIndexSet *)indexes {
    
    
}*/

- (void)arrayUpdatedWithAllEvents:(NSMutableArray *)arrayUpdated {
    
}

@end
