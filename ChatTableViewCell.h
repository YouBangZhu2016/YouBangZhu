//
//  ChatTableViewCell.h
//  CharttingController
//
//  Created by tjufe on 16/7/13.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import "ChatModel.h"
#import "ChatFrameInfo.h"


@interface ChatTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *playRecordBtn;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *textView;
@property (nonatomic, strong) UILabel *textChatLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) NSString *chatType;
@property (nonatomic, strong) UIView *pictureView;
@property (nonatomic, strong) NSURL *pictureUrl;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat textLabelWidth;
@property (nonatomic, assign) NSTimeInterval *voiceLength;
@property (nonatomic, strong) ChatFrameInfo *frameInfo;
@property (nonatomic, strong) NSString *messageID;


@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UILabel *AVtoStringLabel;
@property (nonatomic,strong) UIButton *playTransTextBtn;



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Model:(ChatModel *)model;

@end
