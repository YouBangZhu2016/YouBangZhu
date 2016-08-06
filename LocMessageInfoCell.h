//
//  LocMessageInfoCell.h
//  travel
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocCellFrameInfo.h"
#import "PlaceNameModel.h"

@interface LocMessageInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *LocImageView;
@property (weak, nonatomic) IBOutlet UILabel *LocationPlaceLabel;

@property (nonatomic, strong) PlaceNameModel *locationPlaceName;
@property (nonatomic, strong) LocCellFrameInfo *locFrameInfo;

-(void)setCellData:(PlaceNameModel *)locationPlaceName locFrameInfo:(LocCellFrameInfo *)locFrameInfo;
@end
