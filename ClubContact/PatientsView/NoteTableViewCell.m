//
//  NoteTableViewCell.m
//  ClubContact
//
//  Created by wangkun on 15/4/5.
//  Copyright (c) 2015年 askpi. All rights reserved.
//

#import "NoteTableViewCell.h"

@implementation NoteTableViewCell

#define kTypeLabelMarginX       (10)
#define kTypeLabelMarginY       (2)

#define kDateLabelRightMargin   (10)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? YES : NO)

- (void)awakeFromNib {
    // Initialization code
}

- (void)addButtonMode
{
    _typeLabel.text = @"+Add...";
    _dateLabel.text = @"";
    if (IS_IPHONE) {
        _typeLabel.font = [UIFont systemFontOfSize:13.0f];
        _dateLabel.font = [UIFont systemFontOfSize:13.0f];
    }
}

- (void)setNote:(Note *)note
{
    _note = note;

    NSString *tyepString = @"Unknown type";
    if (note.notetext!=nil
        && note.notetext.length > 0)
    {
        tyepString = @"Text Note";
        _type = NoteTableViewCellText;
    }
    else if (note.noteimage !=nil
             && note.noteimage.length > 0)
    {
        tyepString = @"Image Note";
        _type = NoteTableViewCellImage;
    }
    else if(note.noterecording !=nil
            && note.noterecording.length > 0)
    {
        tyepString = @"Recording Note";
        _type = NoteTableViewCellRecording;
    }
    
    _typeLabel.text = [NSString stringWithFormat:@"%@ | %@", note.notetitle, tyepString];
    if (note.timestamp != nil
        && note.timestamp.length > 0)
    {
        NSTimeInterval timestamp = [note.timestamp doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        NSDateFormatter *dateFormat = [NSDateFormatter new];
        [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
        NSString *dateString = [dateFormat stringFromDate:date];

        _dateLabel.text = [NSString stringWithFormat:@"%@",dateString];
        
        if (IS_IPHONE) {
            _typeLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
            _dateLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
        }
    }
    else
    {
        _dateLabel.text = @"";
        
        if (IS_IPHONE) {
            _typeLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
            _dateLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
        }
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _typeLabel.textColor = [UIColor blackColor];
        [self addSubview:_typeLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel.textColor = [UIColor blackColor];
        [self addSubview:_dateLabel];
     
        _type = NoteTableViewCellUnknown;
        
        if (IS_IPHONE) {
            _typeLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];///[UIFont systemFontOfSize:12.0f];
            _dateLabel.font = [UIFont fontWithName:@"Myriad Pro" size:12.0f];//[UIFont systemFontOfSize:12.0f];
        }
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _typeLabel.frame = CGRectMake(kTypeLabelMarginX,
                                  kTypeLabelMarginY,
                                  self.bounds.size.width / 2,
                                  self.bounds.size.height - kTypeLabelMarginY * 2);
    
    _dateLabel.frame = CGRectMake(self.frame.size.width - (self.bounds.size.width / 4) - kDateLabelRightMargin,
                                  _typeLabel.frame.origin.y,
                                  self.bounds.size.width / 4,
                                  _typeLabel.frame.size.height);
}

@end
