//
//  YBZFindKeyViewController.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZFindKeyViewController.h"
#import "UITextField+Validator.h"
#import "AFViewShaker.h"
#import "AFNetworking.h"
#import "WebAgent.h"
#import "UIBarButtonItem+YBZBarButtonItem.h"
//#import "YBZChooseTranslatorViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface YBZFindKeyViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) NSTimer         *timer;
@property(nonatomic,strong) UIImageView     *otherImageView;///////////////
@property(nonatomic,strong) UIImageView     *userImageView;
@property(nonatomic,strong)UIImageView      *pswImageView;
@property(nonatomic,strong)UIImageView      *confirmPswImageView;
@property(nonatomic,strong) UITextField     *userTextField;
@property(nonatomic,strong) UITextField     *pswTextField;
@property(nonatomic,strong) UITextField     *confirmPswTextField;
@property(nonatomic,strong) UITextField     *enderCodeTextField;
@property(nonatomic,strong) UIButton        *finishRegBtn;
@property(nonatomic,strong) UIButton        *getCodeBtn;
//@property(nonatomic,strong) UIButton        *putCodeBtn;
@property(nonatomic,strong) AFViewShaker    *userShaker;
@property(nonatomic,strong) AFViewShaker    *pswShaker;
@property (nonatomic,strong) UIImageView    *getCodeImageView;

@end

@implementation YBZFindKeyViewController{
    int countDown;
    NSString *userStr;
}

- (void)viewDidLoad {
    
    countDown = 59;
    [super viewDidLoad];
    [super viewDidLoad];
    [self.view addSubview:self.userTextField];
    [self.view addSubview:self.otherImageView];
    [self.view addSubview:self.getCodeImageView];
    [self.view addSubview:self.getCodeBtn];
    [self.view addSubview:self.userTextField];
    //    [self.view addSubview:self.putCodeBtn];
    [self.view addSubview:self.pswTextField];
    [self.view addSubview:self.confirmPswTextField];
    [self.view addSubview:self.userImageView];
    [self.view addSubview:self.pswImageView];
    [self.view addSubview:self.confirmPswImageView];
    [self.view addSubview:self.finishRegBtn];
    [self.view addSubview:self.enderCodeTextField];
    self.userShaker = [[AFViewShaker alloc]initWithView:self.userTextField];
    self.pswShaker = [[AFViewShaker alloc]initWithView:self.pswTextField];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"return" target:self action:@selector(leftMenuClick) width:ScreenWidth*0.043 height:ScreenHeight*0.024];
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.userTextField) {
        [self.userTextField resignFirstResponder];
    }
    if (textField == self.pswTextField) {
        [self.pswTextField resignFirstResponder];
    }
    if (textField == self.confirmPswTextField) {
        [self.confirmPswTextField resignFirstResponder];
    }
    if (textField == self.enderCodeTextField) {
        [self.enderCodeTextField resignFirstResponder];
    }
    
    
    return YES;
}
#pragma mark - 响应事件
-(void)leftMenuClick{
    //[self  dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userTextField resignFirstResponder];
    [self.pswTextField resignFirstResponder];
    [self.confirmPswTextField resignFirstResponder];
    [self.enderCodeTextField resignFirstResponder];
}
-(void)finishRegBtnClick{
    if ([self.userTextField isNotEmpty]) {
        if ([self.pswTextField isNotEmpty]) {
            if ([self.userTextField validatePhoneNumber]) {
                if ([self.pswTextField validatePassWord]) {
                    if (_pswTextField.text == _confirmPswTextField.text) {
                        NSString *str1 = self.enderCodeTextField.text;
                        if ([str1 isEqualToString:userStr]) {
                            //注册
                            [WebAgent userPhone:self.userTextField.text userPsw:self.pswTextField.text userID:self.userTextField.text
                                        success:^(id responseObject) {
                                            //成功
                                        } failure:^(NSError *error) {
                                            //失败
                                        }];
                            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改成功" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                                [self dismissViewControllerAnimated:YES completion:nil];
                            }];
                            [alertVC addAction:okAction];
                            [self presentViewController:alertVC animated:YES completion:nil];
                            //                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                            //                        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                            //                        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                            //                        NSDictionary *paramDict = @{@"user_id":self.userTextField.text,
                            //                                                    @"user_phone":self.userTextField.text,
                            //                                                    @"user_password":self.pswTextField.text};
                            //                        [manager POST:@"http://127.0.0.1/YouBangZhuServer/index.php/Home/User/user_findKey"  parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
                            //                        //do nothing
                            //                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            //
                            //
                            //                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            //
                            //                        }];
                        }else{
                            [self showMssage:@"验证码错误" becomeFirstResponder:nil];
                        }
                    }else{
                        [self showMssage:@"密码和确认密码不一致" becomeFirstResponder:nil];
                    }
                    
                }else{
                    [self showMssage:@"请输入有效密码" becomeFirstResponder:_pswTextField];
                }
            }else{
                [self showMssage:@"请输入11位有效手机号" becomeFirstResponder:_userTextField];
            }
        }else{
            [self.pswShaker shake];
        }
    }else{
        [self.userShaker shake];
        
    }
}
-(void)getCodeBtnClick{
    if ([self.userTextField isNotEmpty]) {
        if ([self.userTextField validatePhoneNumber]) {
            [self.getCodeBtn setEnabled:NO];
            NSString *str1 = self.userTextField.text;
            [WebAgent userPhone:self.userTextField.text success:^(id responseObject) {
                NSData *data = [[NSData alloc]initWithData:responseObject];
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *str2 = dic[@"user_info"][@"user_phone"];
                if ([str2 isEqualToString:str1]) {
                    //获取验证码
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
                    NSDictionary *paramdict = @{@"code":self.enderCodeTextField.text,
                                                @"user_phone":self.userTextField.text};
                    [manager POST:[NSString stringWithFormat:@"%@User/getValidateAndFamilyPhoneInfo",API_HOST] parameters:paramdict progress:^(NSProgress * _Nonnull uploadProgress) {
                        //do nothing
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        //成功
                        NSData *data = [[NSData alloc]initWithData:responseObject];
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSString *str3 = dic[@"code"];
                        NSString *phoneStr = dic[@"user_phone"];
                        phoneStr = self.userTextField.text;
                        userStr = str3;
                        NSLog(@"%@",str3);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        //失败
                    }];
                    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
                }else{
                    [self showMssage:@"您还未注册" becomeFirstResponder:nil];
                    [self.getCodeBtn setEnabled:YES];
                    
                }
            } failure:^(NSError *error) {
                //数据库回调失败
            }];
        }else{
            [self showMssage:@"请输入11位有效手机号" becomeFirstResponder:_userTextField];
        }
    }else{
        [self.userShaker shake];
    }
}
//-(void)putCodeBtnClick{
//
//}
-(void)onTimer{
    if (countDown > 0) {
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%ds后获取",countDown] forState:UIControlStateDisabled];
        self.getCodeBtn.backgroundColor = [UIColor grayColor];
        countDown--;
    }
    if (countDown == 0 ) {
        countDown = 59;
        [_timer invalidate];
        _timer = nil;
        [self.getCodeBtn setTitle:@"60s后获取" forState:UIControlStateDisabled];
        [self.getCodeBtn setTitle:@"可以发送" forState:UIControlStateNormal];
        [self.getCodeBtn setEnabled:YES];
        [self.getCodeBtn setBackgroundColor:[UIColor purpleColor]];
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
#pragma mark - getters

-(UITextField *)userTextField{
    if (!_userTextField) {
        _userTextField = [[UITextField alloc]init];
        _userTextField.backgroundColor = [UIColor whiteColor];
        _userTextField.placeholder = @"请输入手机号";
        _userTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userTextField.keyboardType = UIKeyboardTypeNumberPad;
        _userTextField.delegate = self;
        _userTextField.frame = CGRectMake(0,ScreenHeight*0.118,ScreenWidth * 0.6, ScreenHeight*0.066);
        _userTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth*0.156,ScreenHeight*0.066)];
        _userTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgUser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"forget_password_acount"]];
        imgUser.frame = CGRectMake(ScreenWidth*0.050, ScreenHeight*0.019, ScreenWidth*0.046, ScreenHeight*0.026);
        [_userTextField.leftView addSubview:imgUser];
    }
    return _userTextField;
}
-(UIImageView *)getCodeImageView{
    if (!_getCodeImageView) {
        _getCodeImageView = [[UIImageView alloc]init];
        [_getCodeImageView setImage:[UIImage imageNamed:@"forget_password_btn"]];
        _getCodeImageView.frame = CGRectMake(ScreenWidth*0.746-5, ScreenHeight*0.137-2,ScreenWidth*0.192+10, ScreenHeight*0.034);
    }
    return _getCodeImageView;
}
-(UIImageView *)otherImageView{
    if (!_otherImageView) {
        _otherImageView = [[UIImageView alloc]init];
        _otherImageView.frame = CGRectMake(0,ScreenHeight*0.118,ScreenWidth, ScreenHeight*0.066);
        _otherImageView.backgroundColor = UIColorFromRGB(0xffffff);
    }
    return _otherImageView;
}
-(UIButton *)getCodeBtn{
    
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        // _getCodeBtn.backgroundColor = UIColorFromRGB(0xFFB90F);
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = FONT_12;
        [_getCodeBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        _getCodeBtn.frame = CGRectMake( ScreenWidth*0.746, ScreenHeight*0.137-3,ScreenWidth*0.192, ScreenHeight*0.034);
        [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _getCodeBtn;
}

-(UITextField *)enderCodeTextField{
    if (!_enderCodeTextField) {
        _enderCodeTextField = [[UITextField alloc]init];
        _enderCodeTextField.backgroundColor = [UIColor whiteColor];
        _enderCodeTextField.placeholder = @"请输入验证码";
        _enderCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _enderCodeTextField.delegate = self;
        _enderCodeTextField.frame = CGRectMake(0,CGRectGetMaxY(self.userTextField.frame)+2, ScreenWidth,ScreenHeight*0.066);
        _enderCodeTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth*0.156,ScreenHeight*0.066)];
        _enderCodeTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgUser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password_shield"]];
        imgUser.frame = CGRectMake(ScreenWidth*0.050, ScreenHeight*0.019, ScreenWidth*0.046, ScreenHeight*0.026);        [_enderCodeTextField.leftView addSubview:imgUser];
    }
    return _enderCodeTextField;
}
//-(UIButton *)putCodeBtn{
//    if (!_putCodeBtn) {
//        _putCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _putCodeBtn.backgroundColor = UIColorFromRGB(0xFFB90F);
//        [_putCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//        [_putCodeBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
//        _putCodeBtn.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width-110, 136,100, 24);
//        [_putCodeBtn addTarget:self action:@selector(putCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//
//    return _putCodeBtn;
//}
-(UITextField *)pswTextField{
    if (!_pswTextField) {
        _pswTextField = [[UITextField alloc]init];
        _pswTextField.backgroundColor = [UIColor whiteColor];
        _pswTextField.placeholder = @"请输入密码";
        [_pswTextField setSecureTextEntry:YES];
        _pswTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _pswTextField.delegate = self;
        _pswTextField.frame = CGRectMake(0,CGRectGetMaxY(self.enderCodeTextField.frame)+2, [UIScreen mainScreen].bounds.size.width, ScreenHeight*0.066);
        _pswTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth*0.156,ScreenHeight*0.066)];
        _pswTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgUser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"forget_password_lock"]];
        imgUser.frame = CGRectMake(ScreenWidth*0.050, ScreenHeight*0.019, ScreenWidth*0.046, ScreenHeight*0.026);
        [_pswTextField.leftView addSubview:imgUser];
    }
    return _pswTextField;
}
-(UITextField *)confirmPswTextField{
    if (!_confirmPswTextField) {
        _confirmPswTextField = [[UITextField alloc]init];
        _confirmPswTextField.backgroundColor = [UIColor whiteColor];
        _confirmPswTextField.placeholder = @"确认密码";
        [_confirmPswTextField setSecureTextEntry:YES];
        _confirmPswTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _confirmPswTextField.delegate = self;
        _confirmPswTextField.frame = CGRectMake(0,CGRectGetMaxY(self.pswTextField.frame)+2,[UIScreen mainScreen].bounds.size.width, ScreenHeight*0.066);
        _confirmPswTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth*0.156,ScreenHeight*0.066)];
        _confirmPswTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgUser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"forget_password_key"]];
        imgUser.frame = CGRectMake(ScreenWidth*0.050, ScreenHeight*0.019, ScreenWidth*0.046, ScreenHeight*0.026);
        [_confirmPswTextField.leftView addSubview:imgUser];
        
    }
    return _confirmPswTextField;
}

-(UIButton *)finishRegBtn{
    if (!_finishRegBtn) {
        _finishRegBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishRegBtn.backgroundColor = UIColorFromRGB(0xffd703);
        [_finishRegBtn setTitle:@"确    定" forState:UIControlStateNormal];
        [_finishRegBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        _finishRegBtn.frame = CGRectMake(0, CGRectGetMaxY(self.confirmPswTextField.frame)+ScreenHeight*0.023, [UIScreen mainScreen].bounds.size.width, ScreenHeight*0.081);
        [_finishRegBtn addTarget:self action:@selector(finishRegBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _finishRegBtn;
}

@end
