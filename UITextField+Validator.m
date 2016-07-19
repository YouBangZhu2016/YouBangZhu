//
//  UITextField+Validator.m
//  YBZTravel
//
//  Created by tjufe on 16/7/8.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "UITextField+Validator.h"

@implementation UITextField (Validator)

-(BOOL)isNotEmpty{
    return ![self.text isEqualToString:@""];
}
-(BOOL)validate:(NSString *)inputStr{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",inputStr];
    return [predicate evaluateWithObject:self.text];
}

#pragma mark - 具体验证函数

-(BOOL)validateEmail{
    return [self validate:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

-(BOOL)validatePhoneNumber{
    return [self validate:@"^\\d{11}$"];
}

-(BOOL)validatePassWord{
    return [self validate:@"(^[A-Za-z0-9]{6,20}$)"];  //6～20位字符,不能存在空格
}


@end
