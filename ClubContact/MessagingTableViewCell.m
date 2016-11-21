//
//  MessagingTableViewCell.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/4/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "MessagingTableViewCell.h"
#import "UIImageView+WebCache.h"

#define kIconMargin  (10)
#define kIconSize CGSizeMake(kPatientsTableViewCellHeight - (kIconMargin * 2), kPatientsTableViewCellHeight - (kIconMargin * 2))


#define kRefreshButtonMargin  (25)
#define kRefreshButtonSize CGSizeMake(kPatientsTableViewCellHeight - (kRefreshButtonMargin * 2), kPatientsTableViewCellHeight - (kRefreshButtonMargin * 2))

@implementation MessagingTableViewCell 

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    
    return self;
}

- (void)setPatient:(Patient *)patient
{
    _patient = patient;
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [iconView setImageWithURL:[NSURL URLWithString:patient.profilepic]];
    nameLabel.text = [NSString stringWithFormat:@"%@ %@ (%@)",patient.firstName, patient.lastName, patient.msgCount];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)refreshButtonClicked
{
    if (_delegate)
    {
        //[_delegat;
    }
}

- (void)imageButtonClicked
{
    if (_delegate)
    {
        //[_delegate PatientsTableViewCellImageButtonClicked:self];
    }
}

@end
