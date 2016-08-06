//
//  BaseTableView.m
//  CharttingController
//
//  Created by tjufe on 16/7/11.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [super touchesBegan:touches withEvent:event];
    
    
    
    if ([self.idelegate conformsToProtocol:@protocol(BaseTableViewDelegate)] &&
        
        [self.idelegate respondsToSelector:@selector(tableView: BaseTouchesBegan: withEvent:)])
        
    {
        
        [self.idelegate tableView:self BaseTouchesBegan:touches withEvent:event];
        
    }
    
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [super touchesCancelled:touches withEvent:event];
    
    
    
    if ([self.idelegate conformsToProtocol:@protocol(BaseTableViewDelegate)] &&
        
        [self.idelegate respondsToSelector:@selector(tableView:BaseTouchesCancel:withEvent:)])
        
    {
        
        [self.idelegate tableView:self BaseTouchesCancel:touches withEvent:event];
        
    }
    
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [super touchesEnded:touches withEvent:event];
    
    
    
    if ([self.idelegate conformsToProtocol:@protocol(BaseTableViewDelegate)] &&
        
        [self.idelegate respondsToSelector:@selector(tableView:BaseTouchesEnded:withEvent:)])
        
    {
        
        [self.idelegate tableView:self BaseTouchesEnded:touches withEvent:event];
        
    }
    
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [super touchesMoved:touches withEvent:event];
    
    
    
    if ([self.idelegate conformsToProtocol:@protocol(BaseTableViewDelegate)] &&
        
        [self.idelegate respondsToSelector:@selector(tableView:BaseTouchesMoved:withEvent:)])
        
    {
        
        [self.idelegate tableView:self BaseTouchesMoved:touches withEvent:event];
        
    }
    
}

@end
