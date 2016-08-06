//
//  BaseAudioButton.m
//  CharttingController
//
//  Created by tjufe on 16/7/12.
//  Copyright © 2016年 tjufe. All rights reserved.
//

#import "BaseAudioButton.h"

@implementation BaseAudioButton


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [super touchesBegan:touches withEvent:event];
    
    
    
    if ([self.mdelegate conformsToProtocol:@protocol(BaseAudioButtonDelegate)] &&
        
        [self.mdelegate respondsToSelector:@selector(button: BaseTouchesBegan: withEvent:)])
        
    {
        
        [self.mdelegate button:self BaseTouchesBegan:touches withEvent:event];
        
    }
    
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [super touchesCancelled:touches withEvent:event];
    
    
    
    if ([self.mdelegate conformsToProtocol:@protocol(BaseAudioButtonDelegate)] &&
        
        [self.mdelegate respondsToSelector:@selector(button:BaseTouchesCancel:withEvent:)])
        
    {
        
        [self.mdelegate button:self BaseTouchesCancel:touches withEvent:event];
        
    }
    
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [super touchesEnded:touches withEvent:event];
    
    
    
    if ([self.mdelegate conformsToProtocol:@protocol(BaseAudioButtonDelegate)] &&
        
        [self.mdelegate respondsToSelector:@selector(button:BaseTouchesEnded:withEvent:)])
        
    {
        
        [self.mdelegate button:self BaseTouchesEnded:touches withEvent:event];
        
    }
    
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [super touchesMoved:touches withEvent:event];
    
    
    
    if ([self.mdelegate conformsToProtocol:@protocol(BaseAudioButtonDelegate)] &&
        
        [self.mdelegate respondsToSelector:@selector(button:BaseTouchesMoved:withEvent:)])
        
    {
        
        [self.mdelegate button:self BaseTouchesMoved:touches withEvent:event];
        
    }
    
}
@end
