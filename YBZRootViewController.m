//
//  YBZRootViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZRootViewController.h"
#import "YBZTranslationController.h"
#import "YBZFreeTravelController.h"
#import "UserViewController.h"
#import "YBZBaseNaviController.h"
#import "WebAgent.h"
#import "YBZLoginViewController.h"

@interface YBZRootViewController ()
@property(nonatomic,assign) NSString* isLogin;
@property(nonatomic,strong) NSArray* arrVC;
@end

@implementation YBZRootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initAllNaviController];
    
}

-(void)initAllNaviController{
    
    YBZTranslationController *transVC = [[YBZTranslationController alloc]initWithTitle:@"翻译"];
    YBZFreeTravelController  *freTraVC = [[YBZFreeTravelController alloc]initWithTitle:@"自游行"];
    UserViewController       *userVC  = [[UserViewController alloc]init];
            self.arrVC = @[transVC,freTraVC,userVC];
        NSMutableArray *arrNavi = [[NSMutableArray alloc]initWithCapacity:[self.arrVC count]];
        
        for (int i = 0; i < self.arrVC.count; i ++) {
            
            
            YBZBaseNaviController *nav = [[YBZBaseNaviController alloc]initWithRootViewController:self.arrVC[i]];
            
            [arrNavi addObject:nav];
        }
        
        self.viewControllers = arrNavi;
        
        
        NSArray *arrTitle = @[@"翻译",@"自游行",@"我的"];
        for (int i = 0; i < arrTitle.count ; i++) {
            
            UITabBarItem *item = self.tabBar.items[i];
            item.title = arrTitle[i];
        }

    }


@end
