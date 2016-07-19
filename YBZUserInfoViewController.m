//
//  YBZUserInfoViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZUserInfoViewController.h"
//#import "YBZNickNameViewController.h"
//#import "YBZLocationViewController.h"
//#import "YBZPersonalSignViewController.h"

@interface YBZUserInfoViewController ()

@property(nonatomic,strong) UIButton *nickNameBtn;
@property(nonatomic,strong) UIButton *locationBtn;
@property(nonatomic,strong) UIButton *personalSignBtn;


@end

@implementation YBZUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.nickNameBtn];
    [self.view addSubview:self.locationBtn];
    [self.view addSubview:self.personalSignBtn];
}

#pragma mark - 点击事件
-(void)changeUserNickNameClick{
    
//    YBZNickNameViewController *nickVC = [[YBZNickNameViewController alloc]initWithTitle:@"修改昵称"];
//    [self.navigationController pushViewController:nickVC animated:YES];
    
}

-(void)changeLocationInfoClick{
//    YBZLocationViewController *locationVC = [[YBZLocationViewController alloc]initWithTitle:@"修改地区"];
//    [self.navigationController pushViewController:locationVC animated:YES];
}

-(void)changePersonalSignClick{
//    YBZPersonalSignViewController *signVC = [[YBZPersonalSignViewController alloc]initWithTitle:@"个性签名"];
//    [self.navigationController pushViewController:signVC animated:YES];
    
}
#pragma mark - getters

-(UIButton *)nickNameBtn{
    
    if (!_nickNameBtn) {
        _nickNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nickNameBtn setTitle:@"昵称" forState:UIControlStateNormal];
        _nickNameBtn.frame = CGRectMake(0,  100, [UIScreen mainScreen].bounds.size.width, 80);
        _nickNameBtn.backgroundColor = [UIColor redColor];
        [_nickNameBtn addTarget:self action:@selector(changeUserNickNameClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nickNameBtn;
}
-(UIButton *)locationBtn{
    
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setTitle:@"地区" forState:UIControlStateNormal];
        _locationBtn.frame = CGRectMake(0, 200 + 10, [UIScreen mainScreen].bounds.size.width, 80);
        _locationBtn.backgroundColor = [UIColor redColor];
        [_locationBtn addTarget:self action:@selector(changeLocationInfoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationBtn;
}
-(UIButton *)personalSignBtn{
    
    if (!_personalSignBtn) {
        _personalSignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_personalSignBtn setTitle:@"个性签名" forState:UIControlStateNormal];
        _personalSignBtn.frame = CGRectMake(0, 300 + 10, [UIScreen mainScreen].bounds.size.width, 80);
        _personalSignBtn.backgroundColor = [UIColor redColor];
        [_personalSignBtn addTarget:self action:@selector(changePersonalSignClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _personalSignBtn;
}

@end
