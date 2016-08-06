//
//  complaintViewController.m
//  YBZTravel
//
//  Created by sks on 16/7/26.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "complaintViewController.h"

@interface complaintViewController ()
@property (nonatomic, strong) UITextField *complaintText;


@end

@implementation complaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.complaintText = [[UITextField alloc]initWithFrame:CGRectMake(0, 84, self.view.bounds.size.width, 100)];
    self.complaintText.backgroundColor = [UIColor whiteColor];
    self.complaintText.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    self.complaintText.leftViewMode = UITextFieldViewModeAlways;
    self.complaintText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.complaintText.keyboardType = UIKeyboardTypeEmailAddress;
    self.complaintText.placeholder = @"投诉";

    [self.view addSubview:self.complaintText];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title  = @"投诉";
    //添加保存按钮
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(selectrightAction)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //自定义返回键
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 30);
    // backBtn.backgroundColor = [UIColor blackColor];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [backBtn setImage:[UIImage imageNamed:@"boult"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}



-(void)selectrightAction
{
    
    NSString *comlaintValue = self.complaintText.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"complaintText" object:nil
                                                      userInfo:@{@"投诉":comlaintValue}];

    
    [self.navigationController popViewControllerAnimated:YES];
  
}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
