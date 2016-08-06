//
//  WebAgent.m
//  WebServer
//
//  Created by tjufe on 16/7/22.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "WebAgent.h"
#import "APIClient.h"
@implementation WebAgent

//上传个人信息
+(void)userid:(NSString *)user_id
   usernickname:(NSString *)user_nickname
        usersex:(NSString *)user_sex
      userbirth:(NSString *)user_birth
   userdistrict:(NSString *)user_district
  usersignature:(NSString *)user_signature
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure
{
    NSDictionary *dict = @{@"newuser_id":user_id,
                           @"newuser_nickname":user_nickname,
                           @"newuser_sex":user_sex,
                           @"newuser_birth":user_birth,
                           @"newuser_district":user_district,
                           @"newuser_signature":user_signature};
    [[APIClient sharedClient] POST:@"User/upload/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

//下拉个人信息
+(void)userid:(NSString *)user_id
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure
{
    NSDictionary *dict = @{@"user_id":user_id};
    [[APIClient sharedClient] POST:@"User/edit/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];

}


//Protocol
+(void)version_numProtocol:(NSString *)version_num
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure
{
    
    
    NSDictionary *dict = @{@"version_num":version_num};
    
    [[APIClient sharedClient] POST:@"User/loginProtocol/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}




//About
+(void)version_numAbout:(NSString *)version_num
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure
{
    
    
    NSDictionary *dict = @{@"version_num":version_num};
    
    
    [[APIClient sharedClient] POST:@"User/loginAbout/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}

//Help
+(void)user_id:(NSString *)user_id
user_feedbackinfo:(NSString *)user_feedbackinfo
feedbackinfo_time:(NSString *)feedbackinfo_time
    user_phone:(NSString *)user_phone
    user_email:(NSString *)user_email
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure
{
    
    
    NSDictionary *dict = @{@"user_id":user_id,
                           @"user_feedbackinfo":user_feedbackinfo,
                           @"feedbackinfo_time":feedbackinfo_time,
                           @"user_phone":user_phone,
                           @"user_email":user_email};
    
    [[APIClient sharedClient] POST:@"User/loginHelp/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}

//lxx
+(void)userGetInfo:(NSString *)userId
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure
{
    NSDictionary *dict = @{@"user_id":userId};
    
    [[APIClient sharedClient] POST:@"User/getUserInfo/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

//lzy
//登录
+(void)translator_id:(NSString *)translator_id
         valuator_id:(NSString *)valuator_id
   evaluate_infostar:(NSString *)evaluate_infostar
   evaluate_infotext:(NSString *)evaluate_infotext
       evaluate_time:(NSString *)evaluate_time
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *dict = @{@"translator_id":translator_id,
                           @"valuator_id":valuator_id,
                           @"evaluate_infostar":evaluate_infostar,
                           @"evaluate_infotext":evaluate_infotext,
                           @"evaluate_time":evaluate_time
                           };
    
    [[APIClient sharedClient] POST:@"User/evaluate/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}

+(void)user_id:(NSString *)user_id
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *dict = @{@"user_id":user_id};
    [[APIClient sharedClient] POST:@"User/edit/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}
//验证登录
+(void)userLoginState:(NSString *)userID

              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *dict = @{@"user_id":userID};
    
    [[APIClient sharedClient] POST:@"User/userloginstate/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}

//登录
+(void)userLogin:(NSString *)userPhone
         userPsw:(NSString *)userPsw
         
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *dict = @{@"user_phone":userPhone,
                           @"user_password":userPsw};
    
    [[APIClient sharedClient] POST:@"User/login/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}
+(void)userLogout:(NSString *)userID
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *dict = @{@"user_id":userID};
    
    [[APIClient sharedClient] POST:@"User/user_logout/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
//注册
+(void)userPhone:(NSString *)userPhone
         userPsw:(NSString *)userPsw
        userName:(NSString *)userName
          userID:(NSString *)userID
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure
{
    NSDictionary *dict = @{@"user_phone":userPhone,
                           @"user_password":userPsw,
                           @"user_name":userName,
                           @"user_id":userID};
    
    [[APIClient sharedClient] POST:@"User/user_register/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}
//找回密码
+(void)userPhone:(NSString *)userPhone
         userPsw:(NSString *)userPsw
          userID:(NSString *)userID
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *dict = @{@"user_phone":userPhone,
                           @"user_password":userPsw,
                           @"user_id":userID};
    
    [[APIClient sharedClient] POST:@"User/user_findKey/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}

//检验此手机号是否注册
+(void)userPhone:(NSString *)userPhone
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *dict = @{@"user_phone":userPhone};
    
    [[APIClient sharedClient] POST:@"User/login/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}

//选择语言
+(void)selectLanguage:(NSString *)languageKind
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *dict = @{@"language_kind":languageKind};
    
    [[APIClient sharedClient] POST:@"User/selectLanguage/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}

//轮播图图片
+(void)addScrollViewImage:(NSString *)turnPictureID
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure
{
    
    NSDictionary *dict = @{@"turnpicture_id":turnPictureID};
    [[APIClient sharedClient] POST:@"User/addScrollViewImage/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
}
//更改邮箱
+(void)userId:(NSString *)user_id userEmail:(NSString *)user_email accountstate:(NSString *)account_state success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *dict = @{@"user_id":user_id,
                           @"user_email":user_email,
                           @"emailState":account_state};
    
    [[APIClient sharedClient] POST:@"User/changeEmail/" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];

}

//账号保护状态
+(void)userId:(NSString *)user_id success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure
{
    NSDictionary *dict = @{@"user_id":user_id};
    [[APIClient sharedClient] POST:@"User/accountState" parameters:dict  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
}
@end