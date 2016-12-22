//
//  AppDelegate.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/9/26.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "TabBarVC.h"
#import "AddressListModel.h"    //收货地址model

@interface AppDelegate ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locManager;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) NSString *channelID_JPush;

@end

@implementation AppDelegate

+ (instancetype)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

//入口配置 （重写父类）
- (void)configAppLaunch
{
    TabBarVC *tabBarVC = [[TabBarVC alloc] init];
    self.window.rootViewController = tabBarVC;
    self.tabBarVC = tabBarVC;
}

//配置单例
- (void)configureSingle
{
    Single *single = [Single single];
    single.isLogin = [ReadForLocation(kIsLoginKey) boolValue];
    for (int i = 0; i < 8; i++)
    {
        AddressListModel *model = [AddressListModel new];
        model.name = @"李小龙";
        model.tel = @"18137801314";
        model.addressProvince = @"北京";
        model.addressCity = @"北京市";
        model.addressDistrict = @"朝阳区";
        model.addressDetail = [NSString stringWithFormat:@"立水桥明天生活馆502 立水桥明天生活馆--%d", i];
        if (i == 0)
        {
            model.isDefault = YES;
        }
        [[Single addressListArray] addObject:model];
    }
}


//开启定位操作
- (void)openLocationManager
{
    // 开始更新地理位置，并根据更新结果执行CLLocationManagerDelegate方法
    [self.locManager startUpdatingLocation];
    _isFirst = YES;
}

#pragma mark - lazy
- (CLLocationManager *)locManager
{
    if (_locManager == nil)
    {
        //1.创建位置管理器（定位用户的位置）
        self.locManager = [[CLLocationManager alloc]init];
        //2.设置代理
        _locManager.delegate = self;
        
        _locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        if ([QBGet getCurrentIOS] >= 8.0)
        {
            [_locManager requestWhenInUseAuthorization];
        }
    }
    return _locManager;
}

#pragma mark - <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [_locManager stopUpdatingLocation];
    CLLocation *location = locations[0];
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
    
    //如果定位成功 不再继续定位
    if (!_isFirst)
    {
        return;
    }
    _isFirst = NO;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
     {
         CLPlacemark *placemark = [placemarks lastObject];
         NSMutableString *strM = [NSMutableString string];
         for (NSString *string in placemark.addressDictionary[@"FormattedAddressLines"]) {
             [strM appendString:string];
         }
         
         self.province = placemark.addressDictionary[@"State"];
         self.city = placemark.addressDictionary[@"City"];
         self.district = placemark.addressDictionary[@"SubLocality"];
         
         BOOL isEmpty = !_province || !_province.length;
         if (isEmpty)
         {
             _province = NotAddressString;
             _city = NotAddressString;
         }
         
         //发送定位成功的通知
         [[NSNotificationCenter defaultCenter] postNotificationName:AppHadLocNotificationName object:nil];
         NSString *province = [[_province removeString:@"省"] removeString:@"市"];
         [Single setLoc:province];
     }];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    _isFirst = YES;
    [manager stopUpdatingLocation];
    switch([error code]) {
        case kCLErrorDenied:
        {
            NSString *errorString;
                        errorString = [NSString stringWithFormat:@"为了给您提供更加优质的服务，请打开%@的定位服务。", App_Name];
            [UIAlertController qb_showAlertWithTitle:@"温馨提示" message:errorString cancelTitle:@"取消" otherTitles:@[@"立即前往"] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
                
            } vc:self.tabBarVC];
        }
            break;
        case kCLErrorLocationUnknown:
            
            break;
        default:
            
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //回到活跃状态时（如果定位是不成功的就继续定位）
    if (!self.province || [self.province isEqualToString:NotAddressString])
    {
        [self openLocationManager]; //打开定位
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - app内存警告
//app收到内存警告时调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 1. 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2. 清除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

@end
