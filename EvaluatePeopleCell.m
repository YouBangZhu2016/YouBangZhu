//
//  EvaluatePeopleCell.m
//  EvaluatePeole
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import "EvaluatePeopleCell.h"
#import "GTStarsScore.h"
#import "AFNetworking.h"
#import "APIClient.h"
#import "WebAgent.h"
#import "FeedBackViewController.h"
#import "complaintViewController.h"

@interface EvaluatePeopleCell ()<GTStarsScoreDelegate>


@property (nonatomic , strong) PeoPle *people;
@property (nonatomic , strong) CellFrameInfo *frameInfo;
@end

@implementation EvaluatePeopleCell



- (void)starsScore:(GTStarsScore *)starsScore valueChange:(CGFloat)value
{
}

- (void)setCellData:(PeoPle *)people
          frameInfo:(CellFrameInfo *)frameInfo
{
    self.starsScore_20 = [[GTStarsScore alloc]initWithFrame:CGRectMake(3, 5, 0, 20)];
    self.starsScore_20.delegate = self;
    self.people = people;
    self.frameInfo = frameInfo;
    [self.avaterImageView addSubview:self.people.avaterImageName];
    self.nickNameLable.text = self.people.nickName;
    
    UIImage *backImage = [UIImage imageNamed:@"starBackground"];
    self.gradeView.layer.contents =(id)backImage.CGImage;
    
    [self.gradeView addSubview:self.starsScore_20];
    [self.complaintButton setTitle:self.people.complaint forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //[self sendStarValue];
    
    self.avaterImageView.frame = self.frameInfo.avaterImageViweFrame;
    self.nickNameLable.frame = self.frameInfo.nickNameLabelFrame;
    self.gradeView.frame = self.frameInfo.gradeViewFrame;
    self.complaintButton.frame = self.frameInfo.complaintButtonFrame;
}

@end
