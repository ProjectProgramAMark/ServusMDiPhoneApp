//
//  PatientsTableViewCell.m
//  ClubContact
//
//  Created by wangkun on 15/3/11.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import "PatientsTableViewCell.h"
#import "UIImageView+WebCache.h"

#define kIconMargin  (10)
#define kIconSize CGSizeMake(kPatientsTableViewCellHeight - (kIconMargin * 2), kPatientsTableViewCellHeight - (kIconMargin * 2))
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)


#define kRefreshButtonMargin  (25)
#define kRefreshButtonSize CGSizeMake(kPatientsTableViewCellHeight - (kRefreshButtonMargin * 2), kPatientsTableViewCellHeight - (kRefreshButtonMargin * 2))

@implementation PatientsTableViewCell
{
    UIImageView *iconView;
    UILabel *nameLabel;
 
    UIButton *refreshButton;
    UIButton *imageButton;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (IS_IPHONE) {
            iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
            iconView.layer.masksToBounds = YES;
            iconView.layer.cornerRadius = iconView.frame.size.width / 2;
           // [self addSubview:iconView];
            
            nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            [self addSubview:nameLabel];
            
            refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [refreshButton setBackgroundImage:[UIImage imageNamed:@"refreshButton"] forState:UIControlStateNormal];
            
            [refreshButton addTarget:self
                              action:@selector(refreshButtonClicked)
                    forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:refreshButton];
            
            imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            
            [imageButton addTarget:self
                            action:@selector(imageButtonClicked)
                  forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:imageButton];
            
            
            _hideRefreshButton = TRUE;

        } else {
            
        
        iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
        iconView.layer.masksToBounds = YES;
        iconView.layer.cornerRadius = iconView.frame.size.width / 2;
        [self addSubview:iconView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:nameLabel];
        
        refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshButton setBackgroundImage:[UIImage imageNamed:@"refreshButton"] forState:UIControlStateNormal];

        [refreshButton addTarget:self
                          action:@selector(refreshButtonClicked)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:refreshButton];
        
        imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        [imageButton addTarget:self
                          action:@selector(imageButtonClicked)
                forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageButton];
        
     
        _hideRefreshButton = TRUE;
            
        }
    }
    
    return self;
}

- (void)setPatient:(Patient *)patient
{
    _patient = patient;
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [iconView setImageWithURL:[NSURL URLWithString:patient.profilepic]];
    nameLabel.text = [NSString stringWithFormat:@"%@ %@",patient.firstName, patient.lastName];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (IS_IPHONE) {
        refreshButton.frame = CGRectMake(self.frame.size.width - kRefreshButtonMargin - kRefreshButtonSize.width,
                                         kRefreshButtonMargin,
                                         kRefreshButtonSize.width,
                                         kRefreshButtonSize.height);
        refreshButton.hidden = _hideRefreshButton;
        
        iconView.frame = CGRectMake(20, kIconMargin, kIconSize.width, kIconSize.height);
        imageButton.frame = CGRectMake(20, kIconMargin, kIconSize.width, kIconSize.height);
        
        float labelHeight = kPatientsTableViewCellHeight / 2;
        nameLabel.frame = CGRectMake(20,
                                     (kPatientsTableViewCellHeight - labelHeight) / 2,
                                     self.frame.size.width - iconView.frame.origin.x + iconView.frame.size.width + 10,
                                     labelHeight);
        nameLabel.font = [UIFont systemFontOfSize:20.0f];
    } else {
    refreshButton.frame = CGRectMake(self.frame.size.width - kRefreshButtonMargin - kRefreshButtonSize.width,
                                     kRefreshButtonMargin,
                                     kRefreshButtonSize.width,
                                     kRefreshButtonSize.height);
    refreshButton.hidden = _hideRefreshButton;
    
    iconView.frame = CGRectMake(20, kIconMargin, kIconSize.width, kIconSize.height);
    imageButton.frame = CGRectMake(20, kIconMargin, kIconSize.width, kIconSize.height);
    
    float labelHeight = kPatientsTableViewCellHeight / 2;
    nameLabel.frame = CGRectMake(iconView.frame.origin.x + iconView.frame.size.width + 10,
                                 (kPatientsTableViewCellHeight - labelHeight) / 2,
                                 self.frame.size.width - iconView.frame.origin.x + iconView.frame.size.width + 10,
                                 labelHeight);
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshButtonClicked
{
    if (_delegate)
    {
        [_delegate PatientsTableViewCellRefreshButtonClicked:self];
    }
}

- (void)imageButtonClicked
{
    if (_delegate)
    {
        [_delegate PatientsTableViewCellImageButtonClicked:self];
    }
}

@end
