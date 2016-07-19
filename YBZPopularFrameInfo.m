//
//  YBZPopularFrameInfo.m
//  YBZTravel
//
//  Created by 孟宪璞 on 16/7/8.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZPopularFrameInfo.h"

@implementation YBZPopularFrameInfo

- (instancetype)initWithTitle:(NSString *)title AndLevel:(NSString *)level AndState:(NSString *)state AndContent:(NSString *)content
{
    self = [super init];
    if (self) {
        self.title = title;
        self.level = level;
        self.state = state;
        self.content = content;
        
    }
    return self;
}

//+ (instancetype)initWithTitle:(NSString *)title AndLevel:(NSString *)level AndState:(NSString *)state AndContent:(NSString *)content{
//
//    YBZPopularViewCell *popularView = [[YBZPopularViewCell alloc]initWithTitle:title AndLevel:level AndState:state AndContent:content];
//
//    return popularView;
//}
@end
