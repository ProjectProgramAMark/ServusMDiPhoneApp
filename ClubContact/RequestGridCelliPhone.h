//
//  RequestGridCelliPhone.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 6/22/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestGridCelliPhone : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UILabel *nameLabel1;
@property (nonatomic, retain) IBOutlet UILabel *fromTimeLabel1;
@property (nonatomic, retain) IBOutlet UILabel *toTimeLabel1;
@property (nonatomic, retain) IBOutlet UILabel *monthLabel1;
@property (nonatomic, retain) IBOutlet UILabel *dayLabel1;
@property (nonatomic, retain) IBOutlet UIImageView *profIMG;
@property (nonatomic, retain) IBOutlet UIVisualEffectView *profBlurEffect;

@end
