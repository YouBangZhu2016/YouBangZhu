//
//  PlaceNameModel.m
//  travel
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "PlaceNameModel.h"

@implementation PlaceNameModel
- (instancetype)initWithPlaceName:(NSString *)placeName selected:(NSString *)selected
{
    self = [super init];
    if (self) {
        self.placeName = placeName;
        self.selected = selected;
    }
    return self;
}

@end
