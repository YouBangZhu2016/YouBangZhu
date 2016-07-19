//
//  PeoPle.m
//  Evaluate
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import "PeoPle.h"

@implementation PeoPle

- (instancetype)initWitAvaterImageName:(UIImageView *)avaterImageName
                              nickName:(NSString *)nickName
                                 //grade:(GTStarsScore *)grade
                             complaint:(NSString *)complaint
{
    self = [super init];
    if (self) {
        self.avaterImageName = avaterImageName;
        self.nickName = nickName;
        //self.grade = grade;
        self.complaint = complaint;
    }
    return self;
}

@end
