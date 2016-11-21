//
//  AboutTableViewCell.m
//  ClubContact
//
//  Created by wangkun on 15/3/12.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import "AboutTableViewCell.h"

#define kKeyLabelHeight   (30)
#define kKeyLabelMarginY  ((kAboutTableViewCellHeight - kKeyLabelHeight)/2) 
#define kKeyLabelMarginX  (10)

#define kValueLabelMarginX (10)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)


@implementation AboutTableViewCell
{

}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (IS_IPHONE) {
            _keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kKeyLabelMarginX,
                                                                  kKeyLabelMarginY,
                                                                  [UIScreen mainScreen].bounds.size.width / 3,
                                                                  kKeyLabelHeight)];
            _keyLabel.textColor = [UIColor grayColor];
            _keyLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
            _keyLabel.minimumFontSize = 9.0f;
            _keyLabel.adjustsFontSizeToFitWidth = YES;
            [self addSubview:_keyLabel];
            
            int valueLabelMarginX = _keyLabel.frame.size.width;
            _valueLabel = [[UITextField alloc] initWithFrame:CGRectMake(valueLabelMarginX,
                                                                    _keyLabel.frame.origin.y,
                                                                    [UIScreen mainScreen].bounds.size.width - valueLabelMarginX,
                                                                    kKeyLabelHeight)];
            _valueLabel.textColor = [UIColor blackColor];
           //  _valueLabel.font = [UIFont systemFontOfSize:12.0f];
              _valueLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];
            [self addSubview:_valueLabel];
  
        } else {

        _keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kKeyLabelMarginX,
                                                              kKeyLabelMarginY,
                                                              [UIScreen mainScreen].bounds.size.width / 4,
                                                              kKeyLabelHeight)];
        _keyLabel.textColor = [UIColor grayColor];
        [self addSubview:_keyLabel];
        
        int valueLabelMarginX = _keyLabel.frame.size.width - kKeyLabelMarginX - kValueLabelMarginX;
        _valueLabel = [[UITextField alloc] initWithFrame:CGRectMake(valueLabelMarginX,
                                                               _keyLabel.frame.origin.y,
                                                               [UIScreen mainScreen].bounds.size.width - valueLabelMarginX,
                                                               kKeyLabelHeight)];
        _valueLabel.textColor = [UIColor blackColor];
        [self addSubview:_valueLabel];
            
        }
        
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
