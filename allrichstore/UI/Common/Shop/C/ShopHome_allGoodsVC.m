//
//  ShopHome_allGoodsVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopHome_allGoodsVC.h"

#import "CollectionViewChangeLayout.h"  //布局类
#import "GoodsOneListFirstStyleCell.h"  //单列cell
#import "GoodsTwoListFirstStyleCell.h"  //双列cell
#import "GoodsModel.h"                  //商品model

#define ListCell_Space  1

#define ListGoodsCell_W (collectionView.width - ListCell_Space * 1.0) / 2.0

@interface ShopHome_allGoodsVC ()<ButtonsViewDelegate>

/**  顶部标题栏 */
@property (nonatomic, strong) ButtonsView *btnsView;

@end

@implementation ShopHome_allGoodsVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    
    for (NSInteger i = 0; i < 20; i++) {
        GoodsModel *model = [[GoodsModel alloc] init];
        NSInteger num = i % 2 + 1;
        NSString *imgString = [NSString stringWithFormat:@"goodsPic%ld", (long)num];
        model.g_imgurl = imgString;
        model.g_name = @"秋装新款简约百搭圆领衬衫纯色打底衬衫女";
        model.g_commentcount = 999;
        model.g_price = 1999.00;
        model.g_famerate = @"99%";
        model.g_paysum = 220;
        model.g_site = @"浙江杭州";
        [self.listArray addObject:model];
    }
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    [self.view addSubview:self.collectionView];
    
    //头部title栏
    self.btnsView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, 64 + Adapted(66) + 60 + 10, self.view.width, 44) btnTitles:@[String(@"销量优先"), String(@"评价数"), String(@"价格"), @""] titleColor:[UIColor grayColor] selectedColor:QF_RedColor];
    _btnsView.backgroundColor = Color_CustomEffectViewbg;
    _btnsView.effectView.alpha = 1.0;
    _btnsView.delegate = self;
    _btnsView.titleFont = Font(13);
    
    [_btnsView addBottomLineWithStyle:LineLayoutStyleOutside];
    
    //价格按钮
    QButton *priceBtn = _btnsView.btns[2];
    priceBtn.style = QButtonStyleImageRight;
    priceBtn.space = 2.0;
    
    //筛选按钮
    QButton *changeLayoutBtn = _btnsView.btns[3];
    [changeLayoutBtn setImage:Image(@"shangxiapailie") forState:UIControlStateNormal];
    [changeLayoutBtn setImage:Image(@"zuoyoupailie") forState:UIControlStateSelected];
    //移除“更改布局按钮”在ButtonsView中的事件关联
    [changeLayoutBtn removeTarget:_btnsView action:@selector(handleTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    //在本控制器添加“更改布局按钮”的事件
    [changeLayoutBtn addTarget:self action:@selector(handleChangeLayoutBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [priceBtn setImage:Image(@"priceRank_normal") forQButtonState:QButtonNormalStateNormal];
    [priceBtn setImage:Image(@"priceRank_normal") forQButtonState:QButtonNormalStateSelected];
    [priceBtn setImage:Image(@"priceRank_selected_normal") forQButtonState:QButtonSelectedStateNormal];
    [priceBtn setImage:Image(@"priceRank_selected_selected") forQButtonState:QButtonSelectedStateSelected];
    
    [self.view addSubview:self.collectionView];
    _collectionView.backgroundColor = QFColor_splitLine_Color;
    
    [self.view addSubview:_btnsView];

    
    [_collectionView setContentInset:UIEdgeInsetsMake(64 + Adapted(66) + 60 + 10 + _btnsView.height, 0, Layout_customBar_height, 0)];
    [_collectionView setScrollIndicatorInsets:UIEdgeInsetsMake(64 + Adapted(66) + 60 + 10 + _btnsView.height, 0, Layout_customBar_height, 0)];
    

    //默认是列表样式
    CollectionViewChangeLayout *layout = [[CollectionViewChangeLayout alloc] initWithType:ChangeLayoutList];
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerClass:[GoodsOneListFirstStyleCell class] forCellWithReuseIdentifier:[GoodsOneListFirstStyleCell className]];
    [self.collectionView registerClass:[GoodsTwoListFirstStyleCell class] forCellWithReuseIdentifier:[GoodsTwoListFirstStyleCell className]];
    
    [_collectionView setMj_footer:self.refreshFooter];
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
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action
//更改布局按钮 -- 触发事件
- (void)handleChangeLayoutBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    CollectionViewChangeLayout *layout = (CollectionViewChangeLayout *)self.collectionView.collectionViewLayout;
    sender.selected ?(layout.type = ChangeLayoutHorizontal):(layout.type = ChangeLayoutList);
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = CGSizeZero;
    
    CollectionViewChangeLayout *layout = (CollectionViewChangeLayout *) collectionView.collectionViewLayout;
    if (layout.type == ChangeLayoutList)
    {
        CGFloat cellHeight = [GoodsTwoListFirstStyleCell cellHeight];
        cellSize = CGSizeMake(ListGoodsCell_W, cellHeight);
        
    }
    else if (layout.type == ChangeLayoutHorizontal)
    {
        CGFloat cellHeight = [GoodsOneListFirstStyleCell cellHeight];
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
        GoodsTwoListFirstStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GoodsTwoListFirstStyleCell className] forIndexPath:indexPath];
        cell.model = self.listArray[indexPath.row];
        NSInteger num = indexPath.row % 2 + 1;
        NSString *imgString = [NSString stringWithFormat:@"goodsPic%ld", num];
        cell.imgView.image = ImageStr(imgString);
        return cell;
    }
    else if (layout.type == ChangeLayoutHorizontal)
    {
        GoodsOneListFirstStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GoodsOneListFirstStyleCell className] forIndexPath:indexPath];
        cell.model = self.listArray[indexPath.row];
        NSInteger num = indexPath.row % 2 + 1;
        NSString *imgString = [NSString stringWithFormat:@"goodsPic%ld", num];
        cell.imgView.image = ImageStr(imgString);
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转详情
    GoodsDetailVC *detailVC = [[GoodsDetailVC alloc] init];
    [self.navigationController pushVC:detailVC animated:YES];
}

#pragma mark - <ButtonsViewDelegate>
- (void)btsView:(ButtonsView *)btnView IsClicked:(UIButton *)btn atIndex:(NSInteger)index isRepeatTouch:(BOOL)isRepeatTouch
{
    if (btnView == _btnsView)
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.width * index, 0) animated:YES];
        
        switch (index)
        {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                if (isRepeatTouch)
                {
                    ((QButton *)btn).qbSelected = !((QButton *)btn).qbSelected;
                }
            }
                break;
            case 3:
            {
                
            }
                break;
            default:
                break;
        }
    }
}



#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
