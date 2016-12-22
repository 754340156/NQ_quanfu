//
//  BaseVC.m
//  LiveTest
//
//  Created by 任强宾 on 16/8/14.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "BaseVC.h"
#import "NetErrorCell.h"
#import "NetErrorItem.h"
#import "FoldMenuView.h"

#define kInitialPageIndex  1      //初始页码
#define kNetwork_successCode 200  //网络请求成功的代码

#define kNaviCustomLine_height  0.7 //自定义导航底线的高度
#define kNaviCustomLine_color   [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0] //默认颜色

#define kNaviBarItemTintColor   [UIColor darkGrayColor]

#define NetWorkErrorFooterString @"点击或拖拽重试"

@interface BaseVC ()

@property (nonatomic, strong) UIView *rootView;
@property (nonatomic, strong) NSMutableArray *leftBarBtnArray;
@property (nonatomic, strong) NSMutableArray *rightBarBtnArray;

@property (nonatomic, strong) NSMutableArray *networkArray;

@end


static NSString *netErrorCellIdentifier = @"NetErrorCell";
static NSString *netErrorItemIdentifier = @"NetErrorItem";

@implementation BaseVC

@synthesize tableView = _tableView, collectionView = _collectionView, webView = _webView, webViewUrl = _webViewUrl, listUrl = _listUrl, listArray = _listArray, refreshHeader = _refreshHeader, refreshFooter = _refreshFooter, childVcArray = _childVcArray, isEditState = _isEditState;

//自定义控制器的初始化方法
- (instancetype)initWithRootView:(UIView *)rootView
{
    self = [super init];
    if (self)
    {
        self.rootView = rootView;
    }
    return self;
}

#pragma mark - Life Cycle
//- (void)loadView
//{
//    [super loadView];
//    if (self.rootView)
//    {
//        self.view = self.rootView;
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self baseConfigure];   //baseVC的基本配置
    [self configParams];    //配置初始参数
    [self configContainer]; //配置容器类属性
    [self addOwnViews];     //添加views
    [self configOwnViews];  //配置,布局views
    [self requestListDataDefault];   //默认的主列表网络请求
    [self requestInitialData];  //默认的初始配置请求
    [self reserveJS];       //为热更新预留
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self configureNaviBarLine];  //配置导航条底线
    
    //修改键盘管理者的属性
    [IQKeyboardManager sharedManager].enable = _isUseKeyboardManager;
    [IQKeyboardManager sharedManager].enableAutoToolbar = _isUseKeyboardManager;
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    [IQKeyboardManager sharedManager].toolbarTintColor = QF_BlackColor;
}

//解决系统提供的侧滑失效问题
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.isFirstLoad = NO;  //视图已经创建并出现完毕
    self.isDidAppear = YES; 
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar endEditing:YES];
    [self.view endEditing:YES];
    //修改键盘管理者的属性
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

//基础配置
- (void)baseConfigure
{
    self.view.backgroundColor = Color_BaseVCViewBg;
    //设置导航底线相关属性
    self.naviBarSystemLine_hidden = YES;
    self.naviBarCustomLine_hidden = NO;
    
    //self.fd_interactivePopDisabled = YES;  //全屏侧滑设置
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.extendedLayoutIncludesOpaqueBars = YES;
    //self.navigationController.navigationBar.translucent = YES;
    //self.tabBarController.tabBar.translucent = YES;
    //self.automaticallyAdjustsScrollViewInsets = YES;
    
    //统一设置导航栏返回按钮(设置后系统提供的侧滑pop会失效)
    if (self.navigationController.childViewControllers.count > 1)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:Image_NaviBar_Left_Back style:UIBarButtonItemStylePlain target:self action:@selector(handlePop)];
        self.hidesBottomBarWhenPushed = YES;
    }
    
    self.isFirstLoad = YES;           //默认是第一次创建
    self.isUseKeyboardManager = YES;  //(默认使用键盘管理者)
    self.listUrl = @"666";
    _pageIndex = kInitialPageIndex;
    
    if (_webViewUrl)
    {
        NSURL *url = [NSURL URLWithString:_webViewUrl];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];
        [self.view addSubview:_webView];
    }
}

#pragma mark - SubClass Override
//配置初始化的参数（供子类重写）
- (void)configParams
{

}

//配置容器类（供子类重写）
- (void)configContainer
{
    
}

//添加views (供子类重写)
- (void)addOwnViews
{
    
}

//配置,布局views (供子类重写)
- (void)configOwnViews
{

}

//请求初始数据（供子类重写）
- (void)requestInitialData
{
    
}

//为热更新预留
- (void)reserveJS
{
    
}

//默认的列表网络请求
- (void)requestListDataDefault
{
    [self requestListDataAnimation:YES]; //请求列表数据
}

- (void)addRefreshHeader
{
    
}

- (void)addRefreshFooter
{
    
}

//创建tableView
- (void)setupTableView:(UITableViewStyle)style
{
    self.tableView = [[TableView alloc]initWithFrame:self.view.bounds style:style];
    CGRect headerRect = (style == UITableViewStylePlain) ? CGRectZero : CGRectMake(0, 0, _tableView.width, 0.001);
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:headerRect];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:headerRect];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = Color_TableViewBg;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerClass:[NetErrorCell class] forCellReuseIdentifier:netErrorCellIdentifier];
}


#pragma mark - handle action
//列表数据网络请求(供子类重写)
- (void)requestListDataAnimation:(BOOL)animated
{

}

//点击某个按钮执行的事件（确定/删除/完成）
- (void)handleComplete:(UIButton *)sender
{
    
}

//左侧按钮 dismiss
- (void)handleDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//左侧返回按钮 -- pop
- (void)handlePop
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - network
//单纯的网络请求
- (void)POST_:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary*dic))success fail:(void(^)(NSError*error))fail
{
    [NetWork POST_:url parameters:parameters success:^(NSDictionary *dic) {
        
        NSInteger code = [dic[@"code"] integerValue];
        if (code == kNetwork_successCode)
        {
            success(dic);
        }
        
    } fail:^(NSError *error) {
       
        fail(error);
    }];
}

//耦合视图层的请求
- (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary*dic))success fail:(void(^)(NSError*error))fail sendView:(UIView *)sendView animSuperView:(UIView *)animSuperView animated:(BOOL)animated
{
    WS(weakSelf)
    if (!animSuperView)
    {
        animSuperView = self.view;
    }
    
    [NetWork POST:url parameters:parameters success:^(NSDictionary *dic) {
        
        [weakSelf endRefreshing];
        
        NSInteger code = [dic[@"code"] integerValue];
        if (code == kNetwork_successCode)
        {
            success(dic);
        }
        else
        {
            [self.view showToastMsg:dic[@"errorMessage"]];
        }
        
    } fail:^(NSError *error) {
        
        [self endRefreshing];
        fail(error);
        
    } sendView:sendView animSuperView:animSuperView animated:animated];
}

//解析数据
- (void)receiveListData:(id)data
{
    
}

//下拉刷新 -- 触发事件
- (void)onDownPullRefresh:(MJRefreshNormalHeader *)refreshHeader
{
    _pageIndex = kInitialPageIndex;
    [self requestListDataAnimation:NO];
}

//上拉加载 -- 触发事件
- (void)onUpPullRefresh:(MJRefreshAutoNormalFooter *)refreshFooter
{
    if (self.listArray.count == 0)
    {
        _pageIndex = kInitialPageIndex;
    }
    else
    {
        _pageIndex ++;
    }
    
    [self.refreshFooter beginRefreshing];
    [self requestListDataAnimation:NO];
}

#pragma mark - Lazy Load
- (NSMutableArray *)childVcArray
{
    if (!_childVcArray)
    {
        self.childVcArray = [NSMutableArray array];
    }
    return _childVcArray;
}

- (NSMutableArray *)listArray
{
    if (!_listArray)
    {
        self.listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = Color_TableViewBg;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
        [_tableView registerClass:[NetErrorCell class] forCellReuseIdentifier:netErrorCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = Color_TableViewBg;
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[NetErrorItem class] forCellWithReuseIdentifier:netErrorItemIdentifier];
    }
    return _collectionView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIWebView *)webView
{
    if (!_webView)
    {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scrollView.backgroundColor = Color_ScrollViewBg;
        _webView.delegate = self;
    }
    return _webView;
}

//下拉刷新控件
- (MJRefreshNormalHeader *)refreshHeader
{
    if (!_refreshHeader)
    {
//        self.refreshHeader = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
//        [_refreshHeader addTarget:self action:@selector(onDownPullRefresh:) forControlEvents:UIControlEventValueChanged];
        //[_refreshHeader setTintColor:MainCol];
        
        self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onDownPullRefresh:)];
        //_refreshHeader.stateLabel.hidden = YES;
        _refreshHeader.stateLabel.textColor = [UIColor lightGrayColor];
        _refreshHeader.stateLabel.font = [UIFont systemFontOfSize:14];
        
        _refreshHeader.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
        _refreshHeader.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _refreshHeader;
}

//上拉加载控件
- (MJRefreshAutoNormalFooter *)refreshFooter
{
    if (!_refreshFooter)
    {
        self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onUpPullRefresh:)];
        _refreshFooter.stateLabel.textColor = [UIColor lightGrayColor];
        _refreshFooter.stateLabel.font = [UIFont systemFontOfSize:14];
        //_refreshFooter.hidden = YES;
    }
    return _refreshFooter;
}

//停止刷新
- (void)endRefreshing
{
    [self.refreshHeader endRefreshing];
    [self.refreshFooter endRefreshing];
    //((UIScrollView *)self.refreshHeader.superview).scrollEnabled = YES;
}

- (AppDelegate *)appDelegate
{
    return [AppDelegate sharedAppDelegate];
}

- (NSMutableArray *)leftBarBtnArray
{
    if (!_leftBarBtnArray)
    {
        self.leftBarBtnArray = [NSMutableArray array];
    }
    return _leftBarBtnArray;
}

- (NSMutableArray *)rightBarBtnArray
{
    if (!_rightBarBtnArray)
    {
        self.rightBarBtnArray = [NSMutableArray array];
    }
    return _rightBarBtnArray;
}

#pragma mark - BarButtonItem
//设置导航栏标题按钮
- (void)addLeftTitle:(NSString *)title action:(SEL)action
{
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleDone target:self action:action];
    [self.leftBarBtnArray addObject:barBtnItem];
    self.navigationItem.leftBarButtonItems = _leftBarBtnArray;
}

- (void)addRightTitle:(NSString *)title action:(SEL)action
{
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStyleDone target:self action:action];
    [self.rightBarBtnArray addObject:barBtnItem];
    self.navigationItem.rightBarButtonItems = _rightBarBtnArray;
}

//设置导航栏图片按钮
- (void)addLeftImage:(UIImage *)image action:(SEL)action
{
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:action];
    [self.leftBarBtnArray addObject:barBtnItem];
    self.navigationItem.leftBarButtonItems = _leftBarBtnArray;
}

- (void)addRightImage:(UIImage *)image action:(SEL)action
{
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:action];
    [self.rightBarBtnArray addObject:barBtnItem];
    self.navigationItem.rightBarButtonItems = _rightBarBtnArray;
}

- (void)addLeftBtn:(UIButton *)btn action:(SEL)action
{
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.leftBarBtnArray addObject:barBtnItem];
    self.navigationItem.leftBarButtonItems = _leftBarBtnArray;
}

- (void)addRightBtn:(UIButton *)btn action:(SEL)action
{
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.rightBarBtnArray addObject:barBtnItem];
    self.navigationItem.rightBarButtonItems = _rightBarBtnArray;
}

- (void)removeAllLeftBtns
{
    [self.leftBarBtnArray removeAllObjects];
    self.navigationItem.leftBarButtonItems = _leftBarBtnArray;
}

- (void)removeAllRightBtns
{
    [self.rightBarBtnArray removeAllObjects];
    self.navigationItem.rightBarButtonItems = _rightBarBtnArray;
}

#pragma mark - KeyBoard
//点击空白回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark - UIGestureRecognizerDelegate
//解决系统提供的侧滑失效问题
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController && [self.navigationController.viewControllers count] == 1)
    {
        return NO;
    }
    return YES;
}

//解决有水平方向滚动的ScrollView时边缘返回手势失效的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_webView showLoadingView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_webView dismissLoadingView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error
{
    [_webView dismissLoadingView];
}

#pragma mark - helper
//配置导航条底线
- (void)configureNaviBarLine
{
    //获取到导航底部的黑线控件
    UIImageView *bottomLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    //默认显示黑线
    bottomLineImageView.hidden = NO;
    
    if (_naviBarSystemLine_hidden)
    {
        bottomLineImageView.hidden = YES;
    }
    
    //自定义底线
    UIView *tabBarLineView = [self.navigationController.navigationBar viewWithTag:10001];
    
    if (!_naviBarCustomLine_color)
    {
        _naviBarCustomLine_color = kNaviCustomLine_color;
    }
    
    tabBarLineView.backgroundColor = _naviBarCustomLine_color;
    
    if (!_naviBarCustomLine_hidden)
    {
        _naviBarSystemLine_hidden = YES;
        bottomLineImageView.hidden = YES;
        
        if (!tabBarLineView)
        {
            tabBarLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.height - kNaviCustomLine_height, self.navigationController.navigationBar.width, kNaviCustomLine_height)];
            tabBarLineView.tag = 10001;
            tabBarLineView.alpha = 0.8;
            [self.navigationController.navigationBar addSubview:tabBarLineView];
        }
        
        tabBarLineView.hidden = NO;
        tabBarLineView.backgroundColor = _naviBarCustomLine_color;
    }
    else
    {
        if (tabBarLineView)
        {
            tabBarLineView.hidden = YES;
            tabBarLineView.backgroundColor = _naviBarCustomLine_color;
        }
    }
}

//查找到某视图高度小于1的UIImageView控件
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews)
    {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView)
        {
            return imageView;
        }
    }
    return nil;
}

#pragma mark - dealloc
- (void)dealloc
{
    for (int i = 0; i < _networkArray.count; i++)
    {
        
    }
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Memory
//内存警告处理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window)
    {
        self.view = nil;
    }
}

@end
