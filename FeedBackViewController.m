//
//  ViewController.m
//  Evaluate
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import "FeedBackViewController.h"
#import "PeoPle.h"
#import "EvaluatePeopleCell.h"
#import "CellFrameInfo.h"
#import "GTStarsScore.h"
#import "AFNetworking.h"
#import "WebAgent.h"
#import "YBZInterpretViewController.h"
#import "complaintViewController.h"

#define kScreenWindth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface FeedBackViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *mainTabViwe;
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , strong) UIImageView *userIconImageV;
@property (nonatomic , strong) NSString *translator_id;
@property (nonatomic , strong) NSString *user_id;
@property (nonatomic , strong) NSString *evaluate_infotext;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadDateFromWeb];
    [self initLeftButton];
    
    //背景色
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    
    //获得高度
    NSIndexPath *indexPath = [self.mainTabViwe indexPathForCell:self];
    CGFloat cellHeight = [self tableView:self.mainTabViwe heightForRowAtIndexPath:indexPath];
    
    //服务人员
    UILabel *servicePersonalBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(0,64, self.view.bounds.size.width,kScreenHeight*0.062)];
    servicePersonalBottomLable.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    UILabel *servicePersonalLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWindth*0.054,64, self.view.bounds.size.width, kScreenHeight*0.062)];
    NSString *servicePersonalText = [NSString stringWithFormat:@"%@%d%@",@"本次服务译员人数：",1,@"人"];
    
    servicePersonalLable.text = servicePersonalText;
    servicePersonalLable.font = [UIFont systemFontOfSize:20];
    servicePersonalLable.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    [self.view addSubview:servicePersonalBottomLable];
    [self.view addSubview:servicePersonalLable];
    
    //加载控件
    CGFloat mainTabViewHeight = ( cellHeight + kScreenHeight*0.008 );
    CGRect mainTabViweFrame = CGRectMake(0, kScreenHeight*0.062+64, self.view.bounds.size.width, mainTabViewHeight);
    self.mainTabViwe = [[UITableView alloc]initWithFrame:mainTabViweFrame style:UITableViewStylePlain];
    self.mainTabViwe.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    self.mainTabViwe.sectionHeaderHeight = 10;
    self.mainTabViwe.delegate = self;
    self.mainTabViwe.dataSource = self;
    [self.view addSubview:self.mainTabViwe];
    
    //消费
    CGFloat tabViewHeight = mainTabViewHeight;
    CGFloat consumptionLableY = tabViewHeight+kScreenHeight*0.062+64;
    UILabel *consumptionBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(0,consumptionLableY, self.view.bounds.size.width, kScreenHeight*0.12)];
    consumptionBottomLable.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    UILabel *consumptionLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWindth*0.23,consumptionLableY, 0.42*kScreenWindth, kScreenHeight*0.12)];
    UIImage *gold = [UIImage imageNamed:@"gold"];
    UIImageView *moneyImg = [[UIImageView alloc]initWithImage:gold];
    moneyImg.frame =CGRectMake(0.64*kScreenWindth, 0.298*kScreenHeight, 0.046*kScreenWindth, 0.026*kScreenHeight);
    NSString *money = @"10";
    NSString *consumptionLableText = [NSString stringWithFormat:@"%@%@",@"您本次消费游币 ",money];
    NSMutableAttributedString *consumptionLablestr = [[NSMutableAttributedString alloc] initWithString:consumptionLableText];
    [consumptionLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,consumptionLableText.length)];
    [consumptionLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,7)];
    [consumptionLable setAttributedText:consumptionLablestr] ;
    
    
    consumptionLable.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    [self.view addSubview:consumptionBottomLable];
    [self.view addSubview:consumptionLable];
    [self.view addSubview:moneyImg];

    
    //提交
    CGFloat submitEvaluateY = consumptionLableY + kScreenHeight*0.12;
    UIButton *submitEvaluate = [[UIButton alloc] initWithFrame:CGRectMake(0, submitEvaluateY, self.view.bounds.size.width,kScreenHeight*0.083)];
    submitEvaluate.backgroundColor = [UIColor colorWithRed:255.0/255 green:220.0/255 blue:0/255 alpha:1];
    [submitEvaluate addTarget:self action:@selector(elalateClick) forControlEvents:UIControlEventTouchUpInside];
    [submitEvaluate setTitle:@"提交评价" forState:UIControlStateNormal];
    [submitEvaluate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    submitEvaluate.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:submitEvaluate];
    
    //第一步：注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(complaintText:) name:@"complaintText" object:nil];
    
    
}

#pragma mark - 投诉跳转
-(void)complaintClick
{
    complaintViewController *comVC = [[complaintViewController alloc]init];
    [self.navigationController pushViewController:comVC animated:YES];
}

-(void)initLeftButton
{
    self.title = @"口语即时评价";
    //左上角的按钮
    UIButton *boultButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0.05*kScreenWindth, 0.05*kScreenWindth)];
    [boultButton setImage:[UIImage imageNamed:@"boult"] forState:UIControlStateNormal];
    [boultButton addTarget:self action:@selector(interpretClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:boultButton];
}

#pragma mark - 评价跳转
- (void)elalateClick
{
    //系统时间
    NSDate *sendDate = [NSDate date];
    NSDateFormatter  *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *morelocationString = [dateformatter stringFromDate:sendDate];
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
    self.user_id = user_id[@"user_id"];
    
    //获得value值
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    EvaluatePeopleCell *cell = [self.mainTabViwe cellForRowAtIndexPath:index];
    NSString *value = @((round(cell.starsScore_20.value * 100) / 100.0)*5);
    
    if (self.evaluate_infotext !=nil)
    {
        [WebAgent translator_id:self.translator_id valuator_id:self.user_id evaluate_infostar:value  evaluate_infotext:self.evaluate_infotext evaluate_time:morelocationString success:^(id responseObject) {
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            
        }];
    }
    else
    {
    [WebAgent translator_id:self.translator_id valuator_id:user_id[@"user_id"] evaluate_infostar:value  evaluate_infotext:@"" evaluate_time:morelocationString success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


#pragma mark - 箭头跳转
- (void)interpretClick
{
    YBZInterpretViewController *interpretVC = [[YBZInterpretViewController alloc]init];
    
    [self.navigationController pushViewController:interpretVC animated:YES];
}


#pragma mark - 剪切圆形
-(UIImageView *)setPeopleImage:(NSString *)imag
{
    self.userIconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 50, 50)];
    self.userIconImageV.layer.masksToBounds=YES;
    self.userIconImageV.layer.cornerRadius=50/2.0f;
    self.userIconImageV.layer.borderWidth=1.0f;
    self.userIconImageV.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.userIconImageV.image = [UIImage imageNamed:imag];
    return self.userIconImageV;
    
}


#pragma mark - 数据源
-(void)loadDateFromWeb
{
    self.translator_id = @"7777";
    [WebAgent user_id:self.translator_id success:^(id responseObject) {
        
        NSData *data = [[NSData alloc] initWithData:responseObject];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *info = dic[@"user_info"];
        
        PeoPle *people1 = [[PeoPle alloc] initWitAvaterImageName:[self setPeopleImage:@"photo"] nickName:info[@"user_nickname"] complaint:@"投诉"];
        self.dataArr = @[people1];
        
        [self.mainTabViwe reloadData];
        [self.mainTabViwe layoutIfNeeded];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    
}

#pragma mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"EvaluatePeopleCell";
    EvaluatePeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"EvaluatePeopleCell" owner:nil options:nil].lastObject;
        
        PeoPle *people = self.dataArr[indexPath.section];
        
        CellFrameInfo *frameInfo = [[CellFrameInfo alloc] initWithPeople:people];
        [cell setCellData:people frameInfo:frameInfo];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.complaintButton addTarget:self action:@selector(complaintClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return cell;
}


#pragma mark - 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeoPle *people = self.dataArr[indexPath.row];
    CellFrameInfo *frameInfo = [[CellFrameInfo alloc] initWithPeople:people];
    return frameInfo.cellHeight;
}

#pragma mark - 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

#pragma mark - 头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.008*kScreenHeight;
}

//第三步：处理通知
-(void)complaintText:(NSNotification *)noti{
    NSDictionary *textDic = [noti userInfo];
    self.evaluate_infotext = [textDic objectForKey:@"投诉"];
}
//第四步：移除通知
-(void)dealloc{
    //    free((__bridge void *)(self.textALabel));
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"complaintText" object:nil];
}


@end
