//
//  Infor.h
//  Language
//
//  Created by sks on 16/8/10.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Infor : NSObject

@property (nonatomic , strong) UIImageView *ensureImg;
@property (nonatomic , strong) NSString *language;

- (instancetype)initWitensureImg:(UIImageView *)ensureImg
                              language:(NSString *)language;
@end
