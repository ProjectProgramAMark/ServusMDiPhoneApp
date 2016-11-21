//
//  AmslerGridViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AmslerGridViewControllerDelegate <NSObject>
- (void)rtgridassign:(NSString *)sender;
- (void)ltgridassign:(NSString *)sender;
- (void)rtcongridassign:(NSString *)sender;
- (void)ltcongridassign:(NSString *)sender;
@end

@interface AmslerGridViewController : UIViewController {
    IBOutlet UIView *containerView;
    IBOutlet UIImageView *gridIMGView;
    
    NSMutableArray *dataArray;
     NSMutableArray *dataArrayFromString;
    
}

@property (weak, nonatomic) id<AmslerGridViewControllerDelegate> delegate;
@property (nonatomic) NSString *dataString;
@property (nonatomic) BOOL isEnabled;
@property (nonatomic) int gridType;
@end
