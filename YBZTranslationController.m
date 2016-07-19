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

#import "MJRefresh.h"

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
@property (nonatomic, strong) UIButton *translaterBtn;
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
@property (nonatomic, strong) UITableView *popularCellView;
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (nonatomic, strong) UIView      *bottomView;



//@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
//@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
//@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
//@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
//@property (strong, nonatomic) IBOutlet UIButton *allInfoBtn;
//@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
//@property (strong, nonatomic) IBOutlet UILabel *payLabel;



//判断登录状态
@property(nonatomic,assign) BOOL isLogin;
@property(nonatomic,assign) BOOL isUser;



@end

@implementation YBZTranslationController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.isLogin = YES;
    self.isUser = YES;
    
    //self.view.backgroundColor = [UIColor grayColor];
    
    //[self.view addSubview:self.popularCell];
    [self.view addSubview:self.popularCellView];
    
    [self.bottomView addSubview:self.newsView];
    [self.newsView addSubview:self.newsLabel];
    [self.newsView addSubview:self.newsLeftImageView];
    [self.newsView addSubview:self.newsRightImageView];
    

    [self.bottomView addSubview:self.userBtn];
    [self.bottomView addSubview:self.translaterBtn];
    
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
    self.userBtn.backgroundColor = [UIColor orangeColor];
    
    self.translaterBtn.selected = NO;
    self.translaterBtn.backgroundColor = [UIColor grayColor];
    
}

-(void)interpretIdentifierClick{
    
    self.userBtn.selected = NO;
    self.userBtn.backgroundColor = [UIColor grayColor];
    
    self.translaterBtn.selected = YES;
    self.translaterBtn.backgroundColor = [UIColor orangeColor];

    
}

-(void)intoFreeTranslationClick{
    
    
    YBZFreeTranslationViewController *freeTransVC = [[YBZFreeTranslationViewController alloc]initWithTitle:@"免费翻译"];
    freeTransVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:freeTransVC animated:YES];
    
}

-(void)intoChangeLanguageClick{
    
    if (self.isLogin) {
        
//        YBZChangeLanguageViewController *changelangeVC = [[YBZChangeLanguageViewController alloc]initWithTitle:@"切换语言"];
        
    
        YBZInterpretViewController  *changelangeVC = [[YBZInterpretViewController alloc]init];
        
        changelangeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changelangeVC animated:YES];
        
    }else{
        
        //进入登陆流程
        YBZLoginViewController *logVC = [[YBZLoginViewController alloc]initWithTitle:@"登录"];
        YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:logVC];
        logVC.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:nav animated:YES completion:nil];
        
    }
    
}


- (void)pageChanged:(UIPageControl *)page
{
    // 根据页数，调整滚动视图中的图片位置 contentOffset
    CGFloat x = page.currentPage * self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}









#pragma mark - getters



//用户身份按钮
-(UIButton *)userBtn{
    
    if (!_userBtn) {
        _userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_userBtn setTitle:@"用户" forState:UIControlStateNormal];
        
        if (_isUser) {
            _userBtn.backgroundColor = [UIColor orangeColor];
        }else{
            _userBtn.backgroundColor = [UIColor grayColor];
        }
        _userBtn.frame = CGRectMake(-25, CGRectGetMaxY(self.newsView.frame) + 15, UIScreenWidth / 2 + 15, 32);
        
        [_userBtn addTarget:self action:@selector(userIdentifierClick) forControlEvents:UIControlEventTouchUpInside];
        _userBtn.layer.cornerRadius = 16;
    }
    return _userBtn;
}


//翻译人员身份按钮
-(UIButton *)translaterBtn{
    
    if (!_translaterBtn) {
        _translaterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_translaterBtn setTitle:@"译员" forState:UIControlStateNormal];
        
        if (_isUser) {
            _translaterBtn.backgroundColor = [UIColor grayColor];
        }else{
            _translaterBtn.backgroundColor = [UIColor orangeColor];
        }
        _translaterBtn.frame = CGRectMake(CGRectGetMaxX(self.userBtn.frame) + 20, CGRectGetMaxY(self.newsView.frame) + 15, UIScreenWidth / 2 + 25, 32);
        [_translaterBtn addTarget:self action:@selector(interpretIdentifierClick) forControlEvents:UIControlEventTouchUpInside];
        _translaterBtn.layer.cornerRadius = 16;
    }
    return _translaterBtn;
}

-(UIButton *)freeTransBtn{
    
    if (!_freeTransBtn) {
        _freeTransBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_freeTransBtn setTitle:@"免费翻译" forState:UIControlStateNormal];
        _freeTransBtn.backgroundColor = [UIColor purpleColor];
        _freeTransBtn.frame = CGRectMake(UIScreenWidth / 2 - UITranslationBtnMargin * 1.5 - UITranslationBtnSize * 2, CGRectGetMaxY(self.userBtn.frame) + 20, UITranslationBtnSize , UITranslationBtnSize);
        [_freeTransBtn addTarget:self action:@selector(intoFreeTranslationClick) forControlEvents:UIControlEventTouchUpInside];
        _freeTransBtn.layer.cornerRadius = UITranslationBtnSize / 2;

    }
    return _freeTransBtn;
}

- (UILabel *)freeTransLabel{
    
    if (!_freeTransLabel) {
        _freeTransLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.freeTransBtn.frame) - 35, CGRectGetMaxY(self.freeTransBtn.frame) + 2, 70, 15)];
        //_freeTransLabel.backgroundColor = [UIColor greenColor];
        [_freeTransLabel setText:@"免费翻译"];
        _freeTransLabel.textAlignment = NSTextAlignmentCenter;
        
        _freeTransLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _freeTransLabel;
}

-(UIButton *)interpretBtn{
    
    if (!_interpretBtn) {
        _interpretBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_interpretBtn setTitle:@"口语即时" forState:UIControlStateNormal];
        _interpretBtn.backgroundColor = [UIColor purpleColor];
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
        //_interpretLabel.backgroundColor = [UIColor greenColor];
        [_interpretLabel setText:@"口语即时"];
        _interpretLabel.textAlignment = NSTextAlignmentCenter;
        
        _interpretLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return _interpretLabel;
    
}

-(UIButton *)customMadeBtn{
    
    if (!_customMadeBtn) {
        _customMadeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_customMadeBtn setTitle:@"Btn3" forState:UIControlStateNormal];
        _customMadeBtn.backgroundColor = [UIColor purpleColor];
        //_interpretBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, CGRectGetMaxY(self.translaterBtn.frame) + 20, 100, 50);
        _customMadeBtn.frame = CGRectMake(CGRectGetMidX(self.interpretBtn.frame) + UITranslationBtnSize / 2 + UITranslationBtnMargin, CGRectGetMaxY(self.userBtn.frame) + 20, UITranslationBtnSize, UITranslationBtnSize);
        [_customMadeBtn addTarget:self action:@selector(intoChangeLanguageClick) forControlEvents:UIControlEventTouchUpInside];
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
        _customMadeLabel.textAlignment = NSTextAlignmentCenter;
        
        _customMadeLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return _customMadeLabel;
    
}

-(UIButton *)myOfferBtn{
    
    if (!_myOfferBtn) {
        _myOfferBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myOfferBtn setTitle:@"Btn4" forState:UIControlStateNormal];
        _myOfferBtn.backgroundColor = [UIColor purpleColor];
        //_interpretBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, CGRectGetMaxY(self.translaterBtn.frame) + 20, 100, 50);
        _myOfferBtn.frame = CGRectMake(CGRectGetMaxX(self.customMadeBtn.frame) + UITranslationBtnMargin, CGRectGetMaxY(self.userBtn.frame) + 20, UITranslationBtnSize, UITranslationBtnSize);
        [_myOfferBtn addTarget:self action:@selector(intoChangeLanguageClick) forControlEvents:UIControlEventTouchUpInside];
        _myOfferBtn.layer.cornerRadius = UITranslationBtnSize / 2;

    }
    return _myOfferBtn;
}

- (UILabel *)myOfferLabel{
    
    if (!_myOfferLabel) {
        _myOfferLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.myOfferBtn.frame) - 35, CGRectGetMaxY(self.myOfferBtn.frame) + 2, 70, 15)];
        //_myOfferLabel.backgroundColor = [UIColor greenColor];
        [_myOfferLabel setText:@"我的悬赏"];
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
        _newsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), UIScreenWidth, 28)];
        _newsView.backgroundColor = [UIColor lightGrayColor];

    }
    return _newsView;
}

- (UILabel *)newsLabel{
    
    if (!_newsLabel) {
        _newsLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, UIScreenWidth - 100, 28)];
        _newsLabel.backgroundColor = [UIColor purpleColor];
        
        [_newsLabel setText:@"啦啦啦"];
        
    }
    return _newsLabel;
    
}

- (UIImageView *)newsLeftImageView{
    
    if (!_newsLeftImageView) {
        _newsLeftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 28, 28)];
        _newsLeftImageView.backgroundColor = [UIColor redColor];
    }
    
    return _newsLeftImageView;
    
}

- (UIImageView *)newsRightImageView{
    
    if (!_newsRightImageView) {
        _newsRightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth - 48, 0, 28, 28)];
        _newsRightImageView.backgroundColor = [UIColor redColor];
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
        _popularImageView.backgroundColor = [UIColor orangeColor];
        _popularImageView.frame = CGRectMake(0, CGRectGetMaxY(self.freeTransLabel.frame) + 10, 100, 36);
    }
    return _popularImageView;
}


- (UITableView *)popularCellView{
    if (!_popularCellView) {
        _popularCellView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
        
        
        _popularCellView.backgroundColor = [UIColor whiteColor];
        
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
        
        _bottomView.backgroundColor = [UIColor yellowColor];
    }
    return _bottomView;
}


- (void)aa{
    
}

@end



























