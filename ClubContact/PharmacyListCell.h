//
//  PharmacyListCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pharmacy.h"
#define kConditionsTableViewCellHeight    (60.0)

@interface PharmacyListCell : UITableViewCell {
    
    
    UIImageView *iconView;
    UILabel *nameLabel;
    UILabel *addressLabel;
    
    
}

@property (strong, nonatomic) Pharmacy *pharmacy;



@end
