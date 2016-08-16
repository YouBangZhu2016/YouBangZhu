//
//  SelectPhoto.h
//  Publish
//
//  Created by ydz on 16/8/11.
//  Copyright © 2016年 LLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SelectPhoto : NSObject

@property(nonatomic,strong)UIViewController *selfController;
@property(nonatomic,strong) UIImageView *avatarImageView;

-(void)createActionSheetWithView;
-(void)updateDisplay;


@end
