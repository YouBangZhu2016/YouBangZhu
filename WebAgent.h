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
@end
