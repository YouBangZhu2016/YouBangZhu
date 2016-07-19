//
//  ViewController.m
//  aboutYBZ
//
//  Created by sks on 16/7/14.
//  Copyright © 2016年 heyi. All rights reserved.
//

#import "AboutViewController.h"
#import "SecondViewController.h"
#define kbtn 44
@interface AboutViewController ()
@property(nonatomic,strong) UIButton *btn1;
@property(nonatomic,strong) UIButton *btn2;
@property(nonatomic,strong) UIButton *btn3;
@property(nonatomic,strong) UIButton *btn4;
@property(nonatomic,strong) UIButton *btn5;
@property(nonatomic,strong) UIButton *btn6;
-(void)jumpLabClick;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *aboutYBZLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    aboutYBZLabel.text = @"关于游帮主";
    aboutYBZLabel.textAlignment = NSTextAlignmentCenter;
    aboutYBZLabel.font = [UIFont systemFontOfSize:23.0];
    aboutYBZLabel.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:aboutYBZLabel];
    
    
    
    
    UIImage* image = [UIImage imageNamed:@"Logo"];
    UIImageView *logoYBZ   = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 130)];
    [logoYBZ setImage:image];
    logoYBZ.contentMode =  UIViewContentModeCenter;
    [self.view addSubview:logoYBZ];
    
    

    self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 204, self.view.bounds.size.width, kbtn)];
    [self.btn1 setTitle:@"去评分" forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(jumpLabClick) forControlEvents:UIControlEventTouchDown];
    self.btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btn1.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [self.view addSubview:self.btn1];
    
    
    self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 204+kbtn, self.view.bounds.size.width, kbtn)];
    [self.btn2 setTitle:@"功能介绍" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn2 addTarget:self action:@selector(jumpLabClick) forControlEvents:UIControlEventTouchDown];
    self.btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btn2.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [self.view addSubview:self.btn2];
    

    
    self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 204+kbtn*2, self.view.bounds.size.width, kbtn)];
    [self.btn3 setTitle:@"系统通知" forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn3 addTarget:self action:@selector(jumpLabClick) forControlEvents:UIControlEventTouchDown];
    self.btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btn3.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [self.view addSubview:self.btn3];
    

    self.btn4 = [[UIButton alloc]initWithFrame:CGRectMake(0, 204+kbtn*3, self.view.bounds.size.width, kbtn)];
    [self.btn4 setTitle:@"帮助与反馈" forState:UIControlStateNormal];
    [self.btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn4 addTarget:self action:@selector(jumpLabClick) forControlEvents:UIControlEventTouchDown];
    self.btn4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btn4.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [self.view addSubview:self.btn4];

    
    self.btn5 = [[UIButton alloc]initWithFrame:CGRectMake(0, 204+kbtn*4, self.view.bounds.size.width, kbtn)];
    [self.btn5 setTitle:@"投诉" forState:UIControlStateNormal];
    [self.btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn5 addTarget:self action:@selector(jumpLabClick) forControlEvents:UIControlEventTouchDown];
    self.btn5.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btn5.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [self.view addSubview:self.btn5];
    
    
    self.btn6 = [[UIButton alloc]initWithFrame:CGRectMake(0, 204+kbtn*5, self.view.bounds.size.width, kbtn)];
    [self.btn6 setTitle:@"检查新版本" forState:UIControlStateNormal];
    [self.btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btn6 addTarget:self action:@selector(jumpLabClick) forControlEvents:UIControlEventTouchDown];
    self.btn6.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.btn6.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [self.view addSubview:self.btn6];

}

-(void)jumpLabClick{
    SecondViewController *secVC = [[SecondViewController alloc]init];
    [self presentViewController:secVC animated:YES completion:nil];

    
}

@end
