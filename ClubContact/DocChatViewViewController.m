//
//  DocChatViewViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/13/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DocChatViewViewController.h"
#import "SPHTextBubbleCell.h"
#import "SPHMediaBubbleCell.h"
#import "Constantvalues.h"
#import "SPH_PARAM_List.h"
#import "AppController.h"
#import "EXPhotoViewer.h"


@interface DocChatViewViewController ()<TextCellDelegate,MediaCellDelegate, UIImagePickerControllerDelegate>
{
    NSMutableArray *sphBubbledata;
    BOOL isfromMe;
    NSMutableArray *dataArray;
    
    
    int keyboardHeight;
    
    UIImage *selectedImage;
    
    NSTimer *repeatTimer;
    NSTimer *repeatTimer2;
    
    int offSetKeyboard;
    
    CGRect keyboardFrame;
    
    BOOL isOffSet;
    int commentOffset2 ;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}



@end

@implementation DocChatViewViewController


@synthesize patientID;
@synthesize delegate;
@synthesize msgSession;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isfromMe=YES;
    sphBubbledata =[[NSMutableArray alloc]init];
    dataArray = [[NSMutableArray alloc] init];
    isOffSet = false;
    
    self.chattable.backgroundColor = [UIColor clearColor];
    
    [self SetupDummyMessages];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.chattable addGestureRecognizer:tap];
    self.chattable.backgroundColor =[UIColor clearColor];
    self.chattable.delegate = self;
    self.chattable.dataSource = self;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.messageField.leftView = paddingView;
    self.messageField.leftViewMode = UITextFieldViewModeAlways;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Close Session" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop)];
   // self.navigationItem.rightBarButtonItem = cancelButton;
    
   /* UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPop)];
    self.navigationItem.leftBarButtonItem= cancelButton;*/
    
   /* UIBarButtonItem *cancelButton2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backarrow2"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];*/
     UIBarButtonItem *cancelButton2 = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    self.navigationItem.leftBarButtonItem = cancelButton2;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"MESSAGING";
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:)
                   name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    repeatTimer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                   target: self
                                                 selector:@selector(loadMessages2)
                                                 userInfo: nil repeats:YES];
    
    repeatTimer2 = [NSTimer scheduledTimerWithTimeInterval: 10.0
                                                    target: self
                                                  selector:@selector(getMessageStatus2)
                                                  userInfo: nil repeats:YES];
    
    [self performSelector:@selector(loadMessages2) withObject:nil afterDelay:5.0];
    [self performSelector:@selector(getMessageStatus2) withObject:nil afterDelay:10.0];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
}




- (void)keyboardDidShow:(NSNotification *)notification
{
    // keyboard frame is in window coordinates
    NSDictionary *userInfo = [notification userInfo];
    keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // convert own frame to window coordinates, frame is in superview's coordinates
    CGRect ownFrame = [self.view.window convertRect:self.view.frame fromView:self.view.superview];
    
    // calculate the area of own frame that is covered by keyboard
    CGRect coveredFrame = CGRectIntersection(ownFrame, keyboardFrame);
    
    // now this might be rotated, so convert it back
    coveredFrame = [self.view.window convertRect:coveredFrame toView:self.view.superview];
    
    // set inset to make up for covered array at bottom
    //  self.contentInset = UIEdgeInsetsMake(0, 0, coveredFrame.size.height, 0);
    //self.scrollIndicatorInsets = self.contentInset;
    offSetKeyboard = keyboardFrame.size.height;
    int someotherOffSet = 100 + (self.msgInPutView.frame.size.height - 40.0f);
    int commentOffset = (windowHeight - someotherOffSet) - offSetKeyboard;
    commentOffset2 = commentOffset;
    if (isOffSet == true) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             //  commentContainerView.frame = CGRectMake(0, (windowHeight - 42) - offSetKeyboard, commentContainerView.frame.size.width, commentContainerView.frame.size.height);
             self.msgInPutView.frame = CGRectMake(0, commentOffset, self.msgInPutView.frame.size.width, self.msgInPutView.frame.size.height);
             
         }     completion:^(BOOL finished)
         {
         }];
        
    }
}




- (void)viewDidAppear:(BOOL)animated {
    [self loadMessages];
    [self getMessageStatus];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [repeatTimer invalidate];
    [repeatTimer2 invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    [repeatTimer invalidate];
    [repeatTimer2 invalidate];
    [self.navigationController popViewControllerAnimated:YES];
  //  [self.delegate refreshPatientsInfo3];
}

- (void)cancelPop {
   
    [[AppController sharedInstance] closeMSGSession:msgSession.pid sessionID:msgSession.postid completion:^(BOOL success, NSString *message)  {
        
        if (success) {
             [repeatTimer invalidate];
            [repeatTimer2 invalidate];
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate refreshPatientsInfo3];
        }
        
    }];
}

- (void)goBack {
    [repeatTimer invalidate];
    [repeatTimer2 invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadMessages {
  //  [repeatTimer invalidate];
    [SVProgressHUD showWithStatus:@"Loading..."];
   /* [[AppController sharedInstance] getMessagesBySession:msgSession.pid sessionID:msgSession.postid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions)
     {
         [SVProgressHUD dismiss];
         if (success)
         {
             // [_patient.conditions removeAllObjects];
             // [_patient.conditions addObjectsFromArray:conditions];
             [dataArray removeAllObjects];
             [dataArray addObjectsFromArray:conditions];
             [_chattable reloadData];
             
             repeatTimer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                            target: self
                                                          selector:@selector(loadMessages2)
                                                          userInfo: nil repeats:YES];
             
         }
     }];*/
    
    //[[AppController sharedInstance] getDoc]
    
    [[AppController sharedInstance] getMessagesForDoc:msgSession.pid sessionID:msgSession.postid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            // [_patient.conditions removeAllObjects];
            // [_patient.conditions addObjectsFromArray:conditions];
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:conditions];
            [_chattable reloadData];
            
          /*  repeatTimer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                           target: self
                                                         selector:@selector(loadMessages2)
                                                         userInfo: nil repeats:YES];*/
            
        }
        
    }];
    
}

- (void)loadMessages2 {
   // [repeatTimer invalidate];
    //[SVProgressHUD showWithStatus:@"Loading..."];
       [[AppController sharedInstance] getMessagesForDoc:msgSession.pid sessionID:msgSession.postid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
         //   [SVProgressHUD dismiss];
         if (success)
         {
             // [_patient.conditions removeAllObjects];
             // [_patient.conditions addObjectsFromArray:conditions];
             
             [dataArray removeAllObjects];
             [dataArray addObjectsFromArray:conditions];
             [_chattable reloadData];
             
           /*  repeatTimer = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                                            target: self
                                                          selector:@selector(loadMessages2)
                                                          userInfo: nil repeats:YES];*/
         }
     }];
    
}

- (void)getMessageStatus {
    //[repeatTimer2 invalidate];
    /*[[AppController sharedInstance] getMSGSessionsByID:msgSession.did sessionID:msgSession.postid WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
        
        if (success) {
            
            if ([msgsession.mstatus intValue] == 3) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Closed Session" message:@"This session is closed by the patient" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            repeatTimer2 = [NSTimer scheduledTimerWithTimeInterval: 10.0
                                                            target: self
                                                          selector:@selector(getMessageStatus2)
                                                          userInfo: nil repeats:YES];
        }
    }];*/
    
    [[AppController sharedInstance] getDocMSGSessionsByID:msgSession.did sessionID:msgSession.postid WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
        
        
        if (success) {
            
            if ([msgsession.mstatus intValue] == 3) {
                
             //   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Closed Session" message:@"This session is closed by the patient" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
              //  [alert show];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
           /* repeatTimer2 = [NSTimer scheduledTimerWithTimeInterval: 10.0
                                                            target: self
                                                          selector:@selector(getMessageStatus2)
                                                          userInfo: nil repeats:YES];*/
        }

        
    }];
}

- (void)getMessageStatus2 {
   // [repeatTimer2 invalidate];
    [[AppController sharedInstance]  getDocMSGSessionsByID:msgSession.did sessionID:msgSession.postid WithCompletion:^(BOOL success, NSString *message, MSGSession *msgsession) {
        
        if (success) {
            if ([msgsession.mstatus intValue] == 3) {
                //[repeatTimer2 invalidate];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Closed Session" message:@"This session is closed by the patient" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                
             /*   repeatTimer2 = [NSTimer scheduledTimerWithTimeInterval: 10.0
                                                                target: self
                                                              selector:@selector(getMessageStatus2)
                                                              userInfo: nil repeats:YES];*/
                
            }
            
            
        }
    }];
}



#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //SPH_PARAM_List *feed_data=[[SPH_PARAM_List alloc]init];
    //feed_data=[sphBubbledata objectAtIndex:indexPath.row];
    
    Messages *message = [dataArray objectAtIndex:indexPath.row];
    
    if (message.msgimage.length != 0)  return 180;
    
    CGSize labelSize =[message.message boundingRectWithSize:CGSizeMake(226.0f, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:14.0f] }
                                                    context:nil].size;
    return labelSize.height + 30 + TOP_MARGIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *L_CellIdentifier = @"SPHTextBubbleCell";
    static NSString *R_CellIdentifier = @"SPHMediaBubbleCell";
    
    // SPH_PARAM_List *feed_data=[[SPH_PARAM_List alloc]init];
    /// feed_data=[sphBubbledata objectAtIndex:indexPath.row];
    
    Messages *message = [dataArray objectAtIndex:indexPath.row];
    
    if (message.msgimage.length == 0)
    {
        SPHTextBubbleCell *cell = (SPHTextBubbleCell *) [tableView dequeueReusableCellWithIdentifier:L_CellIdentifier];
        if (cell == nil)
        {
            cell = [[SPHTextBubbleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:L_CellIdentifier];
        }
        
        if ([message.sendertype isEqual:@"Patient"]) {
            cell.bubbletype= @"RIGHT";
        } else {
            cell.bubbletype= @"LEFT";
        }
        
        double unixTimeStamp =[message.sentdate doubleValue];
        NSTimeInterval _interval=unixTimeStamp;
        NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
        
        NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
        NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
        NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
        
        //   NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
        
        /* NSString *dateString = [NSDateFormatter localizedStringFromDate:destinationDate
         dateStyle:NSDateFormatterShortStyle
         timeStyle:NSDateFormatterShortStyle];*/
        
        NSString *dateString = [NSDateFormatter localizedStringFromDate:sourceDate
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        
        cell.textLabel.text = message.message;
        cell.textLabel.tag=indexPath.row;
        cell.timestampLabel.text = dateString;
        cell.CustomDelegate=self;
        //   cell.AvatarImageView.image=([feed_data.chat_media_type isEqualToString:kTextByme])?[UIImage imageNamed:@"ProfilePic"]:[UIImage imageNamed:@"person"];
        if ([message.sendertype isEqual:@"Patient"]) {
            [cell.AvatarImageView setImageWithURL:[NSURL URLWithString:message.fromprofilepic]];
        } else {
            [cell.AvatarImageView setImageWithURL:[NSURL URLWithString:message.fromprofilepic]];
        }
        
        return cell;
        
    }
    
    SPHMediaBubbleCell *cell = (SPHMediaBubbleCell *) [tableView dequeueReusableCellWithIdentifier:R_CellIdentifier];
    if (cell == nil)
    {
        cell = [[SPHMediaBubbleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:R_CellIdentifier];
    }
    
     Doctor *doc = [Doctor getFromUserDefault];
    
    if (![message.fromuid isEqual:doc.uid]) {
        cell.bubbletype= @"RIGHT";
    } else {
        cell.bubbletype= @"LEFT";
    }
    
    double unixTimeStamp =[message.sentdate doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate* sourceDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:destinationDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    
    cell.textLabel.text = message.message;
    cell.messageImageView.tag=indexPath.row;
    [cell.messageImageView setImageWithURL:[NSURL URLWithString:message.msgimage]];
    cell.CustomDelegate=self;
    cell.timestampLabel.text = dateString;
    if ([message.sendertype isEqual:@"Patient"]) {
        [cell.AvatarImageView setImageWithURL:[NSURL URLWithString:message.fromprofilepic]];
    } else {
        [cell.AvatarImageView setImageWithURL:[NSURL URLWithString:message.fromprofilepic]];
    }
    [cell.AvatarImageView setImageWithURL:[NSURL URLWithString:message.fromprofilepic]];

    
    return cell;
}



//=========***************************************************=============
#pragma mark - CELL CLICKED  PROCEDURE
//=========***************************************************=============


-(void)textCellDidTapped:(SPHTextBubbleCell *)tesxtCell AndGesture:(UIGestureRecognizer*)tapGR;
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tesxtCell.textLabel.tag inSection:0];
    NSLog(@"Forward Pressed =%@ and IndexPath=%@",tesxtCell.textLabel.text,indexPath);
    [tesxtCell showMenu];
}
// 7684097905

-(void)cellCopyPressed:(SPHTextBubbleCell *)tesxtCell
{
    NSLog(@"copy Pressed =%@",tesxtCell.textLabel.text);
    
}

-(void)cellForwardPressed:(SPHTextBubbleCell *)tesxtCell
{
    NSLog(@"Forward Pressed =%@",tesxtCell.textLabel.text);
    
}
-(void)cellDeletePressed:(SPHTextBubbleCell *)tesxtCell
{
    NSLog(@"Delete Pressed =%@",tesxtCell.textLabel.text);
    
}

//=========*******************  BELOW FUNCTIONS FOR IMAGE  **************************=============

-(void)mediaCellDidTapped:(SPHMediaBubbleCell *)mediaCell AndGesture:(UIGestureRecognizer*)tapGR;
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:mediaCell.messageImageView.tag inSection:0];
    NSLog(@"Media cell Pressed  and IndexPath=%@",indexPath);
    
    Messages *message = [dataArray objectAtIndex:indexPath.row];
    
    [self showRemoteImage:message.msgimage];
    //[mediaCell showMenu];
}

-(void)mediaCellCopyPressed:(SPHMediaBubbleCell *)mediaCell
{
    NSLog(@"copy Pressed =%@",mediaCell.messageImageView.image);
    
}

-(void)mediaCellForwardPressed:(SPHMediaBubbleCell *)mediaCell
{
    NSLog(@"Forward Pressed =%@",mediaCell.messageImageView.image);
    
}
-(void)mediaCellDeletePressed:(SPHMediaBubbleCell *)mediaCell
{
    NSLog(@"Delete Pressed =%@",mediaCell.messageImageView.image);
    
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark               KEYBOARD UPDOWN EVENT
/////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

/*

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (dataArray.count >2) {
        [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.0];
    }
    CGRect tableviewframe=self.chattable.frame;
    tableviewframe.size.height-=210;
    
    [UIView animateWithDuration:0.25 animations:^{
      //  self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-345, self.view.frame.size.width, 50);
        //  self.chattable.frame=tableviewframe;
    }];
    
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect tableviewframe=self.chattable.frame;
    tableviewframe.size.height+=210;
    [UIView animateWithDuration:0.25 animations:^{
        self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-50,  self.view.frame.size.width, 50);
        //    self.chattable.frame=tableviewframe;
    }];
    if (sphBubbledata.count>2) {
        [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.25];
    }
    
    
}*/
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    isOffSet = true;
    
    return  true;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    isOffSet = true;
    if (dataArray.count >2) {
        [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.0];
    }
    CGRect tableviewframe=self.chattable.frame;
    tableviewframe.size.height-=210;
    
    [UIView animateWithDuration:0.25 animations:^{
        //  self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-345, self.view.frame.size.width, 50);
        //  self.chattable.frame=tableviewframe;
    }];
    
    
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         if (isOffSet == true) {
             
             
             isOffSet = false;
             
             self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-40,  self.view.frame.size.width, 40);
         }
         
         
     }
     
                     completion:^(BOOL finished)
     {
     }];
    
    
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    isOffSet = false;
    CGRect tableviewframe=self.chattable.frame;
    tableviewframe.size.height+=210;
    [UIView animateWithDuration:0.25 animations:^{
        ///self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-50,  self.view.frame.size.width, 50);
        //    self.chattable.frame=tableviewframe;
    }];
    if (sphBubbledata.count>2) {
        [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.25];
    }
    
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}






- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    isOffSet = true;
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         if (isOffSet == true) {
             
             
             isOffSet = false;
             
             self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-self.msgInPutView.frame.size.height,  self.view.frame.size.width, self.msgInPutView.frame.size.height);
             
         }
         
         
     }
     
                     completion:^(BOOL finished)
     {
     }];
    
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    // isOffSet = false;
    isOffSet = false;
    CGRect tableviewframe=self.chattable.frame;
    tableviewframe.size.height+=210;
    [UIView animateWithDuration:0.25 animations:^{
        ///self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-50,  self.view.frame.size.width, 50);
        //    self.chattable.frame=tableviewframe;
    }];
    if (sphBubbledata.count>2) {
        [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.25];
    }
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField text];
    NSFont *font = [textField font];
    CGFloat width = [textField frame].size.width;
    
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 9999) lineBreakMode:UILineBreakModeWordWrap];
    
    self.messageField.frame = CGRectMake(42.0f, 6.0f, self.messageField.frame.size.width, 30 + size.height);
    
    self.messageField2.frame = CGRectMake(42.0f, 6.0f, self.messageField2.frame.size.width, 30 + size.height);
    
    self.msgInPutView.frame = CGRectMake(0, commentOffset2 -  size.height, self.msgInPutView.frame.size.width, 40 + size.height);
    // self.msgInPutView.frame =
    
    return YES;
}



-(void)textViewDidChange:(UITextView *)textView
{
    NSString *text = [textView text];
    NSFont *font = [textView font];
    CGFloat width = [textView frame].size.width;
    
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 9999) lineBreakMode:UILineBreakModeWordWrap];
    
    if (size.height > 27.0f) {
        
        
        self.messageField.frame = CGRectMake(42.0f, 6.0f, self.messageField.frame.size.width, 30 + size.height);
        
        self.messageField2.frame = CGRectMake(42.0f, 6.0f, self.messageField2.frame.size.width, 30 + size.height);
        
        self.msgInPutView.frame = CGRectMake(0, commentOffset2 -  size.height, self.msgInPutView.frame.size.width, 40 + size.height);
        
    } else {
       
            self.messageField.frame = CGRectMake(42.0f, 6.0f, self.messageField.frame.size.width, 30 );
            
            self.messageField2.frame = CGRectMake(42.0f, 6.0f, self.messageField2.frame.size.width, 30);
            
            self.msgInPutView.frame = CGRectMake(0, (self.view.frame.size.height - offSetKeyboard - 40)  , self.msgInPutView.frame.size.width, 40);
        
    }
    
    
    
    
    /* Adjust text view width with "size.height" */
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqual:@"\n"]) {
        [textView resignFirstResponder];
    }
    
    return YES;
}







/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark       SEND MESSAGE PRESSED
/////////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)sendMessageNow:(id)sender
{
    NSString *messageText = self.messageField2.text;
    self.messageField2.text = @"";
    
    
    if (![self.messageField2 isFirstResponder]) {
        self.msgInPutView.frame = CGRectMake(0, self.view.frame.size.height- 40, self.msgInPutView.frame.size.width, 40);
        
        self.messageField.frame = CGRectMake(42.0f, 6.0f, self.messageField.frame.size.width, 30);
        
        self.messageField2.frame = CGRectMake(42.0f, 6.0f, self.messageField2.frame.size.width, 30);
        
        self.msgInPutView.frame = CGRectMake(0, self.view.frame.size.height- 40, self.msgInPutView.frame.size.width, 40);
    } else {
       /* self.msgInPutView.frame=CGRectMake(0,commentOffset2-40,  self.view.frame.size.width, self.msgInPutView.frame.size.height);
        
        self.messageField.frame = CGRectMake(42.0f, 6.0f, self.messageField.frame.size.width, 30);
        
        self.messageField2.frame = CGRectMake(42.0f, 6.0f, self.messageField2.frame.size.width, 30);
        
        self.msgInPutView.frame=CGRectMake(0,commentOffset2- 40,  self.view.frame.size.width, self.msgInPutView.frame.size.height);*/
    }
    
    if (messageText.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a message to send" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else {
        [SVProgressHUD showWithStatus:@"Sending..."];
        [[AppController sharedInstance] addMessageToDoc:msgSession.pid messagetext:messageText msgimg:nil sessionID:msgSession.postid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            [SVProgressHUD dismiss];
            if (success)
            {
                [repeatTimer invalidate];
                [self loadMessages];
            }
        }];
    }
}


- (IBAction)selectImageToSend:(UIButton *)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Send Image" message:@"Select an image source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //  isProfileUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // isProfileUpdate = true;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
        
        
        
        
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //  [self dismissViewControllerAnimated:self completion:nil];
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    
    UIPopoverPresentationController *popPresenter = [actionSheet
                                                     popoverPresentationController];
    popPresenter.sourceView = sender;
    popPresenter.sourceRect = sender.bounds;
    [self presentViewController:actionSheet animated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    selectedImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [SVProgressHUD showWithStatus:@"Sending..."];
    [[AppController sharedInstance] addMessageToDoc:msgSession.pid messagetext:@"" msgimg:selectedImage sessionID:msgSession.postid WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
            [repeatTimer invalidate];
            [self loadMessages];
        }
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    selectedImage = nil;
    
    
}

/////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)messageSent:(NSString*)rownum
{
    int rowID=[rownum intValue];
    
    SPH_PARAM_List *feed_data=[[SPH_PARAM_List alloc]init];
    feed_data=[sphBubbledata objectAtIndex:rowID];
    
    [sphBubbledata  removeObjectAtIndex:rowID];
    feed_data.chat_send_status=kSent;
    [sphBubbledata insertObject:feed_data atIndex:rowID];
    
    // [self.chattable reloadData];
    
    NSArray *indexPaths = [NSArray arrayWithObjects:
                           [NSIndexPath indexPathForRow:rowID inSection:0],
                           // Add some more index paths if you want here
                           nil];
    BOOL animationsEnabled = [UIView areAnimationsEnabled];
    [UIView setAnimationsEnabled:NO];
    [self.chattable reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [UIView setAnimationsEnabled:animationsEnabled];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)scrollTableview
{
    @try {
        NSInteger item = [self.chattable numberOfRowsInSection:0] - 1;
        NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:0];
        if (dataArray.count > 1) {
            [self.chattable scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}


/////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)adddMediaBubbledata:(NSString*)mediaType  mediaPath:(NSString*)mediaPath mtime:(NSString*)messageTime thumb:(NSString*)thumbUrl  downloadstatus:(NSString*)downloadstatus sendingStatus:(NSString*)sendingStatus msg_ID:(NSString*)msgID
{
    
    SPH_PARAM_List *feed_data=[[SPH_PARAM_List alloc]init];
    feed_data.chat_message=mediaPath;
    feed_data.chat_date_time=messageTime;
    feed_data.chat_media_type=mediaType;
    feed_data.chat_send_status=sendingStatus;
    feed_data.chat_Thumburl=thumbUrl;
    feed_data.chat_downloadStatus=downloadstatus;
    feed_data.chat_messageID=msgID;
    [sphBubbledata addObject:feed_data];
}


/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark  GENERATE RANDOM ID to SAVE IN LOCAL
/////////////////////////////////////////////////////////////////////////////////////////////////////


-(NSString *) genRandStringLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}



/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark       SETUP DUMMY MESSAGE / REPLACE THEM IN LIVE
/////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)SetupDummyMessages
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    //  msg_ID  Any Random ID
    
    //  mediaPath  : Your Message  or  Path of the Image
    
    [self adddMediaBubbledata:kTextByme mediaPath:@"Hi, check this new control!" mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
    //[self performSelector:@selector(messageSent:) withObject:@"0" afterDelay:1];
    
    [self adddMediaBubbledata:kTextByOther mediaPath:@"Hello! How are you?" mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
    
    [self adddMediaBubbledata:kTextByme mediaPath:@"I'm doing Great!" mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
    
    [self adddMediaBubbledata:kImagebyme mediaPath:@"ImageUrl" mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
    
    [self adddMediaBubbledata:kImagebyOther mediaPath:@"Yeah its cool!" mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
    
    [self adddMediaBubbledata:kTextByme mediaPath:@"Supports Image too." mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
    
    [self adddMediaBubbledata:kTextByOther mediaPath:@"Yup. I like the tail part of it." mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
    
    [self adddMediaBubbledata:kImagebyme mediaPath:@"ImageUrl" mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSending msg_ID:@"ABFCXYZ"];
    
    [self adddMediaBubbledata:kImagebyOther mediaPath:@"Hi, check this new control!" mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
    [self adddMediaBubbledata:kTextByme mediaPath:@"lets meet some time for dinner! hope you will like it." mtime:[formatter stringFromDate:date] thumb:@"" downloadstatus:@"" sendingStatus:kSent msg_ID:[self genRandStringLength:7]];
    
    
    
    [self.chattable reloadData];
}



- (void)showRemoteImage:(NSString *)imageLink
{
    [SVProgressHUD showWithStatus:@"Loading..."];
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




@end
