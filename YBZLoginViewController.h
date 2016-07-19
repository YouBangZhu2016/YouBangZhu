//
//  YBZLoginViewController.h
//  YBZTravel
//
//  Created by tjufe on 16/7/7.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "YBZBaseViewController.h"
#import "YBZAreaCodeViewController.h"

@interface YBZLoginViewController : YBZBaseViewController<YBZAreaCodeViewControllerDelegate>

@property   (nonatomic,assign)BOOL isNeedBack;

@end
