//
//  EvaluatePeopleCell.h
//  Evaluate
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellFrameInfo.h"
#import "PeoPle.h"

@interface EvaluatePeopleCell : UITableViewCell
@property (nonatomic , assign ) CGFloat starValue;
@property (weak, nonatomic) IBOutlet UIImageView *avaterImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UIView *gradeView;
@property (weak, nonatomic) IBOutlet UIButton *complaintButton;
@property (nonatomic , strong) GTStarsScore *starsScore_20;

- (void)setCellData:(PeoPle *)people
          frameInfo:(CellFrameInfo *)frameInfo;

- (void)starsScore:(GTStarsScore *)starsScore valueChange:(CGFloat)value;
@end
