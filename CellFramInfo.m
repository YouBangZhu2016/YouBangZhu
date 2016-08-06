//
//  CellFramInfo.m
//  LLY_Friend
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 lly. All rights reserved.
//

#import "CellFramInfo.h"

#define kSubViewHorizontalMargin 12
#define kSubViewVerticalHeight  14
#define kScreenWith   [[UIScreen mainScreen]bounds].size.width

@interface CellFramInfo ()

@property(nonatomic,strong)InformationModel *infoModel;

@end

@implementation CellFramInfo

- (instancetype)initWithInformationModel:(InformationModel *)infoModel
{
    self = [super init];
    if (self) {
        self.infoModel = infoModel;
        
        CGSize nameSize = [infoModel.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        self.nameLableFrame = CGRectMake(kSubViewHorizontalMargin, kSubViewVerticalHeight, nameSize.width, nameSize.height);
        CGSize infoSize = [infoModel.receiveInfo sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        CGFloat receiveInfoLableX = kScreenWith-infoSize.width-kSubViewHorizontalMargin;
        CGFloat receiveInfoLableWidth = infoSize.width;
        CGFloat minReceiveInfoLableX = kScreenWith/2;
        if (receiveInfoLableX < minReceiveInfoLableX) {
            receiveInfoLableX = minReceiveInfoLableX;
            receiveInfoLableWidth = minReceiveInfoLableX;
        }
        self.receiveInfoLableFrame = CGRectMake(200, kSubViewVerticalHeight,kScreenWith-kSubViewHorizontalMargin-200, infoSize.height);
    }
    return self;
}
@end
