//
//  YBZProductListViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZProductListViewController.h"
#import "YBZProductDetailInfoViewController.h"
@interface YBZProductListViewController ()

@property(nonatomic,strong) UIButton *selectProductBtn;

@end

@implementation YBZProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.selectProductBtn];
}


#pragma mark - 点击事件
-(void)intoProductDetailInfoClick{
    
    YBZProductDetailInfoViewController *detailVC = [[YBZProductDetailInfoViewController alloc]initWithTitle:@"产品详情"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark -getters

-(UIButton *)selectProductBtn{
    
    if (!_selectProductBtn) {
        _selectProductBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectProductBtn setTitle:@"选择该产品" forState:UIControlStateNormal];
        _selectProductBtn.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 80);
        _selectProductBtn.backgroundColor = [UIColor redColor];
        [_selectProductBtn addTarget:self action:@selector(intoProductDetailInfoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectProductBtn;
}



@end
