//
//  BaseVC.h
//  LiveTest
//
//  Created by 任强宾 on 16/8/14.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, UIWebViewDelegate>
{
    NSMutableArray *childVcArray;   //子控制器数组
    UITableView *_tableView;
    UICollectionView *_collectionView;
    UIScrollView *_scrollView;
    UIWebView *_webView;
    
    NSMutableArray *_listArray; //列表数据源
    NSInteger _pageIndex;       //列表页码
    MJRefreshNormalHeader *_refreshHeader;      //下拉刷新
    MJRefreshAutoNormalFooter *_refreshFooter;  //上拉加载
    
    BOOL _isEditState;           //是否是编辑状态
}

//是否是第一次创建视图的时候
@property (nonatomic, assign) BOOL isFirstLoad;
//视图是否已经出现
@property (nonatomic, assign) BOOL isDidAppear;

//是否是编辑状态
@property (nonatomic, assign) BOOL isEditState;

//导航条底部的黑线（系统和自定义）隐藏和颜色的设置
@property (nonatomic, assign) BOOL naviBarSystemLine_hidden;
@property (nonatomic, assign) BOOL naviBarCustomLine_hidden;

@property (nonatomic, strong) UIColor *naviBarCustomLine_color;

@property (nonatomic, weak, readonly) AppDelegate *appDelegate;
@property (nonatomic, strong) NSMutableArray *childVcArray;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) NSString *webViewUrl;

@property (nonatomic, strong) NSString *listUrl;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) NSArray *placeholderArray;

@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader; //下拉刷新
@property (nonatomic, strong) MJRefreshAutoNormalFooter *refreshFooter; //上拉加载

@property (nonatomic, assign) BOOL isUseKeyboardManager;  //是否使用键盘管理者(默认使用)
@property (nonatomic, assign) NSInteger pageIndex;//页码

@property (nonatomic, strong) UIImageView *backgroundView;//背景

@property (nonatomic, assign) NSInteger networkCount;

//自定义控制器的初始化方法
//- (instancetype)initWithRootView:(UIView *)rootView;

//配置初始化的参数 (供子类重写)
- (void)configParams;

//配置容器类 (供子类重写)
- (void)configContainer;

//添加views (供子类重写)
- (void)addOwnViews;

//配置,布局views (供子类重写)
- (void)configOwnViews;

//请求初始数据（供子类重写）
- (void)requestInitialData;

//为热更新预留的方法
- (void)reserveJS;

//设置导航栏图片按钮
- (void)addLeftImage:(UIImage *)image action:(SEL)action;
- (void)addRightImage:(UIImage *)image action:(SEL)action;

//设置导航栏右侧文字按钮
- (void)addLeftTitle:(NSString *)title action:(SEL)action;
- (void)addRightTitle:(NSString *)title action:(SEL)action;

- (void)addLeftBtn:(UIButton *)btn action:(SEL)action;
- (void)addRightBtn:(UIButton *)btn action:(SEL)action;


- (void)removeAllLeftBtns;

- (void)removeAllRightBtns;

#pragma mark - handle action
//默认的列表网络请求
- (void)requestListDataDefault;

///列表数据网络请求
- (void)requestListDataAnimation:(BOOL)animated;

//解析数据
- (void)receiveListData:(id)data;

///下拉刷新 -- 触发事件
- (void)onDownPullRefresh:(MJRefreshNormalHeader *)refreshHeader;

//上拉加载 -- 触发事件
- (void)onUpPullRefresh:(MJRefreshAutoNormalFooter *)refreshFooter;

///停止刷新
- (void)endRefreshing;

- (void)addRefreshHeader;

- (void)addRefreshFooter;

//创建tableView
- (void)setupTableView:(UITableViewStyle)style;

//点击某个按钮执行的事件（确定/删除/完成）
- (void)handleComplete:(UIButton *)sender;

//左侧按钮 dismiss
- (void)handleDismiss;

//左侧返回按钮 -- pop
- (void)handlePop;

#pragma mark - network
//单纯的网络请求
- (void)POST_:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary*dic))success fail:(void(^)(NSError*error))fail;

//耦合视图层的请求
- (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary*dic))success fail:(void(^)(NSError*error))fail sendView:(UIView *)sendView animSuperView:(UIView *)animSuperView animated:(BOOL)animated;

#pragma mark - helper
//查找到某视图高度小于1的UIImageView控件
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

@end
