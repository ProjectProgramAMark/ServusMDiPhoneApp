//
//  MSGPatientGridCell.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/13/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSGPatientGridCell : UICollectionViewCell

@property (nonatomic, retain) IBOutlet UILabel *messageCountLabel;
@property (nonatomic, retain) IBOutlet UIImageView *profileIMG;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *smallCircleIMG;

@end
