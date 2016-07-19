//
//  CellFrameInfo.m
//  Evaluate
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import "CellFrameInfo.h"


#define kSubViewHorizontalMargin 5//水平
#define kSubViewVerticalMargin   15//垂直
//头像的位置
#define kAvaterImageViweX        20
#define kAvaterImageViweY        5
#define kAvaterImageViweWidth    50
#define kAvaterImageViweHeight   50
//等级的位置
#define kGradeLabelWidth         100
#define kGradeLabelHeight        10
#define kGradeLabelY             10



@interface CellFrameInfo()
@end

@implementation CellFrameInfo

- (instancetype)initWithPeople:(PeoPle *)people
{
    self = [super init];
    if (self) {
        //头像
        self.avaterImageViweFrame = CGRectMake(kAvaterImageViweX, kAvaterImageViweY, kAvaterImageViweWidth, kAvaterImageViweHeight);
        
        //昵称
        CGSize size = [people.nickName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        CGFloat nickNameLabelX = self.avaterImageViweFrame.origin.x + self.avaterImageViweFrame.size.width + kSubViewHorizontalMargin;
        self.nickNameLabelFrame = CGRectMake(nickNameLabelX, kSubViewVerticalMargin,size.width, size.height);
        
        //等级
        CGFloat gradeLabelX = self.nickNameLabelFrame.origin.x+self.nickNameLabelFrame.size.width + kSubViewHorizontalMargin;
        self.gradeLabelFrame = CGRectMake(gradeLabelX, kGradeLabelY, kGradeLabelWidth, kGradeLabelHeight);
        
        //投诉
        size = [people.complaint sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        CGFloat complaintButtonX = self.gradeLabelFrame.origin.x + self.gradeLabelFrame.size.width + kSubViewHorizontalMargin;
        self.complaintButtonFrame = CGRectMake(complaintButtonX, kSubViewVerticalMargin, size.width, size.height);
        
        //cell高度
        self.cellHeight = self.avaterImageViweFrame.origin.y + self.avaterImageViweFrame.size.height + kSubViewVerticalMargin;
        
        
        
        
    }
    return self;
}


@end
