//
//  UserSetViewController.m
//  YBZHelper
//
//  Created by guozhiwei on 16/7/14.
//  Copyright © 2016年 guozhiwei. All rights reserved.
//

#import "UserSetViewController.h"
#import "UserSetTableViewCell.h"
#import "UserSetoutTableViewCell.h"
#import "AccountAndSafeViewController.h"
#import "AboutViewController.h"
#import "HelpViewController.h"
#import "YBZTranslationController.h"
#import "WebAgent.h"
#import "APIClient.h"
@interface UserSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *usersetTabView;
@property (nonatomic , strong) NSDictionary *dataDic;
@property (nonatomic , strong) NSDictionary *stateDic;

@end

@implementation UserSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.usersetTabView.delegate = self;
    self.usersetTabView.dataSource = self;
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];

    [WebAgent userGetInfo:user_id[@"user_id"] success:^(id responseObject) {
        NSData *data = [[NSData alloc]initWithData:responseObject];
        self.dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.stateDic = @{@"stateinfo":[self.dataDic objectForKey:@"account_state"]};
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.stateDic forKey:@"stateinfo"];
        
    } failure:^(NSError *error) {
        NSLog(@"cuole");
    }];
    self.navigationItem.title = @"设置";
     [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    [self.view addSubview:self.usersetTabView];
    
    
}

#pragma mark - getters

-(UITableView *)usersetTabView
{
    if(!_usersetTabView){
        _usersetTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    }
    return _usersetTabView;
}

#pragma mark － 表示图协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
        return 1;
    else
        return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0 && indexPath.section == 0){
        UserSetTableViewCell *setCell = [[UserSetTableViewCell alloc]init];
        setCell.textLabel.text = @"账号与安全";
        
        return setCell;}
    if(indexPath.row == 1 && indexPath.section == 0){
        UserSetTableViewCell *setCell = [[UserSetTableViewCell alloc]init];
        setCell.textLabel.text = @"通用";
        return setCell;
    }
    if(indexPath.row == 0 && indexPath.section == 1){
        UserSetTableViewCell *setCell = [[UserSetTableViewCell alloc]init];
        setCell.textLabel.text = @"帮助与反馈";
        return setCell;
    }
    if(indexPath.row == 1 && indexPath.section == 1){
        UserSetTableViewCell *setCell = [[UserSetTableViewCell alloc]init];
        setCell.textLabel.text = @"关于游帮主";
        return setCell;
    }
    else{
        UserSetoutTableViewCell *setCell = [[UserSetoutTableViewCell alloc]init];
        setCell.textLabel.text = @"退出登录";
        return setCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0)
        return 12;
    else
        return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height*0.074;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0){
        AccountAndSafeViewController *aasVC = [[AccountAndSafeViewController alloc]init];
        [self.navigationController pushViewController:aasVC animated:YES];
    }
    else
    {
        if(indexPath.section == 0 && indexPath.row == 1)
        {
            AccountAndSafeViewController *aasVC = [[AccountAndSafeViewController alloc]init];
            [self.navigationController pushViewController:aasVC animated:YES];
        }
        else{
            if(indexPath.section == 1 && indexPath.row == 0)
            {
                HelpViewController *aasVC = [[HelpViewController alloc]init];
                [self.navigationController pushViewController:aasVC animated:YES];
            }
            else{
                if(indexPath.section == 1 && indexPath.row == 1)
                {
                    AboutViewController *aasVC = [[AboutViewController alloc]init];
                    [self.navigationController pushViewController:aasVC animated:YES];
                }
                else
                {
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myDictionary"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"stateinfo"];
                    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
                    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
               
                    [WebAgent userLogout:user_id[@"user_id"] success:^(id responseObject) {
                        
                    } failure:^(NSError *error) {
                        
                    }];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"setTextALabel" object:nil];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
        
        }
    }
}

@end










