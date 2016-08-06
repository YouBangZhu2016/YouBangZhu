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

@interface HelpViewController ()
-(void)submitClick;
@property (nonatomic ,strong) UITextField *submitTF;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"帮助与反馈";
    
    
    self.submitTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 230)];
    self.submitTF.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.submitTF];
    
    UIButton *submitB = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-85, 300, 75, 30)];
    submitB.backgroundColor = [UIColor orangeColor];
    [submitB setTitle:@"提交" forState:UIControlStateNormal];
    [submitB addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:submitB];
}


-(void)submitClick{
    if(self.submitTF.text.length == 0){
        
        self.submitTF.placeholder = @"反馈信息不能为空";
        
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


