//
//  DoctorTableViewCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 4/20/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Doctors.h"
#define kPatientsTableViewCellHeight    (100.0)

@protocol DoctorTableViewCellDelegate;

@interface DoctorTableViewCell : UITableViewCell {
    
    UIImageView *iconView;
    UILabel *nameLabel;
    
    UIButton *refreshButton;
    UIButton *imageButton;
}


@property (strong, nonatomic) Doctors *doctor;
@property (nonatomic) BOOL hideRefreshButton;
@property (nonatomic, assign) id<DoctorTableViewCellDelegate> delegate;

@end


@protocol DoctorTableViewCellDelegate <NSObject>
@required

- (void)DoctorTableViewCellRefreshButtonClicked:(DoctorTableViewCell *)cell;
- (void)DoctorTableViewCellImageButtonClicked:(DoctorTableViewCell *)cell;

@end

