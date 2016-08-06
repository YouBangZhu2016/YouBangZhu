  //
//  ViewController.m
//  CharttingController
//
//  Created by tjufe on 16/7/9.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "FreeTransViewController.h"
#import "BaseTableView.h"
#import "BaseAudioButton.h"
#import "ChatFrameInfo.h"
#import "ChatModel.h"
#import "ChatTableViewCell.h"
#import "CWViewController.h"
#import "RecordMethod.h"
#import "iflyMSC/IFlyMSC.h"
#import "StringTransViewController.h"


#define LANGUAGE_ENGLISH  @"ENGLISH"
#define LANGUAGE_CHINESE  @"CHINESE"

@interface FreeTransViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate,BaseTableViewDelegate,BaseAudioButtonDelegate,UITableViewDataSource,UITableViewDelegate,IFlySpeechRecognizerDelegate>

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHight  [UIScreen mainScreen].bounds.size.height

@property (nonatomic,strong) NSString *selectedCellMessageID;

@property(nonatomic,strong) BaseTableView *bottomTableView;
@property(nonatomic,strong) UIView      *inputBottomView;
@property(nonatomic,strong) UIButton    *changeSendContentBtn;
@property(nonatomic,strong) UIButton    *selectLangueageBtn;
@property(nonatomic,strong) BaseAudioButton    *reportAudioBtn;
@property(nonatomic,strong) UIButton    *sendMessageBtn;
@property(nonatomic,strong) UITextView *inputTextView;
@property(nonatomic,strong) NSString * senderID;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,strong) UIRefreshControl *refreshController;
@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UIView *subBottomView;
@property(nonatomic,assign) BOOL isCancelSendRecord;
@property(nonatomic,assign) BOOL isRecognizer;
@property(nonatomic,assign) BOOL isZero;
@property(nonatomic,assign) BOOL isKeyboardShow;

///////asdasdasdasd

@property(nonatomic,strong) CWViewController *cwViewController;
//@property(nonatomic,strong) RecordMethod *recordMethod;
@property(nonatomic,strong) NSString *cellMessageID;
@property(nonatomic,strong) NSString *currentCellID;

@property (nonatomic,strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic,strong) StringTransViewController *stringTransVC;



@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *target_id;


@property (nonatomic,strong) NSString *userIdentifier;
@property (nonatomic,strong) NSString *voice_Language;
@property (nonatomic,strong) NSString *trans_Language;

@end

@implementation FreeTransViewController{
  NSInteger  ascCount;
  NSString   *iFlySpeechRecognizerString;
    CGFloat    KeyboardWillShowHeight;

}


- (instancetype)initWithUserID:(NSString *)userID WithTargetID:(NSString *)targetID WithUserIdentifier:(NSString *)userIdentifier WithVoiceLanguage:(NSString *)voice_Language WithTransLanguage:(NSString *)trans_Language
{
    self = [super init];
    if (self) {
        self.user_id = userID;
        self.target_id = targetID;
        
        self.userIdentifier = userIdentifier;
        
        self.voice_Language = voice_Language;
        self.trans_Language = trans_Language;
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.voice_Language forKey:@"VOICE_LANGUAGE"];
        [userDefaults setObject:self.trans_Language forKey:@"TRANS_LANGUAGE"];
        
        
        //欠缺单利处理 （头像获取）
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.isCancelSendRecord = NO;
    self.isRecognizer = NO;
    self.isZero = NO;
    self.isKeyboardShow = NO;
     self.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgp"]];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
   
    _stringTransVC = [[StringTransViewController alloc]init];
    [_stringTransVC viewDidLoad];
   
    
    ascCount = 0;
    self.senderID = self.user_id;
    NSArray *arr = [NSArray array];
    self.dataArr = [NSMutableArray arrayWithArray:arr];
    self.dataSource = [[NSMutableArray alloc]init];
    
    self.cwViewController = [[CWViewController alloc]init];
    [self.view addSubview:self.bottomTableView];
    [self.view addSubview:self.inputBottomView];
    [self.inputBottomView addSubview:self.changeSendContentBtn];
    [self.inputBottomView addSubview:self.selectLangueageBtn];
    [self.inputBottomView addSubview:self.inputTextView];
    [self.bottomTableView setContentOffset:CGPointMake(0, self.bottomTableView.bounds.size.height)];

    [self AddTapGestureRecognizer];
    [self reloadDataSourceWithNumber:ascCount];
    
    self.iFlySpeechRecognizer  = [[IFlySpeechRecognizer alloc]init];
    self.iFlySpeechRecognizer.delegate = self;
    
    //键盘弹出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘收起
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(determinePlayARecord:) name:@"determinePlayARecord" object:nil];
}


#pragma mark - 语音听写私有方法 & IFlySpeechRecognizerDelegate

-(void)iFlySpeechRecognizerStop{
    [self.iFlySpeechRecognizer stopListening];//做完现在的任务
    self.isRecognizer = NO;

}

-(void)iFlySpeechRecognizerCancel{
    
    [self.iFlySpeechRecognizer cancel];//一切
    self.isRecognizer = NO;
}

-(void)iFlySpeechRecognizerBegin:(NSString *)language{
    
    self.isRecognizer = YES;
    [self.iFlySpeechRecognizer setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    if ([language isEqualToString:LANGUAGE_ENGLISH]) {
        [self.iFlySpeechRecognizer setParameter: @"en_us" forKey:[IFlySpeechConstant LANGUAGE]];//英语
    }
    if ([language isEqualToString:LANGUAGE_CHINESE]) {
        [self.iFlySpeechRecognizer setParameter: @"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];//中文
    }


    //asr_audio_path保存录音文件名,默认目录是documents
//    [self.iFlySpeechRecognizer setParameter: @"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    //设置返回的数据格式为默认plain
    [self.iFlySpeechRecognizer setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    [self.iFlySpeechRecognizer startListening];
}

//IFlySpeechRecognizerDelegate

- (void) onError:(IFlySpeechError *) errorCode{
    
    
    NSLog(@"错误描述--->%@",errorCode);
    
}


- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    NSMutableString *result = [NSMutableString new];
    NSDictionary *dic = [results objectAtIndex:0];
    NSLog(@"DIC:%@",dic);
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    if(iFlySpeechRecognizerString != nil && ![iFlySpeechRecognizerString isEqualToString:@""]){
        iFlySpeechRecognizerString = [NSString stringWithFormat:@"%@%@",iFlySpeechRecognizerString,result];
    }else{
        iFlySpeechRecognizerString = result;
    }
    NSLog(@"哈哈哈%@",iFlySpeechRecognizerString);
    
    if (self.isCancelSendRecord == YES && self.isZero == YES) {
        
        //取消发送
//        iFlySpeechRecognizerString = @"";
        
    }
    
    if (self.isCancelSendRecord == NO  && self.isZero == YES) {
        
        //发送
        
        NSLog(@"asdasdsad%@",iFlySpeechRecognizerString);
        
//        iFlySpeechRecognizerString = @"";
    }
    
    
    
}


#pragma mark - 观察者方法

-(void)determinePlayARecord:(NSNotification *)info{
    
    self.currentCellID = info.userInfo[@"cellID"];
    [self.cwViewController playButtonClickWithURLString:self.currentCellID];
    NSLog(@"%@",self.currentCellID);
    [self cancelResignFirstResponder];
    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"determinePlayARecord" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification                                                           object:nil];
}

#pragma mark - 功能方法


//获取当前时间string
-(NSString *)getCurerentTimeString{
    
    
    NSDate *currentTime = [NSDate date];
    
    NSString *dateString = [self fromDateToNSString:currentTime];
    
    return dateString;
}

//Date转化为Nsstring方法
//格式为：2016-04-0813:15:10" 把这个字符串传进去 @"yyyy-MM-ddHH:mm:ss"
-(NSString *)fromDateToNSString:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
    
    
    NSString *dateNSString = [formatter stringFromDate:date];
    
    
    return dateNSString;
}

-(void)sendRecordAudioWithRecordURLString:(NSString *)urlString{
    NSInteger count = self.dataArr.count;
    
    
    //////////
//    iFlySpeechRecognizerString = @"今天天气不错！";
    
    //////////
    NSDictionary *dict = @{@"senderID":self.senderID,
                           @"chatAudioContent":urlString,
                           @"chatContentType":@"audio",
                           @"chatPictureURLContent":@"",
                           @"messageID":self.cellMessageID,
                           @"sendIdentifier":self.userIdentifier,
                           @"audioSecond":self.cwViewController.secondString,
                           @"AVtoStringContent":iFlySpeechRecognizerString,
                           @"sendTime":self.cellMessageID,
                           @"chatTextContent":@"",
                           @"senderImgPictureURL":@""};
    NSLog(@"%@asmdjasdgjkashdjkashkhdask%@",self.cwViewController.secondString,iFlySpeechRecognizerString);
    
    self.inputTextView.text = nil;
    [self.dataArr insertObject:dict atIndex:count];
    ascCount = ascCount + 1;
    [self reloadDataSourceWithNumber:ascCount];
    [self.bottomTableView reloadData];
    
    [self.sendMessageBtn removeFromSuperview];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:ascCount - 1 inSection:0];
    [self.bottomTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self performSelector:@selector(freeTranslationMethod) withObject:nil afterDelay:1.0f];
}

//免费翻译进行

-(void)freeTranslationMethod{
   
    if (iFlySpeechRecognizerString == nil || [iFlySpeechRecognizerString isEqualToString:@""]) {
        //不需要翻译
    }else{
        NSInteger count = self.dataArr.count;
        
        self.stringTransVC.inputTF.text = iFlySpeechRecognizerString;
        [self.stringTransVC btnClick];
        NSString *result = self.stringTransVC.resultString;
        
        
        NSDictionary *dict = @{@"senderID":@"0002",@"chatTextContent":result,@"chatContentType":@"text",@"chatPictureURLContent":@"",@"sendIdentifier":@"FREETRANS"};
        self.inputTextView.text = nil;
        [self.dataArr insertObject:dict atIndex:count];
        ascCount = ascCount + 1;
        [self reloadDataSourceWithNumber:ascCount];
        [self.bottomTableView reloadData];
        
        [self.sendMessageBtn removeFromSuperview];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:ascCount - 1 inSection:0];
        [self.bottomTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        if (self.isKeyboardShow == YES) {
            ///////
            ///////////
            NSInteger cccount = self.dataSource.count;
            NSIndexPath *iindex = [NSIndexPath indexPathForRow:cccount - 1 inSection:0];
            CGRect    rect = [self.bottomTableView rectForRowAtIndexPath:iindex];
            CGFloat   cellMaxY = rect.origin.y + rect.size.height + 64;
            ;
            [UIView animateWithDuration:0.25 animations:^{
                
                CGFloat moveY = 0.0;
                CGFloat xiangjian;
                xiangjian = cellMaxY - ([UIScreen mainScreen].bounds.size.height - KeyboardWillShowHeight - CGRectGetHeight(self.inputBottomView.frame));
                
                if (xiangjian <= 0) {
                    moveY = 0;
                }
                
                if (xiangjian > 0 && xiangjian < KeyboardWillShowHeight) {
                    moveY = xiangjian;
                }
                
                if (xiangjian >= KeyboardWillShowHeight ) {
                    moveY = KeyboardWillShowHeight;
                }
                self.inputBottomView.transform = CGAffineTransformMakeTranslation(0, -KeyboardWillShowHeight);
                self.bottomTableView.transform = CGAffineTransformMakeTranslation(0, -moveY);
            }];
            ///////
        }
        
    }
}

-(void)sendTextMessageMethodWithString:(NSString *)text{

    NSInteger count = self.dataArr.count;
    
    iFlySpeechRecognizerString = text;
    
    
    
    NSString *currentDateString = [self getCurerentTimeString];
    self.cellMessageID = currentDateString;
    
    NSDictionary *dict = @{@"senderID":self.senderID,
                           @"chatTextContent":text,
                           @"chatContentType":@"text",
                           @"chatPictureURLContent":@"",
                           @"messageID":self.cellMessageID,
                           @"senderImgPictureURL":@"",
                           @"messageID":self.cellMessageID,
                           @"audioSecond":@"",
                           @"sendIdentifier":self.userIdentifier,
                           @"AVtoStringContent":@"",
                           @"sendTime":self.cellMessageID};
    self.inputTextView.text = nil;
    [self.dataArr insertObject:dict atIndex:count];
    ascCount = ascCount + 1;
    [self reloadDataSourceWithNumber:ascCount];
    [self.bottomTableView reloadData];
    
    [self.sendMessageBtn removeFromSuperview];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:ascCount - 1 inSection:0];
    [self.bottomTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
    if (self.isKeyboardShow == YES) {
        ///////////
        NSInteger cccount = self.dataSource.count;
        NSIndexPath *iindex = [NSIndexPath indexPathForRow:cccount - 1 inSection:0];
        CGRect    rect = [self.bottomTableView rectForRowAtIndexPath:iindex];
        CGFloat   cellMaxY = rect.origin.y + rect.size.height + 64;
        ;
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat moveY = 0.0;
            CGFloat xiangjian;
            xiangjian = cellMaxY - ([UIScreen mainScreen].bounds.size.height - KeyboardWillShowHeight - CGRectGetHeight(self.inputBottomView.frame));
            
            if (xiangjian <= 0) {
                moveY = 0;
            }
            
            if (xiangjian > 0 && xiangjian < KeyboardWillShowHeight) {
                moveY = xiangjian;
            }
            
            if (xiangjian >= KeyboardWillShowHeight ) {
                moveY = KeyboardWillShowHeight;
            }
            self.inputBottomView.transform = CGAffineTransformMakeTranslation(0, -KeyboardWillShowHeight);
            self.bottomTableView.transform = CGAffineTransformMakeTranslation(0, -moveY);
        }];

    }
    
    [self performSelector:@selector(freeTranslationMethod) withObject:nil afterDelay:1.0f];

}
//加载datasource
-(void)reloadDataSourceWithNumber:(long)count{
    _dataSource = [[NSMutableArray alloc]init];
    long dataCount = _dataArr.count;
    if (dataCount>=count) {
        long j=0;
        long m=count;
        for (long i=count; i >0; i--) {
            
            [_dataSource insertObject:_dataArr[dataCount-m] atIndex:j];
            m--;
            j++;
        }
    }else{
        for (int i=0; i<_dataArr.count; i++) {
            [_dataSource insertObject:_dataArr[i] atIndex:i];
        }
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSInteger i = indexPath.row;
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *object = self.dataSource[i];
    ChatModel *model = [[ChatModel alloc]init];
    
    if ([object[@"senderID"] isEqualToString:self.senderID]) {
        model.isSender = 1;
    }else{
        model.isSender = 0;
    }
    
    model.senderID = object[@"senderID"];
    model.chatTextContent = object[@"chatTextContent"];
    model.chatContentType = object[@"chatContentType"];
    model.chatPictureURLContent = object[@"chatPictureURLContent"];
    model.messageID            = object[@"messageID"];
    model.sendIdentifier = object[@"sendIdentifier"];
    model.AVtoStringContent = object[@"AVtoStringContent"];
    model.audioSecond = object[@"audioSecond"];
    
    ChatTableViewCell *cell = [[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier Model:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger i = indexPath.row;
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *object = self.dataSource[i];
    ChatModel *model = [[ChatModel alloc]init];
    
    if ([object[@"senderID"] isEqualToString:self.senderID]) {
        model.isSender = 1;
    }else{
        model.isSender = 0;
    }
    
    model.senderID = object[@"senderID"];
    model.chatTextContent = object[@"chatTextContent"];
    model.chatContentType = object[@"chatContentType"];
    model.chatPictureURLContent = object[@"chatPictureURLContent"];
    model.AVtoStringContent = object[@"AVtoStringContent"];
    
    ChatTableViewCell *cell = [[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier Model:model];
    
    return cell.height + 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ChatTableViewCell *cell = [self.bottomTableView cellForRowAtIndexPath:indexPath];
    
    self.currentCellID = cell.messageID;
    NSLog(@"%@------%ld",self.currentCellID,(long)indexPath.row);
    
}

#pragma mark - BaseAudioButtonDelegate

-(void)button:(UIButton *)button BaseTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.isCancelSendRecord = NO;
    self.isZero = NO;
    iFlySpeechRecognizerString = @"";
    
    //宣告一个UITouch的指标来存放事件触发时所撷取到的状态
    UITouch *touch = [[event touchesForView:button] anyObject];
    
    //将XY轴的座标资讯正规化后输出
    NSLog(@"%@",[NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].x]) ;
    NSLog(@"%@",[NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].y]) ;
    
    NSString *currentDateString = [self getCurerentTimeString];
    self.cellMessageID = currentDateString;
    
    self.cwViewController.URLNameString = self.cellMessageID;
    [self.cwViewController getSavePath];
    [self.cwViewController recordButtonClick];
    
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.subBottomView];
    
    if (self.isRecognizer == NO) {
        [self iFlySpeechRecognizerBegin:LANGUAGE_CHINESE];
    }
    
    NSLog(@"ButtonBegan!");
}

-(void)button:(UIButton *)button BaseTouchesCancel:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    NSLog(@"ButtonCancel!");
}

-(void)button:(UIButton *)button BaseTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //宣告一个UITouch的指标来存放事件触发时所撷取到的状态
    UITouch *touch = [[event touchesForView:button] anyObject];
    NSString *xString = [NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].x];
    NSString *yString = [NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].y];
    int x = [xString intValue];
    int y = [yString intValue];
    //将XY轴的座标资讯正规化后输出
    NSLog(@"%d",x) ;
    NSLog(@"%d",y) ;
    
    if (self.bottomView) {
        
        //取消发送View热区
        
        CGFloat leftBorder = (CGRectGetMinX(self.subBottomView.frame) - CGRectGetMinX(self.reportAudioBtn.frame));
        CGFloat rightBorder = (CGRectGetMaxX(self.subBottomView.frame) - CGRectGetMinX(self.reportAudioBtn.frame));
        CGFloat topBorder =  (CGRectGetMinY(self.subBottomView.frame) - (CGRectGetMinY(self.reportAudioBtn.frame) + CGRectGetMinY(self.inputBottomView.frame)));
        CGFloat bottomBorder =  (CGRectGetMaxY(self.subBottomView.frame) - (CGRectGetMinY(self.reportAudioBtn.frame) + CGRectGetMinY(self.inputBottomView.frame)));
        
        
        if (x > leftBorder && x < rightBorder && y > topBorder && y < bottomBorder) {
            
            self.isCancelSendRecord = YES;
            self.subBottomView.backgroundColor = [UIColor greenColor];
            NSLog(@"取消发送语音");
            [self.cwViewController pauseRecordBtnClick];
            
            if (self.isRecognizer == YES) {
                [self iFlySpeechRecognizerStop];
            }
          
            
        }else{
            
            [self.cwViewController goOnRecordBtnClick];
            self.isCancelSendRecord = NO;
            self.subBottomView.backgroundColor = [UIColor redColor];
            
            if (self.isRecognizer == NO) {
                [self iFlySpeechRecognizerBegin:LANGUAGE_CHINESE];
            }
            
            NSLog(@"继续录音");
            
        }
        
        
        
    }
    
    NSLog(@"ButtonMoved!");
}

-(void)button:(UIButton *)button BaseTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //宣告一个UITouch的指标来存放事件触发时所撷取到的状态
    UITouch *touch = [[event touchesForView:button] anyObject];
    
    //将XY轴的座标资讯正规化后输出
    NSLog(@"%@",[NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].x]) ;
    NSLog(@"%@",[NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].y]) ;
    NSLog(@"ButtonEnded!");
    
    
    
    if (self.isCancelSendRecord == YES) {
        
        [self removeRecordPageView];
        
        [self.cwViewController cancelButtonClick];
         self.isZero = YES;
        [self iFlySpeechRecognizerStop];
        iFlySpeechRecognizerString = @"";
        
    }else{
        
        
        [self.cwViewController recordButtonClick];
        [self removeRecordPageView];
        [self iFlySpeechRecognizerStop];
        [self sendRecordAudioWithRecordURLString:self.cellMessageID];
        
      
        self.isZero = YES;
        
        
    }
    
}

-(void)removeRecordPageView{
    
    [self.subBottomView removeFromSuperview];
    [self.bottomView removeFromSuperview];
}

#pragma mark - BaseTableViewDelegate





-(void)tableView:(UITableView *)tableView BaseTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //宣告一个UITouch的指标来存放事件触发时所撷取到的状态
    UITouch *touch = [[event touchesForView:tableView] anyObject];
    [self cancelResignFirstResponder];
    //将XY轴的座标资讯正规化后输出
    NSLog(@"%@",[NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].x]) ;
    NSLog(@"%@",[NSString stringWithFormat:@"%0.0f", [touch locationInView:touch.view].y]) ;
    
    NSLog(@"Began!");
}

-(void)tableView:(UITableView *)tableView BaseTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Enaded!");
}

-(void)tableView:(UITableView *)tableView BaseTouchesCancel:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Cancel!");
}

-(void)tableView:(UITableView *)tableView BaseTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Moved!");
}


#pragma mark - 观察者模式

-(void)keyboardWillShow:(NSNotification *)noti{
   
    self.isKeyboardShow = YES;
    
    NSInteger count = self.dataSource.count;
    CGRect  rect;
    CGFloat   cellMaxY;
    
    if (count != 0) {
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:count - 1 inSection:0];
        rect = [self.bottomTableView rectForRowAtIndexPath:index];
        cellMaxY = rect.origin.y + rect.size.height + 64;
    }else{
        
        cellMaxY = 0;
    }
    
;
    
    
    CGRect keyboardRect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY = keyboardRect.size.height;
    KeyboardWillShowHeight = deltaY;
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        
        CGFloat moveY = 0.0;
        CGFloat xiangjian;
        xiangjian = cellMaxY - ([UIScreen mainScreen].bounds.size.height - deltaY - CGRectGetHeight(self.inputBottomView.frame));
        
        if (xiangjian <= 0) {
            moveY = 0;
        }
        
        if (xiangjian > 0 && xiangjian < deltaY) {
            moveY = xiangjian;
        }
        
        if (xiangjian >= deltaY ) {
            moveY = deltaY;
        }
        self.inputBottomView.transform = CGAffineTransformMakeTranslation(0, -deltaY);
        self.bottomTableView.transform = CGAffineTransformMakeTranslation(0, -moveY);
    }];
    
    if (count != 0) {
        NSIndexPath *ndex = [NSIndexPath indexPathForRow:ascCount - 1 inSection:0];
        [self.bottomTableView scrollToRowAtIndexPath:ndex atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
}
-(void)keyboardWillHide:(NSNotification *)noti{
    
    self.isKeyboardShow = NO;
    
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.inputBottomView.transform = CGAffineTransformIdentity;
        self.bottomTableView.transform = CGAffineTransformIdentity;
    }];
    
}


#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    
    NSLog(@"变了");
    if ([self.inputTextView.text isEqualToString:@""] || self.inputTextView.text == nil) {
        
         [self.sendMessageBtn removeFromSuperview];
        
    }else{
        
        [self.inputBottomView addSubview:self.sendMessageBtn];
        
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
       
        //发送消息！！！！！！
        [self sendTextMessageMethodWithString:textView.text];
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    //开始输入聊天信息
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    //结束输入聊天信息
}

#pragma mark - 私有方法


-(NSArray *)getData{
    
    NSArray *arr= @[
                    @{@"senderID":@"0001",@"chatTextContent":@"你好韦富钟",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0002",@"chatTextContent":@"这段文字要很长很长，因为我要测试他能不能多换几行",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0001",@"chatTextContent":@"这段儿短点",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0002",@"chatTextContent":@"嗯哼",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0001",@"chatTextContent":@"发几个表情符号～～～～～～～～ － 。－",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0001",@"chatTextContent":@"你好韦富钟",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0002",@"chatTextContent":@"这段文字要很长很长，因为我要测试他能不能多换几行",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0001",@"chatTextContent":@"这段儿短点",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0002",@"chatTextContent":@"嗯哼",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0001",@"chatTextContent":@"发几个表情符号～～～～～～～～ － 。－",@"chatContentType":@"text",@"chatPictureURLContent":@""},      @{@"senderID":@"0001",@"chatTextContent":@"你好韦富钟",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0002",@"chatTextContent":@"这段文字要很长很长，因为我要测试他能不能多换几行",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0001",@"chatTextContent":@"这段儿短点",@"chatContentType":@"text",@"chatPictureURLContent":@""},
                    @{@"senderID":@"0002",@"chatTextContent":@"嗯哼",@"chatContentType":@"text",@"chatPictureURLContent":@"",@"sendIdentifier":@"FREETRANS"},
                    @{@"senderID":@"0002",@"chatTextContent":@"发几个表情符号～～～～～～～～ － 。－",@"chatContentType":@"audio",@"chatPictureURLContent":@"",@"messageID":@"123",@"AVtoStringContent":@"这段文字要很长很长，因为我要测试他能不能多测试他能不能多测试他能不能多测试他能不能多测试他能不能多换几行",@"audioSecond":@"3fs"}
                    ];
    return arr;
}


- (void)AddTapGestureRecognizer{
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelResignFirstResponder)];
    
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired=1;
    tapGesture.numberOfTouchesRequired=1;
//    [self.bottomTableView addGestureRecognizer:tapGesture];
    
}

- (void)cancelResignFirstResponder{
    
    [self.inputTextView resignFirstResponder];
    
}


#pragma mark - 响应事件

-(void)refreshView:(UIRefreshControl *)refresh{
    
    [self reloadDataSourceWithNumber:ascCount+10];
    [self.bottomTableView reloadData];
    
    [refresh endRefreshing];

}

-(void)sendAudioInfoClick{
    
//    NSLog(@"发送语音");
}

-(void)benginRecordAudio{
    
    NSLog(@"开始录音");
    
}

-(void)TouchDragExitClickWithEvent:(UIEvent *)event{
    
    NSLog(@"asdasda");
    
}

-(void)changeSendContentClick{
    
    if (self.changeSendContentBtn.tag == 1001) {
        //输入转语音
        [self.inputBottomView addSubview:self.reportAudioBtn];
        [self cancelResignFirstResponder];
        self.changeSendContentBtn.tag = 1002;
        [self.changeSendContentBtn setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
    }else{
        //语音转输入
        self.changeSendContentBtn.tag = 1001;
        [self.changeSendContentBtn setImage:[UIImage imageNamed:@"yuyin"] forState:UIControlStateNormal];
        [self.reportAudioBtn removeFromSuperview];
    }
}

-(void)selectLangueageClick{
    
    [self cancelResignFirstResponder];
    NSLog(@"跳转到新的切换语言页面");
}

-(void)sendMessageBtnClick{
    
    [self sendTextMessageMethodWithString:self.inputTextView.text];
    NSLog(@"发送消息");
}

#pragma mark - getters

-(BaseTableView *)bottomTableView{
    if (!_bottomTableView) {
        _bottomTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(self.inputBottomView.frame) - 64) style:UITableViewStylePlain];
        _bottomTableView.backgroundColor = [UIColor orangeColor];
        _bottomTableView.idelegate = self;
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        [_bottomTableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:@"Cell"];
        _bottomTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _bottomTableView.allowsSelection = YES;
        _bottomTableView.showsVerticalScrollIndicator = YES;
        _bottomTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_bottomTableView addSubview:self.refreshController];
        
        
        
    }
    return _bottomTableView;
}

-(UIView *)inputBottomView{
    if (!_inputBottomView) {
        _inputBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHight*0.915, kScreenWidth, kScreenHight*0.085)];
        
        _inputBottomView.backgroundColor  = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f  blue:240.0f/255.0f  alpha:1];
    }
    
    return _inputBottomView;
}

-(UIButton *)changeSendContentBtn{
    
    if (!_changeSendContentBtn) {
        _changeSendContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeSendContentBtn.frame = CGRectMake(kScreenWidth*0.04, kScreenWidth*0.03, kScreenWidth*0.1, kScreenWidth*0.085);
        [_changeSendContentBtn setImage:[UIImage imageNamed:@"yuyin"] forState:UIControlStateNormal];
        [_changeSendContentBtn addTarget:self action:@selector(changeSendContentClick) forControlEvents:UIControlEventTouchUpInside];
        _changeSendContentBtn.tag = 1001;//展示语音图片，点击切换成语音模式；
    }
    return _changeSendContentBtn;
    
}

-(UIButton *)selectLangueageBtn{
    
    if (!_selectLangueageBtn) {
        _selectLangueageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectLangueageBtn.frame = CGRectMake(kScreenWidth*0.82, kScreenWidth*0.03, kScreenWidth*0.14, kScreenWidth*0.085);
        [_selectLangueageBtn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        [_selectLangueageBtn addTarget:self action:@selector(selectLangueageClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectLangueageBtn;
}

-(UITextView *)inputTextView{
    
    if (!_inputTextView) {
        _inputTextView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.changeSendContentBtn.frame) + 8,  kScreenWidth*0.03, CGRectGetMinX(self.selectLangueageBtn.frame) - 8 - (CGRectGetMaxX(self.changeSendContentBtn.frame) + 8),  kScreenWidth*0.085)];
        _inputTextView.backgroundColor = [UIColor whiteColor];
        _inputTextView.keyboardType = UIKeyboardTypeDefault;
        _inputTextView.returnKeyType = UIReturnKeySend;
        _inputTextView.scrollEnabled = YES;
        _inputTextView.delegate = self;
    }
    return _inputTextView;
}

-(BaseAudioButton *)reportAudioBtn{
    
    if (!_reportAudioBtn) {
        _reportAudioBtn = [BaseAudioButton buttonWithType:UIButtonTypeCustom];
        _reportAudioBtn.mdelegate = self;
        _reportAudioBtn.frame = CGRectMake(CGRectGetMaxX(self.changeSendContentBtn.frame) + 8,  kScreenWidth*0.03, CGRectGetMinX(self.selectLangueageBtn.frame) - 8 - (CGRectGetMaxX(self.changeSendContentBtn.frame) + 8),  kScreenWidth*0.085);
        //        _reportAudioBtn.backgroundColor = [UIColor lightGrayColor];
        //        [_reportAudioBtn setTitle:@"按住说话" forState:UIControlStateNormal];
        [_reportAudioBtn setImage:[UIImage imageNamed:@"say"] forState:UIControlStateNormal];
        [_reportAudioBtn addTarget:self action:@selector(sendAudioInfoClick) forControlEvents:UIControlEventTouchUpInside];
        [_reportAudioBtn addTarget:self action:@selector(benginRecordAudio) forControlEvents:UIControlEventTouchDown];
        
        [_reportAudioBtn addTarget:self action:@selector(TouchDragExitClickWithEvent:) forControlEvents:UIControlEventTouchDragExit];
    }
    return _reportAudioBtn;
}

-(UIButton *)sendMessageBtn{
    
    if (!_sendMessageBtn) {
        _sendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendMessageBtn.frame = CGRectMake( CGRectGetMaxX(self.inputTextView.frame) - 35,  kScreenWidth*0.031,kScreenWidth*0.078,kScreenWidth*0.078);
        _sendMessageBtn.backgroundColor = [UIColor grayColor];
        [_sendMessageBtn setImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
        _sendMessageBtn.layer.cornerRadius = 15;
        _sendMessageBtn.layer.masksToBounds = YES;
        [_sendMessageBtn addTarget:self action:@selector(sendMessageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendMessageBtn;
}

-(UIRefreshControl *)refreshController{
    
    if (!_refreshController) {
        
        _refreshController = [[UIRefreshControl alloc]init];
        [_refreshController addTarget:self
                            action:@selector(refreshView:)
                  forControlEvents:UIControlEventValueChanged];
        [_refreshController setAttributedTitle:[[NSAttributedString alloc] initWithString:@"加载更多数据。。"]];
    }
 
    return _refreshController;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = 0.4;
        _bottomView.userInteractionEnabled = NO;
    }
    
    return _bottomView;
}

-(UIView *)subBottomView{
    
    if (!_subBottomView) {
        _subBottomView = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 200)/2, ([UIScreen mainScreen].bounds.size.height - 150)/2, 200, 150)];
        _subBottomView.backgroundColor = [UIColor redColor];
        _subBottomView.userInteractionEnabled = NO;
    }
    
    return _subBottomView;
    
}

@end










