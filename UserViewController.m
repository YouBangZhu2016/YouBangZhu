//
//  UserViewController.m
//  YBZTravel
//
//  Created by sks on 16/7/12.
//  Copyright © 2016年 dongxin. All rights reserved.
//

#import "UserViewController.h"
#import "UserTableViewCell.h"
#import "YBZUserInfoViewController.h"
#import "YBZUserOrderViewController.h"
#import "YBZUserFavoriteViewController.h"
#import "YBZUserEwalletsViewController.h"
#import "UserSetViewController.h"
#import "EditViewController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,copy)NSString *url;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainTableView];
    
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    
    if (section == 0) {
        number = 1;
    }
    if (section == 1) {
        number = 3;
    }
    if (section == 2) {
        number = 2;
    }
    if (section == 3) {
        number = 1;
    }
    return number;

}

//分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

//设置header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
//样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTableViewCell *cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
    NSInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//最右边>号
    if ( section == 0 && row == 0) {
    
        cell.imageView.image = [UIImage imageNamed:@"head"];
        cell.nameLable.text = @"HUge";
    }
    
    if ( section == 1 && row == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"order"];
        cell.nameLable.text = @"我的订单";
        
    }
    
    if ( section == 1 && row == 1) {
        
        cell.imageView.image = [UIImage imageNamed:@"collect"];
        cell.nameLable.text = @"我的收藏";
        
    }
    
    if ( section == 1 && row == 2) {
        
        cell.imageView.image = [UIImage imageNamed:@"money"];
        cell.nameLable.text = @"我的悬赏";
    
    }
    
    if ( section == 2 && row == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"push"];
        cell.nameLable.text = @"电子钱包";
        
    }
    
    if ( section == 2 && row == 1) {
        
        cell.imageView.image = [UIImage imageNamed:@"set"];
        cell.nameLable.text = @"设置";
        
    }
    
    if ( section == 3 && row == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"youbangzhuapp"];
        cell.nameLable.text = @"游帮主app";
        
    }

    return cell;

}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 60;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    if ( section == 0 && row == 0) {

        [self intoUserDetailInfoClick];

    }
    if ( section == 1 && row == 0) {
        //v1.0不添加“我的订单”
//        [self intoMyOrderListClick];
        
    }
    if ( section == 1 && row == 1) {
        
        [self intoMyFavoritePageClick];
        
    }

    if ( section == 1 && row == 2) {
        
        //我的悬赏
        //v1.0不添加“我的悬赏”
        
    }

    if ( section == 2 && row == 0) {
        //v1.0不添加“电子钱包”
//        [self intoMyEwalletsPageClick];
        
    }

    if ( section == 2 && row == 1) {
        
        [self intoInfoSettingClick];
        
    }
    
    if ( section == 3 && row == 0) {
//        UIWebView *webView = [[UIWebView alloc]init];
//        webView.delegate = self;
//        NSURL *url = [[NSURL alloc]initWithString:@"http://www.baidu.com"];
//        NSLog(@"%@-url地址",url);
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [webView loadRequest:request];
//        webView.opaque = NO;
//        webView.backgroundColor = [UIColor redColor];
//        self.view = webView;
        
    }

}

#pragma mark - 跳转事件

-(void)intoUserDetailInfoClick{
    
    EditViewController *userInfoVC = [[EditViewController alloc]init];
    userInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userInfoVC animated:YES];
    
    
}

-(void)intoMyOrderListClick{
    
    YBZUserOrderViewController *userOrderVC = [[YBZUserOrderViewController alloc]initWithTitle:@"我的订单"];
    
    [self.navigationController pushViewController:userOrderVC animated:YES];
    
}

-(void)intoMyFavoritePageClick{
    
    YBZUserFavoriteViewController *favVC = [[YBZUserFavoriteViewController alloc]initWithTitle:@"我的收藏"];
    
    [self.navigationController pushViewController:favVC animated:YES];
    
}

-(void)intoMyEwalletsPageClick{
    
    YBZUserEwalletsViewController *EwalletsVC = [[YBZUserEwalletsViewController alloc]initWithTitle:@"电子钱包"];
    
    [self.navigationController pushViewController:EwalletsVC animated:YES];
    
}

-(void)intoInfoSettingClick{
    
    
    UserSetViewController *settingVC = [[UserSetViewController alloc]init];
    
    [self.navigationController pushViewController:settingVC animated:YES];
    
}

#pragma mark - getters

-(UITableView *)mainTableView{
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
                _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}
@end