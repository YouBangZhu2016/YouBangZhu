//
//  AccountAndSafeViewController.m
//  YBZHelper
//
//  Created by guozhiwei on 16/7/14.
//  Copyright © 2016年 guozhiwei. All rights reserved
//

#import "AccountAndSafeViewController.h"
#import "AccountTableViewCell.h"
#import "AccountAndSafeOtherTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "WebAgent.h"
#import "APIClient.h"
#import "EmailViewController.h"

@interface AccountAndSafeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *accountandsafeTabView;
@property (nonatomic , strong) NSDictionary *dataDic;
@property (nonatomic , strong) NSDictionary *stateDic;
@property (nonatomic , strong) NSMutableArray *dataArr;
@property (nonatomic , strong) NSString *Img;
@end

@implementation AccountAndSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];

    [WebAgent userGetInfo:user_id[@"user_id"] success:^(id responseObject) {
        NSData *data = [[NSData alloc]initWithData:responseObject];
        self.dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSLog(@"%@",self.dataDic);
        self.dataArr = [NSMutableArray arrayWithCapacity:2];
        [self.dataArr addObject:[self.dataDic objectForKey:@"user_phone"]];
        [self.dataArr addObject:[self.dataDic objectForKey:@"user_email"]];
        self.stateDic = @{@"account_state":[self.dataDic objectForKey:@"account_state"],
                          @"user_phone":[self.dataDic objectForKey:@"user_phone"],
                          @"user_email":[self.dataDic objectForKey:@"user_email"]};
      
        [userDefaults setObject:self.stateDic forKey:@"account_state"];
        [self.accountandsafeTabView reloadData];
        [self.accountandsafeTabView layoutIfNeeded];
    } failure:^(NSError *error) {
        NSLog(@"cuole");
    }];
    
    self.navigationItem.title = @"账号与安全";
    self.accountandsafeTabView.delegate = self;
    self.accountandsafeTabView.dataSource = self;
    [self.view addSubview:self.accountandsafeTabView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEmailAdress:) name:@"changeEmailAdress" object:nil];
}

-(void)changeEmailAdress:(NSNotification *)noti
{
    //重新加载页面
    [self.accountandsafeTabView reloadData];
    [self.accountandsafeTabView layoutIfNeeded];
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
    
    [WebAgent userGetInfo:user_id[@"user_id"] success:^(id responseObject) {
        NSData *data = [[NSData alloc]initWithData:responseObject];
        self.dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSLog(@"%@",self.dataDic);
        self.dataArr = [NSMutableArray arrayWithCapacity:2];
        [self.dataArr addObject:[self.dataDic objectForKey:@"user_phone"]];
        [self.dataArr addObject:[self.dataDic objectForKey:@"user_email"]];
        self.stateDic = @{@"account_state":[self.dataDic objectForKey:@"account_state"],
                          @"user_phone":[self.dataDic objectForKey:@"user_phone"],
                          @"user_email":[self.dataDic objectForKey:@"user_email"]};
        
        [userDefaults setObject:self.stateDic forKey:@"account_state"];
        [self.accountandsafeTabView reloadData];
        [self.accountandsafeTabView layoutIfNeeded];
    } failure:^(NSError *error) {
        NSLog(@"cuole");
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeEmailAdress" object:nil];
}
#pragma mark - getters

-(UITableView *)accountandsafeTabView
{
    if(!_accountandsafeTabView){
        _accountandsafeTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    }
    return _accountandsafeTabView;
}

#pragma mark － 表示图协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else
        return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *myDictionary = [userinfo dictionaryForKey:@"account_state"];
    NSString *accountSafe = [userinfo objectForKey:@"accountSafe"];
    if(indexPath.section == 0)
    {
        AccountTableViewCell *autTableViewCell = [[AccountTableViewCell alloc]init];
        autTableViewCell.textLabel.text = @"账号";
        UILabel *accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.5, autTableViewCell.bounds.size.height*0.08, self.view.bounds.size.width * 0.5, autTableViewCell.contentView.bounds.size.height - 10)];
        accountLabel.backgroundColor = [UIColor whiteColor];
        accountLabel.text = [self.dataDic objectForKey:@"user_phone"];
        [autTableViewCell.contentView addSubview:accountLabel];
        return autTableViewCell;
    }
    else{
        if(indexPath.section == 1 && indexPath.row == 2){
            AccountAndSafeOtherTableViewCell *safecell = [[AccountAndSafeOtherTableViewCell alloc]init];
            safecell.textLabel.text = @"账号与安全";
            if (myDictionary[@"account_state"] != NULL) {
                
                      if([myDictionary[@"account_state"]  isEqual: @"1"]){
                    
                                    UIImageView *proImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.7,0, self.view.bounds.size.width*0.2, safecell.contentView.bounds.size.height*0.9)];
                                    proImg.image = [UIImage imageNamed:@"protectimage"];
                    
                                    [safecell.contentView addSubview:proImg];
                                    self.Img = @"YES";
                      }
            }else if([accountSafe isEqual: @"1"]){
                
                    UIImageView *proImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.7,0, self.view.bounds.size.width*0.2, safecell.contentView.bounds.size.height*0.9)];
                    proImg.image = [UIImage imageNamed:@"protectimage"];
                    
                    [safecell.contentView addSubview:proImg];
                    self.Img = @"YES";
            }
             return safecell;
            
        }
        else
        {
            if(indexPath.section == 1 && indexPath.row == 0)
            {
                AccountAndSafeOtherTableViewCell *phonecell = [[AccountAndSafeOtherTableViewCell alloc]init];
                phonecell.textLabel.text = @"手机号";
                UILabel *otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.5, phonecell.bounds.size.height*0.08, self.view.bounds.size.width * 0.4, phonecell.contentView.bounds.size.height - 10)];
                otherLabel.text = myDictionary[@"user_phone"];
                 [phonecell.contentView addSubview:otherLabel];
                return phonecell;
            }
            else
            {
                AccountAndSafeOtherTableViewCell *emailcell = [[AccountAndSafeOtherTableViewCell alloc]init];
                emailcell.textLabel.text = @"邮箱";
                UILabel *otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.5, emailcell.bounds.size.height*0.08, self.view.bounds.size.width * 0.4, emailcell.contentView.bounds.size.height - 10)];
                otherLabel.text = myDictionary[@"user_email"];
                [emailcell.contentView addSubview:otherLabel];
                return emailcell;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0)
        return 5;
    else
        return 7;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height*0.074;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 && indexPath.row == 1){
        EmailViewController *emailVC = [[EmailViewController alloc]init];
        [self.navigationController pushViewController:emailVC animated:YES];
    }

}
@end