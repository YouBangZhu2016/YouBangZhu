//
//  EmailViewController.m
//  YBZTravel
//
//  Created by sks on 16/7/26.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "EmailViewController.h"
#import "WebAgent.h"

@interface EmailViewController ()

@property (nonatomic , strong) UITextField *emailTextField;

@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.emailTextField];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title  = @"邮箱";
    
    //添加保存按钮
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(selectrightAction)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //修改字体颜色
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    //自定义返回键
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 30);
    // backBtn.backgroundColor = [UIColor blackColor];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [backBtn setImage:[UIImage imageNamed:@"backBtn.jpg"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - getters
-(UITextField *)emailTextField
{
    if (!_emailTextField) {
        _emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, 50)];
        _emailTextField.backgroundColor = [UIColor whiteColor];
        //设置左偏移
        _emailTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        //设置显示模式为永远显示(默认不显示)
        _emailTextField.leftViewMode = UITextFieldViewModeAlways;
        //删除按钮
        _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _emailTextField.placeholder = @"邮箱📮";
    }
    return _emailTextField;
}

#pragma mark - selectrightAction
-(void)selectrightAction
{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *user_id = [userinfo dictionaryForKey:@"user_id"];
    NSString *emailState;
    if([self.emailTextField.text isEqualToString:@""] || self.emailTextField.text == nil){
        emailState = @"0";
    }
    else{
        emailState = @"1";
    };
    NSLog(@"%@",emailState);
    [WebAgent userId:user_id[@"user_id"] userEmail:self.emailTextField.text accountstate:emailState success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];

    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeEmailAdress" object:nil userInfo:nil];

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
