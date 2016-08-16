//
//  TopView.m
//  XWJTask
//
//  Created by sks on 16/8/3.
//  Copyright © 2016年 HuaXinSoftware. All rights reserved.
//

#import "TopView.h"
#define kScreenW [UIScreen mainScreen] bounds].size.width
#define kScreenH [UIScreen mainScreen] bounds].size.height


@interface TopView ()

@property (nonatomic , strong) UILabel *leftLabel;

@end

@implementation TopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:251 / 255.0 green:251 / 255.0 blue:251 / 255.0 alpha:1];
        [self addSubview:self.leftLabel];
        [self addSubview:self.selectBankBut];
    }
    return self;
}

#pragma mark - 控件getters方法
-(UILabel *)leftLabel
{
    if (!_leftLabel) {
          _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 22.5, 100, 20)];
       _leftLabel.text = @"选择账户";
    }
    return _leftLabel;
}

-(UIButton *)selectBankBut
{
    if (!_selectBankBut) {
        
        _selectBankBut = [[UIButton alloc]initWithFrame:CGRectMake(self.leftLabel.frame.origin.x + 100, 45 / 2, 160, 20)];
        [_selectBankBut setTitle:@"游币账户" forState:UIControlStateNormal];
        [_selectBankBut setTitleColor:[UIColor colorWithRed:78 / 255.0 green:193 / 255.0 blue:228 / 255.0 alpha:1] forState:UIControlStateNormal];
        _selectBankBut.backgroundColor = [UIColor colorWithRed:251 / 255.0 green:251 / 255.0 blue:251 / 255.0 alpha:1];
        [_selectBankBut addTarget:self action:@selector(selectBankButClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _selectBankBut;
}

#pragma mark - 按钮的单击事件
-(void)selectBankButClick
{
    
}
@end
