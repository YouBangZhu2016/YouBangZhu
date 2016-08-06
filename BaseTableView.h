//
//  BaseTableView.h
//  CharttingController
//
//  Created by tjufe on 16/7/11.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BaseTableViewDelegate <NSObject>

@optional
-(void)tableView:(UITableView *)tableView BaseTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)tableView:(UITableView *)tableView BaseTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)tableView:(UITableView *)tableView BaseTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)tableView:(UITableView *)tableView BaseTouchesCancel:(NSSet *)touches withEvent:(UIEvent *)event;


@end

@interface BaseTableView : UITableView

@property(nonatomic,weak) id <BaseTableViewDelegate> idelegate;

@end
