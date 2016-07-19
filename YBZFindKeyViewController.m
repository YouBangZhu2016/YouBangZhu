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
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface YBZFindKeyViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) NSTimer         *timer;
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
@end

@implementation YBZFindKeyViewController{
    int countDown;
}
- (void)viewDidLoad {
    
    countDown = 59;
    [super viewDidLoad];
    [super viewDidLoad];
    [self.view addSubview:self.userTextField];
    [self.view addSubview:self.getCodeBtn];
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
                    if (_pswTextField == _confirmPswTextField) {
                        //网络验证
                        [self dismissViewControllerAnimated:YES completion:nil];
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
            //获取验证码
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
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
        _userTextField.frame = CGRectMake(0,ScreenHeight*0.098, [UIScreen mainScreen].bounds.size.width-120, ScreenHeight*0.065);
        _userTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 20)];
        _userTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgUser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-user"]];
        imgUser.frame = CGRectMake(0, 0, 17, 17);
        [_userTextField.leftView addSubview:imgUser];
    }
    return _userTextField;
}
-(UIButton *)getCodeBtn{
    
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getCodeBtn.backgroundColor = UIColorFromRGB(0xFFB90F);
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_getCodeBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        _getCodeBtn.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width-110, ScreenHeight*0.109,ScreenWidth*0.1875, 24);
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
        _enderCodeTextField.frame = CGRectMake(0,CGRectGetMaxY(self.userTextField.frame)+10, [UIScreen mainScreen].bounds.size.width - 110, ScreenHeight*0.065);
        _enderCodeTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 20)];
        _enderCodeTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgEnder= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-password"]];
        imgEnder.frame = CGRectMake(0, 0, 22, 22);
        [_enderCodeTextField.leftView addSubview:imgEnder];
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
        _pswTextField.frame = CGRectMake(0,CGRectGetMaxY(self.enderCodeTextField.frame)+10, [UIScreen mainScreen].bounds.size.width, ScreenHeight*0.065);
        _pswTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 20)];
        _pswTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgPswer= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-password"]];
        imgPswer.frame = CGRectMake(0, 0, 22, 22);
        [_pswTextField.leftView addSubview:imgPswer];
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
        _confirmPswTextField.frame = CGRectMake(0,CGRectGetMaxY(self.pswTextField.frame)+10,[UIScreen mainScreen].bounds.size.width, ScreenHeight*0.065);
        _confirmPswTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 20)];
        _confirmPswTextField.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgPswer= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-password"]];
        imgPswer.frame = CGRectMake(0, 0, 22, 22);
        [_confirmPswTextField.leftView addSubview:imgPswer];
        
    }
    return _confirmPswTextField;
}

-(UIButton *)finishRegBtn{
    if (!_finishRegBtn) {
        _finishRegBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishRegBtn.backgroundColor = UIColorFromRGB(0xFFB90F);
        [_finishRegBtn setTitle:@"确    定" forState:UIControlStateNormal];
        [_finishRegBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        _finishRegBtn.frame = CGRectMake(0, CGRectGetMaxY(self.confirmPswTextField.frame)+ScreenHeight*0.021, [UIScreen mainScreen].bounds.size.width, ScreenHeight*0.081);
        [_finishRegBtn addTarget:self action:@selector(finishRegBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _finishRegBtn;
}

@end
