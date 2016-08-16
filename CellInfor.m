//
//  CellInfor.m
//  Language
//
//  Created by sks on 16/8/10.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import "CellInfor.h"

#define kScreenWindth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

#define languageX                0.066*kScreenWindth
#define languageY                0.025*kScreenHeight

#define languageImageX           0.906*kScreenWindth
#define languageImageY           0.025*kScreenHeight
#define languageImageWindth      0.05*kScreenWindth
#define languageImageHeight      0.017*kScreenHeight


@implementation CellInfor
- (instancetype)initWithInfor:(Infor *)information
{
    self = [super init];
    if (self) {
        
        //语言
        CGSize size = [information.language sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
        self.languageLabelFrame = CGRectMake(languageX, languageY, size.width, size.height);
        
        //确定图标
        self.languageImageFrame = CGRectMake(languageImageX, languageImageY, languageImageWindth, languageImageHeight);
        
        //cell高度
        self.cellHeight = size.height + languageY + 10;
        
    }
    return self;
}

@end
