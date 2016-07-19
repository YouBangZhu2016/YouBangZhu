//
//  UserTableViewCell.m
//  YBZTravel
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 dongxin. All rights reserved.
//

#import "UserTableViewCell.h"
#define KGap 10

@implementation UserTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KGap*2,KGap*0.7,KGap*4,KGap*4)];
        [self.contentView addSubview:self.imgView];
 
        _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(KGap*9,KGap*0.7,KGap*20,KGap*4)];
        [self.contentView addSubview:self.nameLable];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    return self;
}
@end
