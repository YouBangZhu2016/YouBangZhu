//
//  ViewController.h
//  travel
//
//  Created by sks on 16/7/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PlaceNameModel.h"
#import "SelectedCellFrameInfo.h"
#import "SelectedMessageInfoCell.h"
#import "LocationPlaceModel.h"
#import "LocCellFrameInfo.h"
#import "LocMessageInfoCell.h"

@interface LocationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic, strong) UITableView *mainTabelView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *locArray;
@property (nonatomic, strong) UILabel *locationLabel ;
@property (nonatomic, strong) PlaceNameModel *place;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, assign) CLLocationDegrees latitudeText;
@property (nonatomic, assign) CLLocationDegrees longitudeText;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;


@end

