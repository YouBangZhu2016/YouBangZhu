//
//  YBZMyRewardViewController.m
//  YBZTravel
//
//  Created by sks on 16/8/14.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZMyRewardViewController.h"
#import "YBZSendRewardViewController.h"
#import "Model.h"
#import "Btn_TableView.h"
#define kScreenWith  [UIScreen mainScreen].bounds.size.width
// 角度转弧度
#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * 0.01745329252f) // PI / 180
// 弧度转角度
#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f)




@interface YBZMyRewardViewController ()<UITableViewDelegate,UITableViewDataSource,Btn_TableViewDelegate>

@property (strong , nonatomic) Btn_TableView* m_btn_tableView1;
@property (nonatomic ,strong) Btn_TableView *m_btn_tableView2;
@property (nonatomic ,strong) Btn_TableView *m_btn_tableView3;



@property (nonatomic ,strong) NSArray *dataArr;


@property (nonatomic ,strong) UIView *textV;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *contentLabel;
@property (nonatomic ,strong) UILabel *imgLabel;
@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic ,strong) UILabel *moneyLabel;
@property (nonatomic ,strong) UIButton *rightBtn;

@end

@implementation YBZMyRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadDataFromWeb];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"悬赏大厅";
    [self leftButton];
    
    
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kScreenWith*0.09, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.mainTableView.backgroundColor = [UIColor grayColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    
    self.m_btn_tableView1 = [[Btn_TableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWith*0.333, kScreenWith*0.094)];
    self.m_btn_tableView2 = [[Btn_TableView alloc] initWithFrame:CGRectMake(kScreenWith*0.333, 64, kScreenWith*0.333, kScreenWith*0.094)];
    self.m_btn_tableView3 = [[Btn_TableView alloc] initWithFrame:CGRectMake(kScreenWith*0.666, 64, kScreenWith*0.333, kScreenWith*0.094)];
    
    self.m_btn_tableView1.delegate_Btn_TableView = self;
    self.m_btn_tableView2.delegate_Btn_TableView = self;
    self.m_btn_tableView3.delegate_Btn_TableView = self;
    //按钮名字
    self.m_btn_tableView1.m_Btn_Name = @"金额排序";
    self.m_btn_tableView2.m_Btn_Name = @"语言筛选";
    self.m_btn_tableView3.m_Btn_Name = @"时间排序";
    
    //数据内容
    self.m_btn_tableView1.m_TableViewData = @[@"金额由高到低",@"金额由低到高"];
    self.m_btn_tableView2.m_TableViewData = @[@"英文",@"中文",@"法文",@"俄文"];
    self.m_btn_tableView3.m_TableViewData = @[@"时间由早到晚",@"时间由晚到早"];
    
    [self.m_btn_tableView1 addViewData];
    [self.m_btn_tableView2 addViewData];
    [self.m_btn_tableView3 addViewData];
    [self.view addSubview:self.m_btn_tableView1];
    [self.view addSubview:self.m_btn_tableView2];
    [self.view addSubview:self.m_btn_tableView3];
    
    //右键头
    self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [_rightBtn setImage:[UIImage imageNamed:@"back"]forState:UIControlStateNormal];
//    [_rightBtn addTarget:self selfaction:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn addTarget:self action:@selector(searchprogram) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem= rightItem;
}
#pragma mark - 返回箭头
-(void)leftButton{
    UIButton *backB = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [backB setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backB addTarget:self action:@selector(interpretClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backB];
    
}
#pragma mark - 页面跳转
-(void)interpretClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)searchprogram{
    YBZSendRewardViewController *sendRewardVC = [[YBZSendRewardViewController alloc]init];
    [self.navigationController pushViewController:sendRewardVC animated:nil];
}

-(void)loadDataFromWeb{
    Model *m1 = [[Model alloc]initWithTitle:@"请帮我翻译这个广告牌子" content:@"这个牌子是我在悉尼街头看到的，非常想知道它的含义，求助高手！"img:nil date:@"2016.01.01" money:@"50.00"];
    Model *m2 = [[Model alloc]initWithTitle:@"请帮我翻译这个广告牌子" content:@"这个牌子是我在悉尼街头看到的，非常想知道它的含义，求助高手！" img:@"a" date:@"2016.01.02" money:@"100.00"];
    Model *m3 = [[Model alloc]initWithTitle:@"请帮我翻译这个广告牌子" content:@"这个牌子是我在悉尼街头看到的，非常想知道它的含义，求助高手！" img:nil date:@"2016.01.03" money:@"50.00"];
    Model *m4 = [[Model alloc]initWithTitle:@"请帮我翻译这个广告牌子" content:@"这个牌子是我在悉尼街头看到的，非常想知道它的含义，求助高手！" img:@"a" date:@"2016.01.04" money:@"50.00"];
    Model *m5 = [[Model alloc]initWithTitle:@"请帮我翻译这个广告牌子" content:@"这个牌子是我在悉尼街头看到的，非常想知道它的含义，求助高手！" img:nil date:@"2016.01.05" money:@"50.00"];
    Model *m6 = [[Model alloc]initWithTitle:@"请帮我翻译这个广告牌子" content:@"这个牌子是我在悉尼街头看到的，非常想知道它的含义，求助高手！" img:@"a" date:@"2016.01.06" money:@"50.00"];
    Model *m7 = [[Model alloc]initWithTitle:@"请帮我翻译这个广告牌子" content:@"这个牌子是我在悉尼街头看到的，非常想知道它的含义，求助高手！" img:@"a" date:@"2016.01.07" money:@"50.00"];
    self.dataArr = @[m2,m1,m3,m4,m5,m6,m7];
    Btn_TableView *a = [[Btn_TableView alloc]init];
    NSLog(@"ssxsexs%@",a.cellName);
    
    
    
}
-(void)changeOrientationNinty:(UIView *)view
{
    view.transform  = CGAffineTransformMakeRotation(CC_DEGREES_TO_RADIANS(90));
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
    Model *model = self.dataArr[indexPath.row];
    UITableViewCell  *cell= [[UITableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textV = [[UIView alloc]initWithFrame:CGRectMake(kScreenWith*0.048,kScreenWith*0.013,kScreenWith*0.902,kScreenWith*0.262)];
    self.textV.backgroundColor = [UIColor colorWithRed:55.0f/255.0f green:53.0f/255.0f blue:77.0f/255.0f alpha:1];
    self.textV.layer.cornerRadius = 5.0;
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWith*0.035, kScreenWith*0.017, kScreenWith*0.783, kScreenWith*0.059)];
    self.titleLabel.text = model.title;
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.titleLabel setTextColor:[UIColor colorWithRed:238.0f/255.0f green:204.0f/255.0f blue:69.0f/255.0f alpha:1]];
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWith*0.035, kScreenWith*0.076, kScreenWith*0.783, kScreenWith*0.108)];
    self.contentLabel.text = model.content;
    [self.contentLabel setTextColor:[UIColor whiteColor]];
    self.contentLabel.numberOfLines = 2;
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWith*0.035, kScreenWith*0.194, kScreenWith*0.17, kScreenWith*0.04)];
    [label1 setTextColor:[UIColor whiteColor]];
    label1.text = @"发布日期：";
    [label1 setNumberOfLines:0];
    label1.adjustsFontSizeToFitWidth = YES;
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWith*0.459, kScreenWith*0.194, kScreenWith*0.5, kScreenWith*0.04)];
    [label2 setTextColor:[UIColor whiteColor]];
    label2.text = @"悬赏金额：              游币";
    [label2 setNumberOfLines:0];
    label2.adjustsFontSizeToFitWidth = YES;
    
    UIImage* image = [UIImage imageNamed:@"right"];
    UIImageView *right   = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWith*0.824, kScreenWith*0.09, 18,23)];
    [right setImage:image];
    
    
    if(model.img){
        UIImage* image = [UIImage imageNamed:@"tu"];
        UIImageView *tu   = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWith*0.818-37, kScreenWith*0.017,27,27)];
        [tu setImage:image];
        [self.textV addSubview:tu];
        
    }
    
    
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWith*0.205, kScreenWith*0.194, kScreenWith*0.202, kScreenWith*0.04)];
    [self.dateLabel setTextColor:[UIColor whiteColor]];
    self.dateLabel.text = model.date;
    [self.dateLabel setNumberOfLines:0];
    self.dateLabel.adjustsFontSizeToFitWidth = YES;
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWith*0.62, kScreenWith*0.194, kScreenWith*0.148, kScreenWith*0.04)];
    self.moneyLabel.text = model.money;
    [self.moneyLabel setTextColor:[UIColor redColor]];
    
    
    
    
    [self.textV addSubview:self.titleLabel];
    [self.textV addSubview:self.contentLabel];
    [self.textV addSubview:label1];
    [self.textV addSubview:label2];
    [self.textV addSubview:self.dateLabel];
    [self.textV addSubview:self.moneyLabel];
    [self.textV addSubview:right];
    [cell addSubview:self.textV];
    return cell;
}

//控制行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  kScreenWith*0.288;
}
//点击行之后的响应事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
