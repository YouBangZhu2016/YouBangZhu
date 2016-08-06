//
//  ViewController.m
//  aboutYBZ
//
//  Created by sks on 16/7/14.
//  Copyright © 2016年 heyi. All rights reserved.
//

#import "AboutViewController.h"
#import "AFNetworking.h"
#import "WebAgent.h"
#import "APIClient.h"


@interface AboutViewController ()

@property (nonatomic ,strong) UITextView *textView;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"关于游帮主";
    
    UIImage* image = [UIImage imageNamed:@"Logo"];
    UIImageView *logoYBZ   = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 130)];
    [logoYBZ setImage:image];
    logoYBZ.contentMode =  UIViewContentModeCenter;
    [self.view addSubview:logoYBZ];
    
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 194,self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.textView];
    
    
    
    [WebAgent version_numAbout:@"1.0" success:^(id responseObject) {
        NSData *data = [[NSData alloc]initWithData:responseObject];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        NSDictionary *offsend = dic[@"official_send"];
        NSString *aString = offsend[@"about-text"];
        
        NSLog(@"%@",aString);
        self.textView.text = aString;
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
    
    
    
    
    
    
    
}



@end
