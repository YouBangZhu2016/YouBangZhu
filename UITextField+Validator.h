//
//  UITextField+Validator.h
//  YBZTravel
//
//  Created by tjufe on 16/7/8.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Validator)

-(BOOL)isNotEmpty;
-(BOOL)validateEmail;
-(BOOL)validatePhoneNumber;
-(BOOL)validatePassWord;

@end
