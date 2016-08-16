//
//  SelectPhoto.m
//  Publish
//
//  Created by ydz on 16/8/11.
//  Copyright © 2016年 LLY. All rights reserved.
//

#import "SelectPhoto.h"

@interface SelectPhoto()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong,nonatomic) UIImage *image;
@property (strong,nonatomic) NSURL *movieURL;
@property (copy,nonatomic) NSString *lastChosenMediaType;

@end

@implementation SelectPhoto


-(void)createActionSheetWithView{

    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma mark -选择媒体类型
-(void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType{
    
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self.selfController presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark -imagePickerController协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage]){
        
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.image = chosenImage;
        
    }else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie]){
        
        self.movieURL = info[UIImagePickerControllerMediaURL];
        NSString *pictureUrl = self.movieURL.absoluteString;
[[NSNotificationCenter defaultCenter] postNotificationName:@"sendUrl" object:nil
                                                          userInfo:@{@"url":pictureUrl}];
        
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
