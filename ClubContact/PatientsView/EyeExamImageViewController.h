//
//  EyeExamImageViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/1/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "BaseViewController.h"
#import "UIAlertView+Blocks.h"
#import "EyeExam2.h"
#import "UIImageView+WebCache.h"
#import "EyeExamShareViewController.h"

@interface EyeExamImageViewController : BaseViewController {
    int catType;
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    
    IBOutlet UISegmentedControl *segmentDraw;
    
    IBOutlet UIImageView *form1IMG;
    IBOutlet UIImageView *form2IMG;
    IBOutlet UIImageView *form3IMG;
    
    IBOutlet UIView *containerView;
    IBOutlet UIView *containerView2;
    IBOutlet UIView *containerView3;
    
    BOOL zoomOn;
    BOOL isEraserON;
    
    UIBarButtonItem *zoomButton;
    UIBarButtonItem *eraseButton;
    
    
    UIPanGestureRecognizer * panRecognizer;
    UIPinchGestureRecognizer * pinchRecognizer;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;


}

@property (nonatomic) EyeExam2 *eyeExam;
@property (nonatomic) NSString *patientID;

@end
