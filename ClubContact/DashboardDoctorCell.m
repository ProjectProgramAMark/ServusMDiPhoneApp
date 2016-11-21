//
//  DashboardDoctorCell.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/24/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "DashboardDoctorCell.h"

@implementation DashboardDoctorCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)imageOverflowHeight
{
    return self.cellImageView.image.size.height - self.cellImageView.frame.size.height;
}

- (void)setImageOffset:(CGPoint)imageOffset
{
    CGRect frame = self.cellImageView.frame;
    frame.origin = imageOffset;
    self.cellImageView.frame = frame;
}

@end
