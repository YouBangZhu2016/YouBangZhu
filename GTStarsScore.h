//
//  GTStarsScore.h
//  OCComponent_master
//
//  Created by 赵国腾 on 16/5/26.
//  Copyright © 2016年 赵国腾. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 星星评分视图 */

@protocol GTStarsScoreDelegate;
@interface GTStarsScore : UIView

/** 代理 */
@property (nonatomic, strong) id<GTStarsScoreDelegate> delegate;

/** 分数比例 10分 / 100 = 0.1 */
@property (nonatomic, assign) CGFloat scoreScale;

@end

@protocol GTStarsScoreDelegate<NSObject>

- (void)starsScore:(GTStarsScore *)starsScore valueChange:(CGFloat)value;

@end
