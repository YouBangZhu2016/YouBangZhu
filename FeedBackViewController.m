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


@interface FeedBackViewController ()<UITableViewDelegate,UITableViewDataSource,GTStarsScoreDelegate>

@property (nonatomic , strong) UITableView *mainTabViwe;
@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , strong) UIImageView *userIconImageV;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadDateFromWeb];
    
    //获得高度
    NSIndexPath *indexPath = [self.mainTabViwe indexPathForCell:self];
    CGFloat cellHeight = [self tableView:self.mainTabViwe heightForRowAtIndexPath:indexPath];
    
    
    //服务人员
    UILabel *servicePersonalBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(0,64, self.view.bounds.size.width, 60)];
    servicePersonalBottomLable.backgroundColor = [UIColor grayColor];
    UILabel *servicePersonalLable = [[UILabel alloc] initWithFrame:CGRectMake(15,64, self.view.bounds.size.width, 60)];
    NSString *servicePersonalText = [NSString stringWithFormat:@"%@%lu%@",@"本次服务译员人数：",(unsigned long)self.dataArr.count,@"人"];
    servicePersonalLable.text = servicePersonalText;
    servicePersonalLable.font = [UIFont systemFontOfSize:20];
    servicePersonalLable.backgroundColor = [UIColor grayColor];
    [self.view addSubview:servicePersonalBottomLable];
    [self.view addSubview:servicePersonalLable];
    
    //加载控件
    CGFloat mainTabViewHeight = ( cellHeight + 10 )*self.dataArr.count;
    CGRect mainTabViweFrame = CGRectMake(0, 124, self.view.bounds.size.width, mainTabViewHeight);
    self.mainTabViwe = [[UITableView alloc]initWithFrame:mainTabViweFrame style:UITableViewStylePlain];
    self.mainTabViwe.sectionHeaderHeight = 10;
    self.mainTabViwe.delegate = self;
    self.mainTabViwe.dataSource = self;
     //self.mainTabViwe.rowHeight = 100;
    self.mainTabViwe.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.mainTabViwe];
    
    //消费
    CGFloat tabViewHeight = mainTabViewHeight;
    CGFloat consumptionLableY = tabViewHeight+124;
    UILabel *consumptionBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(0,consumptionLableY, self.view.bounds.size.width, 100)];
    consumptionBottomLable.backgroundColor = [UIColor grayColor];
    
    UILabel *consumptionLable = [[UILabel alloc] initWithFrame:CGRectMake(80,consumptionLableY, self.view.bounds.size.width, 100)];
    consumptionLable.text = @"本次消费的游币：";
    consumptionLable.font = [UIFont systemFontOfSize:20];
    consumptionLable.backgroundColor = [UIColor grayColor];
    [self.view addSubview:consumptionBottomLable];
    [self.view addSubview:consumptionLable];
    
    //提交
    CGFloat submitEvaluateY = consumptionLableY + 100;
    UIButton *submitEvaluate = [[UIButton alloc] initWithFrame:CGRectMake(0, submitEvaluateY, self.view.bounds.size.width,50)];
    submitEvaluate.backgroundColor = [UIColor orangeColor];
    
    [submitEvaluate setTitle:@"提交评价" forState:UIControlStateNormal];
    [self.view addSubview:submitEvaluate];
    
    
    
}

- (void)starsScore:(GTStarsScore *)starsScore valueChange:(CGFloat)value
{
}

-(UIImageView *)userIconImageV
{
        NSArray *ima = @[@"photo",@"photo1"];
        for (int i = 0 ;i < ima.count ; i++) {
             _userIconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 50, 50)];
        _userIconImageV.layer.masksToBounds=YES;
        _userIconImageV.layer.cornerRadius=50/2.0f;
        _userIconImageV.layer.borderWidth=1.0f;
        _userIconImageV.layer.borderColor=[[UIColor whiteColor] CGColor];
        _userIconImageV.image=[UIImage imageNamed:ima[i]];
    }
        return _userIconImageV;

}
        


-(void)loadDateFromWeb
{
    
         PeoPle *people1 = [[PeoPle alloc] initWitAvaterImageName:self.userIconImageV nickName:@"天空湛蓝" /*grade:starsScore_20*/ complaint:@"投诉"];
    PeoPle *people2 = [[PeoPle alloc] initWitAvaterImageName:self.userIconImageV nickName:@"我是帅哥" /*grade:starsScore_20*/ complaint:@"投诉"];
    
    self.dataArr = @[people1,people2];
    
}

//剪切圆形图片
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
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
    return self.dataArr.count;
}

#pragma mark - 头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}













@end
