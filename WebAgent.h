//
//  WebAgent.h
//  WebServer
//
//  Created by tjufe on 16/7/22.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebAgent : NSObject


+(void)userid:(NSString *)user_id
         usernickname:(NSString *)user_nickname
         usersex:(NSString *)user_sex
         userbirth:(NSString *)user_birth
         userdistrict:(NSString *)user_district
         usersignature:(NSString *)user_signature
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure;

+(void)userid:(NSString *)user_id
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure;

//Protocol
+(void)version_numProtocol:(NSString *)version_num
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

//About
+(void)version_numAbout:(NSString *)version_num
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure;

//Help
+(void)user_id:(NSString *)user_id
user_feedbackinfo:(NSString *)user_feedbackinfo
feedbackinfo_time:(NSString *)feedbackinfo_time
    user_phone:(NSString *)user_phone
    user_email:(NSString *)user_email
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;

//lxx
+(void)userGetInfo:(NSString *)userId
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;

//lzy
+(void)translator_id:(NSString *)translator_id
         valuator_id:(NSString *)valuator_id
   evaluate_infostar:(NSString *)evaluate_infostar
   evaluate_infotext:(NSString *)evaluate_infotext
       evaluate_time:(NSString *)evaluate_time
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure;

+(void)user_id:(NSString *)user_id
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;
//验证登录
+(void)userLoginState:(NSString *)userID

              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure;
//登陆
+(void)userLogin:(NSString *)userPhone
         userPsw:(NSString *)userPsw
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure;
//退出登录
+(void)userLogout:(NSString *)userID
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;
//注册
+(void)userPhone:(NSString *)userPhone
         userPsw:(NSString *)userPsw
        userName:(NSString *)userName
          userID:(NSString *)userID
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure;
//找回密码
+(void)userPhone:(NSString *)userPhone
         userPsw:(NSString *)userPsw
          userID:(NSString *)userID
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure;
//检验是否已经注册
+(void)userPhone:(NSString *)userPhone
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure;
//选择语言
+(void)selectLanguage:(NSString *)languageKind
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure;
//轮播图图片
+(void)addScrollViewImage:(NSString *)turnPictureID
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;
//更改邮箱
+(void)userId:(NSString *)user_id userEmail:(NSString *)user_email accountstate:(NSString *)account_state success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure;

//账号保护状态
+(void)userId:(NSString *)user_id success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure;


//查找译员所会语种,匹配译员，返回所有译员ID，（发送推送用）
+(void)matchTranslatorWithchooseLanguage:(NSString *)choose_language
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *error))failure;
//查询用户口语即时请求状态。（匹配译员用）
+(void)interpreterStateWithuserId:(NSString *)user_id
                          success:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;

//口语即时，发送远程推送APNS
+(void)sendRemoteNotificationsWithuseId:(NSString *)user_id
                        WithsendMessage:(NSString *)send_message
                    WithlanguageCatgory:(NSString *)language_catgory
                          WithpayNumber:(NSString *)pay_number
                           WithSenderID:(NSString *)sender_id
                                success:(void (^)(id responseObject))success
                                failure:(void (^)(NSError *error))failure;
//语言
+(void)userIdentity:(NSString *)userIdentity
       userLanguage:(NSString *)userLanguage
             userID:(NSString *)userID
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;

//*******************************************************************//
//发布悬赏
+(void)sendRewardRewardID:(NSString *)rewardID
              rewardTitle:(NSString *)rewardTitle
               rewardText:(NSString *)rewardText
                rewardUrl:(NSString *)rewardUrl
              rewardMoney:(NSString *)rewardMoney
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

//获取热门标签
+(void)getLabelInfo:(NSString *)labelId
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;





@end
