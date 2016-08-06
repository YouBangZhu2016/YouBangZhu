//
//  CustomInfoCell.m
//  LLY_Friend
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 lly. All rights reserved.
//

#import "CustomInfoCell.h"

@interface CustomInfoCell()

@end

@implementation CustomInfoCell


-(void)setCellData:(InformationModel *)infoModel
          framInfo:(CellFramInfo *)frameInfo
{
    self.infoModel = infoModel;
    self.frameInfo = frameInfo;
    self.nameLable.text = self.infoModel.name;
    self.receiveInfoLable.text = self.infoModel.receiveInfo;
    [self layoutIfNeeded];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.nameLable.frame = self.frameInfo.nameLableFrame;
    self.receiveInfoLable.frame = self.frameInfo.receiveInfoLableFrame;
}

@end
