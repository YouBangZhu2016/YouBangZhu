//
//  ViewController.m
//  assistAndFreedbackInformation
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 heyi. All rights reserved.
//

#import "HelpViewController.h"
#import "matter.h"

@interface HelpViewController ()<UITabBarDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *mainTableView;
@property (nonatomic ,strong) NSArray *dataArr;
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *assistAndFreedbackInfoemationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    assistAndFreedbackInfoemationLabel.text = @"帮助与反馈";
    assistAndFreedbackInfoemationLabel.textAlignment = NSTextAlignmentCenter;
    assistAndFreedbackInfoemationLabel.font = [UIFont systemFontOfSize:23.0];
    assistAndFreedbackInfoemationLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:assistAndFreedbackInfoemationLabel];
    
    
    UITextField *search = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44)];
    search.placeholder = @"🔍搜索";
    
    [self.view addSubview:search];
    
    
    UILabel *matterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 104, self.view.bounds.size.width, 40)];
    matterLabel.text = @"  热点问题";
    matterLabel.font = [UIFont systemFontOfSize:23.0];
    [self.view addSubview:matterLabel];
    
    
    //加载数据源
    [self loadDataFromWeb];
    //加载控件
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 144,self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
}

#pragma make - 加载数据源
-(void)loadDataFromWeb{
    matter *matter1 = [[matter alloc]init];
    matter1.hotMatter = @"aaaaaaaaaaaaa";
    matter *matter2 = [[matter alloc]init];
    matter2.hotMatter = @"bbbbbbbbbbbbbb";
    matter *matter3 = [[matter alloc]init];
    matter3.hotMatter = @"cccccccccccccc";
    
    self.dataArr = @[matter1,matter2,matter3];
    
}

#pragma mark - 表视图协议
//控制表视图的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
//控制每一行使用什么样式
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        matter *matter = self.dataArr[indexPath.row];
        cell.textLabel.text = matter.hotMatter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
//控制行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
//点击行之后的响应事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
