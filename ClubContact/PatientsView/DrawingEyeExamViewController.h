//
//  DrawingEyeExamViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/1/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreeDrawSettingViewController.h"
#import "AppController.h"
#import "BaseViewController.h"
#import "UIAlertView+Blocks.h"

@interface DrawingEyeExamViewController : BaseViewController <FreeDrawSettingViewControllerDelegate, UIActionSheetDelegate> {
    
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
    int catType;
    
    IBOutlet UISegmentedControl *segmentDraw;
    
    CGFloat old_distance;
    CGFloat old_distance2;
    CGFloat old_distance3;
    
    BOOL zoomOn;
    BOOL isEraserON;
    
    UIBarButtonItem *zoomButton;
    UIBarButtonItem *eraseButton;
    
    UIPanGestureRecognizer * panRecognizer;
    UIPinchGestureRecognizer * pinchRecognizer;
    
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
}

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage2;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage2;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage3;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage3;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *containerView2;
@property (weak, nonatomic) IBOutlet UIView *containerView3;
@property (nonatomic) NSString *patientID;

- (IBAction)pencilPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)settings:(id)sender;
- (IBAction)save:(id)sender;

@end
