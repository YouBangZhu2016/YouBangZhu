//
//  LocCellFrameInfo.h
//  travel
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceNameModel.h"
#import <UIKit/UIKit.h>

@interface LocCellFrameInfo : NSObject
@property (nonatomic, assign) CGRect imageViewFrame;
@property (nonatomic, assign) CGRect locationPlaceLabelFrame;
@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithLocationPlace:(PlaceNameModel *)locationPlace;
@end
