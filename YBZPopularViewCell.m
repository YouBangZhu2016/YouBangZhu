//
//  YBZPopularViewCell.m
//  YBZTravel
//
//  Created by 孟宪璞 on 16/7/8.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZPopularViewCell.h"
#import "YBZPopularFrameInfo.h"

@interface YBZPopularViewCell()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>



@property (nonatomic , strong) YBZPopularFrameInfo *info;


@end

@implementation YBZPopularViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //标题
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    //时间
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = UIColorFromRGB(0x888888);
    //正文内容
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.textColor = UIColorFromRGB(0x888888);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    
    
    self.cellBottomView.frame = CGRectMake(18, 5, UIScreenWidth - 36, 80);
    _cellBottomView.backgroundColor = [UIColor colorWithRed:56 / 255.0 green:53 / 255.0 blue:78 / 255.0 alpha:0.9];
    _cellBottomView.layer.cornerRadius =  5;
    
    
    self.titleLabel.frame = CGRectMake(11, 6, CGRectGetMaxX(self.cellBottomView.frame) / 2 + 10, 18);
    //_titleLabel.backgroundColor = [UIColor yellowColor];
    [_titleLabel setTextColor:[UIColor yellowColor]];
    
    
    self.levelLabel.frame = CGRectMake(CGRectGetWidth(self.cellBottomView.frame) - 109, 8.5, 60, 12);
    //_levelLabel.backgroundColor = [UIColor yellowColor];
    [_levelLabel setTextColor:[UIColor whiteColor]];
    
    
    self.stateLabel.frame = CGRectMake(CGRectGetWidth(self.cellBottomView.frame) - 47, 8.5, 36, 12);
    //_stateLabel.backgroundColor = [UIColor yellowColor];
    [_stateLabel setTextColor:[UIColor whiteColor]];
    
    
    self.contentLabel.frame = CGRectMake(11, CGRectGetMaxY(self.titleLabel.frame) + 2, CGRectGetWidth(self.cellBottomView.frame) - 44 , 32);
    //_contentLabel.backgroundColor = [UIColor yellowColor];
    [_contentLabel setTextColor:[UIColor whiteColor]];
    _contentLabel.numberOfLines = 0;
    
    
    
    self.timeLabel.frame = CGRectMake(11, CGRectGetMaxY(self.contentLabel.frame) + 2, UIScreenWidth / 2 - 29 , 15);
    //_timeLabel.backgroundColor = [UIColor yellowColor];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    
    
    self.payLabel.frame = CGRectMake(CGRectGetWidth(self.cellBottomView.frame) / 2, CGRectGetMaxY(self.contentLabel.frame) + 2, CGRectGetWidth(self.cellBottomView.frame) / 2 - 11, 15);
    //_payLabel.backgroundColor = [UIColor greenColor];
    [_payLabel setTextColor:[UIColor whiteColor]];
    
    //
    self.allInfoBtn.frame = CGRectMake(CGRectGetWidth(self.cellBottomView.frame) - 31, CGRectGetMaxY(self.titleLabel.frame) + 2, 20, 32);
    //_allInfoBtn.backgroundColor = [UIColor greenColor];
    [_allInfoBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
}



//+ (instancetype)initWithTitle:(NSString *)title AndLevel:(NSString *)level AndState:(NSString *)state AndContent:(NSString *)content{
//    
//    YBZPopularViewCell *popularView = [[YBZPopularViewCell alloc]initWithTitle:title AndLevel:level AndState:state AndContent:content];
//    
//    return popularView;
//}

@end
