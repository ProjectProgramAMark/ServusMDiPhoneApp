//
//  NoteTableViewCell.h
//  ClubContact
//
//  Created by wangkun on 15/4/5.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

typedef enum : NSUInteger {
    NoteTableViewCellText,
    NoteTableViewCellRecording,
    NoteTableViewCellImage,
    NoteTableViewCellUnknown,
} NoteTableViewCellType;

@interface NoteTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *typeLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) Note *note;
@property (nonatomic) NoteTableViewCellType type;

- (void)addButtonMode;

@end
