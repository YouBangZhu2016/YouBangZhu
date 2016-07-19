//
//  PickAvatarImage.m
//  UIImagePickerContrlllerTest
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 AlexianAnn. All rights reserved.
//

#import "PickAvatarImage.h"

@interface PickAvatarImage()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong,nonatomic) UIImage *image;
@property (strong,nonatomic) NSURL *movieURL;
@property (copy,nonatomic) NSString *lastChosenMediaType;

@end

@implementation PickAvatarImage


-(void)createActionSheetWithView{

    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"本机相册",nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.selfController.view];
    
}


#pragma mark -ActionSheet协议
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:{
            [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
            break;
        }
            
        case 1:{
            [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        }
        default:
            break;
    }
    
    
}

#pragma mark -选择媒体类型
-(void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType{
    
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0){
        
        //        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self.selfController presentViewController:picker animated:YES completion:nil];
    }
    else{
        
//        NSLog(@"UUUU");
        
    }
    
}


#pragma mark -裁剪方法
-(UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGFloat originalAspect = original.size.width /original.size.height;
    CGFloat targetAspect = size.width / size.height;
    CGRect targetRect;
    
    
    if(originalAspect > targetAspect){
        //原图片比头像选取框宽
        targetRect.size.width = size.width;
        targetRect.size.height = size.height * targetAspect / originalAspect;
        targetRect.origin.x = 0;
        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
        
    }else if(originalAspect < targetAspect){
        //原图片比头像选取框窄
        targetRect.size.width = size.width * originalAspect / targetAspect;
        targetRect.size.height = size.height;
        targetRect.origin.x = (size.width - targetRect.size.width) * 0.5;
        targetRect.origin.y = 0;
        
    }else{
        //原图片与选取框尺寸相同
        targetRect = CGRectMake(0, 0, size.width, size.height);
        
    }
    
    [original drawInRect:targetRect];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
    
}

#pragma mark -imagePickerController协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage]){
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.image = [self shrinkImage:chosenImage toSize:self.avatarImageView.bounds.size];
        
        
    }else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie]){
        
        self.movieURL = info[UIImagePickerControllerMediaURL];
        
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changePhotoImage" object:nil userInfo:@{@"image":self.image}];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)updateDisplay{
    
    if([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage]){
        
        self.avatarImageView.image = self.image;
        self.avatarImageView.hidden = NO;
        
        
    }
    
}


@end
