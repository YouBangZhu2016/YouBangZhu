//
//  MessageInfoCell.h
//  travel
//
//  Created by sks on 16/7/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedCellFrameInfo.h"
#import "PlaceNameModel.h"

@interface SelectedMessageInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;

@property (nonatomic, strong) PlaceNameModel *placeName;
@property (nonatomic, strong) SelectedCellFrameInfo *frameInfo;

-(void)setCellData:(PlaceNameModel *)placeName frameInfo:(SelectedCellFrameInfo *)frameInfo;


@end
