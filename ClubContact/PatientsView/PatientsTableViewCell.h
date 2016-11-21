//
//  PatientsTableViewCell.h
//  ClubContact
//
//  Created by wangkun on 15/3/11.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#define kPatientsTableViewCellHeight    (100.0)

@protocol PatientsTableViewCellDelegate;

@interface PatientsTableViewCell : UITableViewCell

@property (strong, nonatomic) Patient *patient;
@property (nonatomic) BOOL hideRefreshButton;
@property (nonatomic, assign) id<PatientsTableViewCellDelegate> delegate;

@end


@protocol PatientsTableViewCellDelegate <NSObject>
@required

- (void)PatientsTableViewCellRefreshButtonClicked:(PatientsTableViewCell *)cell;
- (void)PatientsTableViewCellImageButtonClicked:(PatientsTableViewCell *)cell;

@end