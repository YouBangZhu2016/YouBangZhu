//
//  ViewController.m
//  travel
//
//  Created by sks on 16/7/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "LocationViewController.h"

#define kViewSpace         12


@interface LocationViewController ()

@end

@implementation LocationViewController{

}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationLabel = [[UILabel alloc]init];
    if([CLLocationManager locationServicesEnabled])//服务是否开启
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [self.locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
        }
        [self.locationManager startUpdatingLocation];//开始
    }
    else
    {
        NSLog(@"服务未开启，定位失败 ！");
    }
    self.view.backgroundColor = [UIColor whiteColor];

    //[self loadNavigationController];
    [self loadDataFromWeb];
    [self loadDataFromLocation];
    [self.view addSubview:self.mainTabelView];
    
}

#pragma mark - mainTabelView getters
-(UIView *)mainTabelView
{
    if (!_mainTabelView) {
        self.mainTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
        self.mainTabelView.backgroundColor = [UIColor whiteColor];
        self.mainTabelView.delegate = self;
        self.mainTabelView.dataSource = self;
    }
    return _mainTabelView;
}

#pragma mark - locationManager getters
-(CLLocationManager *)locationManager
{
    if(_locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc]init];//创建位置管理器
        self.locationManager.delegate = self;//设置代理
        self.locationManager.distanceFilter = kCLDistanceFilterNone;//任何移动定位
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;//精度
    }
    return _locationManager;
}
#pragma mark - geocoder getters
-(CLGeocoder *)geocoder
{
    if(_geocoder == nil)
    {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}
#pragma mark - CLLocationManagerDelegate
//当定位到用户的位置时，就会调用（调用的频率比较频繁）
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *loc = [locations firstObject];
    self.latitudeText = loc.coordinate.latitude;
    self.longitudeText = loc.coordinate.longitude;
    [self geocode];
    [self.locationManager stopUpdatingLocation];//停止
}
-(void)geocode
{
    //境外的经纬度不能解析
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:self.latitudeText longitude:self.longitudeText];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array , NSError *error){
        if(error || array.count == 0)
        {
            NSLog(@"失败！");
        }
        else
        {
            CLPlacemark *firstPlacemark = [array firstObject];
            self.locationLabel.text = firstPlacemark.country;
        }
    }];
}
//失误时触发
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
}

#pragma mark - loadDataFromWeb
-(NSArray *)loadDataFromWeb
{
    PlaceNameModel *placeone = [[PlaceNameModel alloc]initWithPlaceName:@"百慕大" selected:@"已选地区"];
    PlaceNameModel *placetwo = [[PlaceNameModel alloc]initWithPlaceName:@"安道尔" selected:@"已选地区"];
    PlaceNameModel *placethree = [[PlaceNameModel alloc]initWithPlaceName:@"奥地利" selected:@"已选地区"];
    PlaceNameModel *placefour = [[PlaceNameModel alloc]initWithPlaceName:@"澳大利亚" selected:@"已选地区"];
    PlaceNameModel *placefive = [[PlaceNameModel alloc]initWithPlaceName:@"阿尔巴尼亚" selected:@"已选地区"];
    PlaceNameModel *placesix = [[PlaceNameModel alloc]initWithPlaceName:@"阿尔及利亚" selected:@"已选地区"];
    PlaceNameModel *placeseven = [[PlaceNameModel alloc]initWithPlaceName:@"爱尔兰" selected:@"已选地区"];
    PlaceNameModel *placeeight = [[PlaceNameModel alloc]initWithPlaceName:@"安哥拉" selected:@"已选地区"];
    PlaceNameModel *placenine = [[PlaceNameModel alloc]initWithPlaceName:@"阿根廷" selected:@"已选地区"];
    PlaceNameModel *placeten = [[PlaceNameModel alloc]initWithPlaceName:@"埃及" selected:@"已选地区"];
    PlaceNameModel *placeoneone = [[PlaceNameModel alloc]initWithPlaceName:@"阿鲁巴" selected:@"已选地区"];
    self.dataArray = @[placeone,placetwo,placethree,placefour,placefive,placesix,placeseven,placeeight,placenine,placeten,placeoneone];
    return self.dataArray;
}

#pragma mark - loadDataFromLocation
-(NSArray *)loadDataFromLocation
{
    LocationPlaceModel *locPlace = [[LocationPlaceModel alloc]initWithLocationPlaceName:@"中国  天津"];
    self.locArray = @[locPlace];
    return self.locArray;
}
//#pragma mark - loadNavigationController
//-(void)loadNavigationController
//{
//    UINavigationBar *navigation = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 74)];
//    navigation.backgroundColor = [UIColor yellowColor];
//    UINavigationItem *title = [[UINavigationItem alloc]initWithTitle:@"地区"];
//    [self.view addSubview:navigation];
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backButtonClick)];
//    title.leftBarButtonItem = backButton;
//    [navigation setItems:[NSArray arrayWithObject:title]];
//}
//
//#pragma mark - backButtonClick
//-(void)backButtonClick
//{
//
//}

#pragma mark - TableView
//两个section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//section的高度
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    else
    {
        return self.dataArray.count;
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"定位到的位置";
            break;
        case 1:
            return @"全部";
            break;
        default:
            return @"";
            break;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *header = @"customHeader";
    UITableViewHeaderFooterView *vHeader;
    vHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
    if(section == 0){
        if (!vHeader)
        {
            vHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, self.view.frame.size.width, 40)];
            label.backgroundColor = [UIColor lightGrayColor];
            [vHeader.contentView addSubview:label];
        }
    }
    else{
        if (!vHeader)
        {
            vHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake( 0 , - 18, self.view.frame.size.width, 64)];
            label.backgroundColor = [UIColor lightGrayColor];
            [vHeader.contentView addSubview:label];
        }
    }
    vHeader.textLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    return vHeader;
}
//section的Header高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 46;
    }
    else{
        return 46;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    SelectedMessageInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    static NSString *locCellIdentitier = @"locCellIdentifier";
    LocMessageInfoCell *locCell = [tableView dequeueReusableCellWithIdentifier:locCellIdentitier];
    if(indexPath.section == 0)
    {
        if(locCell == nil)
        {
            locCell = [[NSBundle mainBundle]loadNibNamed:@"LocMessageInfoCell" owner:nil options:nil].lastObject;
            LocationPlaceModel *locPlace = self.locArray[0];
            LocCellFrameInfo *locFrameInfo = [[LocCellFrameInfo alloc]initWithLocationPlace:locPlace];
            [locCell setCellData:locPlace locFrameInfo:locFrameInfo];
        }
        if(self.locationLabel.text.length == 0)
        {
            LocationPlaceModel *locPlaceName = self.locArray[0];
            locCell.LocationPlaceLabel.text = locPlaceName.locationPlaceName;
        }
        else
        {
            locCell.LocationPlaceLabel.text = self.locationLabel.text;
        }
        locCell.imageView.image = [UIImage imageNamed:@"weizhi.jpg"];
        locCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return locCell;
    }
    else
    {
        if(cell == nil)
        {
            cell = [[NSBundle mainBundle]loadNibNamed:@"SelectedMessageInfoCell" owner:nil options:nil].lastObject;
            PlaceNameModel *place = self.dataArray[indexPath.row];
            SelectedCellFrameInfo *frameInfo = [[SelectedCellFrameInfo alloc]initWithPlaceName:place];
            [cell setCellData:place frameInfo:frameInfo];
        }
        PlaceNameModel *placeName = self.dataArray[indexPath.row];
        cell.placeNameLabel.text = placeName.placeName;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
//cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 46;
    }
    PlaceNameModel *place = self.dataArray[indexPath.row];
    SelectedCellFrameInfo *frameInfo = [[SelectedCellFrameInfo alloc]initWithPlaceName:place];
    return frameInfo.cellHeight;
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {

        [self geocode];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

    }
    else{

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
