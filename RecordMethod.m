//
//  RecordMethod.m
//  CharttingController
//
//  Created by tjufe on 16/7/15.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "RecordMethod.h"
#import "CWViewController.h"


@interface RecordMethod ()

@property(nonatomic,strong) CWViewController *cwRecordController;

@end

@implementation RecordMethod


- (instancetype)initRecordController
{
    self = [super init];
    if (self) {
        
        _cwRecordController = [[CWViewController alloc]init];
        
    }
    return self;
}


//录制开始

-(void)benginRecordWithURlString:(NSString *)urlString{

    
    self.cwRecordController.URLNameString = urlString;
    
    [self.cwRecordController recordButtonClick];
    
}
//录音结束
-(void)endedRecordWithURlString:(NSString *)urlString{
    
    [self benginRecordWithURlString:urlString];
}

//暂停录制
-(void)pauseRecord{
    
    [self.cwRecordController pauseRecordBtnClick];
}

//继续录制

-(void)goOnRecord{
    
    [self.cwRecordController goOnRecordBtnClick];
}

//取消录制

-(void)cancelRecord{
    [self.cwRecordController cancelButtonClick];
}

//播放和暂停播放
-(void)playAndPauseAudioWithURLString:(NSString *)urlString{
    
    [self.cwRecordController playButtonClickWithURLString:urlString];
}


@end
