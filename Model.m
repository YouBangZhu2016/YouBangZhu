//
//  Model.m
//  xuanshang
//
//  Created by sks on 16/8/11.
//  Copyright © 2016年 heyi. All rights reserved.
//

#import "Model.h"

@implementation Model
- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
                          img:(NSString *)img
                         date:(NSString *)date
                        money:(NSString *)money
{
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
        self.img = img;
        self.date = date;
        self.money = money;
    }
    return self;
}

@end
