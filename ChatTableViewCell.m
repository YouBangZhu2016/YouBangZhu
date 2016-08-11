//
//  ChatTableViewCell.m
//  CharttingController
//
//  Created by tjufe on 16/7/13.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Model:(ChatModel *)model
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//免费翻译每条cell背景色
        self.frameInfo = [[ChatFrameInfo alloc]initWithModel:model];
        self.headView.frame = self.frameInfo.headBgViewFrame;
        self.headImageView.frame = self.frameInfo.headImageViewFrame;
        self.textView.frame = self.frameInfo.chatTextViewFrame;
        self.pictureView.frame = self.frameInfo.chatPictureViewFrame;
        self.textChatLabel.frame = self.frameInfo.chatTextLabelFrame;
        self.height = self.frameInfo.cellHeight;
        
        self.secondLabel.frame  = self.frameInfo.secondLableFrame;
        self.AVtoStringLabel.frame = self.frameInfo.AVtoStringLabelFrame;
        self.playTransTextBtn.frame = self.frameInfo.transtorTextReadBtnFram;
        
        [self chooseToSetPositionWith:model.isSender];
        [self getHeadViewImageWithID:model.senderID];
        [self getTextViewWithType:model.chatContentType];
        [self getTextField:model.chatTextContent];
        [self getPictureView:model.chatPictureURLContent];
        self.playRecordBtn.frame = self.frameInfo.chatAudioViewFrame;
        
        [self addSubview:self.AVtoStringLabel];
        [self addSubview:self.secondLabel];
        [self addSubview:self.playTransTextBtn];
        
        
        [self getAudioToTranslationText:model.AVtoStringContent];
        [self getSecondLabelText:model.audioSecond];
        
        self.messageID = model.messageID;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }
    return self;
}


-(void)layoutSubviews{
    
    self.headView.frame = self.frameInfo.headBgViewFrame;
    self.headImageView.frame = self.frameInfo.headImageViewFrame;
    self.textView.frame = self.frameInfo.chatTextViewFrame;
    self.pictureView.frame = self.frameInfo.chatPictureViewFrame;
    self.textChatLabel.frame = self.frameInfo.chatTextLabelFrame;
    self.playRecordBtn.frame = self.frameInfo.chatAudioViewFrame;
    self.secondLabel.frame  = self.frameInfo.secondLableFrame;
    self.AVtoStringLabel.frame = self.frameInfo.AVtoStringLabelFrame;
    self.playTransTextBtn.frame = self.frameInfo.transtorTextReadBtnFram;
    
}


//秒数Label
-(void)getSecondLabelText:(NSString *)second{
    
    self.secondLabel.text = second;
    
}

//语音转文字显示Label
-(void)getAudioToTranslationText:(NSString *)text{
    
    self.AVtoStringLabel.text = text;
    
}



//获得发送语音的长度
-(void)getLengthofSpoken:(NSTimeInterval *)timeInterval{
    
    self.voiceLength = timeInterval;
}

//获得发送的图片
-(void)getPictureView:(NSString *)pictureUrl{
    
    self.pictureUrl = [NSURL URLWithString:pictureUrl];
}


//获得输入的文字
-(void)getTextField:(NSString *)text{
    
    self.textChatLabel.text = text;
}


//通过用户ID获取头像
-(void)getHeadViewImageWithID:(NSString *)userID{
    
    if ([userID isEqualToString:@"0001"]) {
        self.headImageView.layer.masksToBounds=YES;
        self.headImageView.layer.cornerRadius=44/2.0f;
        self.headImageView.image = [UIImage imageNamed:@"user"];
    }else if ([userID isEqualToString:@"0002"]){
        self.headImageView.layer.masksToBounds=YES;
        self.headImageView.layer.cornerRadius=44/2.0f;
        self.headImageView.image =[UIImage imageNamed:@"translator"];
    }
    self.headImageView.layer.masksToBounds=YES;
    self.headImageView.layer.cornerRadius=44/2.0f;
    self.headImageView.image =[UIImage imageNamed:@"translator"];
}


//根据气泡和头像放在左侧还是右侧
-(void)chooseToSetPositionWith:(BOOL)isSender{
    
    if(isSender == 1){
        //放在右边
        [self getRightCell];
    }
    else if(isSender == 0){
        //放在左边
        [self getLeftCell];
    }
    [self addSubview:self.headView];
    [self addSubview:self.textView];
    
}

//获得左侧的cell
-(void)getLeftCell{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.textView.bounds.size.width, self.textView.bounds.size.height)];
    UIImage *img = [UIImage imageNamed:@"绿"];
    [imageView setImage:[img stretchableImageWithLeftCapWidth:floor(img.size.width/2) topCapHeight:floor(img.size.height/2)]];
    imageView.backgroundColor = [UIColor clearColor];
    [self.textView addSubview:imageView];
    
}

//获得右侧的cell
-(void)getRightCell{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.textView.bounds.size.width, self.textView.bounds.size.height)];
    UIImage *img = [UIImage imageNamed:@"白"];
    [imageView setImage:[img stretchableImageWithLeftCapWidth:floor(img.size.width/2) topCapHeight:floor(img.size.height/2)]];
    imageView.backgroundColor = [UIColor clearColor];
    [self.textView addSubview:imageView];
    
}

//计算cell需要的长度
-(void)getCellHeight{
    
    self.height =  self.textView.bounds.size.height + 15;
}


//获取聊天内容的类型（文字、语音、图片）并生成对应的textview
-(void)getTextViewWithType:(NSString *)type{
    
    if ([type isEqualToString: @"audio"]) {
        [self.textView addSubview:self.playRecordBtn];
        //生成语音的气泡
    }else if ([type isEqualToString: @"text"]){
        //生成文字的气泡
        [self.textView addSubview:self.textChatLabel];
    }else if ([type isEqualToString:@"picture"]){
        //生成图片的气泡
        [self.textView addSubview:self.pictureView];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark getters
//创建头像
-(UIView *)headView{
    
    if (!_headView) {
        _headView = [[UIView alloc]init];
        _headImageView.backgroundColor = [UIColor purpleColor];
        [_headView addSubview:self.headImageView];
    }
    return _headView;
}

//创建头像imageview
-(UIImageView *)headImageView{
    
    if (!_headImageView) {
        _headImageView  = [[UIImageView alloc]init];
        
    }
    return _headImageView;
}

//创建聊天内容的view
-(UIView *)textView{
    
    if (!_textView) {
        _textView = [[UIView alloc]init];
        _textView.backgroundColor = [UIColor clearColor];
    }
    return _textView;
}

//聊天内容的label
-(UILabel *)textChatLabel{
    
    if (!_textChatLabel) {
        _textChatLabel = [[UILabel alloc]init];
        
        [_textChatLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        _textChatLabel.lineBreakMode = UILineBreakModeWordWrap;
        _textChatLabel.numberOfLines = 0;
    }
    return  _textChatLabel;
}

-(UIView *)pictureView{
    
    if (!_pictureView) {
        _pictureView = [[UIView alloc]init];
        _pictureView.backgroundColor = [UIColor redColor];
    }
    return _pictureView;
}

//灰色条
-(UIButton *)playRecordBtn{
    
    if (!_playRecordBtn) {
        _playRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //_playRecordBtn.backgroundColor = [UIColor grayColor];
        //_playRecordBtn.frame = CGRectMake(0, 0, 50, 25);
        [_playRecordBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playRecordBtn;
}


-(UILabel *)secondLabel{
    
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc]init];
        _secondLabel.numberOfLines = 0;
        _secondLabel.textColor = [UIColor blackColor];
        [_secondLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        _secondLabel.lineBreakMode = UILineBreakModeWordWrap;
        
    }
    return _secondLabel;
}

-(UILabel *)AVtoStringLabel{
    
    if (!_AVtoStringLabel) {
        _AVtoStringLabel = [[UILabel alloc]init];
        _AVtoStringLabel.numberOfLines = 0;
        _AVtoStringLabel.backgroundColor = [UIColor clearColor];
        [_AVtoStringLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        [_AVtoStringLabel setTextColor:[UIColor colorWithRed:128.0f/255.0f
                                                       green:128.0f/255.0f blue:128.0f/255.0f alpha:1]];
        _AVtoStringLabel.lineBreakMode = UILineBreakModeWordWrap;
        
    }
    return _AVtoStringLabel;
}

-(UIButton *)playTransTextBtn{
    
    if (!_playTransTextBtn) {
        _playTransTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playTransTextBtn.backgroundColor = [UIColor whiteColor];
        _playRecordBtn.frame = CGRectMake(0, 0, 25, 25);
        [_playTransTextBtn addTarget:self action:@selector(readText) forControlEvents:UIControlEventTouchUpInside];
        [_playTransTextBtn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    }
    return _playTransTextBtn;
}



#pragma mark - 点击事件以及私有方法

-(void)speakeAString:(NSString *)speakeString{
    
    AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:speakeString];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *voice_language = [userDefaults objectForKey:@"VOICE_LANGUAGE"];
    
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:voice_language];
    
    utterance.voice = voice;
    utterance.rate = 0.38;
    utterance.pitchMultiplier = 1;
    utterance.volume = 1;
    [av speakUtterance:utterance];
    
}

-(void)readText{
    
    NSString *text = self.textChatLabel.text;
    [self speakeAString:text];
    
}

-(void)play{
    NSLog(@"播放");
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"determinePlayARecord" object:nil userInfo:@{@"cellID":self.messageID}];
}




@end











