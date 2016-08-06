//
//  YBZFreeTranslationViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZFreeTranslationViewController.h"
#import "YBZFreeTranslationViewCell.h"
#import "YBZFreeTranslationInfo.h"
#import "FreeTransViewController.h"

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
#define Voice_FaYu            @"fr-FR"
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


@interface YBZFreeTranslationViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIButton *CN_EN;
@property (nonatomic , strong) UIButton *CN_JP;
@property (nonatomic , strong) UIButton *CN_FR;
@property (nonatomic , strong) UIButton *CN_DE;//德语
@property (nonatomic , strong) UIButton *CN_IT;//意大利
@property (nonatomic , strong) UIButton *CN_ES;//西班牙
@property (nonatomic , strong) UIButton *CN_PT;//葡萄牙

@property (nonatomic ,strong) UITableView *cellView;
@property (nonatomic, strong) NSMutableArray *cellArr;


@end

@implementation YBZFreeTranslationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.CN_EN];
    [self.view addSubview:self.CN_JP];
    [self.view addSubview:self.CN_FR];
    [self.view addSubview:self.CN_DE];
    [self.view addSubview:self.CN_IT];
    [self.view addSubview:self.CN_ES];
    
    [self.view addSubview:self.cellView];
    
    [self initData];
}

- (void)initData{
    
    self.cellArr = [[NSMutableArray alloc]init];
    
    YBZFreeTranslationInfo *freeTranslationCellView1 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 英语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView1];
    
    YBZFreeTranslationInfo *freeTranslationCellView2 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 美式英语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView2];
    
    YBZFreeTranslationInfo *freeTranslationCellView3 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 粤语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView3];
    
    YBZFreeTranslationInfo *freeTranslationCellView4 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 日语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView4];
    
    YBZFreeTranslationInfo *freeTranslationCellView5 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 韩语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView5];
    
    YBZFreeTranslationInfo *freeTranslationCellView6 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 法语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView6];
    
    YBZFreeTranslationInfo *freeTranslationCellView7 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 西班牙语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView7];
    
    YBZFreeTranslationInfo *freeTranslationCellView8 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 泰语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView8];
    
    YBZFreeTranslationInfo *freeTranslationCellView9 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 阿拉伯语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView9];
    
    YBZFreeTranslationInfo *freeTranslationCellView10 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 俄语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView10];
    
    YBZFreeTranslationInfo *freeTranslationCellView11 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 葡萄牙语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView11];
    
    YBZFreeTranslationInfo *freeTranslationCellView12 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 德语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView12];
    
    YBZFreeTranslationInfo *freeTranslationCellView13 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 意大利语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView13];
    
    YBZFreeTranslationInfo *freeTranslationCellView14 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 希腊语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView14];
    
    YBZFreeTranslationInfo *freeTranslationCellView15 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 荷兰语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView15];
    
    YBZFreeTranslationInfo *freeTranslationCellView16 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 波兰语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView16];
    
    YBZFreeTranslationInfo *freeTranslationCellView17 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 丹麦语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView17];
    
    YBZFreeTranslationInfo *freeTranslationCellView18 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 芬兰语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView18];
    
    YBZFreeTranslationInfo *freeTranslationCellView19 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 捷克语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView19];
    
    YBZFreeTranslationInfo *freeTranslationCellView20 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 瑞典语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView20];
    
    YBZFreeTranslationInfo *freeTranslationCellView21 = [[YBZFreeTranslationInfo alloc]initWithTitle:@"汉语 － 匈牙利语" AndContent:@"可互译" AndLeftImage:nil AndRightImage:nil];
    [self.cellArr addObject:freeTranslationCellView21];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.cellArr count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    YBZFreeTranslationInfo *model = self.cellArr[indexPath.row];
    
    static NSString *cellID = @"YBZFreeTranslationViewCell";
    
    YBZFreeTranslationViewCell *cell = nil;
    
    //cell = [cellView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell = [self.cellView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell){
        
        cell = [[YBZFreeTranslationViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    cell.titleLabel.text = model.title;
    cell.contentLabel.text = model.content;
    
    NSString *imageName = [NSString stringWithFormat:@"countryImg_%02ld", (long)indexPath.row];
    [cell.rightCountryImageView setImage:[UIImage imageNamed:imageName]];
    
//    UIImage *image = [UIImage imageNamed:imageName];
    
    
    //cell.leftCountryImageView.image = model.leftImage;
    //cell.rightCountryImageView.image = model.rightImage;
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_YingYu WithTransLanguage:Trans_YingYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 1) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Trans_MeiYu WithTransLanguage:Trans_MeiYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 2) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_YueYu WithTransLanguage:Trans_YueYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 3) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_RiYu WithTransLanguage:Trans_RiYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 4) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_HanYu WithTransLanguage:Trans_HanYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 5) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_FaYu WithTransLanguage:Trans_FaYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 6) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_XiBanYa WithTransLanguage:Trans_XiBanYa];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 7) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_TaiYu WithTransLanguage:Trans_TaiYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 8) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_ALaBoYu WithTransLanguage:Trans_ALaBoYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 9) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_EYu WithTransLanguage:Trans_EYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 10) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_PuTaoYaYu WithTransLanguage:Trans_PuTaoYaYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 11) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_DeYu WithTransLanguage:Trans_DeYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 12) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_YiDaLiYu WithTransLanguage:Trans_YiDaLiYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 13) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_XiLaYu WithTransLanguage:Trans_XiLaYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 14) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_HeLanYu WithTransLanguage:Trans_HeLanYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 15) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_BoLanYu WithTransLanguage:Trans_BoLanYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 16) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_DanMaiYu WithTransLanguage:Trans_DanMaiYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 17) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_FenLanYu WithTransLanguage:Trans_FenLanYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 18) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_JieKeYu WithTransLanguage:Trans_JieKeYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 19) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_RuiDianYu WithTransLanguage:Trans_RuiDianYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    
    if (indexPath.row == 20) {
        FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"USER" WithVoiceLanguage:Voice_XiongYaLiYu WithTransLanguage:Trans_XiongYaLiYu];
        [self.navigationController pushViewController:freeVC animated:YES];
    }
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    return UIScreenWidth * 0.24;
}

#pragma mark - getters

- (UITableView *)cellView{
    
    if (!_cellView) {
        
        _cellView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
        
        //_cellView.backgroundColor = [UIColor whiteColor];
        
        //_cellView.tableHeaderView = self.bottomView;
        
        _cellView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        self.cellView.delegate = self;
        
        self.cellView.dataSource = self;
        
        

    }
    
    return _cellView;
    
}

- (void)intoFreeTranslationClick{
    
    FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"TRANSTOR" WithVoiceLanguage:Voice_YingYu WithTransLanguage:Trans_YingYu];

    [self.navigationController pushViewController:freeVC animated:YES];
    
}



@end
