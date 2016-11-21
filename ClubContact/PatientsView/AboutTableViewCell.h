//
//  AboutTableViewCell.h
//  ClubContact
//
//  Created by wangkun on 15/3/12.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAboutTableViewCellHeight (40)

@interface AboutTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *keyLabel;
@property (strong, nonatomic) UITextField *valueLabel;

@end
