//
//  RecordMethod.h
//  CharttingController
//
//  Created by tjufe on 16/7/15.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordMethod : NSObject

- (instancetype)initRecordController;
//录制开始

-(void)benginRecordWithURlString:(NSString *)urlString;
//录音结束
-(void)endedRecordWithURlString:(NSString *)urlString;
//暂停录制
-(void)pauseRecord;
//继续录制

-(void)goOnRecord;
//取消录制

-(void)cancelRecord;
//播放和暂停播放
-(void)playAndPauseAudioWithURLString:(NSString *)urlString;

@end
