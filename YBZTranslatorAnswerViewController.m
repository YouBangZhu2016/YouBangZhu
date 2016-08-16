//
//  YBZTranslatorAnswerViewController.m
//  YBZTravel
//
//  Created by sks on 16/8/14.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZTranslatorAnswerViewController.h"
#define INTERVAL_KEYBOARD  10
#define kAnimationDuration 0.3f
#define kViewHeight        50

@interface YBZTranslatorAnswerViewController()
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *pictureView;
@property (nonatomic,strong) UIButton *pictureButton;
@property (nonatomic,strong) UIBarButtonItem *backButton;
@property (nonatomic,strong) UIButton *submitButton;
@property (nonatomic,strong) UILabel *placeholderLabel;
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,assign) CGFloat keyboardHeight;
@property (copy,nonatomic) NSString *lastChosenMediaType;
@property (strong,nonatomic) NSURL *movieURL;
@property (strong,nonatomic) UIImage *image;

@end

@implementation YBZTranslatorAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.pictureView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.imageView];
    
    self.navigationItem.leftBarButtonItem = self.backButton;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.submitButton];
    
    //添加键盘的监听事件
    //    //注册通知,监听键盘弹出事件
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - textview
-(UITextView *)textView
{
    if(!_textView)
    {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 100)];
        _textView.delegate = self;
        _textView.scrollEnabled = YES;//当文字超过视图的边框时是否允许滑动，默认为“YES”
        _textView.editable = YES;//是否允许编辑内容，默认为“YES”
        _textView.font = [UIFont systemFontOfSize:16];
        
        self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
        self.placeholderLabel.text = @"请在此处输入您回答的内容...";
        self.placeholderLabel.textColor = [UIColor lightGrayColor];
        self.placeholderLabel.enabled = NO;
        [_textView addSubview:self.placeholderLabel];
        //        _textView.returnKeyType = UIReturnKeyDefault;//return键的类型
        //        _textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
        //        _textView.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
        //        _textView.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    }
    return _textView;
}
#pragma mark - 底部图片
-(UIView *)pictureView
{
    if(!_pictureView)
    {
        _pictureView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2)];
        lineView.backgroundColor = [UIColor colorWithRed:225.0f/255.0 green:225.0f/255.0 blue:225.0f/255.0 alpha:1];
        [_pictureView addSubview:lineView];
        
        UIImageView *choosePicture = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 2 , 50, 48)];
        choosePicture.backgroundColor = [UIColor blueColor];
        UIImage *image = [UIImage imageNamed:@"image"];
        choosePicture.image = image;
        //image点击事件
        [choosePicture setUserInteractionEnabled:YES];
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosePictureClick)];
        [choosePicture addGestureRecognizer:click];
        [_pictureView addSubview:choosePicture];
    }
    return _pictureView;
}
-(void)choosePictureClick
{
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"本机相册",nil];
    //    actionSheet.delegate = self;
    //    [actionSheet showInView:self.view];
    NSLog(@"kai kai kai ");
    self.imageView.hidden = NO;
}
-(UIImageView *)imageView
{
    if(!_imageView)
    {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 400) / 2, ([UIScreen mainScreen].bounds.size.height - 400) / 2, 400, 400)];
        _imageView.hidden = NO;
        _imageView.backgroundColor = [UIColor redColor];
        //image点击事件
        [_imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick)];
        [_imageView addGestureRecognizer:click];
    }
    return _imageView;
}
-(void)imageViewClick
{
    if(self.imageView.hidden == NO)
    {
        self.imageView.hidden = YES;
        NSLog(@"guan gaun guan ");
    }
}
#pragma mark - 取消按钮及点击事件
-(UIBarButtonItem *)backButton
{
    if(!_backButton)
    {
        UIButton *backBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [backBtn setTitle:@"取消" forState:UIControlStateNormal];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _backButton = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    }
    return _backButton;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 提交按钮及点击事件
-(UIButton *)submitButton
{
    if(!_submitButton)
    {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}
-(void)submitClick
{
    NSLog(@"--->>> %@",self.textView.text);
}
//#pragma mark -ActionSheet协议
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    switch (buttonIndex) {
//        case 0:{
//            [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
//            break;
//        }
//
//        case 1:{
//            [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
//            break;
//        }
//        default:
//            break;
//    }
//
//
//}

//#pragma mark -选择媒体类型
//-(void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType{
//
//    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
//    if([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0){
//        //        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
//        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
//        picker.mediaTypes = mediaTypes;
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        picker.sourceType = sourceType;
//        [self.view presentViewController:picker animated:YES completion:nil];
//    }
//    else{
//        //        NSLog(@"UUUU");
//    }
//}

//#pragma mark -imagePickerController协议方法
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//
//    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
//    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage])
//    {
//        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
////        self.image = [self shrinkImage:chosenImage toSize:CGSizeMake(50, 50)];
//        self.image = [self OriginImage:chosenImage scaleToSize:CGSizeMake(50, 50)];
//    }
//    else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie])
//    {
//        self.movieURL = info[UIImagePickerControllerMediaURL];
//    }
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"changePhotoImage" object:nil userInfo:@{@"image":self.image}];
//
//}

//#pragma mark -裁剪方法
//-(UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size{
//
//    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
//    CGFloat originalAspect = original.size.width /original.size.height;
//    CGFloat targetAspect = size.width / size.height;
//    CGRect targetRect;
//
//
//    if(originalAspect > targetAspect){
//        //原图片比头像选取框宽
//        targetRect.size.width = size.width;
//        targetRect.size.height = size.height * targetAspect / originalAspect;
//        targetRect.origin.x = 0;
//        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
//
//    }else if(originalAspect < targetAspect){
//        //原图片比头像选取框窄
//        targetRect.size.width = size.width * originalAspect / targetAspect;
//        targetRect.size.height = size.height;
//        targetRect.origin.x = (size.width - targetRect.size.width) * 0.5;
//        targetRect.origin.y = 0;
//
//    }else{
//        //原图片与选取框尺寸相同
//        targetRect = CGRectMake(0, 0, size.width, size.height);
//
//    }
//
//    [original drawInRect:targetRect];
//    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return finalImage;
//
//}
//
//-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
//{
//    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
//
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//
//    UIGraphicsEndImageContext();
//
//    return scaledImage;   //返回的就是已经改变的图片
//}

-(void)textViewDidChange:(UITextView *)textView
{
    if(self.textView.text.length == 0)
    {
        self.placeholderLabel.text = @"请在此处输入您回答的内容...";
    }
    else
    {
        self.placeholderLabel.text = @"";
    }
}


//键盘弹出时
-(void)keyboardWillShow:(NSNotification *)notification
{
    //当图片显示时，点击输入框、空白或图片本身 图片消失
    if(self.imageView.hidden == NO)
    {
        self.imageView.hidden = YES;
    }
    //获取键盘高度
    CGRect keyboardRect = [[[notification userInfo]objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[notification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey]
                                        doubleValue];
    CGRect frame = self.pictureView.frame;
    frame.origin.y -= keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.pictureView.frame = frame;
    [UIView commitAnimations];
    
}
//键盘消失时
-(void)keyboardWillHide:(NSNotification *)notification
{
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.pictureView.frame;
    frame.origin.y += keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.pictureView.frame = frame;
    [UIView commitAnimations];
    
}
//点击空白 keyboard消失
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //当图片显示时，点击输入框、空白或图片本身 图片消失
    if(self.imageView.hidden == NO)
    {
        self.imageView.hidden = YES;
    }
    [self.textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
