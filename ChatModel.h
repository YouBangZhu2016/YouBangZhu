//
//  ChatModel.h
//  CharttingController
//
//  Created by tjufe on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject

@property (nonatomic,strong) NSString *chatContentType;
@property (nonatomic,strong) NSString *chatTextContent;
@property (nonatomic,strong) NSString *chatPictureURLContent;
@property (nonatomic,strong) NSString *chatAudioContent;
@property (nonatomic,strong) NSString *senderID;
@property (nonatomic,strong) NSString *senderImgPictureURL;
@property (nonatomic,strong) NSString *sendTime;
@property (nonatomic,strong) NSString *messageID;


@property (nonatomic,strong) NSString *audioSecond;
@property (nonatomic,strong) NSString *sendIdentifier;//用户身份//@"USER"//@"TRANSTOR"//@"FREETRANS"
@property (nonatomic,strong) NSString *AVtoStringContent;

@property (nonatomic,assign) BOOL isSender;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
