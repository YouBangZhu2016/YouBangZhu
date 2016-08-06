//
//  ChatFrameInfo.h
//  CharttingController
//
//  Created by tjufe on 16/7/13.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChatModel.h"

@interface ChatFrameInfo : NSObject



@property (nonatomic, assign) CGFloat textLableWidth;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect headBgViewFrame;
@property (nonatomic, assign) CGRect chatTextViewFrame;
@property (nonatomic, assign) CGRect headImageViewFrame;
@property (nonatomic, assign) CGRect chatTextLabelFrame;
@property (nonatomic, assign) CGRect chatPictureViewFrame;
@property (nonatomic, assign) CGRect chatAudioViewFrame;

@property (nonatomic, assign) CGRect AVtoStringLabelFrame;
@property (nonatomic, assign) CGRect secondLableFrame;
@property (nonatomic, assign) CGRect transtorTextReadBtnFram;

-(instancetype)initWithModel:(ChatModel *)model;

@end
