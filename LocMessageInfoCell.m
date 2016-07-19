//
//  LocMessageInfoCell.m
//  travel
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "LocMessageInfoCell.h"
@interface LocMessageInfoCell()

@end

@implementation LocMessageInfoCell

-(void)setCellData:(LocationPlaceModel *)locationPlaceName locFrameInfo:(LocCellFrameInfo *)locFrameInfo
{
    self.locationPlaceName = locationPlaceName;
    self.locFrameInfo = locFrameInfo;
    
    self.LocationPlaceLabel.text = self.locationPlaceName.locationPlaceName;
    
    [self layoutIfNeeded];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.LocationPlaceLabel.frame = self.locFrameInfo.locationPlaceLabelFrame;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
