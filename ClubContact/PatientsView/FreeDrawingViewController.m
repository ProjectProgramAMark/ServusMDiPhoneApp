//
//  FreeDrawingViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/1/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "FreeDrawingViewController.h"
#import "UIAlertView+Blocks.h"

@interface FreeDrawingViewController ()

@end

@implementation FreeDrawingViewController


@synthesize mainImage;
@synthesize tempDrawImage;
@synthesize patientID;
@synthesize containerView;
- (void)viewDidLoad
{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 3.0;
    opacity = 1.0;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
   // self.navigationItem.rightBarButtonItem = notiButtonItem;

    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                  target:self
                                  action:@selector(addFreeDraw:)];
    
    addButton.tintColor = [UIColor whiteColor];
    
    
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settings:)];
    
    settingButton.tintColor = [UIColor whiteColor];
    
    eraseButton =[[UIBarButtonItem alloc] initWithTitle:@"Eraser Off" style:UIBarButtonItemStylePlain target:self action:@selector(enableErase:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:addButton, settingButton,nil];
 //    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:  cancelButton, eraseButton, nil];
    
    self.title = @"Draw";
    isEraserON = false;
    
    [super viewDidLoad];
}



- (void)viewDidUnload
{
    [self setMainImage:nil];
    [self setTempDrawImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)goBackToChose:(id)sender {
  
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)addFreeDraw:(id)sender {
   /* eyeExam.patientid = patientID;
    [SVProgressHUD showWithStatus:@"Adding..."];
    [[AppController sharedInstance] addEyeExamForPatient:eyeExam WithCompletion:^(BOOL success, NSString *message) {
        [SVProgressHUD dismiss];
        if (success)
        {
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        // [conditionTable.footer endRefreshing];
        // [conditionTable.header endRefreshing];
    }];*/
    UIGraphicsBeginImageContextWithOptions(self.containerView.bounds.size, NO, 0.0);
    [containerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [UIAlertView showWithTitle:@"Note Title:"
                       message:nil
                         style:UIAlertViewStylePlainTextInput
             cancelButtonTitle:@"Cancel"
             otherButtonTitles:@[@"OK"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == 1)
                          {
                              
                              NSString *noteTitle = [alertView textFieldAtIndex:0].text;
                              [SVProgressHUD showWithStatus:@"Adding..."];
                              [[AppController sharedInstance] addProfilePhotoNote:SaveImage
                                                                        ToPatient:patientID
                                                                            title:noteTitle
                                                                       completion:^(BOOL success, NSString *message)
                               {
                                   if (success)
                                   {
                                       [self.navigationController popViewControllerAnimated:YES];
                                       [UIAlertView showWithTitle:nil message:@"Drawing added" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                                   } else {
                                       [UIAlertView showWithTitle:nil message:@"Failed to add this drawing" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
                                   }
                                   
                               }];

                              
                              
                          }}];

   /* [SVProgressHUD showWithStatus:@"Adding..."];
    [[AppController sharedInstance] addProfilePhotoNote:SaveImage
                                              ToPatient:patientID
                                                  title:@""
                                             completion:^(BOOL success, NSString *message)
     {
         if (success)
         {
             [self.navigationController popViewControllerAnimated:YES];
             [UIAlertView showWithTitle:nil message:@"Drawing added" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
         } else {
             [UIAlertView showWithTitle:nil message:@"Failed to add this drawing" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
         }
         
     }];*/
}



- (IBAction)pencilPressed:(id)sender {
    
    UIButton * PressedButton = (UIButton*)sender;
    
    switch(PressedButton.tag)
    {
        case 0:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 1:
            red = 105.0/255.0;
            green = 105.0/255.0;
            blue = 105.0/255.0;
            break;
        case 2:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case 4:
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5:
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 6:
            red = 51.0/255.0;
            green = 204.0/255.0;
            blue = 255.0/255.0;
            break;
        case 7:
            red = 160.0/255.0;
            green = 82.0/255.0;
            blue = 45.0/255.0;
            break;
        case 8:
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 9:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
    }
}

- (IBAction)eraserPressed:(id)sender {
    
    red = 255.0/255.0;
    green = 255.0/255.0;
    blue = 255.0/255.0;
    opacity = 1.0;
}

- (IBAction)reset:(id)sender {
    
    self.mainImage.image = nil;
    
}
- (IBAction)enableErase:(id)sender {
    if (isEraserON == false) {
        isEraserON = true;
        eraseButton.title = @"Eraser On";
        
   
    } else {
        isEraserON = false;
        eraseButton.title = @"Eraser Off";
       
        
    }
    
}


- (IBAction)settings:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    
     FreeDrawSettingViewController * settingsVC = [[FreeDrawSettingViewController alloc] initWithNibName:@"FreeDrawSettingViewController" bundle:nil];
    settingsVC.delegate = self;
    settingsVC.brush = brush;
    settingsVC.opacity = opacity;
    settingsVC.red = red;
    settingsVC.green = green;
    settingsVC.blue = blue;
    [self.navigationController pushViewController:settingsVC animated:YES];
}

- (IBAction)save:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save to Camera Roll", @"Tweet it!", @"Cancel", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        
        UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, NO, 0.0);
        [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
        UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    
   
        
    } else if(buttonIndex == 0) {
        
        UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, NO, 0.0);
        [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
        UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
    
    if (isEraserON == true) {
        self.tempDrawImage.image = self.mainImage.image;
        self.mainImage.image = nil;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    if (isEraserON == false) {
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
        
    } else {
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
        
    }
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
       // CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        if (isEraserON == false) {
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
            
        } else {
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
        }
        

        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    
    FreeDrawSettingViewController * settingsVC = (FreeDrawSettingViewController  *)[sb instantiateViewControllerWithIdentifier:@"FreeDrawSettingViewController"];
    settingsVC.delegate = self;
    settingsVC.brush = brush;
    settingsVC.opacity = opacity;
    settingsVC.red = red;
    settingsVC.green = green;
    settingsVC.blue = blue;
     [self.navigationController pushViewController:settingsVC animated:YES];
    
}

#pragma mark - SettingsViewControllerDelegate methods

- (void)closeSettings:(id)sender {
    
    brush = ((FreeDrawSettingViewController*)sender).brush;
    opacity = ((FreeDrawSettingViewController*)sender).opacity;
    red = ((FreeDrawSettingViewController *)sender).red;
    green = ((FreeDrawSettingViewController*)sender).green;
    blue = ((FreeDrawSettingViewController*)sender).blue;
   // [self dismissViewControllerAnimated:YES completion:nil];
     [self.navigationController popViewControllerAnimated:YES];
}

@end
