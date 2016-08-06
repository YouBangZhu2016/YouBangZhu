//
//  QuickTransViewController.h
//  CharttingController
//
//  Created by tjufe on 16/7/21.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QuickTransViewController : UIViewController


- (instancetype)initWithUserID:(NSString *)userID WithTargetID:(NSString *)targetID WithUserIdentifier:(NSString *)userIdentifier WithVoiceLanguage:(NSString *)voice_Language WithTransLanguage:(NSString *)trans_Language;

@end
