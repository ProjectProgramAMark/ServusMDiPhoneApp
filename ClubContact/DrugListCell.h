//
//  DrugListCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drug.h"

#define kConditionsTableViewCellHeight    (40.0)


@interface DrugListCell : UITableViewCell {
    
    UIImageView *iconView;
    UILabel *nameLabel;
    
    
}

@property (strong, nonatomic) Drug *drug;

@end
