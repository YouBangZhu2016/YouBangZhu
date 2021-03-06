//
//  YBZTranslationController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZTranslationController.h"
#import "YBZInterpretViewController.h"
#import "YBZFreeTranslationViewController.h"
#import "YBZLoginViewController.h"
#import "YBZChangeLanguageViewController.h"
#import "YBZBaseNaviController.h"
#import "YBZPopularViewCell.h"
#import "YBZPopularFrameInfo.h"
#import "WebAgent.h"
#import "MJRefresh.h"
#import "QuickTransViewController.h"
#import "YBZRewardHallViewController.h"
#import "YBZSendRewardViewController.h"
#import "YBZMyRewardViewController.h"

#define kImageCount 5
//#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]


@interface YBZTranslationController () <UIScrollViewDelegate , UIGestureRecognizerDelegate , UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, strong, null_resettable) UITableView *tableView;

//轮播图

@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIPageControl *pageControl;

@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic, strong) UIView  *newsView;
@property (nonatomic, strong) UILabel *newsLabel;
@property (nonatomic, strong) UIImageView *newsLeftImageView;
@property (nonatomic, strong) UIImageView *newsRightImageView;


@property (nonatomic, strong) UIButton *userBtn;
@property (nonatomic, strong) UIImageView *userBtnImageView;
@property (nonatomic, strong) UIButton *translaterBtn;
@property (nonatomic, strong) UIImageView *translaterBtnImageView;
@property (nonatomic, strong) UIButton *freeTransBtn;
@property (nonatomic, strong) UIButton *interpretBtn;
@property (nonatomic, strong) UIButton *customMadeBtn;
@property (nonatomic, strong) UIButton *myOfferBtn;

@property (nonatomic, strong) UILabel *freeTransLabel;
@property (nonatomic, strong) UILabel *interpretLabel;
@property (nonatomic, strong) UILabel *customMadeLabel;
@property (nonatomic, strong) UILabel *myOfferLabel;

//popularCell

@property (nonatomic, strong) UIImageView *popularImageView;
@property (nonatomic, strong) UILabel     *popularImageViewLabel;
@property (nonatomic, strong) UITableView *popularCellView;
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (nonatomic, strong) UIView      *bottomView;
@property (nonatomic, strong) UIImageView *backgroundImageView;


//@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
//@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
//@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
//@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
//@property (strong, nonatomic) IBOutlet UIButton *allInfoBtn;
//@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
//@property (strong, nonatomic) IBOutlet UILabel *payLabel;



//判断登录状态
@property(nonatomic,assign) NSString* isLogin;
@property(nonatomic,assign) BOOL isUser;



@end

@implementation YBZTranslationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.isUser = YES;
    
    //self.view.backgroundColor = [UIColor grayColor];
    
    //[self.view addSubview:self.popularCell];
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.popularCellView];

    
    [self.bottomView addSubview:self.newsView];
    [self.newsView addSubview:self.newsLabel];
    [self.newsView addSubview:self.newsLeftImageView];
    [self.newsView addSubview:self.newsRightImageView];
    
    
    [self.bottomView addSubview:self.userBtn];
    [self.userBtn addSubview:self.userBtnImageView];
    [self.bottomView addSubview:self.translaterBtn];
    [self.translaterBtn addSubview:self.translaterBtnImageView];
    
    [self.bottomView addSubview:self.freeTransBtn];
    [self.bottomView addSubview:self.freeTransLabel];
    [self.bottomView addSubview:self.interpretBtn];
    [self.bottomView addSubview:self.interpretLabel];
    [self.bottomView addSubview:self.customMadeBtn];
    [self.bottomView addSubview:self.customMadeLabel];
    [self.bottomView addSubview:self.myOfferBtn];
    [self.bottomView addSubview:self.myOfferLabel];
    [self.bottomView addSubview:self.scrollView];
    [self.bottomView addSubview:self.pageControl];
    
    
    //popularCell
    [self.bottomView addSubview:self.popularImageView];
    [self.bottomView addSubview:self.popularImageViewLabel];
    [self initData];
    
    
    
    //    for (int i=0; i<kImageCount; i++) {
    //        NSString *imageName=[NSString stringWithFormat:@"img_%02d",i+1];
    //        UIImage *image=[UIImage imageNamed:imageName];
    //
    //        UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.scrollView.bounds];
    //        imageView.image=image;
    //
    //        [self.scrollView addSubview:imageView];
    //    }
    [self addImageView];
    [self startTimer];
    
    
    //集成刷新控件
    [self setupRefresh];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recieveARemoteRequire:) name:@"recieveARemoteRequire" object:nil];
    
}
#pragma mark - 观察者方法
-(void)recieveARemoteRequire:(NSNotification *)noti{
    
    NSString *yonghuID = noti.userInfo[@"yonghuID"];
    NSString *language = noti.userInfo[@"language_catgory"];
    NSString *pay_number = noti.userInfo[@"pay_number"];

    
    NSString *VoiceLanguage;
    NSString *TransLanguage;
    if ([language isEqualToString:@"English"]) {
        
        VoiceLanguage = Voice_YingYu;
        TransLanguage = Trans_YingYu;
    }
    if ([language isEqualToString:@"MeiYu"]) {
        
        VoiceLanguage = Voice_MeiYu;
        TransLanguage = Trans_MeiYu;
    }
    if ([language isEqualToString:@"HanYu"]) {
        
        VoiceLanguage = Voice_HanYu;
        TransLanguage = Trans_HanYu;
    }
    if ([language isEqualToString:@"XiBanYa"]) {
        
        VoiceLanguage = Voice_XiBanYa;
        TransLanguage = Trans_XiBanYa;
    }
    if ([language isEqualToString:@"TaiYu"]) {
        
        VoiceLanguage = Voice_TaiYu;
        TransLanguage = Trans_TaiYu;
    }
    if ([language isEqualToString:@"ALaBoYu"]) {
        
        VoiceLanguage = Voice_ALaBoYu;
        TransLanguage = Trans_ALaBoYu;
    }
    if ([language isEqualToString:@"EYu"]) {
        
        VoiceLanguage = Voice_EYu;
        TransLanguage = Trans_EYu;
    }
    if ([language isEqualToString:@"PuTaoYaYu"]) {
        
        VoiceLanguage = Voice_PuTaoYaYu;
        TransLanguage = Trans_PuTaoYaYu;
    }
    if ([language isEqualToString:@"XiLaYu"]) {
        
        VoiceLanguage = Voice_XiLaYu;
        TransLanguage = Trans_XiLaYu;
    }
    if ([language isEqualToString:@"HeLanYu"]) {
        
        VoiceLanguage = Voice_HeLanYu;
        TransLanguage = Trans_HeLanYu;
    }
    if ([language isEqualToString:@"BoLanYu"]) {
        
        VoiceLanguage = Voice_BoLanYu;
        TransLanguage = Trans_BoLanYu;
    }
    if ([language isEqualToString:@"DanMaiYu"]) {
        
        VoiceLanguage = Voice_DanMaiYu;
        TransLanguage = Trans_DanMaiYu;
    }
    if ([language isEqualToString:@"FenLanYu"]) {
        
        VoiceLanguage = Voice_FenLanYu;
        TransLanguage = Trans_FenLanYu;
    }
    if ([language isEqualToString:@"JieKeYu"]) {
        
        VoiceLanguage = Voice_JieKeYu;
        TransLanguage = Trans_JieKeYu;
    }
    if ([language isEqualToString:@"RuiDianYu"]) {
        
        VoiceLanguage = Voice_RuiDianYu;
        TransLanguage = Trans_RuiDianYu;
    }
    if ([language isEqualToString:@"XiongYaLiYu"]) {
        
        VoiceLanguage = Voice_XiongYaLiYu;
        TransLanguage = Trans_XiongYaLiYu;
    }
    if ([language isEqualToString:@"RiYu"]) {
        
        VoiceLanguage = Voice_RiYu;
        TransLanguage = Trans_RiYu;
    }
    if ([language isEqualToString:@"FaYu"]) {
        
        VoiceLanguage = Voice_FaYa;
        TransLanguage = Trans_FaYu;
    }
    if ([language isEqualToString:@"DeYu"]) {
        
        VoiceLanguage = Voice_DeYu;
        TransLanguage = Trans_DeYu;
    }
    if ([language isEqualToString:@"YiDaLiYu"]) {
        
        VoiceLanguage = Voice_YiDaLiYu;
        TransLanguage = Trans_YiDaLiYu;
    }
    
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *userID = [userdefault objectForKey:@"user_id"];
    
    
    [WebAgent interpreterStateWithuserId:yonghuID success:^(id responseObject) {
       
        NSData *data = [[NSData alloc]initWithData:responseObject];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
        NSString *msgString = dic[@"msg"];
        if ([msgString isEqualToString:@"查询成功！并且可以成功匹配"]) {
            QuickTransViewController *quickVC = [[QuickTransViewController alloc]initWithUserID:userID[@"user_id"] WithTargetID:yonghuID WithUserIdentifier:@"TRANSTOR" WithVoiceLanguage:VoiceLanguage WithTransLanguage:TransLanguage];
            
            [self.navigationController pushViewController:quickVC animated:YES];
            
            [WebAgent sendRemoteNotificationsWithuseId:yonghuID WithsendMessage:@"匹配成功" WithlanguageCatgory:language WithpayNumber:@"20" WithSenderID:userID[@"user_id"] success:^(id responseObject) {
                NSLog(@"反馈推送—匹配成功通知成功！");
            } failure:^(NSError *error) {
                NSLog(@"反馈推送－匹配成功通知失败－－>%@",error);
            }];
        }else{
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"抱歉，该用户请求已经被别人抢先接单了！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];

        }
        
    } failure:^(NSError *error) {
        NSLog(@"查询用户请求信息失败＝＝＝>%@",error);
    }];
    
    
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"recieveARemoteRequire" object:nil];
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.popularCellView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.popularCellView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
#warning 自动刷新(一进入程序就下拉刷新)
    //[self.popularCellView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.popularCellView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.popularCellView.headerPullToRefreshText = @"下拉可以刷新了";
    self.popularCellView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.popularCellView.headerRefreshingText = @"MJ哥正在帮你刷新中,不客气";
    
    self.popularCellView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.popularCellView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.popularCellView.footerRefreshingText = @"MJ哥正在帮你加载中,不客气";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    //    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        [self.cellArr insertObject:MJRandomData atIndex:0];
    //    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.popularCellView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.popularCellView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    //    // 1.添加假数据
    //    for (int i = 0; i<5; i++) {
    //        [self.cellArr addObject:MJRandomData];
    //    }
    //
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.popularCellView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.popularCellView footerEndRefreshing];
    });
}


- (void)initData{
    
    self.cellArr = [[NSMutableArray alloc]init];
    
    YBZPopularFrameInfo *popularCellView1 = [[YBZPopularFrameInfo alloc]initWithTitle:@"TITLE" AndLevel:@"lv 5" AndState:@"finish" AndContent:@"content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,"];
    [self.cellArr addObject:popularCellView1];
    
    YBZPopularFrameInfo *popularCellView2 = [[YBZPopularFrameInfo alloc]initWithTitle:@"TITLE" AndLevel:@"lv 5" AndState:@"finish" AndContent:@"content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,"];
    [self.cellArr addObject:popularCellView2];
    
    YBZPopularFrameInfo *popularCellView3 = [[YBZPopularFrameInfo alloc]initWithTitle:@"TITLE" AndLevel:@"lv 5" AndState:@"finish" AndContent:@"content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,"];
    [self.cellArr addObject:popularCellView3];
    
    YBZPopularFrameInfo *popularCellView4 = [[YBZPopularFrameInfo alloc]initWithTitle:@"TITLE" AndLevel:@"lv 5" AndState:@"finish" AndContent:@"content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,content,"];
    [self.cellArr addObject:popularCellView4];
    
}

#pragma mark - UIScrollViewDelegate


// 滚动视图停下来，修改页面控件的小点（页数）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算页数
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    self.pageControl.currentPage = page;
}

/**
 修改时钟所在的运行循环的模式后，抓不住图片
 
 解决方法：抓住图片时，停止时钟，送售后，开启时钟
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止时钟，停止之后就不能再使用，如果要启用时钟，需要重新实例化
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark - UITableViewDelegate&UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.cellArr count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    YBZPopularFrameInfo *model = self.cellArr[indexPath.row];
    
    static NSString *cellID = @"YBZPopularViewCell";
    
    YBZPopularViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"YBZPopularViewCell" owner:nil options:nil]lastObject];
    }
    
    
    cell.titleLabel.text = model.title;
    cell.levelLabel.text = model.level;
    cell.stateLabel.text = model.state;
    cell.contentLabel.text = model.content;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    return 90;
}

#pragma mark - 私有方法

- (void)startTimer{
    
    
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    // 添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer
{
    // 页号发生变化
    // (当前的页数 + 1) % 总页数
    int page = (self.pageControl.currentPage + 1) % kImageCount;
    self.pageControl.currentPage = page;
    
    // 调用监听方法，让滚动视图滚动
    [self pageChanged:self.pageControl];
}

- (void)tapUIscrollView{
    
    NSLog(@"%ld",(long)self.pageControl.currentPage);
    
    
    
    //
    //    switch (i = self.pageControl.currentPage) {
    //        case 0:
    //            break;
    //
    //        default:
    //            break;
    //    }
    
    
}



#pragma mark - 响应方法

-(void)userIdentifierClick{
    
    self.userBtn.selected = YES;
    self.userBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:243/255.0 blue:202/255.0 alpha:1];
    
    self.translaterBtn.selected = NO;
    self.translaterBtn.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    
}

-(void)interpretIdentifierClick{
    
    self.userBtn.selected = NO;
    self.userBtn.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    
    self.translaterBtn.selected = YES;
    self.translaterBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:243/255.0 blue:202/255.0 alpha:1];
    
    
}

-(void)intoFreeTranslationClick{
    
    
    YBZFreeTranslationViewController *freeTransVC = [[YBZFreeTranslationViewController alloc]initWithTitle:@"免费翻译"];
    freeTransVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:freeTransVC animated:YES];
    
}

-(void)intoChangeLanguageClick{
    
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
                
                //        YBZChangeLanguageViewController *changelangeVC = [[YBZChangeLanguageViewController alloc]initWithTitle:@"切换语言"];
                
                
                YBZInterpretViewController  *changelangeVC = [[YBZInterpretViewController alloc]init];
                
                changelangeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:changelangeVC animated:YES];
                
                YBZChangeLanguageViewController *changelanguageVC = [[YBZChangeLanguageViewController alloc]initWithTitle:@"切换语言"];
                changelanguageVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:changelanguageVC animated:YES];
                
            }else{
                
                //进入登陆流程
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
-(void)myOfferBtnClick{
    YBZRewardHallViewController *rewardVC = [[YBZRewardHallViewController alloc]init];
    [self.navigationController pushViewController:rewardVC animated:nil];
}

- (void)pageChanged:(UIPageControl *)page
{
    // 根据页数，调整滚动视图中的图片位置 contentOffset
    CGFloat x = page.currentPage * self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

-(void)customMadeBtnClick{
    YBZMyRewardViewController *myRewardVC = [[YBZMyRewardViewController alloc]init];
    [self.navigationController pushViewController:myRewardVC animated:YES];
}








#pragma mark - getters



//用户身份按钮
-(UIButton *)userBtn{
    
    if (!_userBtn) {
        _userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_userBtn setTitle:@"用户" forState:UIControlStateNormal];
        
        if (_isUser) {
            _userBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:243/255.0 blue:202/255.0 alpha:1];
        }else{
            _userBtn.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
        }
        _userBtn.frame = CGRectMake(-25, CGRectGetMaxY(self.newsView.frame) + 15, UIScreenWidth / 2 + 15, 32);
        
        [_userBtn addTarget:self action:@selector(userIdentifierClick) forControlEvents:UIControlEventTouchUpInside];
        _userBtn.layer.cornerRadius = 16;
    }
    return _userBtn;
}

- (UIImageView *)userBtnImageView{
    
    if (!_userBtnImageView) {
        _userBtnImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户界面 用户"]];
        _userBtnImageView.frame = CGRectMake(UIScreenWidth * 0.33, - (UITranslationBtnSize - 32) / 2, UITranslationBtnSize, UITranslationBtnSize);
        //_userBtnImageView.backgroundColor = [UIColor redColor];
    }
    return _userBtnImageView;
}

//翻译人员身份按钮
-(UIButton *)translaterBtn{
    
    if (!_translaterBtn) {
        _translaterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_translaterBtn setTitle:@"译员" forState:UIControlStateNormal];
        
        if (_isUser) {
            _translaterBtn.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
        }else{
            _translaterBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:243/255.0 blue:202/255.0 alpha:1];
        }
        _translaterBtn.frame = CGRectMake(CGRectGetMaxX(self.userBtn.frame) + 20, CGRectGetMaxY(self.newsView.frame) + 15, UIScreenWidth / 2 + 25, 32);
        [_translaterBtn addTarget:self action:@selector(interpretIdentifierClick) forControlEvents:UIControlEventTouchUpInside];
        _translaterBtn.layer.cornerRadius = 16;
    }
    return _translaterBtn;
}

- (UIImageView *)translaterBtnImageView{
    
    if (!_translaterBtnImageView) {
        _translaterBtnImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户界面 译员"]];
        _translaterBtnImageView.frame = CGRectMake(CGRectGetMinX(self.translaterBtn.frame) - UIScreenWidth * 0.315 - UITranslationBtnSize, - (UITranslationBtnSize - 32) / 2, UITranslationBtnSize, UITranslationBtnSize);
        //_userBtnImageView.backgroundColor = [UIColor redColor];
    }
    return _translaterBtnImageView;
}

-(UIButton *)freeTransBtn{
    
    if (!_freeTransBtn) {
        _freeTransBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_freeTransBtn setTitle:@"免费翻译" forState:UIControlStateNormal];
        [_freeTransBtn setImage:[UIImage imageNamed:@"译员首页7"] forState:UIControlStateNormal];
        //_freeTransBtn.backgroundColor = [UIColor purpleColor];
        _freeTransBtn.frame = CGRectMake(UIScreenWidth / 2 - UITranslationBtnMargin * 1.5 - UITranslationBtnSize * 2, CGRectGetMaxY(self.userBtn.frame) + 20, UITranslationBtnSize , UITranslationBtnSize);
        [_freeTransBtn addTarget:self action:@selector(intoFreeTranslationClick) forControlEvents:UIControlEventTouchUpInside];
        _freeTransBtn.layer.cornerRadius = UITranslationBtnSize / 2;
        
    }
    return _freeTransBtn;
}

- (UILabel *)freeTransLabel{
    
    if (!_freeTransLabel) {
        _freeTransLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.freeTransBtn.frame) - 35, CGRectGetMaxY(self.freeTransBtn.frame) + 2, 70, 15)];
        [_freeTransLabel setText:@"免费翻译"];
        [_freeTransLabel setTextColor:[UIColor colorWithRed:19 / 255.0 green:137 / 255.0 blue:143/255.0 alpha:1]];
        _freeTransLabel.textAlignment = NSTextAlignmentCenter;
        
        _freeTransLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _freeTransLabel;
}

-(UIButton *)interpretBtn{
    
    if (!_interpretBtn) {
        _interpretBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_interpretBtn setTitle:@"口语即时" forState:UIControlStateNormal];
        [_interpretBtn setImage:[UIImage imageNamed:@"译员首页8"] forState:UIControlStateNormal];
        //_interpretBtn.backgroundColor = [UIColor purpleColor];
        //_interpretBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, CGRectGetMaxY(self.translaterBtn.frame) + 20, 100, 50);
        _interpretBtn.frame = CGRectMake(CGRectGetMidX(self.freeTransBtn.frame) + UITranslationBtnSize / 2 + UITranslationBtnMargin, CGRectGetMaxY(self.userBtn.frame) + 20, UITranslationBtnSize, UITranslationBtnSize);
        [_interpretBtn addTarget:self action:@selector(intoChangeLanguageClick) forControlEvents:UIControlEventTouchUpInside];
        _interpretBtn.layer.cornerRadius = UITranslationBtnSize / 2;
        
    }
    return _interpretBtn;
}

- (UILabel *)interpretLabel{
    
    if (!_interpretLabel) {
        _interpretLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.interpretBtn.frame) - 35, CGRectGetMaxY(self.interpretBtn.frame) + 2, 70, 15)];
        [_interpretLabel setText:@"口语即时"];
        [_interpretLabel setTextColor:[UIColor colorWithRed:19 / 255.0 green:137 / 255.0 blue:143/255.0 alpha:1]];
        _interpretLabel.textAlignment = NSTextAlignmentCenter;
        
        _interpretLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return _interpretLabel;
    
}

-(UIButton *)customMadeBtn{
    
    if (!_customMadeBtn) {
        _customMadeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_customMadeBtn setTitle:@"Btn3" forState:UIControlStateNormal];
        [_customMadeBtn setImage:[UIImage imageNamed:@"译员首页9"] forState:UIControlStateNormal];
        //_customMadeBtn.backgroundColor = [UIColor purpleColor];
        //_interpretBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, CGRectGetMaxY(self.translaterBtn.frame) + 20, 100, 50);
        _customMadeBtn.frame = CGRectMake(CGRectGetMidX(self.interpretBtn.frame) + UITranslationBtnSize / 2 + UITranslationBtnMargin, CGRectGetMaxY(self.userBtn.frame) + 20, UITranslationBtnSize, UITranslationBtnSize);
        [_customMadeBtn addTarget:self action:@selector(customMadeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _customMadeBtn.layer.masksToBounds = YES;
        _customMadeBtn.layer.cornerRadius = UITranslationBtnSize / 2;
        
    }
    return _customMadeBtn;
}

- (UILabel *)customMadeLabel{
    
    if (!_customMadeLabel) {
        _customMadeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.customMadeBtn.frame) - 35, CGRectGetMaxY(self.customMadeBtn.frame) + 2, 70, 15)];
        //_customMadeLabel.backgroundColor = [UIColor greenColor];
        [_customMadeLabel setText:@"定制翻译"];
        [_customMadeLabel setTextColor:[UIColor colorWithRed:19 / 255.0 green:137 / 255.0 blue:143/255.0 alpha:1]];
        _customMadeLabel.textAlignment = NSTextAlignmentCenter;
        
        _customMadeLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return _customMadeLabel;
    
}

-(UIButton *)myOfferBtn{
    
    if (!_myOfferBtn) {
        _myOfferBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myOfferBtn setTitle:@"Btn4" forState:UIControlStateNormal];
        [_myOfferBtn setImage:[UIImage imageNamed:@"译员首页10"] forState:UIControlStateNormal];
        //_myOfferBtn.backgroundColor = [UIColor purpleColor];
        //_interpretBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, CGRectGetMaxY(self.translaterBtn.frame) + 20, 100, 50);
        _myOfferBtn.frame = CGRectMake(CGRectGetMaxX(self.customMadeBtn.frame) + UITranslationBtnMargin, CGRectGetMaxY(self.userBtn.frame) + 20, UITranslationBtnSize, UITranslationBtnSize);
        [_myOfferBtn addTarget:self action:@selector(myOfferBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _myOfferBtn.layer.cornerRadius = UITranslationBtnSize / 2;
        
    }
    return _myOfferBtn;
}
- (UILabel *)myOfferLabel{
    
    if (!_myOfferLabel) {
        _myOfferLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.myOfferBtn.frame) - 35, CGRectGetMaxY(self.myOfferBtn.frame) + 2, 70, 15)];
        //_myOfferLabel.backgroundColor = [UIColor greenColor];
        [_myOfferLabel setText:@"我的悬赏"];
        [_myOfferLabel setTextColor:[UIColor colorWithRed:19 / 255.0 green:137 / 255.0 blue:143/255.0 alpha:1]];
        _myOfferLabel.textAlignment = NSTextAlignmentCenter;
        
        _myOfferLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return _myOfferLabel;
    
}

//轮播图
- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenWidth * 0.406)];
        _scrollView.backgroundColor = [UIColor redColor];
        
        //取消弹簧效果
        _scrollView.bounces = NO;
        
        // 取消水平滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        // 要分页
        _scrollView.pagingEnabled = YES;
        
        // contentSize
        _scrollView.contentSize = CGSizeMake(kImageCount * _scrollView.bounds.size.width, 0);
        
        // 设置代理
        _scrollView.delegate = self;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUIscrollView)];
        
        tapGesture.delegate = self;
        tapGesture.numberOfTapsRequired = 1;//单击
        tapGesture.numberOfTouchesRequired = 1;//点按手指数
        
        [_scrollView addGestureRecognizer:tapGesture];
        
    }
    return _scrollView;
    
}

- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        // 分页控件，本质上和scrollView没有任何关系，是两个独立的控件
        _pageControl = [[UIPageControl alloc] init];
        // 总页数
        _pageControl.numberOfPages = kImageCount;
        // 控件尺寸
        CGSize size = [_pageControl sizeForNumberOfPages:kImageCount];
        
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.scrollView.frame) - 10);
        
        // 设置颜色
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
        
        [self.view addSubview:_pageControl];
        
        // 添加监听方法
        /** 在OC中，绝大多数"控件"，都可以监听UIControlEventValueChanged事件，button除外" */
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (UIView *)newsView{
    
    if (!_newsView) {
        _newsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), UIScreenWidth, UIScreenHeight * 0.05)];
        _newsView.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
        
    }
    return _newsView;
}

- (UILabel *)newsLabel{
    
    if (!_newsLabel) {
        _newsLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.newsView.frame) - UIScreenWidth * 0.36, 0, UIScreenWidth * 0.72, UIScreenHeight * 0.05)];
        //_newsLabel.backgroundColor = [UIColor purpleColor];
        //_newsLabel.adjustsFontSizeToFitWidth = YES;
        _newsLabel.font = FONT_15;
        [_newsLabel setText:@"新消息在这里～"];
        [_newsLabel setTextColor:[UIColor whiteColor]];
    }
    return _newsLabel;
    
}

- (UIImageView *)newsLeftImageView{
    
    if (!_newsLeftImageView) {
        _newsLeftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, CGRectGetMidY(self.newsLabel.frame) - UIScreenHeight * 0.016, UIScreenHeight * 0.04, UIScreenHeight * 0.032)];
        [_newsLeftImageView setImage:[UIImage imageNamed:@"译员首页1"]];
        //_newsLeftImageView.clipsToBounds  = YES;
        //_newsLeftImageView.backgroundColor = [UIColor redColor];
    }
    
    return _newsLeftImageView;
    
}

- (UIImageView *)newsRightImageView{
    
    if (!_newsRightImageView) {
        _newsRightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth - 15 - UIScreenHeight * 0.04, CGRectGetMidY(self.newsLabel.frame) - UIScreenHeight * 0.016, UIScreenHeight * 0.04, UIScreenHeight * 0.032)];
        [_newsRightImageView setImage:[UIImage imageNamed:@"译员首页2"]];
        //_newsRightImageView.contentMode =  UIViewContentModeScaleAspectFill;
        
        
        //_newsRightImageView.clipsToBounds  = YES;
        //_newsRightImageView.backgroundColor = [UIColor redColor];
    }
    
    return _newsRightImageView;
    
}


- (void)addImageView{
    
    for (int i = 0; i < kImageCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"img_%02d", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        imageView.image = image;
        imageView.backgroundColor = [UIColor whiteColor];
        
        [self.scrollView addSubview:imageView];
    }
    
    //计算imageView
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        // 调整x => origin => frame
        CGRect frame = imageView.frame;
        frame.origin.x = idx * frame.size.width;
        
        imageView.frame = frame;
    }];
    
    // 分页初始页数为0
    self.pageControl.currentPage = 0;
    
    
}

- (UIImageView *)popularImageView{
    if (!_popularImageView) {
        _popularImageView = [[UIImageView alloc]init];
        //_popularImageView.backgroundColor = [UIColor orangeColor];
        [_popularImageView setImage:[UIImage imageNamed:@"译员首页11"]];
        _popularImageView.frame = CGRectMake(18, CGRectGetMaxY(self.freeTransLabel.frame) + 10, (UIScreenWidth + 50) / 2 , 36);
    }
    return _popularImageView;
}

- (UILabel *)popularImageViewLabel{
    if (!_popularImageViewLabel) {
        _popularImageViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, CGRectGetMaxY(self.freeTransLabel.frame) + 10, 160, 36)];
        _popularImageViewLabel.text = @"实时热门";
        _popularImageViewLabel.font = FONT_20;
        [_popularImageViewLabel setTextColor:[UIColor orangeColor]];
        _popularImageViewLabel.backgroundColor = [UIColor clearColor];
    }
    return _popularImageViewLabel;
}


- (UITableView *)popularCellView{
    if (!_popularCellView) {
        _popularCellView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, UIScreenWidth, UIScreenHeight - 108)];
        
        
        _popularCellView.backgroundColor = [UIColor clearColor];
        
        _popularCellView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        _popularCellView.tableHeaderView = self.bottomView;
        
        self.popularCellView.delegate = self;
        
        self.popularCellView.dataSource = self;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aa)];
        
        tapGesture.delegate = self;
        tapGesture.numberOfTapsRequired = 1;//单击
        tapGesture.numberOfTouchesRequired = 1;//点按手指数
        
        [_popularCellView addGestureRecognizer:tapGesture];
    }
    return _popularCellView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, CGRectGetMaxY(self.popularImageView.frame) + 5)];
        
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}

- (UIImageView *)backgroundImageView{
    
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, UIScreenHeight - UIScreenWidth * 0.667, UIScreenWidth, UIScreenWidth * 0.667)];
        _backgroundImageView.image = [UIImage imageNamed:@"backgroundImage"];
        
    }
    return _backgroundImageView;
    
}


- (void)aa{
    
}

@end



























