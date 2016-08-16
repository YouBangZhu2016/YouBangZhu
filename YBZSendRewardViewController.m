//
//  YBZSendRewardViewController.m
//  YBZTravel
//
//  Created by sks on 16/8/14.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZSendRewardViewController.h"
#import "SelectPhoto.h"
#import "YBZMyRewardViewController.h"
#import "YBZRewardChooseLanguageViewController.h"
#import "YBZTagClassifyViewController.h"
#import "YBZRewardMoneyViewController.h"
#import "WebAgent.h"

#define kScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define kMargin        kScreenWidth*0.03

@interface YBZSendRewardViewController ()<UITextViewDelegate>

@property(nonatomic,strong)SelectPhoto *selectPhoto;
@property(nonatomic,strong)UIImageView *userIconImageV;
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)UITextField *titleTextField;

@property(nonatomic,strong)UITextView *contentTextView;

@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *picBtn;
@property(nonatomic,strong)UIButton *tagBtn;
@property(nonatomic,strong)UIButton *moneyBtn;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *seletLanguageBtn;
@property(nonatomic,strong)UIButton *seletMoneyBtn;
@property(nonatomic,strong)UILabel *tishiLabel;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)NSString *pictureUrl;
@property(nonatomic,strong)UILabel *moneyLabel;

@end

@implementation YBZSendRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.contentTextView.hidden = NO;
    self.contentTextView.delegate = self;
    
    //定制导航栏
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0f/255.0f green:221.0f/255.0f blue:1.0f/255.0f alpha:1];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendBtnIClick)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.title = @"发布悬赏";
    
    
    
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.bottomView];
    [self.mainScrollView addSubview:self.titleTextField];
    [self.mainScrollView addSubview:self.contentTextView];
    [self.mainScrollView addSubview:self.seletMoneyBtn];
    [self.mainScrollView addSubview:self.seletLanguageBtn];
    [self.contentTextView addSubview:self.tishiLabel];
    
    
    //键盘自动弹出
    [self.titleTextField becomeFirstResponder];
    
    self.selectPhoto = [[SelectPhoto alloc]init];
    self.selectPhoto.selfController = self;
    self.selectPhoto.avatarImageView = self.userIconImageV;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePhotoImage:) name:@"changePhotoImage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewPoint:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideContentViewPoint:) name:UIKeyboardWillHideNotification object:nil];
    
    // 观察者方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendLanguage) name:@"sendLanguage"object:nil];
    //自定义返回键
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.21, 0, kScreenWidth*0.05, kScreenWidth*0.05)];
        [_cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelPic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
//picture
-(void)changePhotoImage:(NSNotification *)noti{
    UIImage *image = noti.userInfo[@"image"];
    self.userIconImageV.image = image;
    [self.userIconImageV addSubview:self.cancelBtn];
}

-(void)cancelPic{
    self.userIconImageV.image = nil;
    [self.cancelBtn removeFromSuperview];
}

-(UIImageView *)userIconImageV
{
    if (!_userIconImageV) {
        _userIconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*0.7,kScreenHeight*0.4,kScreenWidth*0.26,kScreenWidth*0.27)];
        _userIconImageV.userInteractionEnabled = YES;
        _userIconImageV.backgroundColor = [UIColor whiteColor];
        _userIconImageV.image=[UIImage imageNamed:@"ProfilePhoto"];
    }
    return _userIconImageV;
}
//end+hide
- (void) hideContentViewPoint:(NSNotification *)notification{ NSDictionary *userInfo = [notification userInfo];
    
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    // 得到键盘隐藏后的键盘视图所在y坐标
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue
                     animations:^{ [UIView setAnimationBeginsFromCurrentState:YES];
                         [UIView setAnimationCurve:[curve intValue]];
                         _bottomView.center = CGPointMake(_bottomView.center.x, keyBoardEndY + _bottomView.bounds.size.height/2.0);
                         // keyBoardEndY的坐标包括了状态栏的高度，要减去
                     }];
}
//begin+show
- (void) changeContentViewPoint:(NSNotification *)notification{ NSDictionary *userInfo = [notification userInfo];
    
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;
    // 得到键盘弹出后的键盘视图所在y坐标
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    //添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue
                     animations:^{ [UIView setAnimationBeginsFromCurrentState:YES];
                         [UIView setAnimationCurve:[curve intValue]];
                         _bottomView.center = CGPointMake(_bottomView.center.x, keyBoardEndY - _bottomView.bounds.size.height/2.0);
                         // keyBoardEndY的坐标包括了状态栏的高度，要减去
                     }];
}

-(UILabel *)tishiLabel{
    
    if(!_tishiLabel){
        
        _tishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,8, self.view.bounds.size.width, 20)];
        _tishiLabel.backgroundColor = [UIColor clearColor];
        _tishiLabel.text = @"请输入内容";
        _tishiLabel.font = [UIFont systemFontOfSize:20];
        _tishiLabel.textColor = [UIColor grayColor];
        _tishiLabel.enabled = NO;
    }
    return _tishiLabel;
}

-(void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.tishiLabel.text = @"请输入内容";
    }else{
        self.tishiLabel.text = @"";
    }
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mainScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _mainScrollView;
}
//TextField
-(UITextField *)titleTextField{
    if (!_titleTextField) {
        _titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(kMargin, kScreenWidth*0.02, kScreenWidth-2*kMargin, kScreenHeight*0.077)];
        _titleTextField.placeholder = @"请输入标题";
        _titleTextField.font = [UIFont systemFontOfSize:25 weight:1];
        _titleTextField.backgroundColor = [UIColor greenColor];
        _titleTextField.keyboardType = UIKeyboardTypeDefault;
        _titleTextField.returnKeyType = UIReturnKeySend;
    }
    return _titleTextField;
}
//TextView
-(UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(kMargin, kScreenHeight*0.12, kScreenWidth-2*kMargin, kScreenHeight*0.13)];
        _contentTextView.backgroundColor = [UIColor greenColor];
        _contentTextView.font = [UIFont systemFontOfSize:18];
        _contentTextView.keyboardType = UIKeyboardTypeDefault;
    }
    return _contentTextView;
}
-(UIButton *)picBtn{
    if (!_picBtn) {
        UIImage *img = [UIImage imageNamed:@"pic"];
        _picBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.167, kScreenHeight*0.017, kScreenWidth*0.073, kScreenWidth*0.073)];
        [_picBtn setImage:img forState:UIControlStateNormal];
        [_picBtn addTarget:self action:@selector(picBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _picBtn;
}
-(UIButton *)tagBtn{
    if (!_tagBtn) {
        UIImage *img = [UIImage imageNamed:@"tag"];
        _tagBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.468, kScreenHeight*0.017, kScreenWidth*0.073, kScreenWidth*0.073)];
        [_tagBtn setImage:img forState:UIControlStateNormal];
        [_tagBtn addTarget:self action:@selector(tagBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tagBtn;
}
-(UIButton *)moneyBtn{
    if (!_moneyBtn) {
        UIImage *img = [UIImage imageNamed:@"money1"];
        _moneyBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.769, kScreenHeight*0.017, kScreenWidth*0.073, kScreenWidth*0.073)];
        [_moneyBtn setImage:img forState:UIControlStateNormal];
        [_moneyBtn addTarget:self action:@selector(moneyBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moneyBtn;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight*0.915, kScreenWidth, kScreenHeight*0.068)];
        _bottomView.backgroundColor  = [UIColor colorWithRed:249.0f/255.0f green:249.0f/255.0f  blue:249.0f/255.0f  alpha:1];
        [_bottomView addSubview:self.picBtn];
        [_bottomView addSubview:self.tagBtn];
        [_bottomView addSubview:self.moneyBtn];
    }
    
    return _bottomView;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        UIImage *img = [UIImage imageNamed:@"back_lly"];
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*0.1, kScreenWidth*0.1)];
        [_backBtn setImage:img forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnIClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _backBtn;
}

-(UIButton *)seletMoneyBtn{
    if (!_seletMoneyBtn) {
        UIImage *img = [UIImage imageNamed:@"gezhi"];
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0234*kScreenWidth, 0, kScreenWidth*0.04, kScreenHeight*0.026)];
        [imgV setImage:img];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*0.07, 0, kScreenWidth*0.166, kScreenHeight*0.026)];
        label.text = @"悬赏金额:";
        label.font = [UIFont systemFontOfSize:15];
        _seletMoneyBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.043, kScreenHeight*0.38, kScreenWidth*0.4, kScreenHeight*0.026)];
        [_seletMoneyBtn addSubview:imgV];
        [_seletMoneyBtn addSubview:label];
        _seletMoneyBtn.backgroundColor = [UIColor whiteColor];
        [_seletMoneyBtn.layer setMasksToBounds:YES];
        [_seletMoneyBtn.layer setCornerRadius:8.0];
        [_seletMoneyBtn.layer setBorderWidth:1.0];
    }
    return _seletMoneyBtn;
}
-(UIButton *)seletLanguageBtn{
    if (!_seletLanguageBtn) {
        UIImage *img = [UIImage imageNamed:@"gezhi"];
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0234*kScreenWidth, 0, kScreenWidth*0.04, kScreenHeight*0.026)];
        [imgV setImage:img];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth*0.07, 0, kScreenWidth*0.166, kScreenHeight*0.026)];
        UILabel *returnLanguage = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+5, 0,kScreenWidth*0.04, kScreenHeight*0.026)];
        label.text = @"语种选择:";
        label.font = [UIFont systemFontOfSize:15];
        _seletLanguageBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.043, kScreenHeight*0.415, kScreenWidth*0.4, kScreenHeight*0.026)];
        [_seletLanguageBtn addTarget:self action:@selector(seletLanguageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        returnLanguage.backgroundColor = [UIColor redColor];
        [_seletLanguageBtn addSubview:imgV];
        [_seletLanguageBtn addSubview:label];
        [_seletLanguageBtn addSubview:returnLanguage];
        _seletLanguageBtn.backgroundColor = [UIColor whiteColor];
        [_seletLanguageBtn.layer setMasksToBounds:YES];
        [_seletLanguageBtn.layer setCornerRadius:8.0];
        [_seletLanguageBtn.layer setBorderWidth:1.0];
    }
    return _seletLanguageBtn;
}
//发送
-(void)sendBtnIClick{
    //网络接口
    //观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendUrl:) name:@"sendUrl" object:nil];
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
    NSDictionary *myDictionary = [userinfo dictionaryForKey:@"myDictionary"];

[WebAgent sendRewardRewardID:myDictionary[@"user_id"] rewardTitle:self.titleTextField.text rewardText:self.titleTextField.text rewardUrl:self.pictureUrl rewardMoney:self.titleTextField.text success:^(id responseObject) {
    
    
    
} failure:^(NSError *error) {
    
    NSLog(@"----------->%@",error);
}];
    
    
}
//返回
-(void)backBtnIClick{
    NSLog(@"back");
    [self.navigationController popViewControllerAnimated:YES];
}
//选图片
-(void)picBtnClickEvent{
    [self.selectPhoto createActionSheetWithView];
    [self.view addSubview:self.userIconImageV];
    
}
//标签
-(void)tagBtnClickEvent{
    YBZTagClassifyViewController *tagClassifyVC = [[YBZTagClassifyViewController alloc]init];
    [self.navigationController pushViewController:tagClassifyVC animated:YES];
    
    
    
}
//悬赏
-(void)moneyBtnClickEvent{
    
    YBZRewardMoneyViewController *rewardMoneyVC = [[YBZRewardMoneyViewController alloc]init];
    [self.navigationController pushViewController:rewardMoneyVC animated:YES];
    
    
    
    
}
//语言
-(void)seletLanguageBtnClick{
    YBZRewardChooseLanguageViewController *languageVC = [[YBZRewardChooseLanguageViewController alloc]init];
    [self.navigationController pushViewController:languageVC animated:YES];
}
-(void)sendUrl:(NSNotification *)noti{
    NSDictionary *textDic = [noti userInfo];
    self.pictureUrl = [textDic objectForKey:@"url"];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"sendUrl" object:nil];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"sendLanguage" object:nil];

}

-(void)sendLanguage:(NSNotification *)noti{
    NSDictionary *texDic = [noti userInfo];
    self.moneyLabel.text = [texDic objectForKey:@"语言"];
}


@end
