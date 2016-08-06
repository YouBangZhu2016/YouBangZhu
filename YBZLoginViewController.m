//
//  YBZLoginViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZLoginViewController.h"
#import "YBZRegisterViewController.h"
#import "YBZFindKeyViewController.h"
#import "AFViewShaker.h"
#import "UITextField+Validator.h"
#import "YBZChangeLanguageViewController.h"
#import "UIBarButtonItem+YBZBarButtonItem.h"
#import "YBZAreaCodeViewController.h"
#import "PrefixHeader.pch"
#import "AFNetworking.h"
#import "WebAgent.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface YBZLoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UIButton     *loginBtn;
@property(nonatomic,strong) UIButton     *registerBtn;
@property(nonatomic,strong) UIButton     *findKeyBtn;
@property(nonatomic,strong) UIImageView  *codeImage;
@property(nonatomic,strong) UIImageView  *codeRightImage;
@property(nonatomic,strong) UILabel      *codeLable;
@property(nonatomic,strong) UIButton     *chooseCodeBtn;
@property(nonatomic,strong) UITextField  *phoneTextField;
@property(nonatomic,strong) UIImageView  *phoneImageView;
@property(nonatomic,strong) UITextField  *pswerTextField;
@property(nonatomic,strong) UIImageView  *pswerImageView;
@property(nonatomic,strong) AFViewShaker *userShaker;
@property(nonatomic,strong) AFViewShaker *pswerShaker;
@end

@implementation YBZLoginViewController

-(void)showCode:(NSString *)code{
    self.codeLable.text = code;
    NSLog(@"qweqwew%@",self.codeLable.text);
}
-(instancetype)initWithTitle:(NSString *)title BackButton:(BOOL)isNeedBack{
    self = [super init];
    if (self) {
        self.title = title;
        _isNeedBack = isNeedBack;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.codeImage];
    [self.view addSubview:self.codeRightImage];
    [self.view addSubview:self.codeLable];
    [self.view addSubview:self.chooseCodeBtn];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.phoneImageView];
    [self.view addSubview:self.pswerTextField];
    [self.view addSubview:self.pswerImageView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.findKeyBtn];
    self.navigationController.navigationBar.barTintColor =UIColorFromRGB(0xffd703);
    self.userShaker = [[AFViewShaker alloc]initWithView:self.phoneTextField];
    self.pswerShaker = [[AFViewShaker alloc]initWithView:self.pswerTextField];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithTitle:@"取消" target:self action:@selector(leftMenuClick)];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.phoneTextField) {
        [self.phoneTextField resignFirstResponder];
        
    }
    if (textField == self.pswerTextField) {
        [self.pswerTextField resignFirstResponder];
    }
    return YES;
}
#pragma mark - 点击事件

-(void)leftMenuClick{
    [self  dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneTextField resignFirstResponder];
    [self.pswerTextField resignFirstResponder];
}
-(void)intoRegisterPageClick{
    
    YBZRegisterViewController *regVC = [[YBZRegisterViewController alloc]initWithTitle:@"注册"];
    regVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:regVC animated:YES];
    
    
}
-(void)intoFindUserKeyPageClick{
    
    YBZFindKeyViewController *findVC = [[YBZFindKeyViewController alloc]initWithTitle:@"找回密码"];
    findVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:findVC animated:YES];
    
}
-(void)loginBtnClick{
    if ([self.phoneTextField isNotEmpty]) {
        if ([self.pswerTextField isNotEmpty]) {
            if ([self.phoneTextField validatePhoneNumber]) {
                if ([self.pswerTextField validatePassWord]) {
                    //网络验证
                    [WebAgent userLogin:self.phoneTextField.text userPsw:self.pswerTextField.text success:^(id responseObject) {
                        NSString *str3 = self.phoneTextField.text;
                        NSString *str4 = self.pswerTextField.text;
                        NSData *data = [[NSData alloc]initWithData:responseObject];
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSString *str1 = dic[@"user_info"][@"user_phone"];
                        NSString *str2 = dic[@"user_info"][@"user_password"];
                        NSString *str5 = dic[@"user_info"][@"user_loginstate"];
                        NSDictionary *useridDic = @{@"user_id":dic[@"user_info"][@"user_id"]};
                        
                        if([str1 isEqualToString:str3]) {
                            if ([str2 isEqualToString:str4]) {
                                
                                
                                
                                //登陆成功
                                [[NSNotificationCenter defaultCenter]postNotificationName:@"setTextALabel" object:nil];
                                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                //------------------
                                  [userDefaults setObject:useridDic forKey:@"user_id"];
                                NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
                                NSDictionary *user_idDic = [userinfo dictionaryForKey:@"user_id"];
                                [WebAgent userId:user_idDic[@"user_id"] success:^(id responseObject) {
                                    NSData *data = [[NSData alloc]initWithData:responseObject];
                                    NSString *accountSafe = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                    [userDefaults setObject:accountSafe forKey:@"accountSafe"];
                                    NSLog(@"%@",accountSafe);
                                } failure:^(NSError *error) {
                                    //
                                }];
                                
                                //------------------
                                [userDefaults setObject:useridDic forKey:@"user_id"];
                                [self dismissViewControllerAnimated:YES completion:nil];
                                
                                
                                
                                
                                
                                
                            }else{
                                [self showMssage:@"密码错误" becomeFirstResponder:_pswerTextField];
                            }
                        }else{
                            
                            [self showMssage:@"您还没有注册" becomeFirstResponder:_phoneTextField];
                        }
                    }
                                failure:^(NSError *error) {
                                    NSLog(@"%@",error);
                                }];
                    
                }else{
                    [self showMssage:@"请输入有效密码" becomeFirstResponder:_pswerTextField];
                }
            }else{
                [self showMssage:@"请输入11位有效手机号" becomeFirstResponder:_phoneTextField];
            }
        }else{
            [self.pswerShaker shake];
        }
    }else{
        [self.userShaker shake];
        
    }
}

-(void)showMssage:(NSString *)msg becomeFirstResponder:(UITextField *)textField{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (textField) {
            [textField becomeFirstResponder];
        }
    }];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)chooseCodeBtnClick{
    
    YBZAreaCodeViewController *codeVC = [[YBZAreaCodeViewController alloc]init];
    codeVC.delegate = self;
    codeVC.view.backgroundColor = [UIColor whiteColor];
    // [self.navigationController pushViewController:codeVC animated:YES];
    [self presentViewController:codeVC animated:YES completion:nil];
    
}
#pragma mark - getters
-(UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.backgroundColor = [UIColor whiteColor];
        _phoneTextField.placeholder = @"手机号";
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.delegate = self;
        
        _phoneTextField.frame = CGRectMake(0,ScreenHeight*0.118,ScreenWidth, ScreenHeight*0.066);
        _phoneTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth*0.156,ScreenHeight*0.066)];
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgUser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_phone"]];
        imgUser.frame = CGRectMake(ScreenWidth*0.050, ScreenHeight*0.019, ScreenWidth*0.046, ScreenHeight*0.026);
        [_phoneTextField.leftView addSubview:imgUser];
        
    }
    return _phoneTextField;
}
-(UITextField *)pswerTextField{
    if (!_pswerTextField) {
        _pswerTextField = [[UITextField alloc]init];
        _pswerTextField.backgroundColor = [UIColor whiteColor];
        _pswerTextField.placeholder = @"密码";
        [_pswerTextField setSecureTextEntry:YES];
        _pswerTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pswerTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _pswerTextField.delegate = self;
        _pswerTextField.frame = CGRectMake(0, CGRectGetMaxY(self.phoneTextField.frame)+6,ScreenWidth, ScreenHeight*0.066);
        _pswerTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth*0.156,ScreenHeight*0.066)];
        _pswerTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgUser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"forget_password_lock"]];
        imgUser.frame = CGRectMake(ScreenWidth*0.050, ScreenHeight*0.019, ScreenWidth*0.046, ScreenHeight*0.026);
        [_pswerTextField.leftView addSubview:imgUser];
        
    }
    
    return _pswerTextField;
    
}
-(UIButton *)loginBtn{
    
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(0, CGRectGetMaxY(self.pswerTextField.frame)+ScreenHeight * 0.046, [UIScreen mainScreen].bounds.size.width, ScreenHeight*0.081);
        [_loginBtn setTitle:@"登   录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = UIColorFromRGB(0xffd703);
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.frame = CGRectMake(ScreenWidth * 0.656, CGRectGetMaxY(self.loginBtn.frame)+ScreenHeight * 0.021, ScreenWidth * 0.078, ScreenHeight * 0.014);
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = FONT_12;
        [_registerBtn setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(intoRegisterPageClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

-(UIButton *)findKeyBtn{
    
    if (!_findKeyBtn) {
        _findKeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _findKeyBtn.frame = CGRectMake(ScreenWidth * 0.796, CGRectGetMaxY(self.loginBtn.frame)+ScreenHeight * 0.021,  ScreenWidth * 0.156, ScreenHeight * 0.014);
        [_findKeyBtn setTitle:@"找回密码" forState:UIControlStateNormal];
        [_findKeyBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _findKeyBtn.titleLabel.font = FONT_12;
        [_findKeyBtn addTarget:self action:@selector(intoFindUserKeyPageClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findKeyBtn;
}
-(UIImageView *)codeImage{
    if (!_codeImage) {
        _codeImage = [[UIImageView alloc]init];
        _codeImage.backgroundColor = [UIColor whiteColor];
        _codeImage.frame = CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 60);
    }
    return _codeImage;
}
-(UIImageView *)codeRightImage{
    if (!_codeRightImage) {
        _codeRightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
        _codeRightImage.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-70, 80, 60, 60);
    }
    return _codeRightImage;
}
-(UILabel *)codeLable{
    if (!_codeLable) {
        _codeLable = [[UILabel alloc]init];
        _codeLable.frame = CGRectMake(10,ScreenHeight*0.116, 100, 30);
        _codeLable.text = @"中国 ＋86";
        _codeLable.textColor = [UIColor blackColor];
    }
    return _codeLable;
}
-(UIButton *)chooseCodeBtn{
    if (!_chooseCodeBtn) {
        _chooseCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 60)];
        [_chooseCodeBtn addTarget:self action:@selector(chooseCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseCodeBtn;
}
@end
