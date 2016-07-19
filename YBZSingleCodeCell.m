//
//  YBZSingleCodeCell.m
//  YBZTravel
//
//  Created by tjufe on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZSingleCodeCell.h"

@interface YBZSingleCodeCell()

@end
@implementation YBZSingleCodeCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.codeLabel];
        [self.contentView addSubview:self.codeLabelBtn];
    }
    
    return self;
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
}
#pragma mark - getter
- (UILabel *)codeLabel{
    
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, [UIScreen mainScreen].bounds.size.width, 44)];
        _codeLabel.font = [UIFont systemFontOfSize:16];
        _codeLabel.backgroundColor = [UIColor whiteColor];
        _codeLabel.textColor = [UIColor blackColor];
    }
    return _codeLabel;
}

- (UIButton *)codeLabelBtn{
    
    if (!_codeLabelBtn) {
        _codeLabelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        
    }
    return _codeLabelBtn;
}
@end
