

#import <UIKit/UIKit.h>

/** 星星评分视图 */

@protocol GTStarsScoreDelegate;
@interface GTStarsScore : UIView

/** 代理 */
@property (nonatomic, strong) id<GTStarsScoreDelegate> delegate;

/** 分数比例 10分 / 100 = 0.1 */
@property (nonatomic, assign) CGFloat scoreScale;
@property (nonatomic, assign) CGFloat value;

@end

@protocol GTStarsScoreDelegate<NSObject>

- (void)starsScore:(GTStarsScore *)starsScore valueChange:(CGFloat)value;

@end
