//
//  UIView+Extention.h
//  OCComponent_master
//
//  Created by 赵国腾 on 16/5/20.
//  Copyright © 2016年 赵国腾. All rights reserved.
//

#import <UIKit/UIKit.h>


// 视图frame相关
@interface UIView (frame)

/** 最小的x */
@property (nonatomic, assign) CGFloat gt_minX;

/** 最小的y */
@property (nonatomic, assign) CGFloat gt_minY;

/** centerX */
@property (nonatomic, assign) CGFloat gt_midX;

/** centerY */
@property (nonatomic, assign) CGFloat gt_midY;

/** 最大的x */
@property (nonatomic, assign) CGFloat gt_maxX;

/** 最大的y */
@property (nonatomic, assign) CGFloat gt_maxY;

/** view的宽度 */
@property (nonatomic, assign) CGFloat gt_width;

/** view的高度 */
@property (nonatomic, assign) CGFloat gt_height;

/** size */
@property (nonatomic, assign) CGSize gt_size;

/** origin */
@property (nonatomic, assign) CGPoint gt_origin;

///** 屏幕宽度 */
//@property (nonatomic, assign) CGFloat gt_screenW;
//
///** 屏幕高度 */
//@property (nonatomic, assign) CGFloat gt_screenH;

@end


@interface UIView (image)

/**
 *  获取视图的截图
 *
 *  @return 截图
 */
- (UIImage *)imageByViewshots;

@end



@interface UIView (responder)

/**
 *  获取视图的控制器
 *
 *  @return 控制器
 */
- (UIViewController *)viewController;

@end


















