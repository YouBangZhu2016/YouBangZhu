//
//  CellFrameInfo.h
//  travel
//
//  Created by sks on 16/7/14.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceNameModel.h"
#import <UIKit/UIKit.h>

@interface SelectedCellFrameInfo : NSObject
@property (nonatomic, assign) CGRect placeNameLabelFrame;
@property (nonatomic, assign) CGRect selectedLabelFrame;
@property (nonatomic, assign) CGFloat cellHeight;


- (instancetype)initWithPlaceName:(PlaceNameModel *)placeName;
@end
