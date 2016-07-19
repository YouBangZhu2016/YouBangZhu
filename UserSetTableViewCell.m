//
//  UserSetTableViewCell.m
//  YBZHelper
//
//  Created by guozhiwei on 16/7/14.
//  Copyright © 2016年 guozhiwei. All rights reserved.
//

#import "UserSetTableViewCell.h"

@implementation UserSetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the view for the selected state
    
}

@end
