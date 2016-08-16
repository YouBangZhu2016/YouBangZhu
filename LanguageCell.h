//
//  LanguageCell.h
//  Language
//
//  Created by sks on 16/8/10.
//  Copyright © 2016年 liuzhongyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Infor.h"
#import "CellInfor.h"

@interface LanguageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *languageLable;
@property (weak, nonatomic) IBOutlet UIImageView *ensureImage;
@property (nonatomic , strong) Infor *information;


- (void)setCellData:(Infor *)information
          frameInfo:(CellInfor *)cellInformation;


@end
