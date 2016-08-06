//
//  YBZFreeTranslationInfo.h
//  YBZTravel
//
//  Created by 孟宪璞 on 16/7/26.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBZFreeTranslationInfo : NSObject

@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSURL *leftImage;
@property (nonatomic , strong) NSURL *rightImage;

- (instancetype)initWithTitle:(NSString *)title AndContent:(NSString *)content AndLeftImage:(NSURL *)leftImage AndRightImage:(NSURL *)rightImage;


@end

