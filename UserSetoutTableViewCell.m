//
//  UserSetoutTableViewCell.m
//  YBZHelper
//
//  Created by guozhiwei on 16/7/14.
//  Copyright © 2016年 guozhiwei. All rights reserved.
//

#import "UserSetoutTableViewCell.h"

@implementation UserSetoutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.textAlignment = NSTextAlignmentCenter;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

@end