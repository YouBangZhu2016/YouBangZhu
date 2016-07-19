//
//  EvaluatePeopleCell.m
//  EvaluatePeole
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import "EvaluatePeopleCell.h"
#import "GTStarsScore.h"

@interface EvaluatePeopleCell ()<GTStarsScoreDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avaterImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UILabel *gradeLable;
@property (weak, nonatomic) IBOutlet UIButton *complaintButton;


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
   GTStarsScore *starsScore_20 = [[GTStarsScore alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
    starsScore_20.delegate = self;
    self.people = people;
    self.frameInfo = frameInfo;
    [self.avaterImageView addSubview:self.people.avaterImageName];
    self.nickNameLable.text = self.people.nickName;
    //[self.gradeLable addSubview:self.people.grade];
    self.gradeLable.backgroundColor = [UIColor grayColor];
    [self.gradeLable addSubview:starsScore_20];
    [self.complaintButton setTitle:self.people.complaint forState:UIControlStateNormal];
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.avaterImageView.frame = self.frameInfo.avaterImageViweFrame;
    self.nickNameLable.frame = self.frameInfo.nickNameLabelFrame;
    self.gradeLable.frame = self.frameInfo.gradeLabelFrame;
    self.complaintButton.frame = self.frameInfo.complaintButtonFrame;
}

@end
