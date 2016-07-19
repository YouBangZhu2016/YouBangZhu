//
//  CellFramInfo.h
//  LLY_Friend
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 lly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InformationModel.h"
#import <UIKit/UIKit.h>

@interface CellFramInfo : NSObject

@property(nonatomic,assign)CGRect nameLableFrame;
@property(nonatomic,assign)CGRect receiveInfoLableFrame;

- (instancetype)initWithInformationModel:(InformationModel *)infoModel;

@end
