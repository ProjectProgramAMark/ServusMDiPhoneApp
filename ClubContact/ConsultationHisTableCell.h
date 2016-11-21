//
//  ConsultationHisTableCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/29/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsultationHisTableCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *docnameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *cellImageView;
@property (nonatomic, retain) IBOutlet UIButton  *docButton;

@end
