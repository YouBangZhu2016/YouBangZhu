//
//  YBZPopularViewCell.h
//  YBZTravel
//
//  Created by 孟宪璞 on 16/7/8.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBZPopularViewCell : UITableViewCell

//@property (nonatomic , strong) NSString *title;
//@property (nonatomic , strong) NSString *level;
//@property (nonatomic , strong) NSString *state;
//@property (nonatomic , strong) NSString *content;
//@property (nonatomic , strong) NSString *time;
//@property (nonatomic , strong) NSString *pay;
@property (strong, nonatomic) IBOutlet UIView *cellBottomView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *allInfoBtn;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *payLabel;



//- (instancetype)initWithTitle:(NSString *)title AndLevel:(NSString *)level AndState:(NSString *)state AndContent:(NSString *)content;
//+ (instancetype)initWithTitle:(NSString *)title AndLevel:(NSString *)level AndState:(NSString *)state AndContent:(NSString *)content;


@end
