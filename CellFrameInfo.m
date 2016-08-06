//
//  CellFrameInfo.m
//  Evaluate
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import "CellFrameInfo.h"



#define kScreenWindth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

//#define kSubViewHorizontalMargin 5//水平
//#define kSubViewVerticalMargin   15//垂直
//头像的位置
#define kAvaterImageViweX        0.109*kScreenWindth
#define kAvaterImageViweY        0.017*kScreenHeight
#define kAvaterImageViweWidth    0.109*kScreenWindth
#define kAvaterImageViweHeight   0.058*kScreenHeight
//等级的位置
#define kGradeViewWidth         0.28*kScreenWindth
#define kGradeViewHeight        0.035*kScreenHeight
#define kGradeViewY             0.035*kScreenHeight
#define kGradeViewX             0.35*kScreenWindth


//昵称
#define knickNameY             0.03*kScreenHeight
#define knickNameX             0.23*kScreenWindth

//昵称
#define kcomplaintY             0.046*kScreenHeight
#define kcomplaintX             0.75*kScreenWindth



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
            self.nickNameLabelFrame = CGRectMake(knickNameX, knickNameY,size.width, size.height);
            
            //等级
            //        CGFloat gradeViewX = self.nickNameLabelFrame.origin.x+self.nickNameLabelFrame.size.width + kSubViewHorizontalMargin;
            
            self.gradeViewFrame = CGRectMake(kGradeViewX, kGradeViewY, kGradeViewWidth, kGradeViewHeight);
            
            //投诉
            size = [people.complaint sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
            //        CGFloat complaintButtonX = self.gradeViewFrame.origin.x + self.gradeViewFrame.size.width + kSubViewHorizontalMargin;
            self.complaintButtonFrame = CGRectMake(kcomplaintX, kcomplaintY, size.width, size.height);
            
            //cell高度
            self.cellHeight = 0.092*kScreenHeight;

        
        
        
        
    }
    return self;
}


@end
