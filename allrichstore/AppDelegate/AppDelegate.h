//
//  AppDelegate.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/9/26.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAppDelegate.h"
#import "TabBarVC.h"

@interface AppDelegate : BaseAppDelegate<UIApplicationDelegate>

@property (nonatomic, strong) TabBarVC *tabBarVC;

//省份名称
@property (nonatomic, strong) NSString *province;
//城市名称
@property (nonatomic, strong) NSString *city;
//区县名称
@property (nonatomic, strong) NSString *district;
//街道名称
@property (nonatomic, strong) NSString *streetName;


@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;


+ (instancetype)sharedAppDelegate;

@end

