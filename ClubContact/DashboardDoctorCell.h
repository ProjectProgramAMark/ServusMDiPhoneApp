//
//  DashboardDoctorCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DashboardDoctorCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialityLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UIButton *facetimeIcon;
@property (weak, nonatomic) IBOutlet UIButton *messageIcon;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;


- (CGFloat)imageOverflowHeight;

- (void)setImageOffset:(CGPoint)imageOffset;


@end
