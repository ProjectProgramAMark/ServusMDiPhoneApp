//
//  AllergyListTableViewCell.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/10/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AllergyListTableViewCell.h"

#define kIconMargin2  (10)
#define kIconSize2 CGSizeMake(kConditionsTableViewCellHeight - (kIconMargin2 * 2), kConditionsTableViewCellHeight - (kIconMargin2 * 2))

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)



@implementation AllergyListTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, kIconMargin2, kIconSize2.width, kIconSize2.height)];
        //iconView.layer.masksToBounds = YES;
        //iconView.layer.cornerRadius = iconView.frame.size.width / 2;
        [self addSubview:iconView];
        
        float labelHeight = kConditionsTableViewCellHeight / 2;
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.frame.origin.x + iconView.frame.size.width + 10,
                                                              (kConditionsTableViewCellHeight - labelHeight) / 2,
                                                              self.frame.size.width - iconView.frame.origin.x + iconView.frame.size.width + 10,
                                                              labelHeight)];
        [self addSubview:nameLabel];
    }
    
    return self;
}

- (void)setAllergen:(Allergen *)allergen
{
    _allergen = allergen;
    [iconView setImage:[UIImage imageNamed:@"disableman"]];
    nameLabel.text = [NSString stringWithFormat:@"%@",allergen.PicklistDesc];
    if (IS_IPHONE) {
        nameLabel.font = [UIFont systemFontOfSize:12.0f];
    }
}

- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
