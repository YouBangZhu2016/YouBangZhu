//
//  testViewController.m
//  CharttingController
//
//  Created by tjufe on 16/7/25.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "testViewController.h"
#import "QuickTransViewController.h"
#import "FreeTransViewController.h"

//百度               嗓音
//auto	自动检测
        //zh	中文        //zh-CN
        //en	英语        //en-GB
        //en    美语        //en-US
       //yue	粤语        //zh-CN
       //wyw	文言文      //zh-CN
        //jp	日语        //ja-JP
       //kor	韩语        //ko-KR
       //fra	法语        //fr-FR
       //spa	西班牙语    //es-ES
        //th	泰语        //th-TH
       //ara	阿拉伯语     //ar-SA    ??????
        //ru	俄语        //ru-RU
        //pt	葡萄牙语     //pt-BR
        //de	德语        //de-DE
        //it	意大利语     //it-IT
        //el	希腊语       //el-GR
         //nl	荷兰语       //nl-NL
        //pl	波兰语      //pl-PL
//bul	保加利亚语      （不做）
//est	爱沙尼亚语      （不做）
       //dan	丹麦语          //da-DK
       //fin	芬兰语          //fi-FI
        //cs	捷克语          //cs-CZ
//rom	罗马尼亚语      （不做）
//slo	斯洛文尼亚语    （不做）
       //swe	瑞典语       //sv-SE
        //hu	匈牙利语      //hu-HU
        //cht	繁体中文      //zh-TW


//1
#define Trans_ZhongWen  @"zh"
#define Voice_ZhongWen  @"zh-CN"
//2
#define Trans_YingYu    @"en"
#define Voice_YingYu    @"en-GB"
//3
#define Trans_MeiYu     @"en"
#define Voice_MeiYu     @"en-US"
//4
#define Trans_YueYu     @"yue"
#define Voice_YueYu     @"zh-CN"
//5
#define Trans_WenYanWen       @"wyw"
#define Voice_WenYanWen       @"zh-CN"
//6
#define Trans_RiYu            @"jp"
#define Voice_RiYu            @"ja-JP"
//7
#define Trans_HanYu           @"kor"
#define Voice_HanYu           @"ko-KR"
//8
#define Trans_FaYu            @"fra"
#define Voice_FaYa            @"fr-FR"
//9
#define Trans_XiBanYa         @"spa"
#define Voice_XiBanYa         @"es-ES"
//10
#define Trans_TaiYu           @"th"
#define Voice_TaiYu           @"th-TH"
//11
#define Trans_ALaBoYu         @"ara"
#define Voice_ALaBoYu         @"ar-SA"
//12
#define Trans_EYu             @"ru"
#define Voice_EYu             @"ru-RU"
//13
#define Trans_PuTaoYaYu       @"pt"
#define Voice_PuTaoYaYu       @"pt-BR"
//14
#define Trans_DeYu            @"de"
#define Voice_DeYu            @"de-DE"
//15
#define Trans_YiDaLiYu        @"it"
#define Voice_YiDaLiYu        @"it-IT"
//16
#define Trans_XiLaYu          @"el"
#define Voice_XiLaYu          @"el-GR"
//17
#define Trans_HeLanYu         @"nl"
#define Voice_HeLanYu         @"nl-NL"
//18
#define Trans_BoLanYu         @"pl"
#define Voice_BoLanYu         @"pl-PL"
//19
#define Trans_DanMaiYu        @"dan"
#define Voice_DanMaiYu        @"da-DK"
//20
#define Trans_FenLanYu        @"fin"
#define Voice_FenLanYu        @"fi-FI"
//21
#define Trans_JieKeYu         @"cs"
#define Voice_JieKeYu         @"cs-CZ"
//22
#define Trans_RuiDianYu       @"swe"
#define Voice_RuiDianYu       @"sv-SE"
//23
#define Trans_XiongYaLiYu     @"hu"
#define Voice_XiongYaLiYu     @"hu-HU"
//24
#define Trans_FanTiZhongWen   @"cht"
#define Voice_FanTiZhongWen   @"zh-TW"

@implementation testViewController

-(void)viewDidLoad{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void)butClick{
     QuickTransViewController *ad = [[QuickTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"TRANSTOR" WithVoiceLanguage:Voice_YingYu WithTransLanguage:Trans_YingYu];
    
    [self presentViewController:ad animated:YES completion:nil];
    
}

@end
