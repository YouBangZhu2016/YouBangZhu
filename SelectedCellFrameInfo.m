//
//  CellFrameInfo.m
//  travel
//
//  Created by sks on 16/7/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "SelectedCellFrameInfo.h"
#define kSubViewHorizontalMargin  16
#define kSubViewVerticalMargin    16

@interface SelectedCellFrameInfo()
@property (nonatomic, strong) PlaceNameModel *placeName;

@end

@implementation SelectedCellFrameInfo

- (instancetype)initWithPlaceName:(PlaceNameModel *)placeName
{
    self = [super init];
    if (self) {
        self.placeName = placeName;
        
        CGSize size = [placeName.placeName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
//        self.placeNameLabelFrame = CGRectMake(kSubViewHorizontalMargin, kSubViewVerticalMargin, size.width, size.height);
        self.placeNameLabelFrame = CGRectMake(kSubViewHorizontalMargin, kSubViewVerticalMargin, 200, size.height);
        size =[placeName.selected sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        self.selectedLabelFrame = CGRectMake([[UIScreen mainScreen] bounds].size.width - kSubViewHorizontalMargin - size.width , kSubViewVerticalMargin, size.width , size.height);
        self.cellHeight = self.placeNameLabelFrame.origin.y + 2 * kSubViewVerticalMargin;
    }
    return self;
}
@end
