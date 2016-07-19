//
//  YBZChangeLanguageInfo.h
//  YBZTravel
//
//  Created by 孟宪璞 on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBZChangeLanguageInfo : NSObject

@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *content;

- (instancetype)initWithTitle:(NSString *)title AndContent:(NSString *)content;


@end
