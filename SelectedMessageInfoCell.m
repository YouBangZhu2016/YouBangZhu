//
//  MessageInfoCell.m
//  travel
//
//  Created by sks on 16/7/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "SelectedMessageInfoCell.h"


@interface SelectedMessageInfoCell()

@end
@implementation SelectedMessageInfoCell

-(void)setCellData:(PlaceNameModel *)placeName
         frameInfo:(SelectedCellFrameInfo *)frameInfo
{
    self.placeName = placeName;
    self.frameInfo = frameInfo;
    
    self.placeNameLabel.text = self.placeName.placeName;
    self.selectedLabel.text = self.placeName.selected;
    self.selectedLabel.textColor = [UIColor lightGrayColor];
    self.selectedLabel.hidden = YES;
    
    [self layoutIfNeeded];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeNameLabel.frame = self.frameInfo.placeNameLabelFrame;
    self.selectedLabel.frame = self.frameInfo.selectedLabelFrame;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if(self.selected)
    {
        self.selectedLabel.hidden = NO;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        self.selectedLabel.hidden = YES;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    // Configure the view for the selected state
}

@end
