//
//  YBZFreeTranslationViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZFreeTranslationViewController.h"

@interface YBZFreeTranslationViewController ()

@property (nonatomic , strong) UIButton *CN_EN;
@property (nonatomic , strong) UIButton *CN_JP;
@property (nonatomic , strong) UIButton *CN_FR;
@property (nonatomic , strong) UIButton *CN_DE;//德语
@property (nonatomic , strong) UIButton *CN_IT;//意大利
@property (nonatomic , strong) UIButton *CN_ES;//西班牙
@property (nonatomic , strong) UIButton *CN_PT;//葡萄牙


@end

@implementation YBZFreeTranslationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.CN_EN];
    [self.view addSubview:self.CN_JP];
    [self.view addSubview:self.CN_FR];
    [self.view addSubview:self.CN_DE];
    [self.view addSubview:self.CN_IT];
    [self.view addSubview:self.CN_ES];
}

#pragma mark - getters

- (UIButton *)CN_EN{
    
    if (!_CN_EN) {
        _CN_EN = [[UIButton alloc]initWithFrame:CGRectMake(20, 80, UIScreenWidth-40, 60)];
        [_CN_EN setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _CN_EN.backgroundColor = [UIColor greenColor];
        
    }
    return _CN_EN;
}

- (UIButton *)CN_JP{
    
    if (!_CN_JP) {
        _CN_JP = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.CN_EN.frame) + 20, UIScreenWidth-40, 60)];
        [_CN_JP setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _CN_JP.backgroundColor = [UIColor greenColor];
        
    }
    return _CN_JP;
}

- (UIButton *)CN_FR{
    
    if (!_CN_FR) {
        _CN_FR = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.CN_JP.frame) + 20, UIScreenWidth-40, 60)];
        [_CN_FR setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _CN_FR.backgroundColor = [UIColor greenColor];
        
    }
    return _CN_FR;
}

- (UIButton *)CN_DE{
    
    if (!_CN_DE) {
        _CN_DE = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.CN_FR.frame) + 20, UIScreenWidth-40, 60)];
        [_CN_DE setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _CN_DE.backgroundColor = [UIColor greenColor];
        
    }
    return _CN_DE;
}

- (UIButton *)CN_IT{
    
    if (!_CN_IT) {
        _CN_IT = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.CN_DE.frame) + 20, UIScreenWidth-40, 60)];
        [_CN_IT setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _CN_IT.backgroundColor = [UIColor greenColor];
        
    }
    return _CN_IT;
}

- (UIButton *)CN_ES{
    
    if (!_CN_ES) {
        _CN_ES = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.CN_IT.frame) + 20, UIScreenWidth-40, 60)];
        [_CN_ES setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _CN_ES.backgroundColor = [UIColor greenColor];
        
    }
    return _CN_ES;
}

@end
