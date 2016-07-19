//
//  YBZPopularFrameInfo.h
//  YBZTravel
//
//  Created by 孟宪璞 on 16/7/8.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class YBZPopularFrameInfo;

@interface YBZPopularFrameInfo : NSObject

@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *level;
@property (nonatomic , strong) NSString *state;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *time;
@property (nonatomic , strong) NSString *pay;

//控件frame
@property (nonatomic , assign) CGRect titleLabelFrame;
@property (nonatomic , assign) CGRect levelLabelFrame;
@property (nonatomic , assign) CGRect stateLabelFrame;
@property (nonatomic , assign) CGRect contentLabelFrame;
@property (nonatomic , assign) CGRect allInfoBtnFrame;
@property (nonatomic , assign) CGRect timeLabelFrame;
@property (nonatomic , assign) CGRect payLabelFrame;


- (instancetype)initWithTitle:(NSString *)title AndLevel:(NSString *)level AndState:(NSString *)state AndContent:(NSString *)content;

// + (instancetype)initWithTitle:(NSString *)title AndLevel:(NSString *)level AndState:(NSString *)state AndContent:(NSString *)content;

@end
