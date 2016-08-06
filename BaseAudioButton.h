//
//  BaseAudioButton.h
//  CharttingController
//
//  Created by tjufe on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseAudioButtonDelegate <NSObject>

@optional

-(void)button:(UIButton *)button BaseTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)button:(UIButton *)button BaseTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)button:(UIButton *)button BaseTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)button:(UIButton *)button BaseTouchesCancel:(NSSet *)touches withEvent:(UIEvent *)event;


@end

@interface BaseAudioButton : UIButton

@property(nonatomic,strong) id <BaseAudioButtonDelegate> mdelegate;

@end
