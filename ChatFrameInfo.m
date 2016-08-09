
//
//  ChatFrameInfo.m
//  CharttingController
//
//  Created by tjufe on 16/7/13.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "ChatFrameInfo.h"

@implementation ChatFrameInfo

#define kScreenWith  [UIScreen mainScreen].bounds.size.width
#define kScreenHMargin  20
#define kScreenVMargin  8


-(instancetype)initWithModel:(ChatModel *)model{
    
    self = [super init];
    if (self) {
        [self getCellAllControllerFrameWithModel:model];
    }
    return self;
}


//获得一条聊天信息所有控件的Frame

-(void)getCellAllControllerFrameWithModel:(ChatModel *)model{
    
    if ([model.chatContentType isEqualToString:@"text"]) {
        
        [self getObjectFrameOfTextViewWithChatContentType:model.chatContentType AndInfo:model.chatTextContent];
        
    }
    
    if ([model.chatContentType isEqualToString:@"picture"]) {
        
        [self getObjectFrameOfTextViewWithChatContentType:model.chatContentType AndInfo:model.chatPictureURLContent];
        
    }
    
    if ([model.chatContentType isEqualToString:@"audio"]) {
       
        [self getObjectFrameOfTextViewWithChatContentType:model.chatContentType AndInfo:model.chatAudioContent];
        
        
    }
    
    [self getHeadViewFrameWithisSender:model.isSender];

    [self getHeadImageViewFrame];
    
    [self getTextViewFrameWithisSender:model.isSender AndChatContent:model.chatContentType];
    
    
    
    [self getReadTranstorStringResultBtnFrame:model isSender:model.isSender];
    [self getSencondLabelFrame:model];
    [self getAVtoStringLabelFrame:model];

  
}

#pragma mark - green + black

//获取用户语音转文字的文字label－－Frame
-(void)getAVtoStringLabelFrame:(ChatModel *)model{
    
    if ([model.chatContentType isEqualToString:@"audio"]) {
        
        CGSize textLableSize;
        
        textLableSize = [model.AVtoStringContent boundingRectWithSize:CGSizeMake(kScreenWith*0.6, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:15]} context:nil].size;
        
        if (model.isSender == 0) {
            self.AVtoStringLabelFrame = CGRectMake(CGRectGetMinX(self.chatTextViewFrame), CGRectGetMaxY(self.chatTextViewFrame), textLableSize.width, textLableSize.height);
        }else{
            if ((kScreenWith*0.277-2*kScreenVMargin) <textLableSize.width) {
                self.AVtoStringLabelFrame = CGRectMake(CGRectGetMaxX(self.chatTextViewFrame)-textLableSize.width, CGRectGetMaxY(self.chatTextViewFrame), textLableSize.width, textLableSize.height);
            }else{
                self.AVtoStringLabelFrame = CGRectMake(CGRectGetMinX(self.chatTextViewFrame)+8, CGRectGetMaxY(self.chatTextViewFrame), textLableSize.width, textLableSize.height);
            }
        }
        if (self.chatTextLabelFrame.size.height == 0) {
            self.cellHeight = self.cellHeight  + self.AVtoStringLabelFrame.size.height;
        }else{
            self.cellHeight = self.cellHeight + 2*kScreenVMargin + self.chatTextLabelFrame.size.height;
        }
    }
}

#pragma mark - yellow
//获取播放译员翻译文字的frame
-(void)getReadTranstorStringResultBtnFrame:(ChatModel *)model isSender:(BOOL)isSender{
    
    NSString *identifier = model.sendIdentifier;
    
    if ([model.chatContentType isEqualToString:@"text"]) {
        if (isSender == 0) {
            if ([identifier isEqualToString:@"TRANSTOR"] || [identifier isEqualToString:@"FREETRANS"]) {
                self.transtorTextReadBtnFram = CGRectMake(CGRectGetMaxX(self.chatTextViewFrame)-28, kScreenVMargin*2+0.5*self.chatTextLabelFrame.size.height-0.022*kScreenWith,0.044*kScreenWith, 0.044*kScreenWith);
            }
        }else{
            if ([identifier isEqualToString:@"TRANSTOR"] || [identifier isEqualToString:@"FREETRANS"]) {
                //  not use
                //                self.transtorTextReadBtnFram = CGRectMake(CGRectGetMinX(self.chatTextViewFrame) +8  , self.cellHeight/2-0.022*kScreenWith, 0.044*kScreenWith, 0.044*kScreenWith);
            }
        }
    }
    
}

#pragma mark - red

//获取秒数指示label的Frame
-(void)getSencondLabelFrame:(ChatModel *)model{
    
    
    if (model.isSender == 0) {
        if ([model.chatContentType isEqualToString:@"audio"]) {
            self.secondLableFrame = CGRectMake(kScreenWith*0.254, kScreenVMargin, 20, kScreenWith*0.06);
            
        }
    }else{
        if ([model.chatContentType isEqualToString:@"audio"]) {
            self.secondLableFrame = CGRectMake(kScreenWith*0.746-20,kScreenVMargin, 20, kScreenWith*0.06);
        }
    }
    
}

#pragma mark - 头像

//获取头像底层View的Frame
-(void)getHeadViewFrameWithisSender:(BOOL)isSender{
    
    if (isSender == 0) {
        if (self.chatTextLabelFrame.size.height == 0) {
            self.headBgViewFrame = CGRectMake(kScreenWith*0.044,kScreenWith*0.062+kScreenVMargin-kScreenWith*0.111,kScreenWith*0.111, kScreenWith*0.111);
        }else{
            self.headBgViewFrame = CGRectMake(kScreenWith*0.044,kScreenVMargin*3+self.chatTextLabelFrame.size.height-kScreenWith*0.111,kScreenWith*0.111, kScreenWith*0.111);
        }
    }else{
        if (self.chatTextLabelFrame.size.height == 0) {
            self.headBgViewFrame = CGRectMake(kScreenWith*0.845,kScreenWith*0.062+kScreenVMargin-kScreenWith*0.111, kScreenWith*0.111, kScreenWith*0.111);
        }else{
            self.headBgViewFrame = CGRectMake(kScreenWith*0.845,kScreenVMargin*3+self.chatTextLabelFrame.size.height-kScreenWith*0.111,kScreenWith*0.111, kScreenWith*0.111);
        }
    }
}

#pragma mark - green + bgc

//获取聊天内容气泡的底层View的Frame
-(void)getTextViewFrameWithisSender:(BOOL)isSender AndChatContent:(NSString *)chatContentType{
    
    if (isSender == 0) {
        
        if ([chatContentType isEqualToString:@"text"]) {
            
            self.chatTextViewFrame = CGRectMake(kScreenWith*0.166, kScreenVMargin, self.textLableWidth + 50, self.chatTextLabelFrame.size.height + kScreenVMargin*2);
        }
        
        if ([chatContentType isEqualToString:@"picture"]) {
            
            NSLog(@"这是一张图片");
            
        }
        
        if ([chatContentType isEqualToString:@"audio"]) {
            self.chatTextViewFrame = CGRectMake(kScreenWith*0.166,kScreenVMargin, kScreenWith*0.277, kScreenWith*0.062);
        }
        
    }else{
        
        if ([chatContentType isEqualToString:@"text"]) {
            
            self.chatTextViewFrame = CGRectMake(kScreenWith*0.834-self.textLableWidth-kScreenWith*0.088, kScreenVMargin, self.textLableWidth +kScreenWith*0.088,self.chatTextLabelFrame.size.height + kScreenVMargin*2);
        }
        
        if ([chatContentType isEqualToString:@"picture"]) {
            
            NSLog(@"这是一张图片");
            
        }
        
        if ([chatContentType isEqualToString:@"audio"]) {
            
            self.chatTextViewFrame = CGRectMake(kScreenWith*(1-0.166-0.277), kScreenVMargin, kScreenWith*0.277, kScreenWith*0.062);
        }
        
    }
    self.cellHeight = self.chatTextViewFrame.size.height;
}

//获取头像中ImageView的Frame
-(void)getHeadImageViewFrame{
    
    self.headImageViewFrame = CGRectMake(0, 4, self.headBgViewFrame.size.width , self.headBgViewFrame.size.height );
}

//获取聊天气泡当中text，Pickture，Audio的Frame
-(void)getObjectFrameOfTextViewWithChatContentType:(NSString *)chatContentType AndInfo:(NSString *)info{
    
    if ([chatContentType isEqualToString:@"text"]) {
        
        CGSize textLableSize;
        
        textLableSize = [info boundingRectWithSize:CGSizeMake(180, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:15]} context:nil].size;
        
        self.textLableWidth = textLableSize.width;
        self.chatTextLabelFrame = CGRectMake(kScreenHMargin, kScreenVMargin, textLableSize.width, textLableSize.height);
        
    }
    
    if ([chatContentType isEqualToString:@"picture"]) {
        NSLog(@"图片哦~~");
    }
    
    if ([chatContentType isEqualToString:@"audio"]) {
        
        self.chatAudioViewFrame = CGRectMake(kScreenVMargin, 0, kScreenWith*0.277-2*kScreenVMargin, kScreenWith*0.062);
        
    }
    
    
}





@end


















