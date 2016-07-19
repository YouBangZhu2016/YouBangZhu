//
//  LocationPlaceModel.m
//  travel
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "LocationPlaceModel.h"

@implementation LocationPlaceModel

- (instancetype)initWithLocationPlaceName:(NSString *)locationPlaceName
{
    self = [super init];
    if (self) {
        self.locationPlaceName = locationPlaceName;
    }
    return self;
}
@end
