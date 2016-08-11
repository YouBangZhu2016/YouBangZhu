 //
//  YBZChooseTranslatorViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/26.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZChooseTranslatorViewController.h"
#import "YBZOtherViewController.h"
#import "WebAgent.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface YBZChooseTranslatorViewController ()
@property (nonatomic,strong) UILabel      *questionLabel;
@property (nonatomic,strong) UILabel      *chooseLanguageLabel;
@property (nonatomic,strong) UIImageView  *pointDownImage;
@property (nonatomic,strong) UIButton     *chooseLanguagebtnEnglish;
@property (nonatomic,strong) UIButton     *chooseLanguagebtnJapan;
@property (nonatomic,strong) UIButton     *chooseLanguagebtnGermany;
@property (nonatomic,strong) UIButton     *chooseLanguagebtnFrench;
@property (nonatomic,strong) UIButton     *chooseLanguagebtnItaly;
@property (nonatomic,strong) UIButton     *addChooseLanguagebtn;
@property (nonatomic,strong) UIButton     *protocolBtn;
@property (nonatomic,strong) UIButton     *agreementBtn;
@property (nonatomic,strong) UIButton       *returnBtn;
@property (nonatomic,strong) UIButton       *checkbox;
@property (nonatomic,strong) NSMutableArray *allLangage;
@property (nonatomic,strong) NSArray        *otherLangage;
@property (nonatomic,strong) NSArray        *endLangage;
@property (nonatomic,strong) NSString       *uploadLanguage;



@end

@implementation YBZChooseTranslatorViewController
   NSString     *estimate = @"0";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xffd703);
     [self.view addSubview:self.questionLabel];
     [self.view addSubview:self.chooseLanguageLabel];
     [self.view addSubview:self.chooseLanguagebtnEnglish];
     [self.view addSubview:self.chooseLanguagebtnJapan];
     [self.view addSubview:self.chooseLanguagebtnGermany];
     [self.view addSubview:self.chooseLanguagebtnFrench];
     [self.view addSubview:self.chooseLanguagebtnItaly];
     [self.view addSubview:self.addChooseLanguagebtn];
     [self.view addSubview:self.protocolBtn];
     [self.view addSubview:self.agreementBtn];
     [self.view addSubview:self.returnBtn];
     [self.view addSubview:self.checkbox];
    
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showData:) name:@"sendData" object:nil];
    // Do any additional setup after loading the view.
}
-(void)showData:(NSNotification *)dataNoti{
    self.otherLangage = dataNoti.userInfo[@"data"];
    [self.allLangage addObjectsFromArray:self.otherLangage];
    NSLog(@"%@",self.otherLangage);
    NSLog(@"%@",self.allLangage);
}
    //注销
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"sendData" object:nil];
}
#pragma mark - getters
-(NSMutableArray *)allLangage{
    if (!_allLangage) {
        _allLangage = [[NSMutableArray alloc]init];
    }
    return _allLangage;
}
-(UILabel *)questionLabel{
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc]init];
        _questionLabel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-250)/2+20, 70, 250, 60);
        _questionLabel.text = @"想要成为译员？";
        _questionLabel.font = [UIFont systemFontOfSize:30];
        _questionLabel.textColor = [UIColor blackColor];
    }
    return _questionLabel;
}
-(UILabel *)chooseLanguageLabel{
    if (!_chooseLanguageLabel) {
        _chooseLanguageLabel = [[UILabel alloc]init];
        _chooseLanguageLabel.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-300)/2+40, 150, 300, 30);
        _chooseLanguageLabel.text = @"请选择您擅长的语种 （可多选）";
        _chooseLanguageLabel.font = [UIFont systemFontOfSize:17];
        _chooseLanguageLabel.textColor = [UIColor blackColor];
    }
    return _chooseLanguageLabel;
}
-(UIImageView *)pointDownImage{
    if (!_pointDownImage) {
        _pointDownImage = [[UIImageView alloc]init];
        _pointDownImage.frame = CGRectMake(150, 200, 10, 10);
        _pointDownImage.backgroundColor = [UIColor blueColor];
    }
   return  _pointDownImage;
}
-(UIButton *)chooseLanguagebtnEnglish{
    if (!_chooseLanguagebtnEnglish) {
        _chooseLanguagebtnEnglish = [[UIButton alloc]init];
        _chooseLanguagebtnEnglish.frame = CGRectMake(100, 230, 60, 60);
        [_chooseLanguagebtnEnglish setImage:[UIImage imageNamed:@"English"] forState:UIControlStateNormal];
        //_chooseLanguagebtn1.backgroundColor = [UIColor redColor];
        [_chooseLanguagebtnEnglish addTarget:self action:@selector(chooseLanguagebtnEnglishClick:) forControlEvents:UIControlEventTouchUpInside];
            [_chooseLanguagebtnEnglish setSelected:YES];
    }
    return _chooseLanguagebtnEnglish;
}
-(UIButton *)chooseLanguagebtnJapan{
    if (!_chooseLanguagebtnJapan) {
        _chooseLanguagebtnJapan = [[UIButton alloc]init];
        _chooseLanguagebtnJapan.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-160, 230, 60, 60);
         [_chooseLanguagebtnJapan setImage:[UIImage imageNamed:@"Japan"] forState:UIControlStateNormal];
       // _chooseLanguagebtn2.backgroundColor = [UIColor redColor];
        [_chooseLanguagebtnJapan addTarget:self action:@selector(chooseLanguagebtnJapanClick:) forControlEvents:UIControlEventTouchUpInside];
            [_chooseLanguagebtnJapan setSelected:YES];
    }
    return _chooseLanguagebtnJapan;
}
-(UIButton *)chooseLanguagebtnGermany{
    if (!_chooseLanguagebtnGermany) {
        _chooseLanguagebtnGermany = [[UIButton alloc]init];
        _chooseLanguagebtnGermany.frame = CGRectMake(100, CGRectGetMaxY(self.chooseLanguagebtnJapan.frame)+20, 60, 60);
         [_chooseLanguagebtnGermany setImage:[UIImage imageNamed:@"Germany"] forState:UIControlStateNormal];
        //_chooseLanguagebtn3.backgroundColor = [UIColor redColor];
        [_chooseLanguagebtnGermany addTarget:self action:@selector(chooseLanguagebtnGermanyClick:) forControlEvents:UIControlEventTouchUpInside];
            [_chooseLanguagebtnGermany setSelected:YES];
    }
    return _chooseLanguagebtnGermany;
}
-(UIButton *)chooseLanguagebtnFrench{
    if (!_chooseLanguagebtnFrench) {
        _chooseLanguagebtnFrench = [[UIButton alloc]init];
        _chooseLanguagebtnFrench.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-160,CGRectGetMaxY(self.chooseLanguagebtnJapan.frame)+20, 60,60);
         [_chooseLanguagebtnFrench setImage:[UIImage imageNamed:@"French"] forState:UIControlStateNormal];
        //_chooseLanguagebtn4.backgroundColor = [UIColor redColor];
        [_chooseLanguagebtnFrench addTarget:self action:@selector(chooseLanguagebtnFrenchClick:) forControlEvents:UIControlEventTouchUpInside];
            [_chooseLanguagebtnFrench setSelected:YES];
    }
    return _chooseLanguagebtnFrench;
}
-(UIButton *)chooseLanguagebtnItaly{
    if (!_chooseLanguagebtnItaly) {
        _chooseLanguagebtnItaly = [[UIButton alloc]init];
        _chooseLanguagebtnItaly.frame = CGRectMake(100,  CGRectGetMaxY(self.chooseLanguagebtnGermany.frame)+20, 60, 60);
         [_chooseLanguagebtnItaly setImage:[UIImage imageNamed:@"Italy"] forState:UIControlStateNormal];
      //  [_chooseLanguagebtn5 setBackgroundColor:[UIColor redColor]];
        [_chooseLanguagebtnItaly addTarget:self action:@selector(chooseLanguagebtnItalyClick:)forControlEvents:UIControlEventTouchUpInside];
        [_chooseLanguagebtnItaly setSelected:YES];
    }
    return _chooseLanguagebtnItaly;
}
-(UIButton *)addChooseLanguagebtn{
    if (!_addChooseLanguagebtn) {
        _addChooseLanguagebtn = [[UIButton alloc]init];
        _addChooseLanguagebtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-160,  CGRectGetMaxY(self.chooseLanguagebtnGermany.frame)+20, 60, 60);
        _addChooseLanguagebtn.backgroundColor = [UIColor redColor];
        [_addChooseLanguagebtn addTarget:self action:@selector(addChooseLanguagebtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addChooseLanguagebtn;
}

-(UIButton *)protocolBtn{
    if (!_protocolBtn) {
        _protocolBtn = [[UIButton alloc]init];
        _protocolBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2,  CGRectGetMaxY(self.addChooseLanguagebtn.frame)+40, 250, 30);
        [_protocolBtn setTitle:@"我已阅读《用户译员协议》" forState:UIControlStateNormal];
       // _protocolBtn.titleLabel.textColor = [UIColor blackColor];
        [_protocolBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_protocolBtn addTarget:self action:@selector(protocolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocolBtn;
}
-(UIButton *)agreementBtn{
    if (!_agreementBtn) {
        _agreementBtn = [[UIButton alloc]init];
        _agreementBtn.frame = CGRectMake(100,  CGRectGetMaxY(self.protocolBtn.frame)+30, 70, 40);
        _agreementBtn.backgroundColor = [UIColor grayColor];
         [_agreementBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_agreementBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreementBtn;
}


-(UIButton *)returnBtn{
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc]init];
        _returnBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-140,  CGRectGetMaxY(self.protocolBtn.frame)+30, 70, 40);
        _returnBtn.backgroundColor = [UIColor whiteColor];
        [_returnBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}
-(UIButton *)checkbox{
    if (!_checkbox) {
        _checkbox = [[UIButton alloc]init];
        _checkbox.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-150)/2-40,  CGRectGetMaxY(self.addChooseLanguagebtn.frame)+40, 30, 30);
        [_checkbox setImage:[UIImage imageNamed:@"money"]forState:UIControlStateNormal];
        [_checkbox setImage:[UIImage imageNamed:@"order"]forState:UIControlStateSelected];
        [_checkbox addTarget:self action:@selector(checkboxClick:)forControlEvents:UIControlEventTouchUpInside];
        [_checkbox setSelected:YES];
        
    }
    return _checkbox;
}
#pragma mark - 点击事件
-(void)chooseLanguagebtnEnglishClick:(UIButton *)btn{
    btn.selected=!btn.selected;
    if(btn.selected){
        [self.allLangage removeObject:@"YingYu"];
      [_chooseLanguagebtnEnglish setBackgroundColor:[UIColor clearColor]];
    }else{
        //实现打勾的方法
        [self.allLangage addObject:@"YingYu"];
        _chooseLanguagebtnEnglish.backgroundColor = [UIColor grayColor];
    }
 
}
-(void)chooseLanguagebtnJapanClick:(UIButton *)btn{
    btn.selected=!btn.selected;
    if(btn.selected){
        [self.allLangage removeObject:@"RiYu"];
        [_chooseLanguagebtnJapan setBackgroundColor:[UIColor clearColor]];

    }else{
        //实现不打勾的方法
        [self.allLangage addObject:@"RiYu"];
        _chooseLanguagebtnJapan.backgroundColor = [UIColor grayColor];
    }
}
-(void)chooseLanguagebtnGermanyClick:(UIButton *)btn{
    btn.selected=!btn.selected;
    if(btn.selected){
        [self.allLangage removeObject:@"DeYu"];
        [_chooseLanguagebtnGermany setBackgroundColor:[UIColor clearColor]];
    }else{
        //实现打勾的方法
        [self.allLangage addObject:@"DeYu"];
        _chooseLanguagebtnGermany.backgroundColor = [UIColor grayColor];
    }
}
-(void)chooseLanguagebtnFrenchClick:(UIButton *)btn{
    btn.selected=!btn.selected;
    if(btn.selected){
        [self.allLangage removeObject:@"FaYu"];
        [_chooseLanguagebtnFrench setBackgroundColor:[UIColor clearColor]];
    }else{
        //实现不打勾的方法
        [self.allLangage addObject:@"FaYu"];
        _chooseLanguagebtnFrench.backgroundColor = [UIColor grayColor];
    }
}
-(void)chooseLanguagebtnItalyClick:(UIButton *)btn{
    btn.selected=!btn.selected;
    if(btn.selected){
        //实现打勾时的方法
        
        [self.allLangage removeObject:@"YiDaLiYu"];
        [_chooseLanguagebtnItaly setBackgroundColor:[UIColor clearColor]];
        
    }else{
            //实现不打勾的方法
        [self.allLangage addObject:@"YiDaLiYu"];
        _chooseLanguagebtnItaly.backgroundColor = [UIColor grayColor];
    }

}
-(void)addChooseLanguagebtnClick{
    YBZOtherViewController *otherVC = [[YBZOtherViewController alloc]init];
    [self presentViewController:otherVC animated:YES completion:nil];
}
-(void)protocolBtnClick{
    
}
-(void)agreementBtnClick{
    if ([estimate isEqual:@"0"]) {
        NSLog(@"%@",self.allLangage);
        NSLog(@"%@",self.allLangage);
        NSLog(@"%@",self.otherLangage);
        NSSet *set = [NSSet setWithArray:self.allLangage];
        self.endLangage = [set allObjects];
        NSLog(@"%@",self.endLangage);

        NSString *midString;
        for (int i = 0; i < self.endLangage.count; i++) {
 
            
            midString = [NSString stringWithFormat:@"%@,",self.endLangage[i]];
            if (self.uploadLanguage == nil) {
                self.uploadLanguage = midString;
            }else{
                self.uploadLanguage = [NSString stringWithFormat:@"%@%@",self.uploadLanguage,midString];
            }
            NSLog(@"%@",self.uploadLanguage);
            
            
          NSDictionary  *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        [WebAgent userIdentity:@"TRANSTOR" userLanguage:self.uploadLanguage userID:dict[@"user_id"] success:^(id responseObject) {
            
          }failure:^(NSError *error) {
            
          }];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }else{
        self.agreementBtn.userInteractionEnabled=NO;
    }
    
}
-(void)returnBtnClick{
          [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)checkboxClick:(UIButton *)btn{
    estimate = @"1";
    self.agreementBtn.userInteractionEnabled=NO;
    self.agreementBtn.backgroundColor = [UIColor grayColor];

    btn.selected=!btn.selected;
    if(btn.selected){
        
    }else{
        estimate = @"0";
        self.agreementBtn.userInteractionEnabled=YES;
        self.agreementBtn.backgroundColor = [UIColor whiteColor];

        
      //实现打勾时的方法
    }
   
    //实现不打勾的方法
}
@end
