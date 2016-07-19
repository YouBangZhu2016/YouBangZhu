//
//  EvaluatePeopleCell.h
//  Evaluate
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellFrameInfo.h"
#import "PeoPle.h"

@interface EvaluatePeopleCell : UITableViewCell

- (void)setCellData:(PeoPle *)people
          frameInfo:(CellFrameInfo *)frameInfo;


@end
