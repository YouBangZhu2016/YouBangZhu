//
//  YBZAreaCodeViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZAreaCodeViewController.h"
#import "YBZSingleCodeCell.h"
#import "YBZSingleCodeCell.h"
#import "YBZSingleCodeInfo.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface YBZAreaCodeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *allCodeTableView;
@property (nonatomic,strong) UIButton *chooseCodeBtn;
@property (nonatomic,strong) UILabel *codeLabel;
@property (nonatomic,strong) NSMutableArray *cellArr;

@end

@implementation YBZAreaCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.allCodeTableView];
    [self initData];

}
-(void)initData{
    self.cellArr = [[NSMutableArray alloc]init];
    YBZSingleCodeInfo *cell1 = [[YBZSingleCodeInfo alloc]initWithTitle:@"中国 ＋86"];
    [self.cellArr addObject:cell1];
    YBZSingleCodeInfo *cell2 = [[YBZSingleCodeInfo alloc]initWithTitle:@"日本 ＋81"];
    [self.cellArr addObject:cell2];
    YBZSingleCodeInfo *cell3 = [[YBZSingleCodeInfo alloc]initWithTitle:@"印度 ＋91"];
    [self.cellArr addObject:cell3];
    YBZSingleCodeInfo *cell4 = [[YBZSingleCodeInfo alloc]initWithTitle:@"阿富汗＋93"];
    [self.cellArr addObject:cell4];
    YBZSingleCodeInfo *cell5 = [[YBZSingleCodeInfo alloc]initWithTitle:@"缅甸 ＋95"];
    [self.cellArr addObject:cell5];
    YBZSingleCodeInfo *cell6 = [[YBZSingleCodeInfo alloc]initWithTitle:@"韩国 ＋87"];
    [self.cellArr addObject:cell6];
    YBZSingleCodeInfo *cell7 = [[YBZSingleCodeInfo alloc]initWithTitle:@"土耳其＋90"];
    [self.cellArr addObject:cell7];
    
}

#pragma mark - UITableViewDelegate&UITableViewDataSource


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger row     = indexPath.row;
    
    NSString *data;
    
    if (section == 0 && row == 0) {
        
        data = @"中国＋86";
    }
    if (section == 0 && row == 1) {
        
        data = @"日本＋81";
    }
    if (section == 0 && row == 2) {
        
        data = @"印度＋91";
    }
    if (section == 0 && row == 3) {
        
        data = @"阿富汗＋93";
    }
    if (section == 0 && row == 4) {
        
        data = @"缅甸＋95";
    }
    if (section == 0 && row == 5) {
        
        data = @"韩国＋87";
    }
    if (section == 0 && row == 6) {
        
        data = @"土耳其＋90";
    }
    [self.delegate showCode:data];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YBZSingleCodeInfo *model = self.cellArr[indexPath.row];
    static NSString *cellID = @"YBZSingleCodeInfo";
    YBZSingleCodeCell *cell = nil;
    cell = [self.allCodeTableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YBZSingleCodeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 50);

    }
    cell.codeLabel.text = model.title;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableView *)allCodeTableView{
    if (!_allCodeTableView) {
        
        _allCodeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _allCodeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    
        self.allCodeTableView.delegate = self;
        
        self.allCodeTableView.dataSource = self;
        
    }
    return _allCodeTableView;
    
}
@end
