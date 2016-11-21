//
//  OpponentsFlowLayout.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/25/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpponentsFlowLayout : UICollectionViewFlowLayout

+ (CGRect)frameForWithNumberOfItems:(NSUInteger)numberOfItems row:(NSUInteger)row contentSize:(CGSize)contentSize;

@end
