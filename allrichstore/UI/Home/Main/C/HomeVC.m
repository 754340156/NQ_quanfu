//
//  HomeVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/27.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "HomeVC.h"                      //app首页
#import "HomeHeaderViewCell.h"          //头视图view
#import "HotSectionHeader.h"            //组头view
#import "HomeSection_RecommendHeader.h" //组头（推荐）view
#import "HomeListCell.h"                //菜单cell
#import "GoodsTwoListFirstStyleCell.h"  //第一种商品列表双列cell

#import "GoodsDetailVC.h"               //商品详情VC

#import "SelfBusinessVC.h"              //自营速达VC
#import "ChoiceGoodsVC.h"               //精选VC
#import "GoodsListFirstStyleVC.h"       //第一种商品列表VC
#import "GoodsListSecondStyleVC.h"      //第二种商品列表VC
#import "ShopsApplyVC.h"                //商家入驻VC

#import "LocationVC.h"                  //定位VC
#import "SearchVC.h"                    //搜索VC
#import "ShopHomeVC.h"                  //店铺首页VC
#import "MessageVC.h"                   //消息VC
#import "LoginVC.h"
#import "BannerModel.h"                 //banner列表的model
#import "ActivityListModel.h"           //活动列表model


//组头的高度
#define kSectionHeight  40

//优选cell的水平间距
#define ListCell_Space  1

//优选cell的宽度
#define ListCell_W  (collectionView.width - ListCell_Space * 2.0) / 3.0
//优选cell的高度
#define ListCell_H  ListCell_W

//双列商品cell的宽度
#define GoodsCell_W (collectionView.width - ListCell_Space * 1.0) / 2.0

@interface HomeVC ()<HomeHeaderViewCellDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *rightImgArray;
@property (nonatomic, strong) NSMutableArray *activityArray;

@end

static NSString *cellIdentifier_StyleHeader = @"cellIdentifier_StyleHeader";

static NSString *cellIdentifier_SectionHeader = @"cellIdentifier_SectionHeader";

static NSString *cellIdentifier_HomeSection_RecommendHeader = @"cellIdentifier_HomeSection_RecommendHeader";

static NSString *cellIdentifier_HotMogulCell = @"cellIdentifier_HotMogulCell";

static NSString *cellIdentifier_HotListCell_One = @"cellIdentifier_HotListCell_One";
static NSString *cellIdentifier_HotListCell_Tow = @"cellIdentifier_HotListCell_Tow";

static NSString *cellIdentifier_GoodsTwoListFirstStyleCell = @"cellIdentifier_GoodsTwoListFirstStyleCell";

static NSString *cellIdentifier_StyleMin = @"cellIdentifier_StyleMin";
static NSString *cellIdentifier_StyleMid = @"cellIdentifier_StyleMid";
static NSString *cellIdentifier_StyleMax = @"cellIdentifier_StyleMax";

@implementation HomeVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    //活动分组三种颜色循环
    self.colorArray = @[RGB(255, 122, 133), RGB(120, 201, 44), RGB(161, 142, 255)];
    self.rightImgArray = @[Image(@"homeSectionHeader_Btn1"), Image(@"homeSectionHeader_Btn2"), Image(@"homeSectionHeader_Btn5")];
    //app定位成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAppHaveLocAddress:)name:AppHadLocNotificationName object:nil];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
    //导航条-左侧-选择地区按钮
    QButton *locBtn = [Single locBtnTitle:[Single locStr]];
    [self addLeftBtn:locBtn action:@selector(handleLocation)];
    //导航条-右侧-消息按钮
    [self addRightImage:Image(@"xiaoxi") action:@selector(handleSystemMsg)];
    //导航条-中间-搜索栏
    [self addSearchTF];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    [self.view addSubview:self.collectionView];
    [_collectionView registerClass:[HomeHeaderViewCell class] forCellWithReuseIdentifier:cellIdentifier_StyleHeader];
    [_collectionView registerClass:[HotSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader];
    [_collectionView registerClass:[HomeSection_RecommendHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_HomeSection_RecommendHeader];
    [_collectionView registerClass:[HomeListCell class] forCellWithReuseIdentifier:cellIdentifier_HotListCell_One];
    [_collectionView registerClass:[HomeListCell class] forCellWithReuseIdentifier:cellIdentifier_HotListCell_Tow];
    [_collectionView registerClass:[GoodsTwoListFirstStyleCell class] forCellWithReuseIdentifier:cellIdentifier_GoodsTwoListFirstStyleCell];
    
    //添加下拉刷新和上拉加载
    [_collectionView setRefreshHeader:self.refreshHeader];
    [_collectionView setRefreshFooter:self.refreshFooter];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
}

//初始数据请求 (重写)
- (void)requestInitialData
{
    [self requestTopBanner];    //请求banner列表数据
    [self requestAdvertBanner]; //请求广告轮播的列表
}

#pragma mark - lazy
//活动的数组
- (NSMutableArray *)activityArray
{
    if (!_activityArray)
    {
        self.activityArray = [NSMutableArray array];
    }
    return _activityArray;
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    WS(weakSelf)
    
    //请求活动列表数据
    [self POST:API_FindActivity parameters:nil success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        self.activityArray = [ActivityListModel mj_objectArrayWithKeyValuesArray:array];
        [weakSelf.collectionView reloadData];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:NO];
}

//请求顶部banner列表
- (void)requestTopBanner
{
    NSDictionary *parameters = @{@"id":BannerID_homeTop};
    [self POST_:API_BannerList parameters:parameters success:^(NSDictionary *dic) {
       
        NSArray *array = dic[kResponse];
        NSArray *resultArray = [BannerModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:resultArray key:Key_BannerListById(BannerID_homeTop)];
        HomeHeaderViewCell *headerViewCell = (HomeHeaderViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        headerViewCell.cycleScrollView.modelArray = resultArray;
        
    } fail:^(NSError *error) {
        
    }];
}

//请求广告轮播的列表
- (void)requestAdvertBanner
{
    NSDictionary *parameters = @{@"id":BannerID_homeAdvert};
    [self POST_:API_BannerList parameters:parameters success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        NSArray *resultArray = [BannerModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:resultArray key:Key_BannerListById(BannerID_homeAdvert)];
        HomeHeaderViewCell *headerViewCell = (HomeHeaderViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        headerViewCell.bottomCycleScrollView.modelArray = resultArray;
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark - custom method
//导航条-中间-搜索栏
- (void)addSearchTF
{
    //中间的搜索栏
    UITextField *searchTF = [[UITextField alloc] init];
    [searchTF setBackground:[[UIImage imageWithColor:QFColor_SearchBarBg size:CGSizeMake(100, 30)]roundedCornerImage:5 borderSize:0]];
    searchTF.delegate = self;
    searchTF.layer.masksToBounds = YES;
    searchTF.layer.cornerRadius = 5.0;
    searchTF.layer.borderColor = [UIColor colorWithWhite:0.86 alpha:1.0].CGColor;
    searchTF.layer.borderWidth = 0.5;
    searchTF.backgroundColor = QFColor_SearchBarBg;
    searchTF.bounds = CGRectMake(0, 0, kScreenW, 30);
    searchTF.font = Font(14);
    searchTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:String(@"搜索宝贝") attributes:@{NSForegroundColorAttributeName: kGrayColor}];
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.bounds = CGRectMake(0, 0, 40, 30);
    UIImage *image = Image(@"sousuokuang_fangdajing");
    [leftBtn setImage:image forState:UIControlStateNormal];
    leftBtn.userInteractionEnabled = NO;
    searchTF.leftView = leftBtn;
    
    self.navigationItem.titleView = searchTF;
}

#pragma mark - handle action
//导航条左侧 -- 定位按钮
- (void)handleLocation
{
    NSArray *array = [Tools readFromSandBox:LocationArrayKey];
    if (!array)
    {
        array = @[@"北京", @"安徽", @"重庆", @"福建", @"甘肃", @"广东省", @"呼和浩特", @"乌鲁木齐"];
        [Tools writeToSandBox:array key:LocationArrayKey];
    }
    
    LocationVC *locationVC = [LocationVC new];
    locationVC.homeVC = self;
    BaseNC *nc = [[BaseNC alloc] initWithRootViewController:locationVC];
    [self presentVC:nc animated:YES completion:nil];
}

//导航条右侧 -- 系统右侧
- (void)handleSystemMsg
{
    MessageVC *messageVC = [MessageVC new];
    //进入消息界面
    [self.navigationController pushVC:messageVC animated:YES];
}

//定位成功的通知
- (void)handleAppHaveLocAddress:(NSNotification *)notification
{
    //定位成功刷新首页
    
    
    //2选1（静止刷新/下拉刷新）
    //静止刷新
    //[self requestListDataAnimation:NO];
    
    //下拉刷新
    [self.refreshHeader beginRefreshing];
}

//点击组头 -- 触发事件
- (void)handleSectionHeaderBtn:(UIButton *)sender
{
    NSInteger section = sender.tag - 1001;
    ActivityListModel *listModel = _activityArray[section - 1];
    //跳转 -> 商品列表VC
    GoodsListFirstStyleVC *goodsListVC = [GoodsListFirstStyleVC new];
    goodsListVC.cId = listModel.aid;
    goodsListVC.inType = @"2";
    goodsListVC.navigationItem.title = String(@"商品列表");
    [self.navigationController pushVC:goodsListVC animated:YES];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = CGSizeZero;
    NSInteger section = indexPath.section;
    if (section == 0)
    {
        cellSize = CGSizeMake(collectionView.width, [HomeHeaderViewCell cellHeight]);
    }
    else if (section > 0 && section <= _activityArray.count)
    {
        cellSize = CGSizeMake(ListCell_W, ListCell_H);
    }
    else
    {
        CGFloat cellHeight = [GoodsTwoListFirstStyleCell cellHeight];
        cellSize = CGSizeMake(GoodsCell_W, cellHeight);
    }
    
    return cellSize;
}

//每个组的edge
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

//每组的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//每组的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return ListCell_Space;
}

//每组 组头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return CGSizeZero;
    }
    else
    {
        return CGSizeMake(ListCell_W, kSectionHeight);
    }
}

//每组 组尾的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDataSource>
//collectionView包含的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _activityArray.count + 2;
}

//每一组的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (section == 0)
    {
        count = 1;
    }
    else if (section > 0 && section <= _activityArray.count)
    {
        ActivityListModel *listModel = _activityArray[section - 1];
        NSArray *array = listModel.categroylist;
        count = array.count;
    }
    else
    {
        count = 12;
    }
    return count;
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_StyleHeader forIndexPath:indexPath];
        HomeHeaderViewCell *headerCell = (HomeHeaderViewCell *)cell;
        headerCell.delegate = self;
    }
    else if (indexPath.section > 0 && indexPath.section <= _activityArray.count)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_HotListCell_One forIndexPath:indexPath];
        HomeListCell *listCell = (HomeListCell *)cell;
        ActivityListModel *listModel = _activityArray[indexPath.section - 1];
        ActivitySubModel *model = listModel.categroylist[indexPath.row];
        listCell.model = model;
        NSString *imgString = [NSString stringWithFormat:@"goods%ld", indexPath.row + 1];
        UIImage *image = ImageStr(imgString);
        listCell.imgView.image = image;
    }
    else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_GoodsTwoListFirstStyleCell forIndexPath:indexPath];
        GoodsTwoListFirstStyleCell *listCell = (GoodsTwoListFirstStyleCell *)cell;
        NSInteger num = indexPath.row % 2 + 1;
        NSString *imgString = [NSString stringWithFormat:@"goodsPic%ld", num];
        UIImage *image = ImageStr(imgString);
        
        listCell.imgView.image = image;
        listCell.titleLabel.text = @"秋装新款简约百搭圆领衬衫纯色打底衬衫女";
        listCell.priceLabel.text = @"¥999.00";
        listCell.evaluatNumLabel.text = @"99条评价";
        listCell.praiseRateLabel.text = @"好评99%";
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (indexPath.section <= _activityArray.count)
        {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader forIndexPath:indexPath];
            
            HotSectionHeader *hotSectionHeader = (HotSectionHeader *)reusableview;
            NSInteger index = (indexPath.section - 1) % 3;
            [hotSectionHeader.rightBtn setImage:_rightImgArray[index] forState:(UIControlStateNormal)];
            ActivityListModel *listModel = _activityArray[indexPath.section - 1];
            hotSectionHeader.leftLabel.text = listModel.am_name;
            hotSectionHeader.leftLabel.textColor = _colorArray[index];
            hotSectionHeader.rightBtn.tag = indexPath.section + 1001;
            [hotSectionHeader.rightBtn addTarget:self action:@selector(handleSectionHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_HomeSection_RecommendHeader forIndexPath:indexPath];
        }
    }
    
    return reusableview;
}

#pragma mark - <UICollectionViewDelegate>
//item的点击触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0 && indexPath.section <= 5)
    {//如果是活动cell
        //跳转 -> 商品列表VC
        ActivityListModel *listModel = _activityArray[indexPath.section - 1];
        ActivitySubModel *subModel = listModel.categroylist[indexPath.row];
        GoodsListFirstStyleVC *goodsListVC = [GoodsListFirstStyleVC new];
        goodsListVC.cId = subModel.cid;
        goodsListVC.inType = @"2";
        goodsListVC.navigationItem.title = String(@"商品列表");
        [self.navigationController pushVC:goodsListVC animated:YES];
    }
    
    if (indexPath.section > 5)
    {///如果是推荐的商品cell
        //跳转 -> 跳转至商品详情VC
        GoodsDetailVC *detailVC = [[GoodsDetailVC alloc] init];
        [self.navigationController pushVC:detailVC animated:YES];
    }
    
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    SearchVC *searchVC = [SearchVC new];
    searchVC.frontNC = self.navigationController;
    BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:searchVC];
    [self presentVC:nc animated:NO completion:nil];
    return NO;
}

#pragma mark - <HomeHeaderViewCellDelegate>
- (void)homeHeaderViewCell:(HomeHeaderViewCell *)cell didSelectedIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
        {
            //自营速达
            SelfBusinessVC *selfBusinessVC = [SelfBusinessVC new];
            [self.navigationController pushVC:selfBusinessVC animated:YES];
        }
            break;
        case 1:
        {
            //精品推荐
            GoodsListFirstStyleVC *choiceVC = [GoodsListFirstStyleVC new];
            choiceVC.navigationItem.title = String(@"精品推荐");
            choiceVC.inType = @"3";
            choiceVC.cId = @"1";
            [self.navigationController pushVC:choiceVC animated:YES];
        }
            break;
        case 2:
        {
            //全富特色
            GoodsListSecondStyleVC *allRichVC = [GoodsListSecondStyleVC new];
            allRichVC.navigationItem.title = String(@"全富特色");
            allRichVC.inType = @"3";
            allRichVC.cId = @"2";
            [self.navigationController pushVC:allRichVC animated:YES];
        }
            break;
        case 3:
        {
            //商家入驻
            ShopsApplyVC *applyVC = [[ShopsApplyVC alloc] init];
            applyVC.title = String(@"商家入驻");
            [self.navigationController pushVC:applyVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
