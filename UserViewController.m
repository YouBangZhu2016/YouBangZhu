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
#import "WebAgent.h"
#import "YBZLoginViewController.h"
#import "YBZBaseNaviController.h"

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,copy)NSString *url;
@property (nonatomic , strong) NSString *isLogin;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.mainTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTextALabel:) name:@"setTextALabel" object:nil];
}

//观察者方法
-(void)setTextALabel:(NSNotification *)noti{
    NSDictionary *textDic = [noti userInfo];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    UserTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:index];
    cell.nameLable.text = [textDic objectForKey:@"文本"];
    [self.mainTableView reloadData];
    [self.mainTableView layoutIfNeeded];
}
-(void)dealloc{
    //    free((__bridge void *)(self.textALabel));
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"setTextALabel" object:nil];
}
//行数


//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
//    
//    
//    view.tintColor = [UIColor redColor];
//}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
//    view.tintColor = [UIColor redColor];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if(section == 0)
    {
        return 1;
    }
    else
    {
        if(section == 1)
        {
            return 3;
        }
        else
        {
            if(section == 2)
            {
                return 2;
            }
            else
            {
                return 1;
            }
        }
    }

}

//分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0)
        return 12;
    else
        return 0;
}

//样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTableViewCell *cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
    NSInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//最右边>号
    if ( section == 0 && row == 0) {
        //----------------------------
        
        NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
        NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
        if(user_id[@"user_id"] == NULL)
        {
            cell.imgView.image = [UIImage imageNamed:@"head"];
            //cell.imageView.backgroundColor = [UIColor redColor];
            cell.nameLable.text = @"登录／注册";
        }
        else
        {
            [WebAgent userLoginState:user_id[@"user_id"] success:^(id responseObject) {
                cell.imageView.image = [UIImage imageNamed:@"head"];
                NSData *data = [[NSData alloc]initWithData:responseObject];
                NSDictionary *str= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                self.isLogin = str[@"state"];
                NSLog(@"%@",self.isLogin);
                if ([self.isLogin  isEqual: @"1"]) {
                    cell.imgView.image = [UIImage imageNamed:@"head"];
                    [WebAgent userid:user_id[@"user_id"] success:^(id responseObject) {
                        NSData *data = [[NSData alloc]initWithData:responseObject];
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSDictionary *userInfo = dic[@"user_info"];
                        
                        cell.nameLable.text = userInfo[@"user_nickname"];
                        
                    }failure:^(NSError *error) {
                        NSLog(@"%@",error);
                    }];
                    
                }else{
                    cell.imgView.image = [UIImage imageNamed:@"head"];
                    //cell.imageView.backgroundColor = [UIColor redColor];
                    cell.nameLable.text = @"登录／注册";
                }
                
            }
                             failure:^(NSError *error) {
                                 NSLog(@"22222");
                             }];
        }
         return cell;
    }
        else
        {
            if ( section == 1 && row == 0)
            {
                cell.imageView.image = [UIImage imageNamed:@"order"];
                cell.nameLable.text = @"我的订单";
                 return cell;
            }
            else
            {
                if ( section == 1 && row == 1)
                {
                    cell.imageView.image = [UIImage imageNamed:@"collect"];
                    cell.nameLable.text = @"我的收藏";
                     return cell;
                }
                else
                {
                    if ( section == 1 && row == 2)
                    {
                        cell.imageView.image = [UIImage imageNamed:@"money"];
                        cell.nameLable.text = @"我的悬赏";
                         return cell;
                    }
                    else
                    {
                        if ( section == 2 && row == 0)
                        {
                            cell.imageView.image = [UIImage imageNamed:@"push"];
                            cell.nameLable.text = @"电子钱包";
                             return cell;
                        }
                        else
                        {
                            if ( section == 2 && row == 1)
                            {
                                cell.imageView.image = [UIImage imageNamed:@"set"];
                                cell.nameLable.text = @"设置";
                                 return cell;
                            }
                            else
                            {
                                
                                cell.imageView.image = [UIImage imageNamed:@"youbangzhuapp"];
                                cell.nameLable.text = @"游帮主app";
                                 return cell;
                            }
                        }
                    }
                }
                
            }
        }
        
   
    
}
//    if ( section == 1 && row == 0) {
//        
//        cell.imageView.image = [UIImage imageNamed:@"order"];
//        cell.nameLable.text = @"我的订单";
//        
//    }
//    
//    if ( section == 1 && row == 1) {
//        
//        cell.imageView.image = [UIImage imageNamed:@"collect"];
//        cell.nameLable.text = @"我的收藏";
//        
//    }
//    
//    if ( section == 1 && row == 2) {
//        
//        cell.imageView.image = [UIImage imageNamed:@"money"];
//        cell.nameLable.text = @"我的悬赏";
//    
//    }
//    
//    if ( section == 2 && row == 0) {
//        
//        cell.imageView.image = [UIImage imageNamed:@"push"];
//        cell.nameLable.text = @"电子钱包";
//        
//    }
//    
//    if ( section == 2 && row == 1) {
//        
//        cell.imageView.image = [UIImage imageNamed:@"set"];
//        cell.nameLable.text = @"设置";
//        
//    }
//    
//    if ( section == 3 && row == 0) {
//        
//        cell.imageView.image = [UIImage imageNamed:@"youbangzhuapp"];
//        cell.nameLable.text = @"游帮主app";
//        
//    }





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
    
    
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
    if(user_id[@"user_id"] == NULL)
    {
        YBZLoginViewController *logVC = [[YBZLoginViewController alloc]initWithTitle:@"登录"];
        YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:logVC];
        logVC.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        [WebAgent userLoginState:user_id[@"user_id"] success:^(id responseObject) {
            NSData *data = [[NSData alloc]initWithData:responseObject];
            NSDictionary *str= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.isLogin = str[@"state"];
            NSLog(@"%@",self.isLogin);
            if ([self.isLogin  isEqual: @"1"]) {
                EditViewController *userInfoVC = [[EditViewController alloc]init];
                userInfoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:userInfoVC animated:YES];
                
            }else{
                YBZLoginViewController *logVC = [[YBZLoginViewController alloc]initWithTitle:@"登录"];
                YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:logVC];
                logVC.view.backgroundColor = [UIColor whiteColor];
                [self presentViewController:nav animated:YES completion:nil];
            }
            
            
        }
        failure:^(NSError *error) {
                             NSLog(@"22222");
                    }];
    }
    }

-(void)intoMyOrderListClick{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
    if(user_id[@"user_id"] == NULL)
    {
        YBZLoginViewController *logVC = [[YBZLoginViewController alloc]initWithTitle:@"登录"];
        YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:logVC];
        logVC.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        [WebAgent userLoginState:user_id[@"user_id"] success:^(id responseObject) {
            NSData *data = [[NSData alloc]initWithData:responseObject];
            NSDictionary *str= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.isLogin = str[@"state"];
            NSLog(@"%@",self.isLogin);
            if ([self.isLogin  isEqual: @"1"]) {
                YBZUserOrderViewController *userOrderVC = [[YBZUserOrderViewController alloc]initWithTitle:@"我的订单"];
                
                [self.navigationController pushViewController:userOrderVC animated:YES];
                
            }else{
                YBZLoginViewController *logVC = [[YBZLoginViewController alloc]initWithTitle:@"登录"];
                YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:logVC];
                logVC.view.backgroundColor = [UIColor whiteColor];
                [self presentViewController:nav animated:YES completion:nil];
            }
            
            
        }
                         failure:^(NSError *error) {
                             NSLog(@"22222");
                         }];
    }
    
    
}

-(void)intoMyFavoritePageClick{
    
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
    if(user_id[@"user_id"] == NULL)
    {
        YBZLoginViewController *logVC = [[YBZLoginViewController alloc]initWithTitle:@"登录"];
        YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:logVC];
        logVC.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        [WebAgent userLoginState:user_id[@"user_id"] success:^(id responseObject) {
            NSData *data = [[NSData alloc]initWithData:responseObject];
            NSDictionary *str= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.isLogin = str[@"state"];
            NSLog(@"%@",self.isLogin);
            if ([self.isLogin  isEqual: @"1"]) {
                YBZUserFavoriteViewController *favVC = [[YBZUserFavoriteViewController alloc]initWithTitle:@"我的收藏"];
                
                [self.navigationController pushViewController:favVC animated:YES];
                
            }else{
                YBZLoginViewController *logVC = [[YBZLoginViewController alloc]initWithTitle:@"登录"];
                YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:logVC];
                logVC.view.backgroundColor = [UIColor whiteColor];
                [self presentViewController:nav animated:YES completion:nil];
                
            }
            
        }
                         failure:^(NSError *error) {
                             NSLog(@"22222");
                         }];
    }
    
}

-(void)intoMyEwalletsPageClick{
    
    YBZUserEwalletsViewController *EwalletsVC = [[YBZUserEwalletsViewController alloc]initWithTitle:@"电子钱包"];
    
    [self.navigationController pushViewController:EwalletsVC animated:YES];
    
}

-(void)intoInfoSettingClick{
    
    
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
    if(user_id[@"user_id"] == NULL)
    {
        YBZLoginViewController *logVC = [[YBZLoginViewController alloc]initWithTitle:@"登录"];
        YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:logVC];
        logVC.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:nav animated:YES completion:nil];
        
        

    }
    else
    {
        [WebAgent userLoginState:user_id[@"user_id"] success:^(id responseObject) {
            NSData *data = [[NSData alloc]initWithData:responseObject];
            NSDictionary *str= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.isLogin = str[@"state"];
            NSLog(@"%@",self.isLogin);
            if ([self.isLogin  isEqual: @"1"]) {
                UserSetViewController *settingVC = [[UserSetViewController alloc]init];
                
                [self.navigationController pushViewController:settingVC animated:YES];
                
            }else{
                YBZLoginViewController *logVC = [[YBZLoginViewController alloc]initWithTitle:@"登录"];
                YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:logVC];
                logVC.view.backgroundColor = [UIColor whiteColor];
                [self presentViewController:nav animated:YES completion:nil];
                
            }
            
        }
                         failure:^(NSError *error) {
                             NSLog(@"22222");
                         }];
        //============
       
    }
    
}

#pragma mark - getters

-(UITableView *)mainTableView{
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
        
        //_mainTableView.backgroundColor = [UIColor colorWithRed:209 / 255.0 green:209 / 255.0 blue:209/ 255.0 alpha:1];
//        _mainTableView.backgroundColor = [UIColor grayColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
    }
    return _mainTableView;
}
@end