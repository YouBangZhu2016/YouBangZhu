//
//  LocationPlaceModel.h
//  travel
//
//  Created by sks on 16/7/15.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationPlaceModel : NSObject
@property (nonatomic, strong) NSString *locationPlaceName;

- (instancetype)initWithLocationPlaceName:(NSString *)locationPlaceName;
@end
