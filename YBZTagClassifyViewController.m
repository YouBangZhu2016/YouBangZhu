//
//  YBZTagClassifyViewController.m
//  YBZTravel
//
//  Created by sks on 16/8/14.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZTagClassifyViewController.h"
#import "WebAgent.h"

@interface YBZTagClassifyViewController ()<UITextFieldDelegate>

@property (nonatomic , strong) UIView *mainView;
@property (nonatomic , strong) UILabel *fixedLabel;
@property (nonatomic , strong) UITextField *inputTextField;
@property (nonatomic , strong) UIButton *cancelBut;
@property (nonatomic , strong) UIButton *affirmBut;
@property (nonatomic , strong) UILabel *hotLabel;
@property (nonatomic , strong) NSMutableArray *labelTextArr;
@property (nonatomic , strong) UIButton *labelBut1;
@property (nonatomic , strong) UIButton *labelBut2;
@property (nonatomic , strong) UIButton *labelBut3;
@property (nonatomic , strong) UIButton *labelBut4;
@property (nonatomic , strong) UIButton *labelBut5;
@property (nonatomic , strong) UIButton *labelBut6;

@end

@implementation YBZTagClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"标签分类";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.view.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1];
    
    //使用前一定要初始化数组，否则无法对其赋值
    self.labelTextArr = [[NSMutableArray alloc]initWithCapacity:8];
    NSArray *labelIDArr = @[@"0001",@"0002",@"0003",
                            @"0004",@"0005",@"0006"];
    for (int i = 0; i < labelIDArr.count; i ++) {
        [WebAgent getLabelInfo:labelIDArr[i] success:^(id responseObject) {
            NSData *data = [[NSData alloc]initWithData:responseObject];
            NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self.labelTextArr addObject:[tempDic[@"data"] objectForKey:@"label_text"]];
            //加以判断，决定何时执行函数
            if (i == (labelIDArr.count - 1)) {
                [self drawView];
                NSLog(@"%@",self.labelTextArr);
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldAction) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldAction) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

-(void)drawView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 64) / 2)];
        _mainView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.mainView];
        
        _fixedLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 26, 30)];
        _fixedLabel.text = @"#";
        _fixedLabel.textAlignment = NSTextAlignmentCenter;
        _fixedLabel.font = [UIFont systemFontOfSize:20];
        _fixedLabel.textColor = [UIColor colorWithRed:10 / 255.0 green:165 / 255.0 blue:220 / 255.0 alpha:1];
        _fixedLabel.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:228 / 255.0 blue:230 / 255.0 alpha:1];
        _fixedLabel.layer.cornerRadius = 2;
        _fixedLabel.layer.masksToBounds = YES;
        
        _inputTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 10, [UIScreen mainScreen].bounds.size.width - 96, 30)];
        _inputTextField.placeholder = @"话题、分类、电影、歌曲、书籍、国家";
        _inputTextField.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:228 / 255.0 blue:230 / 255.0 alpha:1];
        _inputTextField.layer.cornerRadius = 2;
        [[UITextField appearance] setTintColor:[UIColor blackColor]];
        _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputTextField.delegate = self;
        
        _cancelBut = [[UIButton alloc]initWithFrame:CGRectMake(self.inputTextField.frame.origin.x + self.inputTextField.bounds.size.width + 8, 10, 40, 30)];
        [_cancelBut setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBut.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBut addTarget:self action:@selector(cancelButClick) forControlEvents:UIControlEventTouchUpInside];
        
        _affirmBut = [[UIButton alloc]initWithFrame:CGRectMake(self.inputTextField.frame.origin.x + self.inputTextField.bounds.size.width + 8, 10, 40, 30)];
        [_affirmBut setTitle:@"确定" forState:UIControlStateNormal];
        [_affirmBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _affirmBut.titleLabel.font = [UIFont systemFontOfSize:16];
        [_affirmBut addTarget:self action:@selector(affirmButClick) forControlEvents:UIControlEventTouchUpInside];
        _affirmBut.hidden = YES;
        
        CGSize size = [@"热门标签" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        _hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.inputTextField.frame.origin.y + 60, size.width, size.height)];
        _hotLabel.text = @"热门标签";
        _hotLabel.font = [UIFont systemFontOfSize:18];
        
        int x = 20;
        int y = self.hotLabel.frame.origin.y + 50;
        size = [self.labelTextArr[0] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        _labelBut1 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, size.width + 16, size.height)];
        [_labelBut1 setTitle:self.labelTextArr[0] forState:UIControlStateNormal];
        _labelBut1.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:229 / 255.0 blue:229 / 255.0 alpha:1];
        [_labelBut1 setTitleColor:[UIColor colorWithRed:148 / 255.0 green:148 / 255.0 blue:148 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_labelBut1 addTarget:self action:@selector(labelBut1Click) forControlEvents:UIControlEventTouchUpInside];
        
        x += size.width + 26;
        size = [self.labelTextArr[1] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        _labelBut2 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, size.width + 16, size.height)];
        [_labelBut2 setTitle:self.labelTextArr[1] forState:UIControlStateNormal];
        _labelBut2.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:229 / 255.0 blue:229 / 255.0 alpha:1];
        [_labelBut2 setTitleColor:[UIColor colorWithRed:148 / 255.0 green:148 / 255.0 blue:148 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_labelBut2 addTarget:self action:@selector(labelBut2Click) forControlEvents:UIControlEventTouchUpInside];
        
        x += size.width + 26;
        size = [self.labelTextArr[2] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        _labelBut3 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, size.width + 16, size.height)];
        [_labelBut3 setTitle:self.labelTextArr[2] forState:UIControlStateNormal];
        _labelBut3.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:229 / 255.0 blue:229 / 255.0 alpha:1];
        [_labelBut3 setTitleColor:[UIColor colorWithRed:148 / 255.0 green:148 / 255.0 blue:148 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_labelBut3 addTarget:self action:@selector(labelBut3Click) forControlEvents:UIControlEventTouchUpInside];
        
        size = [self.labelTextArr[3] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        x = 20;
        y += 40;
        _labelBut4 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, size.width + 16, size.height)];
        [_labelBut4 setTitle:self.labelTextArr[3] forState:UIControlStateNormal];
        _labelBut4.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:229 / 255.0 blue:229 / 255.0 alpha:1];
        [_labelBut4 setTitleColor:[UIColor colorWithRed:148 / 255.0 green:148 / 255.0 blue:148 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_labelBut4 addTarget:self action:@selector(labelBut4Click) forControlEvents:UIControlEventTouchUpInside];
        
        x += size.width + 26;
        size = [self.labelTextArr[4] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        _labelBut5 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, size.width + 16, size.height)];
        [_labelBut5 setTitle:self.labelTextArr[4] forState:UIControlStateNormal];
        _labelBut5.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:229 / 255.0 blue:229 / 255.0 alpha:1];
        [_labelBut5 setTitleColor:[UIColor colorWithRed:148 / 255.0 green:148 / 255.0 blue:148 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_labelBut5 addTarget:self action:@selector(labelBut5Click) forControlEvents:UIControlEventTouchUpInside];
        
        x += size.width + 26;
        size = [self.labelTextArr[5] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        _labelBut6 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, size.width + 16, size.height)];
        [_labelBut6 setTitle:self.labelTextArr[5] forState:UIControlStateNormal];
        _labelBut6.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:229 / 255.0 blue:229 / 255.0 alpha:1];
        [_labelBut6 setTitleColor:[UIColor colorWithRed:148 / 255.0 green:148 / 255.0 blue:148 / 255.0 alpha:1] forState:UIControlStateNormal];
        [_labelBut6 addTarget:self action:@selector(labelBut6Click) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView addSubview:self.fixedLabel];
        [self.mainView addSubview:self.inputTextField];
        [self.mainView addSubview:self.cancelBut];
        [self.mainView addSubview:self.affirmBut];
        [self.mainView addSubview:self.hotLabel];
        [self.mainView addSubview:self.labelBut1];
        [self.mainView addSubview:self.labelBut2];
        [self.mainView addSubview:self.labelBut3];
        [self.mainView addSubview:self.labelBut4];
        [self.mainView addSubview:self.labelBut5];
        [self.mainView addSubview:self.labelBut6];
        
    }
}

#pragma mark - 监听事件
-(void)textFieldAction
{
    if ([self.inputTextField.text isEqual:@""]) {
        self.cancelBut.hidden = NO;
        self.affirmBut.hidden = YES;
    }else{
        self.cancelBut.hidden = YES;
        self.affirmBut.hidden = NO;
    }
}

#pragma mark - 实现协议中的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.inputTextField resignFirstResponder];
    return YES;
}

#pragma mark - 单击事件
-(void)cancelButClick
{
    [self.inputTextField resignFirstResponder];
}

-(void)affirmButClick
{
    NSLog(@"确定");
}

-(void)labelBut1Click
{
    self.inputTextField.text = self.labelTextArr[0];
    if ([self.inputTextField.text isEqual:@""]) {
        self.cancelBut.hidden = NO;
        self.affirmBut.hidden = YES;
    }else{
        self.cancelBut.hidden = YES;
        self.affirmBut.hidden = NO;
    }
}

-(void)labelBut2Click
{
    self.inputTextField.text = self.labelTextArr[1];
    if ([self.inputTextField.text isEqual:@""]) {
        self.cancelBut.hidden = NO;
        self.affirmBut.hidden = YES;
    }else{
        self.cancelBut.hidden = YES;
        self.affirmBut.hidden = NO;
    }
}

-(void)labelBut3Click
{
    self.inputTextField.text = self.labelTextArr[2];
    if ([self.inputTextField.text isEqual:@""]) {
        self.cancelBut.hidden = NO;
        self.affirmBut.hidden = YES;
    }else{
        self.cancelBut.hidden = YES;
        self.affirmBut.hidden = NO;
    }
}

-(void)labelBut4Click
{
    self.inputTextField.text = self.labelTextArr[3];
    if ([self.inputTextField.text isEqual:@""]) {
        self.cancelBut.hidden = NO;
        self.affirmBut.hidden = YES;
    }else{
        self.cancelBut.hidden = YES;
        self.affirmBut.hidden = NO;
    }
}

-(void)labelBut5Click
{
    self.inputTextField.text = self.labelTextArr[4];
    if ([self.inputTextField.text isEqual:@""]) {
        self.cancelBut.hidden = NO;
        self.affirmBut.hidden = YES;
    }else{
        self.cancelBut.hidden = YES;
        self.affirmBut.hidden = NO;
    }
}

-(void)labelBut6Click
{
    self.inputTextField.text = self.labelTextArr[5];
    if ([self.inputTextField.text isEqual:@""]) {
        self.cancelBut.hidden = NO;
        self.affirmBut.hidden = YES;
    }else{
        self.cancelBut.hidden = YES;
        self.affirmBut.hidden = NO;
    }
}

@end
