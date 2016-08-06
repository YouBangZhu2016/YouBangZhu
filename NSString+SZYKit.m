//
//  NSString+Random.m
//  GameEmulator
//
//  Created by 孙中原 on 15/10/27.
//  Copyright (c) 2015年 YouXianMing. All rights reserved.
//

#import "NSString+SZYKit.h"
@implementation NSString (SZYKit)

+(NSString *)stringOfUUID{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

@end

