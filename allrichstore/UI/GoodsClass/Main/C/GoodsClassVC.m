//
//  GoodsClassVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/27.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsClassVC.h"
#import "GoodsClassCell.h"          //分类菜单的cell
#import "MenuHeaderView.h"          //组头
#import "GoodsListFirstStyleVC.h"   //商品列表
#import "GoodsClassModel.h"         //一级商品分类model
#import "GoodClassTwoLevelModel.h"  //二三级商品分类model

#define kHeight_sectionHeader   Adapted(48)

@interface GoodsClassVC ()

//@property (nonatomic, strong) FoldMenuView *foldMenuView;
@property (nonatomic, strong) TabMenuView *tabMenuView;
@property (nonatomic, strong) NSMutableArray *oneLevelArray;
@property (nonatomic, strong) NSMutableArray *twoLevelArray;

@end

static NSString *identifierGoodsClassCell = @"GoodsClassCell";
static NSString *identifierMenuHeaderView = @"MenuHeaderView";

@implementation GoodsClassVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.oneLevelArray = [NSMutableArray arrayWithArray:[Tools readFromSandBox:Key_goodsClass_oneLevel]] ;
    self.twoLevelArray = [NSMutableArray array];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    //关闭自动inset
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    //添加右侧二三级分类（collectionView）
    self.collectionView.frame = CGRectMake(kFoldMenuView_Width + kCollectionCell_Margin, 0, kCollectionView_Width, self.view.height);
    _collectionView.backgroundColor = kClearColor;
    _collectionView.alwaysBounceVertical = YES;
    [_collectionView registerClass:[GoodsClassCell class] forCellWithReuseIdentifier:identifierGoodsClassCell];
    [_collectionView registerClass:[MenuHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierMenuHeaderView];
    _collectionView.insets = UIEdgeInsetsMake(64, 0, 49, 0);
    [self.view addSubview:_collectionView];
    
    //添加左侧一级分类（tableView）
    self.tabMenuView = [[TabMenuView alloc] initWithFrame:CGRectMake(0, 0, kFoldMenuView_Width, self.view.height) menuArray:[_oneLevelArray mutableCopy] configure:^(TabMenuView *tabMenuView) {
        
        tabMenuView.tableView.insets = UIEdgeInsetsMake(64, 0, 49, 0);
        
    } action:^(NSInteger selectedIndex) {
        
        //根据一级model的信息-->请求二三级的数据
        GoodsClassModel *model = _oneLevelArray[selectedIndex];
        NSNumber *cPidNumber = @(model.cPid);
        [self requestTwoAndThreeLevelDataWithCpid:cPidNumber];
    }];
    [self.view addSubview:_tabMenuView];
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
    //如果本地没有缓存的一级菜单数组，就展示加载一级菜单的loading
    if (!_oneLevelArray.count)
    {
        [self.view showLoadingView];
    }
    
    [self POST_:API_GoodsClass_FirstLevel parameters:nil success:^(NSDictionary *dic) {
        
        NSArray *array = dic[@"response"];
        [self.oneLevelArray removeAllObjects];
        for (int j = 0; j < 10; j++)
        {
            for (int i = 0; i < array.count; i++)
            {
                NSDictionary *mDic = array[i];
                GoodsClassModel *model = [GoodsClassModel mj_objectWithKeyValues:mDic];
                [self.oneLevelArray addObject:model];
            }
        }
        
        [Tools writeToSandBox:_oneLevelArray key:Key_goodsClass_oneLevel];
        _tabMenuView.menuArray = [_oneLevelArray mutableCopy];
        [self.view dismissLoadingView];
        
    } fail:^(NSError *error) {
        
        [self.view dismissLoadingView];
    }];
}

//请求二三级分类的数据
- (void)requestTwoAndThreeLevelDataWithCpid:(NSNumber *)cPid
{
    NSDictionary *parameters = @{@"cPid":cPid};
    [self POST:API_GoodsClass_SecondAndThirdLevel parameters:parameters success:^(NSDictionary *dic)
    {
        NSArray *array = dic[@"response"];
        [self.twoLevelArray removeAllObjects];
        for (int i = 0; i < array.count; i++)
        {
            NSDictionary *mDic = array[i];
            GoodClassTwoLevelModel *model = [GoodClassTwoLevelModel mj_objectWithKeyValues:mDic];
            [self.twoLevelArray addObject:model];
        }
        [self.collectionView setContentOffset:CGPointMake(0, -self.collectionView.contentInset.top) animated:NO];
        [self.collectionView reloadData];
        
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.collectionView animated:YES];
}

#pragma mark - custom method

#pragma mark - handle action
//点击组头 -- 触发事件
- (void)handleSectionHeaderBtn:(UIButton *)sender
{
    NSInteger section = sender.tag - 1001;
    GoodClassTwoLevelModel *twoLevelModel = _twoLevelArray[section];
    //商品列表
    GoodsListFirstStyleVC *goodsListVC = [GoodsListFirstStyleVC new];
    goodsListVC.cId = twoLevelModel.ID;
    goodsListVC.inType = @"1";
    goodsListVC.navigationItem.title = String(@"商品列表");
    [self.navigationController pushVC:goodsListVC animated:YES];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = [GoodsClassCell cellHeight];
    return CGSizeMake(kCollectionCell_Width, cellHeight);
}

//每组的edge
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
    return 0;
}

//每组 组头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kCollectionView_Width, kHeight_sectionHeader);
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
    return _twoLevelArray.count;
}

//每一组的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    GoodClassTwoLevelModel *model = _twoLevelArray[section];
    NSInteger count = model.thrid.count;
    return count;
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierGoodsClassCell forIndexPath:indexPath];
    
    GoodClassTwoLevelModel *twoLevelModel = _twoLevelArray[indexPath.section];
    GoodsClassModel *threeLevelModel = twoLevelModel.thrid[indexPath.row];
    cell.model = threeLevelModel;
    
//    NSInteger num = (indexPath.row) % 6 + 1;
//    NSString *imageNameString = [NSString stringWithFormat:@"threeImg%ld", num];
//    cell.imgView.image = ImageStr(imageNameString);
//    cell.titleLabel.text = @"垃圾桶";
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierMenuHeaderView forIndexPath:indexPath];
        
        MenuHeaderView *sectionHeader = (MenuHeaderView *)reusableview;
        //sectionHeader.backgroundColor = self.view.backgroundColor;
        sectionHeader.titleLabel.text = @"居家日用";
        GoodClassTwoLevelModel *twoLevelModel = _twoLevelArray[indexPath.section];
        sectionHeader.titleLabel.text = twoLevelModel.cName;
        sectionHeader.btn.tag = indexPath.section + 1001;
        [sectionHeader.btn addTarget:self action:@selector(handleSectionHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
    }
    
    return reusableview;
}

#pragma mark - <UICollectionViewDelegate>
//item的点击触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodClassTwoLevelModel *twoLevelModel = _twoLevelArray[indexPath.section];
    GoodsClassModel *threeLevelModel = twoLevelModel.thrid[indexPath.row];
    //商品列表
    GoodsListFirstStyleVC *goodsListVC = [GoodsListFirstStyleVC new];
    goodsListVC.cId = [NSString stringWithFormat:@"%ld", threeLevelModel.cPid];
    goodsListVC.inType = @"1";
    goodsListVC.navigationItem.title = String(@"商品列表");
    [self.navigationController pushVC:goodsListVC animated:YES];
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
