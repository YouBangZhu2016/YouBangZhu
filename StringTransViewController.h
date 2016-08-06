//
//  ViewController.h
//  有道翻译api的使用
//
//  Created by CK_chan on 15/11/21.
//  Copyright © 2015年 CK_chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StringTransViewController : UIViewController{
    UILabel *showLabel;
    UITextView *showTV;
}

@property(nonatomic,strong) UITextField *inputTF;
@property(nonatomic,strong) NSString *resultString;
- (void)btnClick;

@end

