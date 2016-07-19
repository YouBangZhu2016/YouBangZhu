//
//  PickAvatarImage.h
//  UIImagePickerContrlllerTest
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 AlexianAnn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface PickAvatarImage : NSObject

@property(nonatomic,strong) UIViewController *selfController;
@property(nonatomic,strong) UIImageView *avatarImageView;

-(void)createActionSheetWithView;
-(void)updateDisplay;

@end
