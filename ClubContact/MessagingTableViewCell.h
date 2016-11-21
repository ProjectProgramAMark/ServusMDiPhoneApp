//
//  MessagingTableViewCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/4/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#define kPatientsTableViewCellHeight    (100.0)

@protocol MessagePatientTableViewCellDelegate;



@interface MessagingTableViewCell : UITableViewCell {
    
        UIImageView *iconView;
        UILabel *nameLabel;
        
        UIButton *refreshButton;
        UIButton *imageButton;
    

}

@property (strong, nonatomic) Patient *patient;
@property (nonatomic) BOOL hideRefreshButton;
@property (nonatomic, assign) id<MessagePatientTableViewCellDelegate> delegate;


@end


@protocol PatientsTableViewCellDelegate <NSObject>
@required

- (void)PatientsTableViewCellRefreshButtonClicked:(MessagingTableViewCell *)cell;
- (void)PatientsTableViewCellImageButtonClicked:(MessagingTableViewCell *)cell;


@end
