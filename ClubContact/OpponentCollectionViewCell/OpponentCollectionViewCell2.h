//
//  OpponentCollectionViewCell2.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/25/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QBRTCVideoTrack;

@interface OpponentCollectionViewCell2 : UICollectionViewCell

@property (weak, nonatomic) UIView *videoView;

@property (assign, nonatomic) QBRTCConnectionState connectionState;

- (void)setColorMarkerText:(NSString *)text andColor:(UIColor *)color;

@end
