//
//  PaitentRecNotesViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PaitentRecNotesViewController.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "TextPopup.h"

@interface PaitentRecNotesViewController ()

@end

@implementation PaitentRecNotesViewController
@synthesize patientInfo;
@synthesize profPatient;
@synthesize doctor;
@synthesize patientsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    patientsArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [menuTable registerNib:[UINib nibWithNibName:@"ConditionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"dashboardMenu"];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    // UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    self.title = @"NOTES";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)viewDidAppear:(BOOL)animated {
    // [menuTable reloadData];
    [self getPatientNotes];
}



- (void)getPatientNotes {
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllNotesByPatient2:patientInfo.postid doctor:patientInfo.docid
                                          WithCompletion:^(BOOL success, NSString *message, NSMutableArray *notes)
     {
         [SVProgressHUD dismiss];
         if (success)
         {
             [profPatient.notes removeAllObjects];
             [profPatient.notes addObjectsFromArray:notes];
             [menuTable reloadData];
         }
     }];

    
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (profPatient) {
        return profPatient.notes.count;
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ConditionsTableViewCell    *cell = (ConditionsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardMenu"];
    
    //cell.cellImageView.image = [UIImage imageNamed:@"appointmenticonv2.png"];
    
    // PatientMedication *patientInfo2 = [profPatient.medications objectAtIndex:indexPath.row];
    Note *note = [profPatient.notes objectAtIndex:indexPath.row];
    
   // NSString *typeString = @"";
    NSString *dateLabel = @"";
    
    NSString *tyepString = @"Unknown type";
    if (note.notetext!=nil
        && note.notetext.length > 0)
    {
        tyepString = @"Text Note";
           }
    else if (note.noteimage !=nil
             && note.noteimage.length > 0)
    {
        tyepString = @"Image Note";
    
    }
    else if(note.noterecording !=nil
            && note.noterecording.length > 0)
    {
        tyepString = @"Recording Note";
   
    }
    
  
    if (note.timestamp != nil
        && note.timestamp.length > 0)
    {
        NSTimeInterval timestamp = [note.timestamp doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
        NSString *dateString = [dateFormat stringFromDate:date];
        
        dateLabel = dateString;
        
    }
    else
    {
        dateLabel = @"";
        
    }

    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ - %@", tyepString, dateLabel];
    //cell.nameLabel.textColor = [UIColor colorWithRed:150.0f/255.0f green:197.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    // cell.nameLabel.text = [NSString stringWithFormat:@"%@: %@", [self aboutTitleByRow:indexPath.row], [self aboutValueByRow:indexPath.row]];
    cell.clipsToBounds = YES;
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Note *note = [profPatient.notes objectAtIndex:indexPath.row];
    
    // NSString *typeString = @"";
    NSString *dateLabel = @"";
    
    NSString *tyepString = @"Unknown type";
    if (note.notetext!=nil
        && note.notetext.length > 0)
    {
         [[TextPopup popUpViewText:note.notetext] showInKeyWindow];
    }
    else if (note.noteimage !=nil
             && note.noteimage.length > 0)
    {
        [self showRemoteImage:note.noteimage];
        
    }
    else if(note.noterecording !=nil
            && note.noterecording.length > 0)
    {
          [self playRemoteAudio:note.noterecording];
        
    }
    

    
  

}



- (void)showRemoteImage:(NSString *)imageLink
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    imageLink = [imageLink stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
    NSURL *imageURL = [NSURL URLWithString:imageLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.center = self.view.center;
        imageView.backgroundColor = [UIColor redColor];
        imageView.image = responseObject;
        [EXPhotoViewer showImageFrom:imageView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Image download failed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];
    [requestOperation start];
    
    
    
}



- (void)playRemoteAudio:(NSString *)audioLink
{
    // Initialize the movie player view controller with a video URL string
    MPMoviePlayerViewController *playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:audioLink]] ;
    
    // Remove the movie player view controller from the "playback did finish" notification observers
    [[NSNotificationCenter defaultCenter] removeObserver:playerVC
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:playerVC.moviePlayer];
    
    // Register this class as an observer instead
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:playerVC.moviePlayer];
    
    // Set the modal transition style of your choice
    playerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    // Present the movie player view controller
    [self presentMoviePlayerViewControllerAnimated:playerVC];
    
    // Start playback
    [playerVC.moviePlayer prepareToPlay];
    [playerVC.moviePlayer play];
}

- (void)movieFinishedCallback:(NSNotification*)aNotification
{
    // Obtain the reason why the movie playback finished
    NSNumber *finishReason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    // Dismiss the view controller ONLY when the reason is not "playback ended"
    if ([finishReason intValue] != MPMovieFinishReasonPlaybackEnded)
    {
        MPMoviePlayerController *moviePlayer = [aNotification object];
        
        // Remove this class from the observers
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:moviePlayer];
        
        // Dismiss the view controller
        [self dismissMoviePlayerViewControllerAnimated];
    }
}



@end
