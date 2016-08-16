//
//  BottomView.m
//  XWJTask
//
//  Created by sks on 16/8/3.
//  Copyright © 2016年 HuaXinSoftware. All rights reserved.
//

#import "BottomView.h"

@interface BottomView ()

@property (nonatomic , strong) UILabel *tiXianLabel;
@property (nonatomic , strong) UIImageView *youBiImageView;
@property (nonatomic , strong) UILabel *lineLabel;

@end

@implementation BottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tiXianLabel];
        [self addSubview:self.youBiImageView];
        [self addSubview:self.moneyTextField];
        [self addSubview:self.lineLabel];
        [self addSubview:self.eDuLabel];
        [self addSubview:self.allMoneyLabel];
        [self addSubview:self.getAllBut];
        [self addSubview:self.alertLabel];
        
    }
    return self;
}

#pragma mark - 控件的getters方法
-(UILabel *)tiXianLabel
{
    if (!_tiXianLabel) {
        _tiXianLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, 100, 20)];
        _tiXianLabel.text = @"悬赏金额";
    }
    return _tiXianLabel;
}

-(UIImageView *)youBiImageView
{
    if (!_youBiImageView) {
        _youBiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(22, self.tiXianLabel.frame.origin.y + 45, 26, 26)];
        _youBiImageView.image = [UIImage imageNamed:@"youBiLogal"];
        
    }
    return _youBiImageView;
}

-(UITextField *)moneyTextField
{
    if (!_moneyTextField) {
        _moneyTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.youBiImageView.frame.origin.x + 30, self.youBiImageView.frame.origin.y, [UIScreen mainScreen].bounds.size.width - 82, 60)];
        _moneyTextField.font = [UIFont systemFontOfSize:40];
        _moneyTextField.backgroundColor= [UIColor whiteColor];
        _moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
        [[UITextField appearance]setTintColor:[UIColor blackColor]];
    }
    return _moneyTextField;
}

-(UILabel *)lineLabel
{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.moneyTextField.frame.origin.y + 70, 345, 1.5)];
        _lineLabel.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
    }
    return _lineLabel;
}

-(UILabel *)eDuLabel
{
    if (!_eDuLabel) {
        CGSize size = [@"游币账户余额，" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _eDuLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, self.lineLabel.frame.origin.y + 10, size.width, size.height)];
        _eDuLabel.text = @"游币账户余额，";
        _eDuLabel.font = [UIFont systemFontOfSize:14];
        _eDuLabel.textColor = [UIColor colorWithRed:87 / 255.0 green:134 / 255.0 blue:157 / 255.0 alpha:1];
    }
    return _eDuLabel;
}

-(UILabel *)allMoneyLabel
{
    if (!_allMoneyLabel) {
        NSString *amountYouBi = @"3500";
        NSString *labelText = [NSString stringWithFormat:@"%@游币。",amountYouBi];
        CGSize size = [labelText sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _allMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.eDuLabel.frame.origin.x + self.eDuLabel.bounds.size.width + 5, self.eDuLabel.frame.origin.y, size.width, size.height)];
        _allMoneyLabel.text = labelText;
        _allMoneyLabel.font = [UIFont systemFontOfSize:14];
        _allMoneyLabel.textColor = [UIColor colorWithRed:87 / 255.0 green:134 / 255.0 blue:157 / 255.0 alpha:1];
    }
    return _allMoneyLabel;
}

-(UILabel *)alertLabel
{
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, self.lineLabel.frame.origin.y + 30, 200 , 20)];
        _alertLabel.backgroundColor = [UIColor whiteColor];
        _alertLabel.text = @"游币账户余额不足";
        _alertLabel.font = [UIFont systemFontOfSize:14];
        _alertLabel.textColor = [UIColor redColor];
        _alertLabel.hidden = YES;
    }
    return _alertLabel;
}

@end
