//
//  AllergyListTableViewCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Allergen.h"
#define kConditionsTableViewCellHeight    (40.0)

@interface AllergyListTableViewCell : UITableViewCell {
    
    UIImageView *iconView;
    UILabel *nameLabel;
    
    
}

@property (strong, nonatomic) Allergen *allergen;
@end
