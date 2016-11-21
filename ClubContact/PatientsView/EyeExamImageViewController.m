//
//  EyeExamImageViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/1/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "EyeExamImageViewController.h"

@interface EyeExamImageViewController ()

@end

@implementation EyeExamImageViewController

@synthesize eyeExam;
@synthesize patientID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    
    eraseButton =[[UIBarButtonItem alloc] initWithTitle:@"Eraser Off" style:UIBarButtonItemStylePlain target:self action:@selector(enableErase:)];
    
    zoomButton = [[UIBarButtonItem alloc] initWithTitle:@"Zoom Off" style:UIBarButtonItemStylePlain target:self action:@selector(enableZoom:)];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareEyeExam:)];
    
    //self.navigationItem.rightBarButtonItem = zoomButton;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: shareButton,  zoomButton, nil];
    //self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: eraseButton,  cancelButton, nil];
    self.navigationItem.leftBarButtonItem= cancelButton;*/
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    eraseButton =[[UIBarButtonItem alloc] initWithTitle:@"Eraser Off" style:UIBarButtonItemStylePlain target:self action:@selector(enableErase:)];
    
    zoomButton = [[UIBarButtonItem alloc] initWithTitle:@"Zoom Off" style:UIBarButtonItemStylePlain target:self action:@selector(enableZoom:)];
    
       UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareEyeExam:)];
    shareButton.tintColor =[UIColor whiteColor];
    zoomButton.tintColor = [UIColor whiteColor];
    
    
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
   // self.navigationItem.rightBarButtonItem = notiButtonItem;
    
     self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:shareButton, zoomButton, nil];
    
    isEraserON = false;
    
     self.title = @"EYE EXAM";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareEyeExam:(id)sender {
    
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
    EyeExamShareViewController *vc = [[EyeExamShareViewController alloc] initWithNibName:@"EyeExamShareViewController" bundle:nil];
    
    
    
    
    vc.patientID = patientID;
    vc.eyeExamID = eyeExam.postid;

     [self.navigationController pushViewController:vc animated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)enableErase:(id)sender {
    if (isEraserON == false) {
        isEraserON = true;
        eraseButton.title = @"Eraser On";
        
        red = 255.0/255.0;
        green = 255.0/255.0;
        blue = 255.0/255.0;
        opacity = 1.0;
    } else {
        eraseButton.title = @"Eraser Off";
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    if (eyeExam.formimage1.length > 0) {
        [form1IMG setImageWithURL:[NSURL URLWithString:eyeExam.formimage1]];
        
    }
    
    if (eyeExam.formimage2.length > 0) {
        [form2IMG setImageWithURL:[NSURL URLWithString:eyeExam.formimage2]];
        
    }
    if (eyeExam.formimage3.length > 0) {
        [form3IMG setImageWithURL:[NSURL URLWithString:eyeExam.formimage3]];
        
    }
}

- (IBAction)segmentValueChanged:(id)sender {
    catType = (int)segmentDraw.selectedSegmentIndex;
    
    if (catType == 0) {
        form1IMG.hidden = false;
        form2IMG.hidden = true;
        form3IMG.hidden = true;
        containerView.hidden = false;
        containerView2.hidden = true;
        containerView3.hidden = true;
        
        if (zoomOn == true) {
            [containerView2 removeGestureRecognizer:panRecognizer];
            [containerView2 removeGestureRecognizer:pinchRecognizer];
            [containerView3 removeGestureRecognizer:panRecognizer];
            [containerView3 removeGestureRecognizer:pinchRecognizer];
            [containerView addGestureRecognizer:panRecognizer];
            [containerView addGestureRecognizer:pinchRecognizer];
        }

        
        
    } else if (catType == 1) {
        form1IMG.hidden = true;
        form2IMG.hidden = false;
        form3IMG.hidden = true;
        containerView.hidden = true;
        containerView2.hidden = false;
        containerView3.hidden = true;
        if (zoomOn == true) {
            [containerView removeGestureRecognizer:panRecognizer];
            [containerView removeGestureRecognizer:pinchRecognizer];
            [containerView3 removeGestureRecognizer:panRecognizer];
            [containerView3 removeGestureRecognizer:pinchRecognizer];
            [containerView2 addGestureRecognizer:panRecognizer];
            [containerView2 addGestureRecognizer:pinchRecognizer];
        }
        
    } else if (catType == 2) {
        form1IMG.hidden = true;
        form2IMG.hidden = true;
        form3IMG.hidden = false;
        containerView.hidden = true;
        containerView2.hidden = true;
        containerView3.hidden = false;
        
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


- (IBAction)enableZoom:(id)sender {
    if (zoomOn == true) {
        zoomOn = false;
        zoomButton.title = @"Zoom Off";
        
       // pinchRecognizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
      //  pinchRecognizer.view.frame = CGRectMake(0, 0, pinchRecognizer.view.frame.size.width, pinchRecognizer.view.frame.size.height);
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
        
      /*  CGPoint velocity = [recognizer velocityInView:self.view];
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


@end
