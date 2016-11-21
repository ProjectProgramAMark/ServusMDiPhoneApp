//
//  NoteNewsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/1/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import "NoteNewsViewController.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "Doctor.h"
#import "Note.h"
#import "EXPhotoViewer.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import "TextPopup.h"

@interface NoteNewsViewController ()

@end

@implementation NoteNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"NOTES";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    //self.navigationItem.rightBarButtonItem = notiButtonItem;
    if (self.isSharedProfile == false) {
        self.navigationItem.rightBarButtonItem = notiButtonItem;
        
    }
    [_tableView registerNib:[UINib nibWithNibName:@"NewGreenTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)addNewNotes:(id)sender {
    [self showNoteChooseTypePopup];
}

- (void)viewWillAppear:(BOOL)animated {
    [self getPatientNotes];
    
    profileIMGView2.layer.cornerRadius = profileIMGView2.frame.size.width/2;
    profileIMGView2.layer.masksToBounds = YES;
    profileIMGView2.layer.borderColor = [UIColor blackColor].CGColor;
    profileIMGView2.layer.borderWidth = 1.0;
    
    
    [profileIMGView2 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    //[profileIMGView3 setImageWithURL:[NSURL URLWithString: _patient.profilepic]];
    nameLabel2.text = [NSString stringWithFormat:@"%@ %@", _patient.firstName, _patient.lastName];
    jobLabel2.text = [NSString stringWithFormat:@"%@", _patient.occupation];
    
    

}



- (void)getPatientNotes
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[AppController sharedInstance] getAllNotesByPatient:_patient.postid docid:_patient.docid                                           WithCompletion:^(BOOL success, NSString *message, NSMutableArray *notes)
     {
         [SVProgressHUD dismiss];
         if (success)
         {
             [_patient.notes removeAllObjects];
             [_patient.notes addObjectsFromArray:notes];
              [_tableView reloadData];
            // notesLabel.text = [NSString stringWithFormat:@"%lu Notes", (unsigned long)_patient.notes.count];
         }
     }];
}




#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _patient.notes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewGreenTableViewCell *cell = (NewGreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Note *note =  [_patient.notes objectAtIndex:indexPath.row];
    
    
   // _note = note;
    
    NSString *tyepString = @"Unknown type";
    if (note.notetext!=nil
        && note.notetext.length > 0)
    {
        tyepString = @"Text Note";
      //  _type = NoteTableViewCellText;
    }
    else if (note.noteimage !=nil
             && note.noteimage.length > 0)
    {
        tyepString = @"Image Note";
      //  _type = NoteTableViewCellImage;
    }
    else if(note.noterecording !=nil
            && note.noterecording.length > 0)
    {
        tyepString = @"Recording Note";
      //  _type = NoteTableViewCellRecording;
    }
    
     if (note.timestamp != nil
        && note.timestamp.length > 0)
    {
        NSTimeInterval timestamp = [note.timestamp doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
        NSString *dateString = [dateFormat stringFromDate:date];
        
          cell.nameLabel.text = [NSString stringWithFormat:@"%@ | %@ | %@", note.notetitle, tyepString, dateString];
    }
    else
    {
         cell.nameLabel.text = [NSString stringWithFormat:@"%@ | %@", note.notetitle, tyepString];
    }

    
   
    cell.nameLabel.numberOfLines = 0;
    cell.imgView.image = [UIImage imageNamed:@"documentIcon"];
    
    cell.delegate = self;
    
    cell.rightUtilityButtons = [self rightButtons];
    
    return cell;
    
    
}

#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    
    return title;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleNone;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Note *note = [_patient.notes objectAtIndex:indexPath.row];
    if (note)
    {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [[AppController sharedInstance] deleteProfileNote:note.noteID
                                               completion:^(BOOL success, NSString *message)
         {
             [SVProgressHUD dismiss];
             if (success)
             {
                 [self getPatientNotes];
             }
             else
             {
                 [UIAlertView showWithTitle:@"Failed" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
             }
         }];
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Note *note =  [_patient.notes objectAtIndex:indexPath.row];
    
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // _note = note;
    
    NSString *tyepString = @"Unknown type";
    if (note.notetext!=nil
        && note.notetext.length > 0)
    {
        tyepString = @"Text Note";
        //  _type = NoteTableViewCellText;
        [[TextPopup popUpViewText:note.notetext] showInKeyWindow];
    }
    else if (note.noteimage !=nil
             && note.noteimage.length > 0)
    {
        tyepString = @"Image Note";
        //  _type = NoteTableViewCellImage;
        [self showRemoteImage:note.noteimage];
    }
    else if(note.noterecording !=nil
            && note.noterecording.length > 0)
    {
        tyepString = @"Recording Note";
        //  _type = NoteTableViewCellRecording;
        [self playRemoteAudio:note.noterecording];
    }

    
      
}







- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    /*[rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
     title:@"More"];*/
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:227.0f/255.0f green:192.0f/255.0f blue:91.0f/255.0f alpha:1.0f]
                                                title:@"Edit Title"];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:239.0f/255.0f green:92.0f/255.0f blue:95.0f/255.0f alpha:1.0f]
                                                title:@"Delete"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:83.0f/255.0f green:184.0f/255.0f blue:195.0f/255.0f alpha:1.0]
                                                icon:[UIImage imageNamed:@"editIconGray"]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:83.0f/255.0f green:184.0f/255.0f blue:195.0f/255.0f alpha:1.0]
                                                icon:[UIImage imageNamed:@"rxIconGray"]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:83.0f/255.0f green:184.0f/255.0f blue:195.0f/255.0f alpha:1.0]
                                                icon:[UIImage imageNamed:@"calendarIconGray"]];
    
    
    return leftUtilityButtons;
}





#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"utility buttons closed");
            break;
        case 1:
            NSLog(@"left utility buttons open");
            break;
        case 2:
            NSLog(@"right utility buttons open");
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0: {
            NSLog(@"left button 0 was pressed");
            
            
        } break;
        case 1: {
            NSLog(@"left button 1 was pressed");
            
            
        }break;
        case 2: {
            NSLog(@"left button 2 was pressed");
            
        } break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
     case 0:
     {
     NSLog(@"More button was pressed");
     
         NSIndexPath *cellIndexPath = [_tableView indexPathForCell:cell];
         
         noteToUpdate = [_patient.notes objectAtIndex:cellIndexPath.row];
         
         /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Passcode"
                                                         message:@"Enter your old passcode (Leave blank if you do not have one)"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@"Next", nil];
         alert.alertViewStyle = UIAlertViewStyleDefault;
         [alert show];*/
         
         
         [UIAlertView showWithTitle:@"Note Title:"
                            message:nil
                              style:UIAlertViewStylePlainTextInput
                  cancelButtonTitle:@"Cancel"
                  otherButtonTitles:@[@"OK"]
                           tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                               if (buttonIndex == 1)
                               {
                                   
                                   NSString *noteTitle = [alertView textFieldAtIndex:0].text;
                                    [SVProgressHUD showWithStatus:@"Please wait..."];
                                   [[AppController sharedInstance] updateNoteTitle:noteTitle postid:noteToUpdate.noteID WithCompletion:^(BOOL success, NSString *message) {
                                       [SVProgressHUD dismiss];
                                        [self.view endEditing:true];
                                        if (success)
                                        {
                                            [self getPatientNotes];
                                        }
                                      
                                    }];
                                   
                               }}];
         
         isNoteUpdate = true;
     
     [cell hideUtilityButtonsAnimated:YES];
     break;
     }
     case 1:
     {
     // Delete button was pressed
     //NSIndexPath *cellIndexPath = [menuTable indexPathForCell:cell];
     
     //  [_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
     //[menuTable deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
          [cell hideUtilityButtonsAnimated:YES];
         NSIndexPath *cellIndexPath = [_tableView indexPathForCell:cell];
         
         noteToUpdate = [_patient.notes objectAtIndex:cellIndexPath.row];
         if (noteToUpdate)
         {
             [SVProgressHUD showWithStatus:@"Loading..."];
             [[AppController sharedInstance] deleteProfileNote:noteToUpdate.noteID
                                                    completion:^(BOOL success, NSString *message)
              {
                  [SVProgressHUD dismiss];
                  if (success)
                  {
                      [self getPatientNotes];
                  }
                  else
                  {
                      [UIAlertView showWithTitle:@"Failed" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                  }
              }];
         }

     break;
     }
     default:
     break;
     }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return YES;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}








#pragma  mark - NOTEs
- (void)showNoteChooseTypePopup
{
    [UIAlertView showWithTitle:@"Choose Note Type:"
                       message:nil
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"Text", @"Photo", @"Audio", @"Draw"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
     {
         if (buttonIndex == 0)
         {
             //cancel, do nothing
             
         }
         else if (buttonIndex == 1)
         {
             //Text
             [self showNoteTextInputPopup];
         }
         else if (buttonIndex == 2)
         {
             //Photo
             [self showNotePhotoInputPopup];
         }
         else if (buttonIndex == 3)
         {
             //Audio
             [self showNoteAudioInputPopup];
         } else if (buttonIndex == 4)
         {
             //Audio
             [self showDrawInputPopup];
         }
     }];
}

- (void)showDrawInputPopup
{
   // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    FreeDrawingViewController  *vc = [[FreeDrawingViewController alloc] initWithNibName:@"FreeDrawingViewController" bundle:nil];
    
    vc.patientID = _patient.postid;
    
    // vc.delegate = self;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)showNoteTextInputPopup
{
    __block NSString *stringNoteText = @"";
    [UIAlertView showWithTitle:@"Input Note:"
                       message:nil
                         style:UIAlertViewStylePlainTextInput
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"OK"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              stringNoteText = [alertView textFieldAtIndex:0].text;
                              //[noteString length];
                              // [self addTextNote:noteString];
                              [UIAlertView showWithTitle:@"Note Title:"
                                                 message:nil
                                                   style:UIAlertViewStylePlainTextInput
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@[@"OK"]
                                                tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                    if (buttonIndex == 1)
                                                    {
                                                        
                                                        NSString *noteTitle = [alertView textFieldAtIndex:0].text;
                                                        [self addTextNote:stringNoteText title:noteTitle];
                                                        
                                                    }}];
                          }
                      }];
}

- (void)showNotePhotoInputPopup
{
    [UIAlertView showWithTitle:@"Pick Photo From:"
                       message:nil
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"Camera", @"Photo Library"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              [self takePhotoFrom:UIImagePickerControllerSourceTypeCamera];
                          }
                          else if (buttonIndex == 2)
                          {
                              [self takePhotoFrom:UIImagePickerControllerSourceTypePhotoLibrary];
                          }
                      }];
}

- (void)takePhotoFrom:(UIImagePickerControllerSourceType)type
{
    if ([UIImagePickerController isSourceTypeAvailable:type])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        [UIAlertView showWithTitle:nil
                           message:@"Source is not available."
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil
                          tapBlock:nil];
    }
}

- (void)showNoteAudioInputPopup
{
    [UIAlertView showWithTitle:@"Pick Audio From:"
                       message:nil
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"Recording"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              [self recordingAudio];
                          }
                          else if (buttonIndex == 2)
                          {
                              [self takeAudioFrom:MPMediaTypeAnyAudio];
                          }
                      }];
}

- (void)takeAudioFrom:(MPMediaType)type
{
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:type];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = NO;
    [self presentViewController:mediaPicker animated:YES completion:nil];
}

- (void)recordingAudio
{
    IQAudioRecorderController *controller = [[IQAudioRecorderController alloc] init];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
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
        [UIAlertView showWithTitle:@"Failed"
                           message:@"Image download failed."
                 cancelButtonTitle:@"Ok"
                 otherButtonTitles:nil tapBlock:nil];
    }];
    [requestOperation start];
    
    
    
}
#pragma mark - Add Note API
- (void)addImageNote:(UIImage *)image
{
    [UIAlertView showWithTitle:@"Note Title:"
                       message:nil
                         style:UIAlertViewStylePlainTextInput
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"OK"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              
                              NSString *noteTitle = [alertView textFieldAtIndex:0].text;
                              //[self addTextNote:stringNoteText title:noteTitle];
                              [[AppController sharedInstance] addProfilePhotoNote:image
                                                                        ToPatient:_patient.postid
                                                                            title:noteTitle
                                                                       completion:^(BOOL success, NSString *message)
                               {
                                   [self.view endEditing:true];
                                   if (success)
                                   {
                                       [self getPatientNotes];
                                   }
                                   [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                               }];
                              
                          }}];
    
    
}

- (void)addTextNote:(NSString *)textNote title:(NSString *)title
{
    [[AppController sharedInstance] addProfileTextNote:textNote
                                             ToPatient:_patient.postid
                                                 title:title
                                            completion:^(BOOL success, NSString *message)
     {
         [self.view endEditing:true];
         if (success)
         {
             [self getPatientNotes];
         }
         
         [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
     }];
}

- (void)addAudioNote:(NSString *)audioFilePath
{
    /*[[AppController sharedInstance] addProfileAudioNote:audioFilePath
     ToPatient:_patient.postid
     completion:^(BOOL success, NSString *message)
     {
     if (success)
     {
     [self getPatientNotes];
     }
     [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
     }];*/
    
    [UIAlertView showWithTitle:@"Note Title:"
                       message:nil
                         style:UIAlertViewStylePlainTextInput
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"OK"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              
                              NSString *noteTitle = [alertView textFieldAtIndex:0].text;
                              [[AppController sharedInstance] addProfileAudioNote:audioFilePath
                                                                        ToPatient:_patient.postid
                                                                            title:noteTitle
                                                                       completion:^(BOOL success, NSString *message)
                               {
                                   [self.view endEditing:true];
                                   if (success)
                                   {
                                       [self getPatientNotes];
                                   }
                                   [UIAlertView showWithTitle:nil message:message cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                               }];
                              
                          }}];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self addImageNote:chosenImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - MPMediaPickerControllerDelegate
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker
  didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //TODO: ADD Audio to note
    NSLog(@"You picked : %@",mediaItemCollection);
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IQAudioRecorderControllerDelegate

-(void)audioRecorderController:(IQAudioRecorderController*)controller didFinishWithAudioAtPath:(NSString*)filePath
{
    [self addAudioNote:filePath];
}

-(void)audioRecorderControllerDidCancel:(IQAudioRecorderController*)controller
{
    
}

#pragma mark - movieFinishedCallback
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
