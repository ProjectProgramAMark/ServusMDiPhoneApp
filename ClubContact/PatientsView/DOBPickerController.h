//
//  DOBPickerController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 7/11/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DOBPickerControllerDelegate <NSObject>   //define delegate protocol
- (void) selectedDOBDate:(NSData *)date;  //define delegate method to be implemented within another class
@end


@interface DOBPickerController : UIViewController {
    IBOutlet UIDatePicker *datePicker;
}

@property (nonatomic, retain) NSString *dobDate;
@property (nonatomic, weak) id <DOBPickerControllerDelegate> delegate;

@end
