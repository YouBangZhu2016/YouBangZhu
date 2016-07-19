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
@interface AccountAndSafeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *accountandsafeTabView;
@end

@implementation AccountAndSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号与安全";
    self.accountandsafeTabView.delegate = self;
    self.accountandsafeTabView.dataSource = self;
    [self.view addSubview:self.accountandsafeTabView];
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
        return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        AccountTableViewCell *autTableViewCell = [[AccountTableViewCell alloc]init];
        autTableViewCell.textLabel.text = @"账号";
        return autTableViewCell;
        
    }
    else{
        if(indexPath.section == 1 && indexPath.row == 4)
        {
            AccountAndSafeOtherTableViewCell *safecell = [[AccountAndSafeOtherTableViewCell alloc]init];
            safecell.textLabel.text = @"账号与安全";
            UIImageView *proImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.7,0, self.view.bounds.size.width*0.2, safecell.contentView.bounds.size.height*0.9)];
            proImg.image = [UIImage imageNamed:@"protectimage"];
            
            [safecell.contentView addSubview:proImg];
            return safecell;
        }
        else
        {
            NSArray *textlablearr = @[@"QQ号",@"手机号",@"邮箱地址",@"密码"];
            NSMutableArray *cellarr = [NSMutableArray arrayWithCapacity:textlablearr.count];
            for(int i = 0;i < textlablearr.count;i ++)
            {
                AccountAndSafeOtherTableViewCell *othercell = [[AccountAndSafeOtherTableViewCell alloc]init];
                othercell.textLabel.text = textlablearr[i];
                [cellarr addObject:othercell];
            }
            return cellarr[indexPath.row];
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
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


@end