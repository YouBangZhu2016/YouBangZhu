//
//  LocCellFrameInfo.m
//  travel
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "LocCellFrameInfo.h"
#define kSubViewHorizontalMargin  16
#define kSubViewVerticalMargin    16
#define kImageViewWidth           50
#define kImageViewHeigjht         50

@interface LocCellFrameInfo()
@property (nonatomic, strong) PlaceNameModel *locationPlace;

@end
@implementation LocCellFrameInfo
- (instancetype)initWithLocationPlace:(PlaceNameModel *)locationPlace
{
    self = [super init];
    if (self) {
        if(self)
        {
            self.locationPlace = locationPlace;
            
            self.imageViewFrame = CGRectMake(kSubViewHorizontalMargin, kSubViewVerticalMargin, kImageViewWidth, kImageViewHeigjht);
            
            CGSize size = [locationPlace.locationPlaceName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
            self.locationPlaceLabelFrame = CGRectMake(self.imageViewFrame.size.width + kSubViewHorizontalMargin, kSubViewVerticalMargin, 300, size.height);
            self.cellHeight = self.imageViewFrame.size.height + 2 * kSubViewVerticalMargin;
        }
    }
    return self;
}

@end
