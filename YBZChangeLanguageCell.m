//
//  YBZChangeLanguageCell.m
//  YBZTravel
//
//  Created by 孟宪璞 on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZChangeLanguageCell.h"

@interface YBZChangeLanguageCell()




@end

@implementation YBZChangeLanguageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization codex
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        
    }
    
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews{
    
    
    [super layoutSubviews];
    
    
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, UIScreenWidth, 25)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, UIScreenWidth, 15)];
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}
@end
