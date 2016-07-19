//
//  InformationModel.m
//  LLY_Friend
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 lly. All rights reserved.
//

#import "InformationModel.h"

@implementation InformationModel

- (instancetype)initWithname:(NSString *)name
         receiveInfo:(NSString *)receiveInfo
{
    self = [super init];
    if (self) {
        self.name = name;
        self.receiveInfo = receiveInfo;
    }
    return self;
}

- (instancetype)initWithPhotoName:(NSString *)photoName
{
    self = [super init];
    if (self) {
        self.photoName = photoName;
    }
    return self;
}
@end
