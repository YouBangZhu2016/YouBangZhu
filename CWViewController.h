//
//  CWViewController.h
//  SoundRecorderText
//
//  Created by lanou3g on 14/12/24.
//  Copyright (c) 2014年 com.lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import <Availability.h>

#ifndef __IPHONE_5_0
#warning "This project uses features only available in iOS SDK 5.0 and later."
#endif

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif

@interface CWViewController : UIViewController<AVAudioPlayerDelegate>
{
    NSURL *recordedFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
//    BOOL isRecording;
}

@property (nonatomic) BOOL isRecording;
@property (strong, nonatomic)  UIButton *playButton;
@property (strong, nonatomic)  UIButton *recordButton;


@property (strong, nonatomic)  UIButton *pauseRecordBtn;
@property (strong, nonatomic)  UIButton *goOnRecordBtn;
@property (strong, nonatomic)  UIButton *cancelRecordBtn;

@property (strong, nonatomic)  NSString *URLNameString;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic,strong)  NSString *secondString;

//@property (strong, nonatomic)  NSTimer  *timer;
//@property (assign, nonatomic)  NSInteger recordSecond;

-(void)getSavePath;
-(void)recordButtonClick;
-(void)pauseRecordBtnClick;
-(void)goOnRecordBtnClick;
-(void)cancelButtonClick;
- (void)playButtonClickWithURLString:(NSString *)URLString;

- (instancetype)initWithURL:(NSString *)URL;
@end
