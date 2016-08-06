//
//  PersonalSignatureVC.m
//  框架搭建
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 AlexianAnn. All rights reserved.
//

#import "PersonalSignatureVC.h"

#define kViewVerticleMargin self.view.bounds.size.height * 7 /730
#define kTextViewVerticleMargin self.view.bounds.size.height *5 /730
#define kinputCharacterNumberLabelWidth 30
#define kinputCharacterNumberLabelHeight 30
#define kMaxWordNumbers 30 //最大输入字数

@interface PersonalSignatureVC ()<UITextViewDelegate>

@property(nonatomic,strong)UIView *myView;//灰色背景UIView
@property(nonatomic,strong)UITextView *individualSignatureTV;//个性签名输入框
@property(nonatomic,strong)UILabel *inputCharacterNumberLabel;//UILabel统计可输入字符字数
@property(nonatomic,strong)UIButton *saveBtn;

@end

@implementation PersonalSignatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.individualSignatureTV.delegate = self;
    
    [self.view addSubview:self.myView];
    [self.view addSubview:self.individualSignatureTV];
    [self.view addSubview:self.inputCharacterNumberLabel];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.saveBtn];
    
}



#pragma mark -灰色背景UIViewget方法
-(UIView *)myView{
    
    if (!_myView) {
        
        self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+kViewVerticleMargin, self.view.bounds.size.width, self.view.bounds.size.height-64-kViewVerticleMargin)];
        self.myView.backgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:244/255.0 alpha:1];
    }
    return _myView;
    
}

-(UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
        [_saveBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(clickSaveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

-(void)clickSaveBtnAction
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeSignature" object:nil userInfo:@{@"个性签名":self.individualSignatureTV.text}];
    [self.navigationController popViewControllerAnimated:YES];
}

//Begin 个性签名文本框的系列设置
-(UITextView *)individualSignatureTV{
    
    if(!_individualSignatureTV){
        
        self.individualSignatureTV = [[UITextView alloc]initWithFrame:CGRectMake(0, self.myView.frame.origin.y+kTextViewVerticleMargin, self.view.bounds.size.width, self.view.bounds.size.height *85 / 730)];
        self.individualSignatureTV.backgroundColor = [UIColor whiteColor];
        self.individualSignatureTV.font = [UIFont systemFontOfSize:20];
        self.individualSignatureTV.keyboardType = UIKeyboardTypeASCIICapable;
        
        
    }
    return _individualSignatureTV;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.individualSignatureTV resignFirstResponder];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    
    if(self.individualSignatureTV.text.length>kMaxWordNumbers){
        
        self.individualSignatureTV.text = [self.individualSignatureTV.text substringToIndex:30];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"最多可输入30个字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    self.inputCharacterNumberLabel.text = [NSString stringWithFormat:@"%ld",kMaxWordNumbers - self.individualSignatureTV.text.length];
}
//End



#pragma mark -UILabel统计可输入字符字数get方法
-(UILabel *)inputCharacterNumberLabel{
    
    if(!_inputCharacterNumberLabel){
        
        self.inputCharacterNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.individualSignatureTV.bounds.size.width-self.view.bounds.size.width * 18 / 410-kinputCharacterNumberLabelWidth, self.individualSignatureTV.frame.origin.y+self.individualSignatureTV.bounds.size.height-self.view.bounds.size.height *8 / 730-kinputCharacterNumberLabelHeight, kinputCharacterNumberLabelWidth, kinputCharacterNumberLabelHeight)];
        self.inputCharacterNumberLabel.text = [NSString stringWithFormat:@"%i",kMaxWordNumbers];
        self.inputCharacterNumberLabel.textAlignment = NSTextAlignmentCenter;
        self.inputCharacterNumberLabel.textColor = [UIColor lightGrayColor];
        self.inputCharacterNumberLabel.backgroundColor = [UIColor whiteColor];
        
        
    }
    return  _inputCharacterNumberLabel;
}


@end
