//
//  ViewController.m
//  travel
//
//  Created by sks on 16/7/12.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "LocationViewController.h"


#define kViewSpace         12


@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic, strong) UITableView *mainTabelView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *locArray;
@property (nonatomic, strong) UILabel *locationLabel ;
@property (nonatomic, strong) PlaceNameModel *place;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, assign) CLLocationDegrees latitudeText;
@property (nonatomic, assign) CLLocationDegrees longitudeText;
@property (nonatomic, strong) NSString *placeString;

@property (nonatomic, strong) CLLocationManager *locationManager;
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
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 30);
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    [backBtn setImage:[UIImage imageNamed:@"backBtn.jpg"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(returnInfoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    [self loadDataFromWeb];
    [self loadDataFromLocation];
    [self.view addSubview:self.mainTabelView];
}

#pragma mark - returnButtonClick和观察者方法
-(void)returnInfoButtonClick{
    if(self.locationInfo.length == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"getLocationInfo" object:nil userInfo:@{@"location":self.locationInfo}];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
#pragma mark - CLLocationManagerDelegate
//当定位到用户的位置时，就会调用（调用的频率比较频繁）
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *loc = [locations firstObject];
    self.latitudeText = loc.coordinate.latitude;
    self.longitudeText = loc.coordinate.longitude;
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *array , NSError *error)
     {
         if(error || array.count == 0)
         {
             self.locationLabel.text = @"未能定位到当前位置";
             NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
             [self.mainTabelView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
         }
         else
         {
             CLPlacemark *firstPlacemark = [array firstObject];
             NSString *str1 = [[NSString alloc]init];
             str1 = firstPlacemark.country;
             NSString *str2 = [[NSString alloc]init];
             str2 = firstPlacemark.locality;
             self.placeString = [NSString stringWithFormat:@"%@ %@",str1,str2];
             self.locationLabel.text = self.placeString;
             NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
             [self.mainTabelView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
         };
     }];
    [self.locationManager stopUpdatingLocation];//停止
}
//失误时触发
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败！ Error: %@",error);
}

#pragma mark - loadDataFromWeb
-(NSArray *)loadDataFromWeb
{
    //    PlaceNameModel *place1 = [[PlaceNameModel alloc]initWithPlaceName:@"百慕大" selected:@"已选地区"];
    PlaceNameModel *place2 = [[PlaceNameModel alloc]initWithPlaceName:@"安道尔" selected:@"已选地区"];
    PlaceNameModel *place3 = [[PlaceNameModel alloc]initWithPlaceName:@"奥地利" selected:@"已选地区"];
    PlaceNameModel *place4 = [[PlaceNameModel alloc]initWithPlaceName:@"澳大利亚" selected:@"已选地区"];
    PlaceNameModel *place5 = [[PlaceNameModel alloc]initWithPlaceName:@"阿尔巴尼亚" selected:@"已选地区"];
    PlaceNameModel *place6 = [[PlaceNameModel alloc]initWithPlaceName:@"阿尔及利亚" selected:@"已选地区"];
    PlaceNameModel *place7 = [[PlaceNameModel alloc]initWithPlaceName:@"爱尔兰" selected:@"已选地区"];
    PlaceNameModel *place8 = [[PlaceNameModel alloc]initWithPlaceName:@"安哥拉" selected:@"已选地区"];
    PlaceNameModel *place9 = [[PlaceNameModel alloc]initWithPlaceName:@"阿根廷" selected:@"已选地区"];
    PlaceNameModel *place10 = [[PlaceNameModel alloc]initWithPlaceName:@"埃及" selected:@"已选地区"];
    PlaceNameModel *place11 = [[PlaceNameModel alloc]initWithPlaceName:@"阿鲁巴" selected:@"已选地区"];
    PlaceNameModel *place12 = [[PlaceNameModel alloc]initWithPlaceName:@"阿拉伯联合酋长国" selected:@"已选地区"];
    PlaceNameModel *place13 = [[PlaceNameModel alloc]initWithPlaceName:@"阿曼" selected:@"已选地区"];
    PlaceNameModel *place14 = [[PlaceNameModel alloc]initWithPlaceName:@"阿塞拜疆" selected:@"已选地区"];
    PlaceNameModel *place15 = [[PlaceNameModel alloc]initWithPlaceName:@"埃塞俄比亚" selected:@"已选地区"];
    PlaceNameModel *place16 = [[PlaceNameModel alloc]initWithPlaceName:@"安提瓜岛和巴布达" selected:@"已选地区"];
    PlaceNameModel *place17 = [[PlaceNameModel alloc]initWithPlaceName:@"巴巴多斯岛" selected:@"已选地区"];
    PlaceNameModel *place18 = [[PlaceNameModel alloc]initWithPlaceName:@"巴布亚新几内亚" selected:@"已选地区"];
    PlaceNameModel *place19 = [[PlaceNameModel alloc]initWithPlaceName:@"博茨瓦纳" selected:@"已选地区"];
    PlaceNameModel *place20 = [[PlaceNameModel alloc]initWithPlaceName:@"冰岛" selected:@"已选地区"];
    PlaceNameModel *place21 = [[PlaceNameModel alloc]initWithPlaceName:@"不丹" selected:@"已选地区"];
    PlaceNameModel *place22 = [[PlaceNameModel alloc]initWithPlaceName:@"波多黎各" selected:@"已选地区"];
    PlaceNameModel *place23 = [[PlaceNameModel alloc]initWithPlaceName:@"波黑" selected:@"已选地区"];
    PlaceNameModel *place24 = [[PlaceNameModel alloc]initWithPlaceName:@"巴哈马" selected:@"已选地区"];
    PlaceNameModel *place25 = [[PlaceNameModel alloc]initWithPlaceName:@"保加利亚" selected:@"已选地区"];
    PlaceNameModel *place26 = [[PlaceNameModel alloc]initWithPlaceName:@"巴基斯坦" selected:@"已选地区"];
    PlaceNameModel *place27 = [[PlaceNameModel alloc]initWithPlaceName:@"巴林" selected:@"已选地区"];
    PlaceNameModel *place28 = [[PlaceNameModel alloc]initWithPlaceName:@"波兰" selected:@"已选地区"];
    PlaceNameModel *place29 = [[PlaceNameModel alloc]initWithPlaceName:@"布隆迪" selected:@"已选地区"];
    PlaceNameModel *place30 = [[PlaceNameModel alloc]initWithPlaceName:@"比利时" selected:@"已选地区"];
    PlaceNameModel *place31 = [[PlaceNameModel alloc]initWithPlaceName:@"玻利维亚" selected:@"已选地区"];
    PlaceNameModel *place32 = [[PlaceNameModel alloc]initWithPlaceName:@"百慕大" selected:@"已选地区"];
    PlaceNameModel *place33 = [[PlaceNameModel alloc]initWithPlaceName:@"北马里亚纳群岛" selected:@"已选地区"];
    PlaceNameModel *place34 = [[PlaceNameModel alloc]initWithPlaceName:@"贝宁" selected:@"已选地区"];
    PlaceNameModel *place35 = [[PlaceNameModel alloc]initWithPlaceName:@"巴拿马" selected:@"已选地区"];
    PlaceNameModel *place36 = [[PlaceNameModel alloc]initWithPlaceName:@"巴西" selected:@"已选地区"];
    PlaceNameModel *place37 = [[PlaceNameModel alloc]initWithPlaceName:@"朝鲜" selected:@"已选地区"];
    PlaceNameModel *place38 = [[PlaceNameModel alloc]initWithPlaceName:@"德国" selected:@"已选地区"];
    PlaceNameModel *place39 = [[PlaceNameModel alloc]initWithPlaceName:@"丹麦" selected:@"已选地区"];
    PlaceNameModel *place40 = [[PlaceNameModel alloc]initWithPlaceName:@"多米尼加共和国" selected:@"已选地区"];
    PlaceNameModel *place41 = [[PlaceNameModel alloc]initWithPlaceName:@"厄瓜多尔" selected:@"已选地区"];
    PlaceNameModel *place42 = [[PlaceNameModel alloc]initWithPlaceName:@"俄罗斯" selected:@"已选地区"];
    PlaceNameModel *place43 = [[PlaceNameModel alloc]initWithPlaceName:@"厄立特里亚" selected:@"已选地区"];
    PlaceNameModel *place44 = [[PlaceNameModel alloc]initWithPlaceName:@"法国" selected:@"已选地区"];
    PlaceNameModel *place45 = [[PlaceNameModel alloc]initWithPlaceName:@"斐济" selected:@"已选地区"];
    PlaceNameModel *place46 = [[PlaceNameModel alloc]initWithPlaceName:@"芬兰" selected:@"已选地区"];
    PlaceNameModel *place47 = [[PlaceNameModel alloc]initWithPlaceName:@"菲律宾" selected:@"已选地区"];
    PlaceNameModel *place48 = [[PlaceNameModel alloc]initWithPlaceName:@"古巴" selected:@"已选地区"];
    PlaceNameModel *place49 = [[PlaceNameModel alloc]initWithPlaceName:@"冈比亚" selected:@"已选地区"];
    PlaceNameModel *place50 = [[PlaceNameModel alloc]initWithPlaceName:@"关岛" selected:@"已选地区"];
    PlaceNameModel *place51 = [[PlaceNameModel alloc]initWithPlaceName:@"格恩西岛" selected:@"已选地区"];
    PlaceNameModel *place52 = [[PlaceNameModel alloc]initWithPlaceName:@"刚果民主共和国" selected:@"已选地区"];
    PlaceNameModel *place53 = [[PlaceNameModel alloc]initWithPlaceName:@"哥伦比亚" selected:@"已选地区"];
    PlaceNameModel *place54 = [[PlaceNameModel alloc]initWithPlaceName:@"格陵兰" selected:@"已选地区"];
    PlaceNameModel *place55 = [[PlaceNameModel alloc]initWithPlaceName:@"格林纳达" selected:@"已选地区"];
    PlaceNameModel *place56 = [[PlaceNameModel alloc]initWithPlaceName:@"哥斯达黎加" selected:@"已选地区"];
    PlaceNameModel *place57 = [[PlaceNameModel alloc]initWithPlaceName:@"海地" selected:@"已选地区"];
    PlaceNameModel *place58 = [[PlaceNameModel alloc]initWithPlaceName:@"洪都拉斯" selected:@"已选地区"];
    PlaceNameModel *place59 = [[PlaceNameModel alloc]initWithPlaceName:@"韩国" selected:@"已选地区"];
    PlaceNameModel *place60 = [[PlaceNameModel alloc]initWithPlaceName:@"荷兰" selected:@"已选地区"];
    PlaceNameModel *place61 = [[PlaceNameModel alloc]initWithPlaceName:@"黑山共和国" selected:@"已选地区"];
    PlaceNameModel *place62 = [[PlaceNameModel alloc]initWithPlaceName:@"哈萨克斯坦" selected:@"已选地区"];
    PlaceNameModel *place63 = [[PlaceNameModel alloc]initWithPlaceName:@"吉布提" selected:@"已选地区"];
    PlaceNameModel *place64 = [[PlaceNameModel alloc]initWithPlaceName:@"吉尔吉斯斯坦" selected:@"已选地区"];
    PlaceNameModel *place65 = [[PlaceNameModel alloc]initWithPlaceName:@"捷克共和国" selected:@"已选地区"];
    PlaceNameModel *place66 = [[PlaceNameModel alloc]initWithPlaceName:@"基里巴斯" selected:@"已选地区"];
    PlaceNameModel *place67 = [[PlaceNameModel alloc]initWithPlaceName:@"加纳" selected:@"已选地区"];
    PlaceNameModel *place68 = [[PlaceNameModel alloc]initWithPlaceName:@"加拿大" selected:@"已选地区"];
    PlaceNameModel *place69 = [[PlaceNameModel alloc]initWithPlaceName:@"柬埔寨" selected:@"已选地区"];
    PlaceNameModel *place70 = [[PlaceNameModel alloc]initWithPlaceName:@"克罗地亚" selected:@"已选地区"];
    PlaceNameModel *place71 = [[PlaceNameModel alloc]initWithPlaceName:@"喀麦隆" selected:@"已选地区"];
    PlaceNameModel *place72 = [[PlaceNameModel alloc]initWithPlaceName:@"开曼群岛" selected:@"已选地区"];
    PlaceNameModel *place73 = [[PlaceNameModel alloc]initWithPlaceName:@"肯尼亚" selected:@"已选地区"];
    PlaceNameModel *place74 = [[PlaceNameModel alloc]initWithPlaceName:@"科威特" selected:@"已选地区"];
    PlaceNameModel *place75 = [[PlaceNameModel alloc]initWithPlaceName:@"利比里亚" selected:@"已选地区"];
    PlaceNameModel *place76 = [[PlaceNameModel alloc]initWithPlaceName:@"黎巴嫩" selected:@"已选地区"];
    PlaceNameModel *place77 = [[PlaceNameModel alloc]initWithPlaceName:@"利比亚" selected:@"已选地区"];
    PlaceNameModel *place78 = [[PlaceNameModel alloc]initWithPlaceName:@"罗马尼亚" selected:@"已选地区"];
    PlaceNameModel *place79 = [[PlaceNameModel alloc]initWithPlaceName:@"留尼旺岛" selected:@"已选地区"];
    PlaceNameModel *place80 = [[PlaceNameModel alloc]initWithPlaceName:@"卢森堡" selected:@"已选地区"];
    PlaceNameModel *place81 = [[PlaceNameModel alloc]initWithPlaceName:@"莱索托" selected:@"已选地区"];
    PlaceNameModel *place82 = [[PlaceNameModel alloc]initWithPlaceName:@"拉脱维亚" selected:@"已选地区"];
    PlaceNameModel *place83 = [[PlaceNameModel alloc]initWithPlaceName:@"卢旺达" selected:@"已选地区"];
    PlaceNameModel *place84 = [[PlaceNameModel alloc]initWithPlaceName:@"老挝" selected:@"已选地区"];
    PlaceNameModel *place85 = [[PlaceNameModel alloc]initWithPlaceName:@"列支敦士登" selected:@"已选地区"];
    PlaceNameModel *place86 = [[PlaceNameModel alloc]initWithPlaceName:@"缅甸" selected:@"已选地区"];
    PlaceNameModel *place87 = [[PlaceNameModel alloc]initWithPlaceName:@"马达加斯加" selected:@"已选地区"];
    PlaceNameModel *place88 = [[PlaceNameModel alloc]initWithPlaceName:@"马尔代夫" selected:@"已选地区"];
    PlaceNameModel *place89 = [[PlaceNameModel alloc]initWithPlaceName:@"摩尔多瓦" selected:@"已选地区"];
    PlaceNameModel *place90 = [[PlaceNameModel alloc]initWithPlaceName:@"美国" selected:@"已选地区"];
    PlaceNameModel *place91 = [[PlaceNameModel alloc]initWithPlaceName:@"蒙古" selected:@"已选地区"];
    PlaceNameModel *place92 = [[PlaceNameModel alloc]initWithPlaceName:@"孟加拉" selected:@"已选地区"];
    PlaceNameModel *place93 = [[PlaceNameModel alloc]initWithPlaceName:@"秘鲁" selected:@"已选地区"];
    PlaceNameModel *place94 = [[PlaceNameModel alloc]initWithPlaceName:@"摩洛哥" selected:@"已选地区"];
    PlaceNameModel *place95 = [[PlaceNameModel alloc]initWithPlaceName:@"毛里求斯" selected:@"已选地区"];
    PlaceNameModel *place96 = [[PlaceNameModel alloc]initWithPlaceName:@"毛里塔尼亚" selected:@"已选地区"];
    PlaceNameModel *place97 = [[PlaceNameModel alloc]initWithPlaceName:@"马拉维" selected:@"已选地区"];
    PlaceNameModel *place98 = [[PlaceNameModel alloc]initWithPlaceName:@"马来西亚" selected:@"已选地区"];
    PlaceNameModel *place99 = [[PlaceNameModel alloc]initWithPlaceName:@"摩纳哥" selected:@"已选地区"];
    PlaceNameModel *place100 = [[PlaceNameModel alloc]initWithPlaceName:@"马其顿" selected:@"已选地区"];
    PlaceNameModel *place101 = [[PlaceNameModel alloc]initWithPlaceName:@"莫桑比克" selected:@"已选地区"];
    PlaceNameModel *place102 = [[PlaceNameModel alloc]initWithPlaceName:@"马绍尔群岛" selected:@"已选地区"];
    PlaceNameModel *place103 = [[PlaceNameModel alloc]initWithPlaceName:@"墨西哥" selected:@"已选地区"];
    PlaceNameModel *place104 = [[PlaceNameModel alloc]initWithPlaceName:@"尼泊尔" selected:@"已选地区"];
    PlaceNameModel *place105 = [[PlaceNameModel alloc]initWithPlaceName:@"南非" selected:@"已选地区"];
    PlaceNameModel *place106 = [[PlaceNameModel alloc]initWithPlaceName:@"尼加拉瓜" selected:@"已选地区"];
    PlaceNameModel *place107 = [[PlaceNameModel alloc]initWithPlaceName:@"纳米比亚" selected:@"已选地区"];
    PlaceNameModel *place108 = [[PlaceNameModel alloc]initWithPlaceName:@"尼日利亚" selected:@"已选地区"];
    PlaceNameModel *place109 = [[PlaceNameModel alloc]initWithPlaceName:@"挪威" selected:@"已选地区"];
    PlaceNameModel *place110 = [[PlaceNameModel alloc]initWithPlaceName:@"帕劳群岛" selected:@"已选地区"];
    PlaceNameModel *place111 = [[PlaceNameModel alloc]initWithPlaceName:@"葡萄牙" selected:@"已选地区"];
    PlaceNameModel *place112 = [[PlaceNameModel alloc]initWithPlaceName:@"卡塔尔" selected:@"已选地区"];
    PlaceNameModel *place113 = [[PlaceNameModel alloc]initWithPlaceName:@"乔治亚" selected:@"已选地区"];
    PlaceNameModel *place114 = [[PlaceNameModel alloc]initWithPlaceName:@"日本" selected:@"已选地区"];
    PlaceNameModel *place115 = [[PlaceNameModel alloc]initWithPlaceName:@"瑞典" selected:@"已选地区"];
    PlaceNameModel *place116 = [[PlaceNameModel alloc]initWithPlaceName:@"苏丹" selected:@"已选地区"];
    PlaceNameModel *place117 = [[PlaceNameModel alloc]initWithPlaceName:@"塞尔维亚" selected:@"已选地区"];
    PlaceNameModel *place118 = [[PlaceNameModel alloc]initWithPlaceName:@"圣基茨和尼维斯" selected:@"已选地区"];
    PlaceNameModel *place119 = [[PlaceNameModel alloc]initWithPlaceName:@"斯洛伐克" selected:@"已选地区"];
    PlaceNameModel *place120 = [[PlaceNameModel alloc]initWithPlaceName:@"塞拉利昂" selected:@"已选地区"];
    PlaceNameModel *place121 = [[PlaceNameModel alloc]initWithPlaceName:@"斯里兰卡" selected:@"已选地区"];
    PlaceNameModel *place122 = [[PlaceNameModel alloc]initWithPlaceName:@"所罗门群岛" selected:@"已选地区"];
    PlaceNameModel *place123 = [[PlaceNameModel alloc]initWithPlaceName:@"苏里南" selected:@"已选地区"];
    PlaceNameModel *place124 = [[PlaceNameModel alloc]initWithPlaceName:@"斯洛文尼亚" selected:@"已选地区"];
    PlaceNameModel *place125 = [[PlaceNameModel alloc]initWithPlaceName:@"圣马力诺" selected:@"已选地区"];
    PlaceNameModel *place126 = [[PlaceNameModel alloc]initWithPlaceName:@"萨摩亚" selected:@"已选地区"];
    PlaceNameModel *place127 = [[PlaceNameModel alloc]initWithPlaceName:@"塞内加尔" selected:@"已选地区"];
    PlaceNameModel *place128 = [[PlaceNameModel alloc]initWithPlaceName:@"塞舌尔" selected:@"已选地区"];
    PlaceNameModel *place129 = [[PlaceNameModel alloc]initWithPlaceName:@"沙特阿拉伯" selected:@"已选地区"];
    PlaceNameModel *place130 = [[PlaceNameModel alloc]initWithPlaceName:@"斯威士兰" selected:@"已选地区"];
    PlaceNameModel *place131 = [[PlaceNameModel alloc]initWithPlaceName:@"土耳其" selected:@"已选地区"];
    PlaceNameModel *place132 = [[PlaceNameModel alloc]initWithPlaceName:@"泰国" selected:@"已选地区"];
    PlaceNameModel *place133 = [[PlaceNameModel alloc]initWithPlaceName:@"汤加" selected:@"已选地区"];
    PlaceNameModel *place134 = [[PlaceNameModel alloc]initWithPlaceName:@"塔吉克斯坦" selected:@"已选地区"];
    PlaceNameModel *place135 = [[PlaceNameModel alloc]initWithPlaceName:@"特立尼达和多巴哥" selected:@"已选地区"];
    PlaceNameModel *place136 = [[PlaceNameModel alloc]initWithPlaceName:@"坦桑尼亚" selected:@"已选地区"];
    PlaceNameModel *place137 = [[PlaceNameModel alloc]initWithPlaceName:@"危地马拉" selected:@"已选地区"];
    PlaceNameModel *place138 = [[PlaceNameModel alloc]initWithPlaceName:@"乌干达" selected:@"已选地区"];
    PlaceNameModel *place139 = [[PlaceNameModel alloc]initWithPlaceName:@"乌克兰" selected:@"已选地区"];
    PlaceNameModel *place140 = [[PlaceNameModel alloc]initWithPlaceName:@"文莱" selected:@"已选地区"];
    PlaceNameModel *place141 = [[PlaceNameModel alloc]initWithPlaceName:@"乌拉圭" selected:@"已选地区"];
    PlaceNameModel *place142 = [[PlaceNameModel alloc]initWithPlaceName:@"瓦努阿图" selected:@"已选地区"];
    PlaceNameModel *place143 = [[PlaceNameModel alloc]initWithPlaceName:@"委内瑞拉" selected:@"已选地区"];
    PlaceNameModel *place144 = [[PlaceNameModel alloc]initWithPlaceName:@"乌兹别克斯坦" selected:@"已选地区"];
    PlaceNameModel *place145 = [[PlaceNameModel alloc]initWithPlaceName:@"西班牙" selected:@"已选地区"];
    PlaceNameModel *place146 = [[PlaceNameModel alloc]initWithPlaceName:@"新加坡" selected:@"已选地区"];
    PlaceNameModel *place147 = [[PlaceNameModel alloc]initWithPlaceName:@"新喀里多尼亚" selected:@"已选地区"];
    PlaceNameModel *place148 = [[PlaceNameModel alloc]initWithPlaceName:@"希腊" selected:@"已选地区"];
    PlaceNameModel *place149 = [[PlaceNameModel alloc]initWithPlaceName:@"新西兰" selected:@"已选地区"];
    PlaceNameModel *place150 = [[PlaceNameModel alloc]initWithPlaceName:@"匈牙利" selected:@"已选地区"];
    PlaceNameModel *place151 = [[PlaceNameModel alloc]initWithPlaceName:@"印度" selected:@"已选地区"];
    PlaceNameModel *place152 = [[PlaceNameModel alloc]initWithPlaceName:@"约旦" selected:@"已选地区"];
    PlaceNameModel *place153 = [[PlaceNameModel alloc]initWithPlaceName:@"意大利" selected:@"已选地区"];
    PlaceNameModel *place154 = [[PlaceNameModel alloc]initWithPlaceName:@"印度尼西亚" selected:@"已选地区"];
    PlaceNameModel *place155 = [[PlaceNameModel alloc]initWithPlaceName:@"英国" selected:@"已选地区"];
    PlaceNameModel *place156 = [[PlaceNameModel alloc]initWithPlaceName:@"伊朗" selected:@"已选地区"];
    PlaceNameModel *place157 = [[PlaceNameModel alloc]initWithPlaceName:@"伊拉克" selected:@"已选地区"];
    PlaceNameModel *place158 = [[PlaceNameModel alloc]initWithPlaceName:@"也门" selected:@"已选地区"];
    PlaceNameModel *place159 = [[PlaceNameModel alloc]initWithPlaceName:@"牙买加" selected:@"已选地区"];
    PlaceNameModel *place160 = [[PlaceNameModel alloc]initWithPlaceName:@"亚美尼亚" selected:@"已选地区"];
    PlaceNameModel *place161 = [[PlaceNameModel alloc]initWithPlaceName:@"越南" selected:@"已选地区"];
    PlaceNameModel *place162 = [[PlaceNameModel alloc]initWithPlaceName:@"以色列" selected:@"已选地区"];
    PlaceNameModel *place163 = [[PlaceNameModel alloc]initWithPlaceName:@"直布罗陀" selected:@"已选地区"];
    PlaceNameModel *place164 = [[PlaceNameModel alloc]initWithPlaceName:@"赞比亚" selected:@"已选地区"];
    PlaceNameModel *place165 = [[PlaceNameModel alloc]initWithPlaceName:@"中非共和国" selected:@"已选地区"];
    PlaceNameModel *place166 = [[PlaceNameModel alloc]initWithPlaceName:@"中国澳门" selected:@"已选地区"];
    PlaceNameModel *place167 = [[PlaceNameModel alloc]initWithPlaceName:@"中国台湾" selected:@"已选地区"];
    PlaceNameModel *place168 = [[PlaceNameModel alloc]initWithPlaceName:@"中国香港" selected:@"已选地区"];
    PlaceNameModel *place169 = [[PlaceNameModel alloc]initWithPlaceName:@"智利" selected:@"已选地区"];
    PlaceNameModel *place170 = [[PlaceNameModel alloc]initWithPlaceName:@"泽西岛" selected:@"已选地区"];
    self.dataArray = @[place2,place3,place4,place5,place6,place7,place8,place9,place10,place11,place12,place13,place14,place15,place16,place17,place18,place19,place20,place21,place22,place23,place24,place25,place26,place27,place28,place29,place30,place31,place32,place33,place34,place35,place36,place37,place38,place39,place40,place41,place42,place43,place44,place45,place46,place47,place48,place49,place50,place51,place52,place53,place54,place55,place56,place57,place58,place59,place60,place61,place62,place63,place64,place65,place66,place67,place68,place69,place70,place71,place72,place73,place74,place75,place76,place77,place78,place79,place80,place81,place82,place83,place84,place85,place86,place87,place88,place89,place90,place91,place92,place93,place94,place95,place96,place97,place98,place99,place100,place101,place102,place103,place104,place105,place106,place107,place108,place109,place110,place111,place112,place113,place114,place115,place116,place117,place118,place119,place120,place121,place122,place123,place124,place125,place126,place127,place128,place129,place130,place131,place132,place133,place134,place135,place136,place137,place138,place139,place140,place141,place142,place143,place144,place145,place146,place147,place148,place149,place150,place151,place152,place153,place154,place155,place156,place157,place158,place159,place160,place161,place162,place163,place164,place165,place166,place167,place168,place169,place170];
    
    return self.dataArray;
}

#pragma mark - loadDataFromLocation
-(NSMutableArray *)loadDataFromLocation
{
    self.locArray = [[NSMutableArray alloc]initWithCapacity:1];
    PlaceNameModel *locPlace = [[PlaceNameModel alloc]initWithLocationPlaceName:@"定位中..."];
    [self.locArray addObject:locPlace];
    return self.locArray;
}


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
            PlaceNameModel *locPlace = self.locArray[0];
            LocCellFrameInfo *locFrameInfo = [[LocCellFrameInfo alloc]initWithLocationPlace:locPlace];
            [locCell setCellData:locPlace locFrameInfo:locFrameInfo];
        }
        if(self.locationLabel.text.length == 0)
        {
            PlaceNameModel *locPlaceName = self.locArray[0];
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
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        self.locationInfo = self.placeString;
    }
    else{
        PlaceNameModel *locat = self.dataArray[indexPath.row];
        self.locationInfo = locat.placeName;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
