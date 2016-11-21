//
//  DrawingEyeExamViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/1/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DrawingEyeExamViewController.h"

@interface DrawingEyeExamViewController ()

@end

@implementation DrawingEyeExamViewController


@synthesize mainImage;
@synthesize tempDrawImage;
@synthesize mainImage2;
@synthesize mainImage3;
@synthesize tempDrawImage2;
@synthesize tempDrawImage3;
@synthesize patientID;
@synthesize containerView;
@synthesize containerView2;
@synthesize containerView3;

- (void)viewDidLoad
{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 1.0;
    opacity = 1.0;
    catType = 0;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                  target:self
                                  action:@selector(addFreeDraw:)];
    UIBarButtonItem *settingButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settings:)];
    zoomButton = [[UIBarButtonItem alloc] initWithTitle:@"Zoom Off" style:UIBarButtonItemStylePlain target:self action:@selector(enableZoom:)];
    
     eraseButton =[[UIBarButtonItem alloc] initWithTitle:@"Eraser Off" style:UIBarButtonItemStylePlain target:self action:@selector(enableErase:)];
    
    addButton.tintColor = [UIColor whiteColor];
    settingButton.tintColor = [UIColor whiteColor];
    zoomButton.tintColor = [UIColor whiteColor];
    cancelButton.tintColor = [UIColor whiteColor];
    eraseButton.tintColor = [UIColor whiteColor];
    
    
    if (IS_IPHONE_6 || IS_IPHONE_6P_IOS8) {
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: addButton,  zoomButton, nil];
    } else if (IS_IPHONE || IS_IPHONE_5) {
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: addButton, nil];
        
    } else {
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: addButton, zoomButton, nil];
    }
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:  cancelButton, eraseButton, nil];

    
    isEraserON = false;
    
    self.title = @"DRAW";
    
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
    containerView.hidden = false;
    mainImage.hidden = false;
    tempDrawImage.hidden = false;
    UIGraphicsBeginImageContextWithOptions(self.containerView.bounds.size, NO, 0.0);
     [containerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    containerView.hidden = true;
    mainImage.hidden = true;
    tempDrawImage.hidden = true;
    
    containerView2.hidden = false;
    mainImage2.hidden = false;
    tempDrawImage2.hidden = false;
    UIGraphicsBeginImageContextWithOptions(self.mainImage2.bounds.size, NO, 0.0);
     [containerView2.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *SaveImage2 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    containerView2.hidden = false;
    mainImage2.hidden = false;
    tempDrawImage2.hidden = false;
    
    containerView3.hidden = false;
    mainImage3.hidden = false;
    tempDrawImage3.hidden = false;
    UIGraphicsBeginImageContextWithOptions(self.mainImage3.bounds.size, NO, 0.0);
     [containerView3.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *SaveImage3 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    containerView3.hidden = true;
    mainImage3.hidden = true;
    tempDrawImage3.hidden = true;
    
    
    if (catType == 0) {
        mainImage.hidden = false;
        tempDrawImage.hidden = false;
        mainImage2.hidden = true;
        tempDrawImage2.hidden = true;
        mainImage3.hidden = true;
        tempDrawImage3.hidden = true;
        containerView3.hidden = true;
        containerView2.hidden = true;
        containerView.hidden = false;
        
        
    } else if (catType == 1) {
        mainImage.hidden = true;
        tempDrawImage.hidden = true;
        mainImage2.hidden = false;
        tempDrawImage2.hidden = false;
        mainImage3.hidden = true;
        tempDrawImage3.hidden = true;
        containerView3.hidden = true;
        containerView2.hidden = false;
        containerView.hidden = true;
        
    } else if (catType == 2) {
        mainImage.hidden = true;
        tempDrawImage.hidden = true;
        mainImage2.hidden = true;
        tempDrawImage2.hidden = true;
        mainImage3.hidden = false;
        tempDrawImage3.hidden = false;
        containerView3.hidden = false;
        containerView2.hidden = true;
        containerView.hidden = true;
        
    }

    
    
    [SVProgressHUD showWithStatus:@"Adding..."];
    [[AppController sharedInstance] addEyeExamForms:SaveImage form2:SaveImage2 form3:SaveImage3 ToPatient:patientID completion:^(BOOL success, NSString *message) {
        
     
         if (success)
         {
             [self.navigationController popViewControllerAnimated:YES];
             [UIAlertView showWithTitle:nil message:@"Eye exam form added" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
         } else {
             [UIAlertView showWithTitle:nil message:@"Failed to add this form" cancelButtonTitle:@"OK" otherButtonTitles:nil tapBlock:nil];
         }
        
         [SVProgressHUD dismiss];
        
         
     }];
}


- (IBAction)enableErase:(id)sender {
    if (isEraserON == false) {
        isEraserON = true;
        eraseButton.title = @"Eraser On";
        
        /*red = 255.0/255.0;
        green = 255.0/255.0;
        blue = 255.0/255.0;
        opacity = 0.0;*/
    } else {
        isEraserON = false;
        eraseButton.title = @"Eraser Off";
        /*red = 0.0/255.0;
        green = 0.0/255.0;
        blue = 0.0/255.0;
        opacity = 1.0;*/

    }
    
}

- (IBAction)enableZoom:(id)sender {
    if (zoomOn == true) {
        zoomOn = false;
        zoomButton.title = @"Zoom Off";
        
         pinchRecognizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        pinchRecognizer.view.frame = CGRectMake(0, 0, pinchRecognizer.view.frame.size.width, pinchRecognizer.view.frame.size.height);
        if (catType == 0) {
        [containerView removeGestureRecognizer:panRecognizer];
            [containerView removeGestureRecognizer:pinchRecognizer];
        } else if (catType == 1)  {
            [containerView2 removeGestureRecognizer:panRecognizer];
            [containerView2 removeGestureRecognizer:pinchRecognizer];
        } else if (catType == 2) {
            [containerView3 removeGestureRecognizer:panRecognizer];
            [containerView3 removeGestureRecognizer:pinchRecognizer];
        }
      
        
    } else {
        zoomOn = true;
        zoomButton.title = @"Zoom On";
        
        if (catType == 0) {
           
            panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            panRecognizer.delegate = self;
            [containerView addGestureRecognizer:panRecognizer];
            
            pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
            pinchRecognizer.delegate = self;
            [containerView addGestureRecognizer:pinchRecognizer];
        }else if (catType == 1)  {
            panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            panRecognizer.delegate = self;
            [containerView2 addGestureRecognizer:panRecognizer];
            
            pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
            pinchRecognizer.delegate = self;
            [containerView2 addGestureRecognizer:pinchRecognizer];
        } else if (catType == 2)  {
            panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            panRecognizer.delegate = self;
            [containerView3 addGestureRecognizer:panRecognizer];
            
            pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
            pinchRecognizer.delegate = self;
            [containerView3 addGestureRecognizer:pinchRecognizer];
        }

    }
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
     /*   CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
        } completion:nil];
        */
    }
    
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    if (catType == 0) {
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    //mainImage.transform = CGAffineTransformScale(mainImage.transform, recognizer.scale, recognizer.scale);
      // tempDrawImage.transform = CGAffineTransformScale(tempDrawImage.transform, recognizer.scale, recognizer.scale);
        
    } else if (catType == 1) {
        recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
        
    } else if (catType == 2) {
        recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
        
    }
    recognizer.scale = 1;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer {
    if (zoomOn == true) {
       /* if (recognizer.numberOfTouches == 2) {
            CGPoint a = [recognizer locationOfTouch:0 inView:recognizer.view];
            CGPoint b = [recognizer locationOfTouch:1 inView:recognizer.view];
            CGFloat xDist = (a.x - b.x);
            CGFloat yDist = (a.y - b.y);
            CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
            
            CGFloat scale = 1;
            if (old_distance != 0) {
                scale = distance / old_distance;
            }
            old_distance = distance;
            recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale);
        }*/
        
    }
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

- (IBAction)settings:(id)sender {
   // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    
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
    
    if (zoomOn == false) {
 
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
        if (isEraserON == true) {
            if (catType == 0) {
                self.tempDrawImage.image = self.mainImage.image;
                self.mainImage.image = nil;
            } else if (catType == 1) {
                self.tempDrawImage2.image = self.mainImage2.image;
                self.mainImage2.image = nil;
            } else if (catType == 2) {
                self.tempDrawImage3.image = self.mainImage3.image;
                self.mainImage3.image = nil;
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (zoomOn == false) {
   
    
    if (catType == 0) {
        mouseSwiped = YES;
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:containerView];
   // UIGraphicsBeginImageContext(self.view.frame.size);
        UIGraphicsBeginImageContext(containerView.frame.size);

        //[self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.tempDrawImage.image drawInRect:CGRectMake(0,0, containerView.frame.size.width, containerView.frame.size.height)];
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
            //  CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
        if (isEraserON == false) {
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
            
        } else {
             CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    
        }
       // CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        [self.tempDrawImage setAlpha:opacity];
    
        UIGraphicsEndImageContext();
        
        // cleanup our context
        //CGContextFlush(UIGraphicsGetCurrentContext());
        //UIGraphicsEndImageContext();
        
                 lastPoint = currentPoint;
    } else if (catType == 1) {
        mouseSwiped = YES;
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.view];
        
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage2.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
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
        self.tempDrawImage2.image = UIGraphicsGetImageFromCurrentImageContext();
        [self.tempDrawImage2 setAlpha:opacity];
        
         lastPoint = currentPoint;
    } else if (catType == 2) {
        mouseSwiped = YES;
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.view];
        
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage3.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
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
        self.tempDrawImage3.image = UIGraphicsGetImageFromCurrentImageContext();
        [self.tempDrawImage3 setAlpha:opacity];
        
         lastPoint = currentPoint;
        
    
    }
    
   
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (zoomOn == false) {
    if (catType == 0) {
    if(!mouseSwiped) {
      //  UIGraphicsBeginImageContext(self.view.frame.size);
        //[self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        UIGraphicsBeginImageContext(containerView.frame.size);
        
        [self.tempDrawImage.image drawInRect:CGRectMake(0,0, containerView.frame.size.width, containerView.frame.size.height)];
        
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
    
    /*UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext(); */
        
        UIGraphicsBeginImageContext(containerView.frame.size);
        
       
        
        [self.mainImage.image drawInRect:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
        self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
        self.tempDrawImage.image = nil;
        UIGraphicsEndImageContext();
        
        
    } else if (catType == 1) {
        if(!mouseSwiped) {
            UIGraphicsBeginImageContext(self.view.frame.size);
            [self.tempDrawImage2.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
            if (isEraserON == false) {
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
                
            } else {
                CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
            }

            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            CGContextFlush(UIGraphicsGetCurrentContext());
            self.tempDrawImage2.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        UIGraphicsBeginImageContext(self.mainImage2.frame.size);
        [self.mainImage2.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        [self.tempDrawImage2.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
        self.mainImage2.image = UIGraphicsGetImageFromCurrentImageContext();
        self.tempDrawImage2.image = nil;
        UIGraphicsEndImageContext();
    }else if (catType == 2) {
        if(!mouseSwiped) {
            UIGraphicsBeginImageContext(self.view.frame.size);
            [self.tempDrawImage3.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
            if (isEraserON == false) {
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
                
            } else {
                CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
            }

            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            CGContextFlush(UIGraphicsGetCurrentContext());
            self.tempDrawImage3.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        UIGraphicsBeginImageContext(self.mainImage3.frame.size);
        [self.mainImage3.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        [self.tempDrawImage3.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
        self.mainImage3.image = UIGraphicsGetImageFromCurrentImageContext();
        self.tempDrawImage3.image = nil;
        UIGraphicsEndImageContext();
    }
    }
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

- (IBAction)segmentValueChanged:(id)sender {
    catType = (int)segmentDraw.selectedSegmentIndex;
    
    if (catType == 0) {
        mainImage.hidden = false;
        tempDrawImage.hidden = false;
        mainImage2.hidden = true;
        tempDrawImage2.hidden = true;
        mainImage3.hidden = true;
        tempDrawImage3.hidden = true;
        containerView3.hidden = true;
        containerView2.hidden = true;
        containerView.hidden = false;
        
        if (zoomOn == true) {
            [containerView2 removeGestureRecognizer:panRecognizer];
            [containerView2 removeGestureRecognizer:pinchRecognizer];
            [containerView3 removeGestureRecognizer:panRecognizer];
            [containerView3 removeGestureRecognizer:pinchRecognizer];
            [containerView addGestureRecognizer:panRecognizer];
            [containerView addGestureRecognizer:pinchRecognizer];
        }
        
        
    } else if (catType == 1) {
        mainImage.hidden = true;
        tempDrawImage.hidden = true;
        mainImage2.hidden = false;
        tempDrawImage2.hidden = false;
        mainImage3.hidden = true;
        tempDrawImage3.hidden = true;
        containerView3.hidden = true;
        containerView2.hidden = false;
        containerView.hidden = true;
        
        if (zoomOn == true) {
            [containerView removeGestureRecognizer:panRecognizer];
            [containerView removeGestureRecognizer:pinchRecognizer];
            [containerView3 removeGestureRecognizer:panRecognizer];
            [containerView3 removeGestureRecognizer:pinchRecognizer];
            [containerView2 addGestureRecognizer:panRecognizer];
            [containerView2 addGestureRecognizer:pinchRecognizer];
        }
        
    } else if (catType == 2) {
        mainImage.hidden = true;
        tempDrawImage.hidden = true;
        mainImage2.hidden = true;
        tempDrawImage2.hidden = true;
        mainImage3.hidden = false;
        tempDrawImage3.hidden = false;
        containerView3.hidden = false;
        containerView2.hidden = true;
        containerView.hidden = true;
        
        if (zoomOn == true) {
            [containerView2 removeGestureRecognizer:panRecognizer];
            [containerView2 removeGestureRecognizer:pinchRecognizer];
            [containerView removeGestureRecognizer:panRecognizer];
            [containerView removeGestureRecognizer:pinchRecognizer];
            [containerView3 addGestureRecognizer:panRecognizer];
            [containerView3 addGestureRecognizer:pinchRecognizer];
        }
        
    }
    
}

@end
