//
//  YBZInterpretViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZInterpretViewController.h"
#import "FeedBackViewController.h"


@interface YBZInterpretViewController ()

@end

@implementation YBZInterpretViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initLeftBarBtnItem];
}


-(void)initLeftBarBtnItem{
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(intoFeedbackClick)];
    
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

#pragma mark - 点击事件
-(void)intoFeedbackClick{
    
    FeedBackViewController *feedbackVC = [[FeedBackViewController alloc]init];
    
    [self.navigationController pushViewController:feedbackVC animated:YES];
    
}

@end
