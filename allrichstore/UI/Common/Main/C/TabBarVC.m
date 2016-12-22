//
//  TabBarVC.m
//  LiveTest
//
//  Created by 任强宾 on 16/8/18.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "TabBarVC.h"
#import "HomeVC.h"          //首页
#import "GoodsClassVC.h"    //分类
#import "ChoiceGoodsVC.h"   //精选
#import "ShoppingCartVC.h"  //购物车
#import "MineVC.h"          //我的

@interface TabBarVC ()<UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger indexFlag;

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTabBar];    //配置tabbar
    [self addOwnViews];     //添加子视图
    [self updateUserInfo];  //更新用户信息
    [self reserveJS];       //为热更新预留
}

//配置tabbar
- (void)configTabBar
{
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:MainCol size:CGSizeMake(kScreenW, 1)]];
    //选中状态颜色
    self.tabBar.tintColor = MainCol;
    self.delegate = self;
}

//添加子视图
- (void)addOwnViews
{

    HomeVC *homeVC = [HomeVC new];
    [self addChildVC:homeVC title:@"首页" image:Image(@"shouye_an") selectedImage:Image(@"shouye_ling")];
    
    GoodsClassVC *goodsClassVC = [GoodsClassVC new];
    [self addChildVC:goodsClassVC title:@"分类" image:Image(@"fenlei_an") selectedImage:Image(@"fenlei_liang")];
    goodsClassVC.navigationItem.title = @"全富";


    ChoiceGoodsVC *choiceGoodsVC = [ChoiceGoodsVC new];
    [self addChildVC:choiceGoodsVC title:@"精选" image:Image(@"jingxuan_an") selectedImage:Image(@"jingxuan_liang")];
    choiceGoodsVC.navigationItem.title = @"精选推荐";
    
    ShoppingCartVC *shoppingCartVC = [ShoppingCartVC new];
    [self addChildVC:shoppingCartVC title:@"购物车" image:Image(@"gouwuche_an") selectedImage:Image(@"gouwuche_liang")];
    
    MineVC *mineVC = [MineVC new];
    [self addChildVC:mineVC title:@"我的" image:Image(@"wode_an") selectedImage:Image(@"wode_liang")];
}

- (void)updateUserInfo
{

    NSDictionary *params = @{};
    
    [NetWork POST_:@"" parameters:params success:^(NSDictionary *dic) {
        
        NSInteger code = [dic[@"code"] integerValue];
        if (code == 0)
        {
            //解析用户数据
        
        }
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)reserveJS
{
    
}

//添加子控制器
- (void)addChildVC:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    vc.title = title;
    
    BaseNC *naviC = [[BaseNC alloc] initWithRootViewController:vc];

    //把图片渲染成指定颜色
    UIImage *normalImage = image;
    naviC.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    naviC.tabBarItem.selectedImage = selectedImage;
    naviC.tabBarItem.title = title;
    [naviC.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self addChildViewController:naviC];
//    //设置tabBarItem的选中状态文字颜色
//    [naviC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : MainCol} forState:UIControlStateSelected];
//    //设置tabBarItem的默认状态文字颜色
//    [naviC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : kGrayColor} forState:UIControlStateNormal];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (self.indexFlag != index) {
        [self animationWithIndex:index];
    }
}

// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.8];
    pulse.toValue= [NSNumber numberWithFloat:1.2];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    
    self.indexFlag = index;
}

@end
