//
//  YBZRewardChooseLanguageViewController.m
//  YBZTravel
//
//  Created by sks on 16/8/14.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZRewardChooseLanguageViewController.h"

#import "LanguageCell.h"
#import "Infor.h"
#import "CellInfor.h"

#define kScreenWindth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height


@interface YBZRewardChooseLanguageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *mainTable;
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , strong) NSString *lang;
@end

@implementation YBZRewardChooseLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDateFromWeb];
    [self initLeftButton];
    
    self.title = @"选择语种";
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 0.017*kScreenHeight)];
    lab.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
    [self.view addSubview:lab];
    
    
    self.mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+0.017*kScreenHeight,self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.mainTable.sectionHeaderHeight = 10;
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.scrollEnabled = NO;
    [self.view addSubview:self.mainTable];
    
    
    
}

#pragma mark - 返回箭头
-(void)initLeftButton
{
    //左上角的按钮
    UIButton *boultButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0.1*kScreenWindth, 0.1*kScreenWindth)];
    [boultButton setImage:[UIImage imageNamed:@"boult"] forState:UIControlStateNormal];
    [boultButton addTarget:self action:@selector(interpretClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:boultButton];
    
    
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(selectrightAction)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

#pragma mark - 页面跳转
- (void)interpretClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据源
-(void)loadDateFromWeb
{
    UIImage *img = [UIImage imageNamed:@"ensure"];
    UIImageView *ensureImg = [[UIImageView alloc]initWithImage:img];
    Infor *infomation1 = [[Infor alloc] initWitensureImg:ensureImg language:@"英语"];
    Infor *infomation2 = [[Infor alloc] initWitensureImg:ensureImg language:@"日语"];
    Infor *infomation3 = [[Infor alloc] initWitensureImg:ensureImg language:@"法语"];
    Infor *infomation4 = [[Infor alloc] initWitensureImg:ensureImg language:@"德语"];
    Infor *infomation5 = [[Infor alloc] initWitensureImg:ensureImg language:@"韩语"];
    Infor *infomation6 = [[Infor alloc] initWitensureImg:ensureImg language:@"意大利语"];
    Infor *infomation7 = [[Infor alloc] initWitensureImg:ensureImg language:@""];
    Infor *infomation8 = [[Infor alloc] initWitensureImg:ensureImg language:@""];
    Infor *infomation9 = [[Infor alloc] initWitensureImg:ensureImg language:@""];
    Infor *infomation10 = [[Infor alloc] initWitensureImg:ensureImg language:@""];
    Infor *infomation11 = [[Infor alloc] initWitensureImg:ensureImg language:@""];
    Infor *infomation12 = [[Infor alloc] initWitensureImg:ensureImg language:@""];
    
    self.dataArr = @[infomation1,infomation2,infomation3,infomation4,infomation5,infomation6,infomation7,infomation8,infomation9,infomation10,infomation11,infomation12];
}

#pragma mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"LanguageCell";
    LanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"LanguageCell" owner:nil options:nil].lastObject;
        
        Infor *information = self.dataArr[indexPath.section];
        
        CellInfor *cellInformation = [[CellInfor alloc] initWithInfor:information];
        [cell setCellData:information frameInfo:cellInformation];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return cell;
}


#pragma mark - 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Infor *information = self.dataArr[indexPath.row];
    CellInfor *cellInformation =[[CellInfor alloc] initWithInfor:information];
    return cellInformation.cellHeight;
}

#pragma mark - 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LanguageCell *cell = [self.mainTable cellForRowAtIndexPath:indexPath];
    if (![cell.information.language  isEqual:@""]) {
        [cell.ensureImage addSubview:cell.information.ensureImg];
        self.lang = cell.information.language;
    }
    
    
}

#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.dataArr.count;
}

#pragma mark - 尾部
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

-(void)selectrightAction
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendLanguage" object:nil userInfo:@{@"语言":self.lang}];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




@end

