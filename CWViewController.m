//
//  CWViewController.m
//  SoundRecorderText
//
//  Created by lanou3g on 14/12/24.
//  Copyright (c) 2014年 com.lanou. All rights reserved.
//

#import "CWViewController.h"

@interface CWViewController ()

@property(nonatomic,strong) NSMutableDictionary *recordSetting;

@end




@implementation CWViewController
@synthesize playButton = _playButton;
@synthesize recordButton = _recordButton;
//@synthesize isRecording = _isRecording;


- (void)viewDidUnload
{
    [self setPlayButton:nil];
    [self setRecordButton:nil];
    recorder = nil;
    player = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // [fileManager removeItemAtPath:recordedFile.path error:nil];
    [fileManager removeItemAtURL:recordedFile error:nil];
    recordedFile = nil;
    [super viewDidUnload];
}

- (instancetype)initWithURL:(NSString *)URL
{
    self = [super init];
    if (self) {
        
        //url用时间
        self.URLNameString = URL;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.isPlaying = NO;
    
//    [self.view addSubview:self.playButton];
//    [self.view addSubview:self.recordButton];
//    [self.view addSubview:self.pauseRecordBtn];
//    [self.view addSubview:self.goOnRecordBtn];
//    [self.view addSubview:self.cancelRecordBtn];
    // 临近状态检测
    
    // 当你的身体靠近iPhone而不是触摸的时候，iPhone将会做出反应。（需要一定的面的影射，约5mm左右的时候就会触发）
    
    // YES 临近 消息触发
    
    // NO
    
    BOOL proximityState = [[UIDevice currentDevice]proximityState];
    
    NSLog(@"++++++++%d",proximityState);
    
    UIDevice *device = [UIDevice currentDevice ];
    
    device.proximityMonitoringEnabled=YES; // 允许临近检测
    
    if (device.proximityMonitoringEnabled == YES) {
        
        // 临近消息触发
        
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(proximityChanged:)
         
                                                     name:UIDeviceProximityStateDidChangeNotification object:device];
        
    }
    
    
    
    self.isRecording = NO;
    //设置play按钮不可点击
    [self.playButton setEnabled:NO];
    //title设置透明度
    self.playButton.titleLabel.alpha = 0.5;
    //录音的存储路径
    [self getSavePath];
    //在获得一个AVAudioSession类的实例后，你就能通过调用音频会话对象的setCategory:error:实例方法，来从IOS应用可用的不同类别中作出选择。
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *sessionError;
    //设置可以播放和录音状态
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];

    
}


-(void)getSavePath{
    
    recordedFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:self.URLNameString]];

}

// 临近手机消息触发

- (void) proximityChanged:(NSNotification *)notification {
    //--------------------------------------------------------------
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗
    
    if ([[UIDevice currentDevice] proximityState] == YES)
        
    {
        
        NSLog(@"接近耳朵");
        //设置从听筒不放,状态设置成播放和录音
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
        
        
    }
    
    else//没黑屏幕
        
    {
        
        NSLog(@"不接近耳朵");
        //设置扬声器播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//        if (![player isPlaying]) {//没有播放了，也没有在黑屏状态下，就可以把距离传感器关了
//
//            [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
//  
//        }
        
    }
    //-------------------------------------------------------------------------------
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



//播放结束的时候把button的标题设置成播放.
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 响应方法

- (void)recordButtonClick{
    
    //If the app is note recording, we want to start recording, disable the play button, and make the record button say "STOP"
    //开始录音
    if(!self.isRecording)
    {
        //先设置能播放和录音状态
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        self.isRecording = YES;
        [self.recordButton setTitle:@"结束" forState:UIControlStateNormal];
        [self.playButton setEnabled:NO];
        [self.playButton.titleLabel setAlpha:0.5];
        //初始化录音
        
        
        //设置属性的字典
        self.recordSetting = [[NSMutableDictionary alloc] init];
        
        //1.格式
        [self.recordSetting setObject:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        //2.采样率
        [self.recordSetting setObject:[NSNumber numberWithInt:8000.00f] forKey:AVSampleRateKey];
        //3.声道
        [self.recordSetting setObject:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
        //4.采样位数
        [self.recordSetting setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        
        [self.recordSetting setObject:[NSNumber numberWithBool:NO] forKeyedSubscript:AVLinearPCMIsNonInterleaved];
        
        [self.recordSetting setObject:[NSNumber numberWithBool:NO] forKeyedSubscript:AVLinearPCMIsFloatKey];
        
        [self.recordSetting setObject:[NSNumber numberWithBool:NO] forKeyedSubscript:AVLinearPCMIsBigEndianKey];
        
        recorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:self.recordSetting error:nil];
        
        NSLog(@"录音路径::::%@",recordedFile);
        //准备录音
        [recorder prepareToRecord];
        //开始录音
        [recorder record];
        player = nil;
    }
    //If the app is recording, we want to stop recording, enable the play button, and make the record button say "REC"
    else
    {
        self.isRecording = NO;
        [self.recordButton setTitle:@"录音" forState:UIControlStateNormal];
        [self.playButton setEnabled:YES];
        [self.playButton.titleLabel setAlpha:1];
        //录音停止
        NSLog(@"asdasd%f",recorder.currentTime);
        
        self.secondString = [NSString stringWithFormat:@"%@\"",[self decimalwithFormat:@"0" floatV:recorder.currentTime]];
        [recorder stop];
        recorder = nil;
        
    }
    
    
}


- (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}



-(void)pauseRecordBtnClick{
    [recorder pause];
}

-(void)goOnRecordBtnClick{
    [recorder record];
}

-(void)cancelButtonClick{
//    [recorder deleteRecording];
//    recorder = nil;
    
    recorder.delegate = nil;
    if ([recorder isRecording]) {
        NSLog(@"%f",recorder.currentTime);
        [recorder stop];
        [recorder deleteRecording];
    }
    recorder = nil;
}

//播放和暂停
- (void)playButtonClickWithURLString:(NSString *)URLString {
    //If the track is playing, pause and achange playButton text to "Play"
    
    NSError *playerError;
    //初始化播放器
    NSURL *URL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:URLString]];

    NSLog(@"播放路径：：：%@",URL);
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:&playerError];
    
    if (player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    //设置播放器代理
    player.delegate = self;
    //设置从扬声器播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    if([player isPlaying] && self.isPlaying == YES)
    {
        [player stop];
        self.isPlaying = NO;
        [self.playButton setTitle:@"播放" forState:UIControlStateNormal];
    }
    //If the track is not player, play the track and change the play button to "Pause"
    else
    {
        [player play];
        self.isPlaying = YES;
        NSLog(@"%d",(int)player.duration);
        [self.playButton setTitle:@"暂停" forState:UIControlStateNormal];
    }
    
    
}

#pragma mark - getters

-(UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.backgroundColor = [UIColor redColor];
        _playButton.frame = CGRectMake(64, 64, 100, 40);
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playButtonClickWithURLString:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

-(UIButton *)recordButton{
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordButton.backgroundColor = [UIColor redColor];
        _recordButton.frame = CGRectMake(64, 110, 100, 40);
        [_recordButton setTitle:@"录制" forState:UIControlStateNormal];
        [_recordButton addTarget:self action:@selector(recordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recordButton;
}

-(UIButton *)pauseRecordBtn{
    if (!_pauseRecordBtn) {
        _pauseRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pauseRecordBtn.backgroundColor = [UIColor redColor];
        _pauseRecordBtn.frame = CGRectMake(64, 160, 100, 40);
        [_pauseRecordBtn setTitle:@"暂停录制" forState:UIControlStateNormal];
        [_pauseRecordBtn addTarget:self action:@selector(pauseRecordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pauseRecordBtn;
}

-(UIButton *)goOnRecordBtn{
    if (!_goOnRecordBtn) {
        _goOnRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goOnRecordBtn.backgroundColor = [UIColor redColor];
        _goOnRecordBtn.frame = CGRectMake(64, 210, 100, 40);
        [_goOnRecordBtn setTitle:@"继续录制" forState:UIControlStateNormal];
        [_goOnRecordBtn addTarget:self action:@selector(goOnRecordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goOnRecordBtn;
}

-(UIButton *)cancelRecordBtn{
    if (!_cancelRecordBtn) {
        _cancelRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelRecordBtn.backgroundColor = [UIColor redColor];
        _cancelRecordBtn.frame = CGRectMake(64, 260, 100, 40);
        [_cancelRecordBtn setTitle:@"取消录制" forState:UIControlStateNormal];
        [_cancelRecordBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelRecordBtn;
}

@end













