//
//  CellFrameInfo.h
//  Evaluate
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeoPle.h"
#import <UIKit/UIKit.h>

@interface CellFrameInfo : NSObject


@property (nonatomic , assign) CGRect avaterImageViweFrame;
@property (nonatomic , assign) CGRect nickNameLabelFrame;
@property (nonatomic , assign) CGRect gradeViewFrame;
@property (nonatomic , assign) CGRect complaintButtonFrame;
@property (nonatomic , assign) CGFloat cellHeight;





// 数据源方法
- (instancetype)initWithPeople:(PeoPle *)people;

@end
