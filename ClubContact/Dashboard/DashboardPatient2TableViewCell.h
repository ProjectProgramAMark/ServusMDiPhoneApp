//
//  DashboardPatient2TableViewCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 12/26/15.
//  Copyright © 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface DashboardPatient2TableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialityLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UIButton *facetimeIcon;
@property (weak, nonatomic) IBOutlet UIButton *messageIcon;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel2;
@property (nonatomic) IBOutlet UILabel *timeLabel;

@end
