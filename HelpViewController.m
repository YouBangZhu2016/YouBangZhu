//
//  ViewController.m
//  assistAndFreedbackInformation
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 heyi. All rights reserved.
//

#import "HelpViewController.h"
#import "AFNetworking.h"
#import "WebAgent.h"
#import "APIClient.h"
#define kScreenWith  [UIScreen mainScreen].bounds.size.width

@interface HelpViewController ()
-(void)submitClick;
@property (nonatomic ,strong) UITextView *submitTF;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"帮助与反馈";
    
    
    self.submitTF = [[UITextView alloc]initWithFrame:CGRectMake(kScreenWith*0.02, kScreenWith*0.013+64, kScreenWith*0.958, kScreenWith*0.37)];
    self.submitTF.backgroundColor = [UIColor whiteColor];
    self.submitTF.editable = YES;
    self.submitTF.font = [UIFont boldSystemFontOfSize:20];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //设置边框宽度
    self.submitTF.layer.borderWidth = 1.0;
    //设置边框颜色
    self.submitTF.layer.borderColor = [UIColor grayColor].CGColor;
    //设置圆角
    self.submitTF.layer.cornerRadius = 5.0;
    [self.view addSubview:self.submitTF];
    
    UIButton *submitB = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-85, kScreenWith*0.394+64, 75, 30)];
    submitB.backgroundColor = [UIColor orangeColor];
    [submitB setTitle:@"提交" forState:UIControlStateNormal];
    [submitB addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submitB];
}


-(void)submitClick{
    if(self.submitTF.text.length == 0){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"反馈信息不能为空" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alertView show];
        
    }
    
    else{
        //获取时间
        NSDate *sendDate = [NSDate date];
        NSDateFormatter *dateForMatter = [[NSDateFormatter alloc]init];
        [dateForMatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *morelocationString = [dateForMatter stringFromDate:sendDate];
        NSUserDefaults *useriinfo = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *user_id = [useriinfo dictionaryForKey:@"user_id"];
        NSDictionary *otherDic = [useriinfo dictionaryForKey:@"account_state"];
        
        
        if([otherDic[@"user_email"] isEqual:@""]){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请绑定邮箱" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [alertView show];
        }
        else{
            [WebAgent user_id:user_id[@"user_id"] user_feedbackinfo:self.submitTF.text feedbackinfo_time:morelocationString user_phone:otherDic[@"user_phone"] user_email:otherDic[@"user_email"] success:^(id responseObject) {
                NSData *data = [[NSData alloc]initWithData:responseObject];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dic);
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }
             ];
        }
        
    }
    
}






@end


