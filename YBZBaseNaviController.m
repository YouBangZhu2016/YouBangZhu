//
//  YBZBaseNaviController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZBaseNaviController.h"

@interface YBZBaseNaviController ()

@end

@implementation YBZBaseNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255.0f/255.0f green:220.0f/255.0f blue:0 alpha:1.0f]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
    
    
}
@end
