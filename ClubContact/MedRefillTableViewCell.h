//
//  MedRefillTableViewCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/27/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedRefillTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UITextField *editText;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *docLabel;
@property (nonatomic, retain) IBOutlet UIButton *docButton;
@property (nonatomic, retain) IBOutlet UIImageView *cellImageView;


@end
