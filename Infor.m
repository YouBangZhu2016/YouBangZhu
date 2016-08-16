//
//  Infor.m
//  Language
//
//  Created by sks on 16/8/10.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import "Infor.h"

@implementation Infor

- (instancetype)initWitensureImg:(UIImageView *)ensureImg
                              language:(NSString *)language
{
    self = [super init];
    if (self) {
        
        self.ensureImg = ensureImg;
        self.language = language;
        
    }
    return self;
}


@end
