//
//  NSString+HBWmd5.h
//  StringTranslation
//
//  Created by tjufe on 16/7/16.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (HBWmd5)

+ (NSString *)md5:(NSString *)str;
+(NSString*)encodeString:(NSString*)unencodedString;
- (NSString*) sha1;
@end
