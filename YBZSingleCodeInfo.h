//
//  YBZSingleCodeInfo.h
//  YBZTravel
//
//  Created by tjufe on 16/7/13.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBZSingleCodeInfo : NSObject

@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *content;

- (instancetype)initWithTitle:(NSString *)title;

@end
