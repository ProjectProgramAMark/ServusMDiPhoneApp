//
//  TransactionCellTableViewCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionCellTableViewCell : UITableViewCell {
    
}

@property (nonatomic, retain) IBOutlet UITextField *editText;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UIImageView *cellImageView;

@end
