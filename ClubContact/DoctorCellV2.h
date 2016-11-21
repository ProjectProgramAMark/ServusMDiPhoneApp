//
//  DoctorCellV2.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 8/5/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface DoctorCellV2 :  SWTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialityLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UIButton *facetimeIcon;
@property (weak, nonatomic) IBOutlet UIButton *messageIcon;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;


@end
