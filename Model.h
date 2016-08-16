//
//  Model.h
//  xuanshang
//
//  Created by sks on 16/8/11.
//  Copyright © 2016年 heyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *content;
@property (nonatomic ,assign) NSString *img;
@property (nonatomic ,strong) NSString *date;
@property (nonatomic ,strong) NSString *money;

- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
                          img:(NSString *)img
                         date:(NSString *)date
                        money:(NSString *)money;

@end
