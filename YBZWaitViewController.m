//
//  YBZWaitViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/8/6.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZWaitViewController.h"
#import "QuickTransViewController.h"
@interface YBZWaitViewController ()

@end

@implementation YBZWaitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.4;
    
    
    UILabel *waitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/3, [UIScreen mainScreen].bounds.size.width, 100)];
    
    waitLabel.textAlignment = NSTextAlignmentCenter;
    waitLabel.font = FONT_15;
    waitLabel.text = @"系统正在给您匹配译员，请耐心等待...";
    
    [self.view addSubview:blackView];
    [self.view addSubview:waitLabel];

   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(beginChatWithTranslator:) name:@"beginChatWithTranslator" object:nil];
    
}

#pragma mark - 观察者方法

-(void)beginChatWithTranslator:(NSNotification *)noti{
    
    
    NSString *translatorId = noti.userInfo[@"translatorID"];
    
    NSString *language = noti.userInfo[@"language_catgory"];
    NSString *pay_number = noti.userInfo[@"pay_number"];
    
    
    
    
    
    NSString *VoiceLanguage;
    NSString *TransLanguage;
    if ([language isEqualToString:@"YingYu"]) {
        
        VoiceLanguage = Voice_YingYu;
        TransLanguage = Trans_YingYu;
    }
    if ([language isEqualToString:@"MeiYu"]) {
        
        VoiceLanguage = Voice_MeiYu;
        TransLanguage = Trans_MeiYu;
    }
    if ([language isEqualToString:@"HanYu"]) {
        
        VoiceLanguage = Voice_HanYu;
        TransLanguage = Trans_HanYu;
    }
    if ([language isEqualToString:@"XiBanYa"]) {
        
        VoiceLanguage = Voice_XiBanYa;
        TransLanguage = Trans_XiBanYa;
    }
    if ([language isEqualToString:@"TaiYu"]) {
        
        VoiceLanguage = Voice_TaiYu;
        TransLanguage = Trans_TaiYu;
    }
    if ([language isEqualToString:@"ALaBoYu"]) {
        
        VoiceLanguage = Voice_ALaBoYu;
        TransLanguage = Trans_ALaBoYu;
    }
    if ([language isEqualToString:@"EYu"]) {
        
        VoiceLanguage = Voice_EYu;
        TransLanguage = Trans_EYu;
    }
    if ([language isEqualToString:@"PuTaoYaYu"]) {
        
        VoiceLanguage = Voice_PuTaoYaYu;
        TransLanguage = Trans_PuTaoYaYu;
    }
    if ([language isEqualToString:@"XiLaYu"]) {
        
        VoiceLanguage = Voice_XiLaYu;
        TransLanguage = Trans_XiLaYu;
    }
    if ([language isEqualToString:@"HeLanYu"]) {
        
        VoiceLanguage = Voice_HeLanYu;
        TransLanguage = Trans_HeLanYu;
    }
    if ([language isEqualToString:@"BoLanYu"]) {
        
        VoiceLanguage = Voice_BoLanYu;
        TransLanguage = Trans_BoLanYu;
    }
    if ([language isEqualToString:@"DanMaiYu"]) {
        
        VoiceLanguage = Voice_DanMaiYu;
        TransLanguage = Trans_DanMaiYu;
    }
    if ([language isEqualToString:@"FenLanYu"]) {
        
        VoiceLanguage = Voice_FenLanYu;
        TransLanguage = Trans_FenLanYu;
    }
    if ([language isEqualToString:@"JieKeYu"]) {
        
        VoiceLanguage = Voice_JieKeYu;
        TransLanguage = Trans_JieKeYu;
    }
    if ([language isEqualToString:@"RuiDianYu"]) {
        
        VoiceLanguage = Voice_RuiDianYu;
        TransLanguage = Trans_RuiDianYu;
    }
    if ([language isEqualToString:@"XiongYaLiYu"]) {
        
        VoiceLanguage = Voice_XiongYaLiYu;
        TransLanguage = Trans_XiongYaLiYu;
    }
    if ([language isEqualToString:@"RiYu"]) {
        
        VoiceLanguage = Voice_RiYu;
        TransLanguage = Trans_RiYu;
    }
    if ([language isEqualToString:@"FaYu"]) {
        
        VoiceLanguage = Voice_FaYa;
        TransLanguage = Trans_FaYu;
    }
    if ([language isEqualToString:@"DeYu"]) {
        
        VoiceLanguage = Voice_DeYu;
        TransLanguage = Trans_DeYu;
    }
    if ([language isEqualToString:@"YiDaLiYu"]) {
        
        VoiceLanguage = Voice_YiDaLiYu;
        TransLanguage = Trans_YiDaLiYu;
    }

    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userdefault objectForKey:@"user_id"];
    
    QuickTransViewController *quickVC = [[QuickTransViewController alloc]initWithUserID:userID WithTargetID:translatorId WithUserIdentifier:@"USER" WithVoiceLanguage:VoiceLanguage WithTransLanguage:TransLanguage];
    
    
    
    [self.navigationController pushViewController:quickVC animated:YES];
    
    
    
}


@end




















