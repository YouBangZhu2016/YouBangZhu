//
//  CellInfor.h
//  Language
//
//  Created by sks on 16/8/10.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Infor.h"

@interface CellInfor : NSObject

@property (nonatomic , assign) CGRect languageImageFrame;
@property (nonatomic , assign) CGRect languageLabelFrame;
@property (nonatomic , assign) CGFloat cellHeight;


// 数据源方法
- (instancetype)initWithInfor:(Infor *)information;


@end
