//
//  PlaceNameModel.h
//  travel
//
//  Created by sks on 16/7/13.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceNameModel : NSObject
@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) NSString *selected;
@property (nonatomic, strong) NSString *locationPlaceName;

- (instancetype)initWithPlaceName:(NSString *)placeName selected:(NSString *)selected;
- (instancetype)initWithLocationPlaceName:(NSString *)locationPlaceName;
@end
