//
//  YBZAreaCodeViewController.h
//  YBZTravel
//
//  Created by tjufe on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YBZAreaCodeViewControllerDelegate<NSObject>

-(void)showCode:(NSString *)code;

@end
@interface YBZAreaCodeViewController : UIViewController
@property (nonatomic,assign)id<YBZAreaCodeViewControllerDelegate> delegate;
@end
