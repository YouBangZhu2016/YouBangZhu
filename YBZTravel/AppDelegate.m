//
//  AppDelegate.m
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "AppDelegate.h"
#import "YBZRootViewController.h"
#import "iflyMSC/IFlyMSC.h"
#import <RongIMLib/RongIMLib.h>
#import "FreeTransViewController.h"
#import "JPUSHService.h"
#import "YBZTranslatorAnswerViewController.h"
#import "WebAgent.h"

#define Trans_YingYu    @"en"
#define Voice_YingYu    @"en-GB"

@interface AppDelegate ()
@property(nonatomic,assign) NSString* isLogin;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
///远程推送！！！千万不能动⬇️
    
    
    
    NSString *advertisingId = nil;
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    //Required
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"c0797bfbe63d9b86f59b7de6"
                          channel:@"Publish channel"
                 apsForProduction:false
            advertisingIdentifier:advertisingId];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerAliasAndTag) name:kJPFNetworkDidLoginNotification object:nil];
    
    
    
    
///远程推送⬆️！！！！！！
//    FreeTransViewController  *freeVC = [[FreeTransViewController alloc]initWithUserID:@"001" WithTargetID:@"001" WithUserIdentifier:@"TRANSTOR" WithVoiceLanguage:Voice_YingYu WithTransLanguage:Trans_YingYu];
    
    //
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    YBZRootViewController *rootVC = [[YBZRootViewController alloc]init];
    self.window.rootViewController = rootVC;
    
    
    //讯飞!!!!!!!!!!!!!!(勿动！)
    NSString *appid = @"56e695e6";
    NSString *initString = [NSString stringWithFormat:@"appid=%@",appid];
    [IFlySpeechUtility createUtility:initString];
    
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"ChatHisTory"] == nil) {
        
        NSUserDefaults *userDfault = [NSUserDefaults standardUserDefaults];
        NSMutableArray *mutableARR = [NSMutableArray array];
        [userDfault setObject:mutableARR forKey:@"ChatHisTory"];
        [userDfault synchronize];
        
    }
    
    
    return YES;
}


#pragma mark -  远程推送！！


-(void)registerAliasAndTag{
    
    //可变
//    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//    NSString *userID = [userdefault objectForKey:@"user_id"];
//    if (userID != nil && ![userID isEqualToString:@""]) {
//        [JPUSHService setTags:nil alias:userID fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
//            NSLog(@"isrescode----%d, itags------%@,ialias--------%@",iResCode,iTags,iAlias);
//        }];
//    }
    
    
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *userID = [userdefault objectForKey:@"user_id"];
    if(userID == NULL){}
    else
    {
    [WebAgent userLoginState:userID[@"user_id"] success:^(id responseObject) {
        NSData *data = [[NSData alloc]initWithData:responseObject];
        NSDictionary *str= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.isLogin = str[@"state"];
        NSLog(@"%@",self.isLogin);
        if ([self.isLogin  isEqual: @"1"])
        {
            [JPUSHService setTags:nil alias:userID[@"user_id"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias)
             {
                 
                 NSLog(@"isrescode----%d, itags------%@,ialias--------%@",iResCode,iTags,iAlias);
             }];
            
            
        }
        
    }
            failure:^(NSError *error) {
                NSLog(@"this is 2222222 failure%@",error);
            }];
    }
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    application.applicationIconBadgeNumber = (NSInteger)0;
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    application.applicationIconBadgeNumber = (NSInteger)0;
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSString *yonghuID = [userInfo valueForKey:@"user_id"];
    NSString *language_catgory = [userInfo valueForKey:@"language_catgory"];
    NSString *pay_number = [userInfo valueForKey:@"pay_number"];
    
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    
    if ([content isEqualToString:@"匹配成功"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"beginChatWithTranslator" object:@{@"translatorID":yonghuID,@"language_catgory":language_catgory,@"pay_number":pay_number}];
        
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"接收到新的翻译任务！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
              [[NSNotificationCenter defaultCenter]postNotificationName:@"recieveARemoteRequire" object:@{@"yonghuID":yonghuID,@"language_catgory":language_catgory,@"pay_number":pay_number}];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"算了吧" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        [alertVC addAction:okAction];
        [self.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
      
    }
    
    

//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
//    NSLog(@"asasaasdasd%@",userInfo);
//    // 取得Extras字段内容
//    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
//    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,(long)badge,sound,customizeField1);
    
    
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}





#pragma mark - 系统Appdelegate
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
