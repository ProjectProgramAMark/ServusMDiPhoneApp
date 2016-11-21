//
//  UnifiedReqTableViewCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/4/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface UnifiedReqTableViewCell : SWTableViewCell

@property (nonatomic) IBOutlet UILabel *topTitleLabel;
@property (nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic) IBOutlet UIImageView *imgView;

@end
