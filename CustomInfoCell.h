//
//  CustomInfoCell.h
//  LLY_Friend
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 lly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellFramInfo.h"
#import "InformationModel.h"

@interface CustomInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *receiveInfoLable;
@property(nonatomic,strong)InformationModel *infoModel;
@property(nonatomic,strong)CellFramInfo *frameInfo;

-(void)setCellData:(InformationModel *)infoModel
          framInfo:(CellFramInfo *)frameInfo;

@end
