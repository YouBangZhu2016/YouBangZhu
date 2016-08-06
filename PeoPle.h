//
//  PeoPle.h
//  EvaluatePeole
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GTStarsScore.h"


@interface PeoPle : NSObject

@property (nonatomic , strong) UIImageView *avaterImageName;
@property (nonatomic , strong) NSString *nickName;
@property (nonatomic , assign) CGFloat grade;
@property (nonatomic , strong) NSString *complaint;

- (instancetype)initWitAvaterImageName:(UIImageView *)avaterImageName
                              nickName:(NSString *)nickName
                             complaint:(NSString *)complaint;
@end

