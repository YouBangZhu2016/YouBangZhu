//
//  YBZChangeLanguageViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZChangeLanguageViewController.h"
#import "YBZInterpretViewController.h"
#import "YBZChangeLanguageCell.h"
#import "YBZChangeLanguageInfo.h"
#import "YBZLanguageSearchResultViewController.h"

@interface YBZChangeLanguageViewController () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>


//@property (nonatomic ,strong) UIView *bottomView;

//@property (nonatomic ,strong) UITextField *searchTextField;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic ,strong) UITableView *cellView;

@property (nonatomic ,strong) NSMutableArray *cellArr;
@property (nonatomic ,strong) NSMutableArray *searchArr;
//搜索结果的表格视图
@property (nonatomic ,strong) UITableViewController *searchTableView;


@end

@implementation YBZChangeLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.view addSubview:self.CH_USBtn];
    //    [self.bottomView addSubview:self.searchTextField];
    
    //    YBZLanguageSearchResultViewController *resultsController = [self.storyboard instantiateViewControllerWithIdentifier:@"YBZLanguageSearchResultViewController"];
    //
    //    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
    //
    //    self.searchController.searchResultsUpdater = resultsController;
    //
    //    self.searchController.searchResultsUpdater = resultsController;
    //    [self.searchController.searchBar sizeToFit];
    //    self.cellView.tableHeaderView = self.searchController.searchBar;
    //    self.definesPresentationContext = YES;
    //
    
    //    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //    _searchController.searchResultsUpdater = self;
    //    _searchController.dimsBackgroundDuringPresentation = NO;
    //    _searchController.hidesNavigationBarDuringPresentation = NO;
    //    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    //    self.cellView.tableHeaderView = self.searchController.searchBar;
    
    //self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.cellView];
    [self createSearchController];
    
    [self initData];
    
}


-(void)initData{
    
    self.cellArr=[NSMutableArray array];
    
    YBZChangeLanguageInfo *cell1 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"简体中文" AndContent:@"简体中文"];
    [self.cellArr addObject:cell1];
    
    YBZChangeLanguageInfo *cell2 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"English" AndContent:@"英文"];
    [self.cellArr addObject:cell2];
    
    YBZChangeLanguageInfo *cell3 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"Français" AndContent:@"法文"];
    [self.cellArr addObject:cell3];
    
    YBZChangeLanguageInfo *cell4 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"Deutsch" AndContent:@"德文"];
    [self.cellArr addObject:cell4];
    
    YBZChangeLanguageInfo *cell5 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"日本語" AndContent:@"日文"];
    [self.cellArr addObject:cell5];
    
    YBZChangeLanguageInfo *cell6 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"Italiano" AndContent:@"意大利文"];
    [self.cellArr addObject:cell6];
    
    YBZChangeLanguageInfo *cell7 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"Español" AndContent:@"西班牙文"];
    [self.cellArr addObject:cell7];
    
    YBZChangeLanguageInfo *cell8 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"한국어" AndContent:@"韩文"];
    [self.cellArr addObject:cell8];
    
    YBZChangeLanguageInfo *cell9 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"Português" AndContent:@"葡萄牙文"];
    [self.cellArr addObject:cell9];
    
    YBZChangeLanguageInfo *cell10 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"Pусский" AndContent:@"俄文"];
    [self.cellArr addObject:cell10];
    
    YBZChangeLanguageInfo *cell11 = [[YBZChangeLanguageInfo alloc]initWithTitle:@"Dansk" AndContent:@"丹麦文"];
    [self.cellArr addObject:cell11];
    
}

#pragma mark - UITableViewDelegate&UITableViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//    return [self.cellArr count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    YBZChangeLanguageInfo *model = self.cellArr[indexPath.row];
//
//    static NSString *cellID = @"YBZChangeLanguageCell";
//
//    YBZChangeLanguageCell *cell = nil;
//
//    //cell = [cellView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//
//    cell = [self.cellView dequeueReusableCellWithIdentifier:cellID];
//
//    if(!cell){
//
//         cell = [[YBZChangeLanguageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//
//    }
//
//    cell.titleLabel.text = model.title;
//    cell.contentLabel.text = model.content;
//
//    return cell;
//
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//    return 60;
//}

#pragma mark - 点击事件

- (void)intoInterpretClick{
    
    
    YBZInterpretViewController *interpretVC = [[YBZInterpretViewController alloc]initWithTitle:@"口语即时"];
    
    [self.navigationController pushViewController:interpretVC animated:YES];
    
}

#pragma mark - getters

//- (UIView *)bottomView{
//    if (!_bottomView) {
//        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 44)];
//
//    }
//    return _bottomView;
//}


- (UITableView *)cellView{
    
    if (!_cellView) {
        
        _cellView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
        
        //_cellView.backgroundColor = [UIColor whiteColor];
        
        //_cellView.tableHeaderView = self.bottomView;
        
        self.cellView.delegate = self;
        
        self.cellView.dataSource = self;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aa)];
        
        tapGesture.delegate = self;
        tapGesture.numberOfTapsRequired = 1;//单击
        tapGesture.numberOfTouchesRequired = 1;//点按手指数
        
        [_cellView addGestureRecognizer:tapGesture];
        
    }
    
    return _cellView;
    
}

- (void)aa{
    
}

//- (UITextField *)searchTextField{
//
//    if (!_searchTextField) {
//        _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 44)];
//        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _searchTextField.placeholder = @"搜索";
//        _searchTextField.textAlignment = NSTextAlignmentCenter;
//
//    }
//    return _searchTextField;
//
//
//}

//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return [self.searchArr count];
    }else{
        return [self.cellArr count];
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YBZChangeLanguageInfo *model = self.cellArr[indexPath.row];
    static NSString *flag=@"cellFlag";
    YBZChangeLanguageCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[YBZChangeLanguageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchController.active) {
        //[cell.textLabel setText:self.searchArr[indexPath.row]];
        cell.titleLabel.text = model.title;
        cell.contentLabel.text = model.content;
    }
    else{
        
        NSLog(@"sadsdasd%@",self.cellArr[indexPath.row]);
        
        //[cell.textLabel setText:self.cellArr[indexPath.row]];
        cell.titleLabel.text = model.title;
        cell.contentLabel.text = model.content;
        
    }
    
    //    cell.titleLabel.text = model.title;
    //    cell.contentLabel.text = model.content;
    
    return cell;
}


- (void)createSearchController
{
    //表格界面
    _searchTableView = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    //tableview是表格视图
    //UITableViewController表格视图控制器
    _searchTableView.tableView.dataSource = self;
    _searchTableView.tableView.delegate = self;
    //设置大小
    _searchTableView.tableView.frame = self.view.bounds;
    //创建搜索界面
    _searchController = [[UISearchController alloc]initWithSearchResultsController:_searchTableView];
    //把表格视图控制器跟搜索界面相关联
    
    //设置搜索栏的大小
    _searchController.searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    
    //把搜索栏放到tableview的头视图上
    _cellView.tableHeaderView = _searchController.searchBar;
    //设置搜索的代理
    _searchController.searchResultsUpdater = self;
    
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"搜索");
    //在点击搜索时会调用一次，点击取消按钮又调用一次
    //判断当前搜索是否在搜索状态还是取消状态
    if (_searchController.isActive) {
        //表示搜索状态
        
        //初始化搜索数组
        if (_searchArr == nil) {
            _searchArr = [[NSMutableArray alloc]init];
        }else{
            [_searchArr removeAllObjects];
            //遍历数据源，给搜索数组添加对象
            for (YBZChangeLanguageInfo * info in _cellArr)
            {
                ////                NSArray *info = array;
                //if (NSString * name in info){
                
                NSRange rangeTitle = [info.title rangeOfString:searchController.searchBar.text];
                NSRange rangeContent = [info.content rangeOfString:searchController.searchBar.text];
                if (rangeTitle.location != NSNotFound | rangeContent.location != NSNotFound) {
                    [_searchArr addObject:info];
                }
                //}
            }
        }
        //刷新搜索界面的tableview
        [_searchTableView.tableView reloadData];

        _searchTableView.tableView.frame = CGRectMake(0, -44, self.view.bounds.size.width, self.view.bounds.size.height + 44);
    }
}

//-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//
//    NSString *searchString = searchController.searchBar.text;
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//    if (!(_searchArr == nil)) {
//        [self.searchArr removeAllObjects];
//    }
//    //过滤数据
//
//    self.searchArr = [NSMutableArray arrayWithArray:[_cellArr filteredArrayUsingPredicate:preicate]];
//    //刷新表格
//    [self.cellView reloadData];
//
//}

@end

