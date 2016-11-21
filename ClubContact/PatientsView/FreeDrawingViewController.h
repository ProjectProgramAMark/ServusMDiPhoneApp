//
//  FreeDrawingViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/1/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreeDrawSettingViewController.h"
#import "AppController.h"
#import "BaseViewController.h"


@interface FreeDrawingViewController : BaseViewController <FreeDrawSettingViewControllerDelegate, UIActionSheetDelegate> {
    
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    
    BOOL mouseSwiped;
    BOOL isEraserON;
    UIBarButtonItem *eraseButton;
    
      IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic) NSString *patientID;

- (IBAction)pencilPressed:(id)sender;
- (IBAction)eraserPressed:(id)sender;
- (IBAction)reset:(id)sender;
- (IBAction)settings:(id)sender;
- (IBAction)save:(id)sender;
@end
