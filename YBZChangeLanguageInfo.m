//
//  YBZChangeLanguageInfo.m
//  YBZTravel
//
//  Created by 孟宪璞 on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZChangeLanguageInfo.h"

@implementation YBZChangeLanguageInfo

- (instancetype)initWithTitle:(NSString *)title AndContent:(NSString *)content{
    
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
    }
    return self;
    
}

@end
