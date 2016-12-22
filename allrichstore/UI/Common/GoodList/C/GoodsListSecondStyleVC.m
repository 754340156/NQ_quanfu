//
//  GoodsListSecondStyleVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsListSecondStyleVC.h"      //第二种商品列表VC
#import "CollectionViewChangeLayout.h"  //布局类
#import "GoodsOneListSecondStyleCell.h" //第二种单列cell
#import "GoodsTwoListSecondStyleCell.h" //第二种双列cell
#import "GoodsModel.h"                   //商品的Model

#import "SearchVC.h"                    //搜索
#import "GoodsFilterVC.h"               //商品筛选控制器

#define ListCell_Space  1

#define ListGoodsCell_W (collectionView.width - ListCell_Space * 1.0) / 2.0

@interface GoodsListSecondStyleVC ()<ButtonsViewDelegate>

//顶部标题栏
@property (nonatomic, strong) ButtonsView *btnsView;
//顶部标题栏数组
@property (nonatomic, strong) NSArray *titlesArr;
//筛选model
@property (nonatomic, strong) GoodsFilterModel *filterModel;
//商品排列条件
@property (nonatomic, strong) NSArray *fieIdArray;

@end

@implementation GoodsListSecondStyleVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.titlesArr = @[@"销量优先", @"评价数", @"价格", @"筛选"];
    self.fieIdArray = @[@"one", @"two", @"three", @"four"];
    self.cField = _fieIdArray[0];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    //self.naviBarCustomLine_hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //导航栏配置
    [self addLayoutBtn];    //添加右侧布局按钮
    [self addSearchBtn];    //添加右侧搜索按钮
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    //头部title栏
    self.btnsView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 44) btnTitles:self.titlesArr titleColor:[UIColor grayColor] selectedColor:QF_RedColor];
    _btnsView.backgroundColor = Color_CustomEffectViewbg;
    _btnsView.effectView.alpha = 1.0;
    _btnsView.delegate = self;
    _btnsView.titleFont = Font(13);
    [_btnsView addBottomLineWithHeight:0.7 style:LineLayoutStyleOutside];
    
    //价格按钮
    QButton *priceBtn = _btnsView.btns[2];
    priceBtn.style = QButtonStyleImageRight;
    priceBtn.space = 2.0;
    
    //筛选按钮
    QButton *filterBtn = _btnsView.btns[3];
//    priceBtn.style = QButtonStyleImageRight;
//    priceBtn.space = 2.0;
    //移除筛选按钮在ButtonsView中的事件关联
    [filterBtn removeTarget:_btnsView action:@selector(handleTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    //在本控制器添加弹出筛选面板的事件
    [filterBtn addTarget:self action:@selector(handleShowFilterView:) forControlEvents:UIControlEventTouchUpInside];

    [priceBtn setImage:Image(@"priceRank_normal") forQButtonState:QButtonNormalStateNormal];
    [priceBtn setImage:Image(@"priceRank_normal") forQButtonState:QButtonNormalStateSelected];
    [priceBtn setImage:Image(@"priceRank_selected_normal") forQButtonState:QButtonSelectedStateNormal];
    [priceBtn setImage:Image(@"priceRank_selected_selected") forQButtonState:QButtonSelectedStateSelected];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:_btnsView];
    
    CGFloat bottomMargin = self.hidesBottomBarWhenPushed ? 0 : 49;
    
    [self.collectionView setContentInset:UIEdgeInsetsMake(64 + _btnsView.height, 0, bottomMargin, 0)];
    [self.collectionView setScrollIndicatorInsets:UIEdgeInsetsMake(64 + _btnsView.height, 0, bottomMargin, 0)];
    //默认是列表样式
    CollectionViewChangeLayout *layout = [[CollectionViewChangeLayout alloc] initWithType:ChangeLayoutList];
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerClass:[GoodsOneListSecondStyleCell class] forCellWithReuseIdentifier:[GoodsOneListSecondStyleCell className]];
    [self.collectionView registerClass:[GoodsTwoListSecondStyleCell class] forCellWithReuseIdentifier:[GoodsTwoListSecondStyleCell className]];
    
    [_collectionView setRefreshHeader:self.refreshHeader];
    [_collectionView setRefreshFooter:self.refreshFooter];
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
    NSDictionary *parameters = @{@"id":_cId, @"field":_cField, @"lType":_inType, @"pageNum":@(_pageIndex), @"pageSize":@(PageSize_list)};
    WS(weakSelf)
    [self POST:API_GoodsList parameters:parameters success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        [self.listArray addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:array]];
        [weakSelf.collectionView reloadData];
        
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.view animated:animated];
}

#pragma mark - custom method
//添加右侧布局按钮
- (void)addLayoutBtn
{
    QButton *changeLayoutBtn = [QButton buttonWithType:UIButtonTypeCustom];
    changeLayoutBtn.frame = CGRectMake(0, 0, 30, 30);
    [changeLayoutBtn setImage:Image(@"shangxiapailie") forState:UIControlStateNormal];
    [changeLayoutBtn setImage:Image(@"zuoyoupailie") forState:UIControlStateSelected];
    [self addRightBtn:changeLayoutBtn action:@selector(changeLayoutAction:)];
}

//添加右侧搜索按钮
- (void)addSearchBtn
{
    [self addRightImage:Image(@"sousuo") action:@selector(searchAction)];
}

#pragma mark - handle action
//搜索
- (void)searchAction
{
    SearchVC *searchVC = [SearchVC new];
    searchVC.frontNC = self.navigationController;
    BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:searchVC];
    [self presentVC:nc animated:NO completion:nil];
}

//改变布局
- (void)changeLayoutAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    CollectionViewChangeLayout *layout = (CollectionViewChangeLayout *)self.collectionView.collectionViewLayout;
    sender.selected ?(layout.type = ChangeLayoutHorizontal):(layout.type = ChangeLayoutList);
    [self.collectionView reloadData];
}

//筛选按钮 -- 弹出筛选
- (void)handleShowFilterView:(QButton *)sender
{
    if (!_filterModel)
    {
        self.filterModel = [GoodsFilterModel new];
        NSMutableArray *muArray = [NSMutableArray array];
        NSArray *nameArray = @[@"品牌", @"尺寸", @"适用人群"];
        for (int i = 0; i < nameArray.count; i++)
        {
            GoodsPropertyModel *properModel = [GoodsPropertyModel new];
            properModel.propertyName = nameArray[i];
            if (i == 0)
            {
                properModel.tagArray = @[@"阿尼玛", @"化石", @"HM", @"百雀羚", @"梦妆", @"曼秀雷敦"];
            }
            else if(i == 1)
            {
                properModel.tagArray = @[@"S", @"M", @"L", @"XL", @"XXL", @"XXXL"];
            }
            else
            {
                properModel.tagArray = @[@"男", @"女", @"儿童", @"青少年", @"老人"];
            }
            
            properModel.selectedTagArray = [NSMutableArray array];
            
            [muArray addObject:properModel];
        }
        
        _filterModel.properArray = muArray;
    }
    
    
    GoodsFilterVC *goodsFilterVC = [[GoodsFilterVC alloc] initWithSlideType:SlideTypeFromRight model:_filterModel completeBlock:^(id<GoodsFilterAble> resultObject) {
        
        [goodsFilterVC dismissViewControllerAnimated:YES completion:nil];
    }];
    
    goodsFilterVC.windowViewWidth = self.view.width * 4 / 5.0;
    [self.appDelegate.window.rootViewController presentVC:goodsFilterVC animated:NO completion:nil];
}

#pragma mark - ChoiceGoodsTitleViewDelegate
- (void)ChoiceGoodsTitleViewDelegate_clickBtn:(UIButton *)sender
{
    
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = CGSizeZero;
    
    CollectionViewChangeLayout *layout = (CollectionViewChangeLayout *) collectionView.collectionViewLayout;
    if (layout.type == ChangeLayoutList)
    {
        CGFloat cellHeight = [GoodsTwoListSecondStyleCell cellHeight];
        cellSize = CGSizeMake(ListGoodsCell_W, cellHeight);
    }
    else if (layout.type == ChangeLayoutHorizontal)
    {
        CGFloat cellHeight = [GoodsOneListSecondStyleCell cellHeight];
        cellSize = CGSizeMake(collectionView.width, cellHeight);
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
        return CGSizeMake(collectionView.width, Adapted(46));
    }
}

//每组 组尾的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewChangeLayout *layout = (CollectionViewChangeLayout *) collectionView.collectionViewLayout;
    if (layout.type == ChangeLayoutList) {
        GoodsTwoListSecondStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GoodsTwoListSecondStyleCell className] forIndexPath:indexPath];
        cell.model = self.listArray[indexPath.row];
        return cell;
    }
    else if (layout.type == ChangeLayoutHorizontal)
    {
        GoodsOneListSecondStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GoodsOneListSecondStyleCell className] forIndexPath:indexPath];
        cell.model = self.listArray[indexPath.row];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转详情
    GoodsDetailVC *detailVC = [[GoodsDetailVC alloc] init];
    GoodsModel *model = _listArray[indexPath.row];
    detailVC.goodId = [NSString stringWithFormat:@"%ld", model.goodid];
    [self.navigationController pushVC:detailVC animated:YES];
}

#pragma mark - <ButtonsViewDelegate>
- (void)btsView:(ButtonsView *)btnView IsClicked:(UIButton *)btn atIndex:(NSInteger)index isRepeatTouch:(BOOL)isRepeatTouch
{
    switch (index)
    {
        case 0:
        {
            _cField = _fieIdArray[0];
            [self.refreshHeader beginRefreshing];
        }
            break;
        case 1:
        {
            _cField = _fieIdArray[1];
            [self.refreshHeader beginRefreshing];
        }
            break;
        case 2:
        {
            
            if (isRepeatTouch)
            {
                ((QButton *)btn).qbSelected = !((QButton *)btn).qbSelected;
                if (((QButton *)btn).qbSelected) {
                    _cField = _fieIdArray[2];
                } else {
                    _cField = _fieIdArray[3];
                }
                
            }
            else
            {
                _cField = _fieIdArray[3];
            }
            [self.refreshHeader beginRefreshing];
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
