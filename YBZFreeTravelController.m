//
//  YBZFreeTravelController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZFreeTravelController.h"
//#import "YBZLocationViewController.h"
#import "YBZProductDetailInfoViewController.h"
#import "YBZProductListViewController.h"

@interface YBZFreeTravelController ()

@property(nonatomic,strong) UIButton *changeLocationBtn;
@property(nonatomic,strong) UIButton *selectCountryBtn;
@property(nonatomic,strong) UIButton *selectProductBtn;

@end

@implementation YBZFreeTravelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.changeLocationBtn];
    [self.view addSubview:self.selectCountryBtn];
    [self.view addSubview:self.selectProductBtn];

}

#pragma mark - 点击事件

-(void)changeLocationBtnClick{
    
//    YBZLocationViewController *localVC = [[YBZLocationViewController alloc]initWithTitle:@"选择出发地"];
//    [self.navigationController pushViewController:localVC animated:YES];
}

-(void)selectCountryBtnClick{
    
    YBZProductListViewController *countryListVC = [[YBZProductListViewController alloc]initWithTitle:@"产品列表"];
    [self.navigationController pushViewController:countryListVC animated:YES];
    
}


-(void)selectProductBtnClick{
    YBZProductDetailInfoViewController *detailVC = [[YBZProductDetailInfoViewController alloc]initWithTitle:@"产品详情"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -getters

-(UIButton *)changeLocationBtn{
    
    if (!_changeLocationBtn) {
        _changeLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeLocationBtn setTitle:@"选择地区" forState:UIControlStateNormal];
        _changeLocationBtn.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 80);
        _changeLocationBtn.backgroundColor = [UIColor redColor];
        [_changeLocationBtn addTarget:self action:@selector(changeLocationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeLocationBtn;
}

-(UIButton *)selectCountryBtn{
    
    if (!_selectCountryBtn) {
        _selectCountryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectCountryBtn setTitle:@"选择国家" forState:UIControlStateNormal];
        _selectCountryBtn.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 80);
        _selectCountryBtn.backgroundColor = [UIColor redColor];
        [_selectCountryBtn addTarget:self action:@selector(selectCountryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectCountryBtn;
}

-(UIButton *)selectProductBtn{
    
    if (!_selectProductBtn) {
        _selectProductBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectProductBtn setTitle:@"选择产品" forState:UIControlStateNormal];
        _selectProductBtn.frame = CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 80);
        _selectProductBtn.backgroundColor = [UIColor redColor];
        [_selectProductBtn addTarget:self action:@selector(selectProductBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectProductBtn;
}


@end
