//
//  YBZFreeTranslationInfo.m
//  YBZTravel
//
//  Created by 孟宪璞 on 16/7/26.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZFreeTranslationInfo.h"

@implementation YBZFreeTranslationInfo

- (instancetype)initWithTitle:(NSString *)title AndContent:(NSString *)content AndLeftImage:(NSURL *)leftImage AndRightImage:(NSURL *)rightImage
{
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
        self.leftImage = leftImage;
        self.rightImage = rightImage;
        
    }
    return self;
}

@end
