//
//  ChatModel.m
//  CharttingController
//
//  Created by tjufe on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "ChatModel.h"

@implementation ChatModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        NSString *chatContentType = dict[@"chatContentType"];
        self.chatContentType = chatContentType;
        
        if ([chatContentType isEqualToString:@"text"]) {
            
            self.chatTextContent = dict[@"chatTextContent"];
            
        }
        
        if ([chatContentType isEqualToString:@"picture"]) {
            
            self.chatPictureURLContent = dict[@"chatPictureURLContent"];
            
        }
        
        if ([chatContentType isEqualToString:@"audio"]) {
            
            self.chatAudioContent = dict[@"chatAudioContent"];
            
        }
        
        self.senderID = dict[@"senderID"];
        self.senderImgPictureURL = dict[@"senderImgPictureURL"];
        self.sendTime = dict[@"sendTime"];
        self.messageID = dict[@"messageID"];
        self.sendIdentifier = dict[@"sendIdentifier"];
        self.AVtoStringContent = dict[@"AVtoStringContent"];
        self.audioSecond = dict[@"audioSecond"];
        
    }
    return self;
}


@end

