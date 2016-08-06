//
//  ViewController.h
//  CharttingController
//
//  Created by tjufe on 16/7/9.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FreeTransViewController : UIViewController

- (instancetype)initWithUserID:(NSString *)userID WithTargetID:(NSString *)targetID WithUserIdentifier:(NSString *)userIdentifier WithVoiceLanguage:(NSString *)voice_Language WithTransLanguage:(NSString *)trans_Language;

@end

