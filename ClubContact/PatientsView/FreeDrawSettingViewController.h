//
//  FreeDrawSettingViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/1/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FreeDrawSettingViewControllerDelegate <NSObject>
- (void)closeSettings:(id)sender;
@end

@interface FreeDrawSettingViewController : UIViewController {
    IBOutlet UIView *menuButton;
}

@property (weak, nonatomic) IBOutlet UISlider *brushControl;
@property (weak, nonatomic) IBOutlet UISlider *opacityControl;
@property (weak, nonatomic) IBOutlet UIImageView *brushPreview;
@property (weak, nonatomic) IBOutlet UIImageView *opacityPreview;
@property (weak, nonatomic) IBOutlet UILabel *brushValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *opacityValueLabel;
@property (weak, nonatomic) id<FreeDrawSettingViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISlider *redControl;
@property (weak, nonatomic) IBOutlet UISlider *greenControl;
@property (weak, nonatomic) IBOutlet UISlider *blueControl;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;

@property CGFloat brush;
@property CGFloat opacity;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;

- (IBAction)closeSettings:(id)sender;
- (IBAction)sliderChanged:(id)sender;



@end
