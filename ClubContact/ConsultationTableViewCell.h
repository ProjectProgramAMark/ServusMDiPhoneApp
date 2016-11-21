//
//  ConsultationTableViewCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/12/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsultationTableViewCell : UITableViewCell {
    
}

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imgView;

@end
