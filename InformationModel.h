//
//  InformationModel.h
//  LLY_Friend
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 lly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationModel : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *receiveInfo;
@property(nonatomic,strong)NSString *photoName;



- (instancetype)initWithname:(NSString *)name
         receiveInfo:(NSString *)receiveInfo;

- (instancetype)initWithPhotoName:(NSString *)photoName;

@end
