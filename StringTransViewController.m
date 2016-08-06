//
//  ViewController.m
//  有道翻译api的使用
//
//  Created by CK_chan on 15/11/21.
//  Copyright © 2015年 CK_chan. All rights reserved.
//

#import "StringTransViewController.h"
#import "CommonCrypto/CommonDigest.h"
#import "NSString+HBWmd5.h"

//使用API key 时，请求频率限制为每小时1000次，超过限制会被封禁。
//这两个参数是要自己去申请的，涉及到版权问题。

#define BAIDU_id          @"20160715000025278"
#define BAIDU_key         @"VAqTAvUCokCOxp3NaCMf"

#define MISS_KEY   @"x690zJbnctrWdcUmKKim"
#define APP_ID     @"20160715000025296"
#define From_Number 1000000000
#define To_Number   4294967296

@interface StringTransViewController ()
@property(nonatomic,assign) int currentSaltNumber;

@end

@implementation StringTransViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //51f6084a274018be74f335850a26ce88
    
    self.currentSaltNumber = 12345678;//[self getARandomNumber];
    NSString *asd = [NSString md5:@"20160715000025296apple123455678x690zJbnctrWdcUmKKim"];
    NSLog(@"%@",asd);
    //view的宽高
    CGFloat WIDTH = self.view.frame.size.width;
    CGFloat HIGH = self.view.frame.size.height;
    
    //输入框
    self.inputTF = [[UITextField alloc]initWithFrame:CGRectMake(16, 30, WIDTH-32, 35)];
    self.inputTF.borderStyle = UITextBorderStyleRoundedRect;
    self.inputTF.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.inputTF.textColor = [UIColor purpleColor];
    self.inputTF.placeholder = @"请输入需要翻译的文字";
    [self.view addSubview:self.inputTF];
    
    //翻译按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(16, 80, WIDTH-32, 40)];
    [btn.layer setCornerRadius:5];
    [btn.layer setMasksToBounds:YES];
    [btn setBackgroundColor:[UIColor purpleColor]];
    [btn setTitle:@"翻 译" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //显示翻译结果
    showLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 140, WIDTH-32, 20)];
    showLabel.textColor = [UIColor purpleColor];
    showLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:showLabel];
}

//按钮响应事件
- (void)btnClick{
    if (self.inputTF.text.length > 0) {
        //调用翻译
        NSString *getString = [self translateText:self.inputTF.text];
        showLabel.text = [NSString stringWithFormat:@"%@",getString];
        self.resultString = showLabel.text;
    }else{
        NSLog(@"输入内容不能为空");
    }
}

//翻译方法，传入和返回都是NSString类型
- (NSString *)translateText:(NSString *)string{
    
    NSString *strURL = [self getBaiduTranslationURLWithQName];
    NSLog(@"ggggggggg: %@",strURL);
    NSError *err = nil;
    NSArray *strResult;
    NSArray *result;
    if(strURL!=nil) {
        NSURL *url = [NSURL URLWithString:strURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        if (data != nil) {
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
            showTV.text = [NSString stringWithFormat:@"%@",dictionary];
            strResult = [dictionary objectForKey:@"trans_result"];
            NSDictionary *dstDictionary = [strResult firstObject];
            result = dstDictionary[@"dst"];
        }else{
            result = (NSArray *)@"请检查您的网络...";
        }
        
      
    }

//    NSData *jsonData = [strURL dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
//    strResult = [dic objectForKey:@"trans_result"];
    //NSLog(@"%@", [err description]);
    
    if(err){
//        return [NSString stringWithFormat:@"error=%@", [err description]];
        return [NSString stringWithFormat:@"网络不稳定..."];
    }else {
        return [NSString stringWithFormat:@"%@", result];
    }
}




//-(void)TransStr:(NSString *) str ToLanguage:(NSString *)language
//{
////    if (str == nil || str.length ==0) {
////        self.transStrLable.placeholder =@"请输入...";
////        return;
////    }
//    NSString *url = [NSString stringWithFormat:@"http://openapi.baidu.com/public/2.0/bmt/translate?client_id=Un9nxy3HR7N8cflwfUgAp8HI&q=%@&from=auto&to=%@",str,language];
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManagermanager];
//    [mgr GET:url parameters:nilsuccess:^(AFHTTPRequestOperation *operation,id responseObject) {
//        //解析返回结果
//        NSDictionary *dict = (NSDictionary *)responseObject;
//        NSArray *result = dict[@"trans_result"];
//        NSDictionary *dd = [result firstObject];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.resultTextview.text = dd[@"dst"];
//        });
//    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.resultTextview.text = [NSStringstringWithFormat:@"翻译出错：%@",error];
//        });
//    }];
//}

//- (NSString *) md5
//{
//    const char *cStr = [self UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, strlen(cStr), digest );
//    
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//    
//    return output;
//}

//返回随机数
-(int)getARandomNumber{
    int value = From_Number + (arc4random() % (To_Number - From_Number + 1));
    if (value > 0 ) {
        
    }else{
        value = - value;
    }
    
    return value;
}

//转换utf8编码
-(NSString *)changeStringToUtf8Code:(NSString *)string{
    
    NSString *unicodeStr = [NSString stringWithCString:[string UTF8String] encoding:NSUnicodeStringEncoding];
    
    return unicodeStr;
}


-(NSString *)getTranslationToBaiduSign{
    
    NSString *appID = APP_ID;//[self changeStringToUtf8Code:APP_ID];
    NSString *q     = self.inputTF.text;
    //[self changeStringToUtf8Code:@"cat"];//[self changeStringToUtf8Code:@"apple"];
    NSString *salt  = [NSString stringWithFormat:@"%d",self.currentSaltNumber];
    NSString *key   = MISS_KEY;//[self changeStringToUtf8Code:MISS_KEY];
    //获得sign
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",appID,q,salt,key];
    //将sign转为utf8编码
//    NSString *signUtf8 = [self changeStringToUtf8Code:sign];
    //对signUtf8 md5加密  此处得到最终的sign!!!!!!!
    NSString *signFinal = [NSString md5:sign];
    
    NSLog(@"%@",signFinal);
    
    return signFinal;
}


-(NSString *)getBaiduTranslationURLWithQName{
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *trans_language = [userDefaults objectForKey:@"TRANS_LANGUAGE"];
    
    NSString *Lname = self.inputTF.text;
    NSString *Qname = [NSString encodeString:Lname];
    //NSString *Kname  = [inputTF.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *From = [NSString encodeString:@"auto"];
    NSString *To = [NSString encodeString:trans_language];
    NSString *app_ID = [NSString encodeString:APP_ID];
    NSString *salt = [NSString stringWithFormat:@"%d",self.currentSaltNumber];
    NSString *sign = [self getTranslationToBaiduSign];
    
    NSString *URLString = [NSString stringWithFormat:@"http://api.fanyi.baidu.com/api/trans/vip/translate?q=%@&from=%@&to=%@&appid=%@&salt=%@&sign=%@",Qname,From,To,app_ID,salt,sign];
    
    NSLog(@"%@",URLString);
    return URLString;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
