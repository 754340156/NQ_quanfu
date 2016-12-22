//
//  SelfBusinessVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/4.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SelfBusinessVC.h"  //自营速达
#import "GoodsHaveBtnStyleTableCell.h"  //带加入购物车的按钮样式的cell

#define kSelectedIndexInit  (-999)

//#import "PulldownView.h"    //二级下拉菜单
#import "SearchVC.h"          //搜索
#import "GoodsModel.h"        //商品的model


#define kBanner_W_H_Scale    (Banner_W_H_Scale + 1.0)
#define kHeight_pulldownMoreView    Adapted(50)

@interface SelfBusinessVC ()

//@property (nonatomic, strong) PulldownView *pulldownView;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) PulldownMoreView *pulldownView;
@property (nonatomic, assign) NSInteger seletcedID; //选中的菜单id


@end

static NSString *identifierCell = @"GoodsHaveBtnStyleTableCell";

@implementation SelfBusinessVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.menuArray = [NSMutableArray arrayWithArray:[Tools readFromSandBox:Key_SelfBusinessMenuList]];
    self.seletcedID = kSelectedIndexInit;
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = String(@"自营速达");
    
    //添加导航条右侧--购物车按钮
    UIButton *shoppingCartBtn = [QButton buttonWithType:UIButtonTypeCustom];
    shoppingCartBtn.frame = CGRectMake(0, 0, 30, 30);
    [shoppingCartBtn setImage:Image(@"gouwuche") forState:UIControlStateNormal];
    [self addRightBtn:shoppingCartBtn action:@selector(handleShoppingCart)];
    
    //添加导航条右侧--搜索按钮
    [self addRightImage:Image(@"sousuo") action:@selector(handleSearch)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    //先创建添加tableView
    self.tableView.frame = CGRectMake(0, 64 + kHeight_pulldownMoreView, self.view.width, self.view.height - 64 - kHeight_pulldownMoreView);
    [self.tableView registerClass:[GoodsHaveBtnStyleTableCell class] forCellReuseIdentifier:identifierCell];
    [_tableView setRefreshHeader:self.refreshHeader];
    [_tableView setRefreshFooter:self.refreshFooter];
    [self.view addSubview:_tableView];

    self.pulldownView = [[PulldownMoreView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, kHeight_pulldownMoreView) menuArray:[self.menuArray mutableCopy] configureBlcok:^(PulldownMoreView *pulldownMoreView) {
        
    } actionBlock:^(NSInteger selectedIndex) {
       
        SelfBusinessModel *model = self.menuArray[selectedIndex];
        self.seletcedID = model.id;
        //下拉刷新
        [self.refreshHeader beginRefreshing];
    }];
    [self.view addSubview:_pulldownView];
    
    WS(weakSelf)
    //监听菜单frame的变化
    [self.KVOController
     observe:self.pulldownView keyPath:@"frame" options:NSKeyValueObservingOptionNew block:^(id observer,id object,NSDictionary *change)
     {
         SS(strongSelf)
         strongSelf.tableView.frame = CGRectMake(0, _pulldownView.bottom, self.view.width, self.view.height - _pulldownView.bottom);
     }];
    
    [self requestMenuList]; //请求菜单
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    if (self.seletcedID == kSelectedIndexInit)
    {
        return;
    }
    NSDictionary *parameters = @{@"fid":@(_seletcedID)};
    WS(weakSelf)
    [self POST:API_SelfBusinessGoosList parameters:parameters success:^(NSDictionary *dic) {
        
        SS(strongSelf)
        [strongSelf.listArray removeAllObjects];
        NSArray *array = dic[kResponse];
        for (int i = 0; i < array.count; i++)
        {
            GoodsModel *model = [GoodsModel mj_objectWithKeyValues:array[i]];
            [strongSelf.listArray addObject:model];
        }
        [self.tableView reloadData];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:NO];
}

//请求菜单列表
- (void)requestMenuList
{
    self.menuArray = _menuArray;
    WS(weakSelf)
    [self POST:API_SelfBusinessMenuList parameters:nil success:^(NSDictionary *dic) {
        SS(strongSelf)
        [strongSelf.menuArray removeAllObjects];
        NSArray *array = dic[kResponse];
        for (int i = 0; i < array.count; i++)
        {
            SelfBusinessModel *model = [SelfBusinessModel mj_objectWithKeyValues:array[i]];
            [strongSelf.menuArray addObject:model];
        }
        [Tools writeToSandBox:strongSelf.menuArray key:Key_SelfBusinessMenuList];
        _pulldownView.menuArray = [strongSelf.menuArray mutableCopy];
        
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action
//添加导航条右侧--购物车按钮
- (void)handleShoppingCart
{
    
}

//添加导航条右侧--搜索按钮
- (void)handleSearch
{
    SearchVC *searchVC = [SearchVC new];
    searchVC.frontNC = self.navigationController;
    BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:searchVC];
    [self presentVC:nc animated:NO completion:nil];
}

#pragma mark - <UITableViewDataSource>
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _listArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsHaveBtnStyleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    GoodsModel *model = _listArray[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:identifierCell cacheByIndexPath:indexPath configuration:^(GoodsHaveBtnStyleTableCell* cell) {
        
        GoodsModel *model = _listArray[indexPath.row];
        cell.model = model;
        
    }];
}

#pragma mark - <SDCycleScrollViewDelegate>
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

#pragma mark - dealloc
- (void)dealloc
{
    //移除观察者
    [self.KVOController unobserveAll];
}

@end

@implementation SelfBusinessModel

- (NSString *)title
{
    return _teName;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.teName forKey:@"teName"];
    [aCoder encodeObject:[NSNumber numberWithLong:self.id] forKey:@"id"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.teName = [aDecoder decodeObjectForKey:@"teName"];
        NSNumber *ID = [aDecoder decodeObjectForKey:@"id"];
        self.id = ID.longValue;
    }
    return self;
}

@end
