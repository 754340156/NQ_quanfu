//
//  ShopHome_homeVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopHome_homeVC.h"
#import "ShopCycleScrollCell.h"         //店铺活动轮播图cell
#import "HomeSection_RecommendHeader.h" //组头
#import "GoodsTwoListSecondStyleCell.h" //商品cell
#import "GoodsModel.h"                  //商品model


#define ListCell_Space  1

#define GoodsCell_W (collectionView.width - ListCell_Space * 1.0) / 2.0

@interface ShopHome_homeVC ()

@end

@implementation ShopHome_homeVC

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
    _collectionView.backgroundColor = QFColor_splitLine_Color;
    [_collectionView registerClass:[GoodsTwoListSecondStyleCell class] forCellWithReuseIdentifier:[GoodsTwoListSecondStyleCell className]];
    [_collectionView registerClass:[ShopCycleScrollCell class] forCellWithReuseIdentifier:[ShopCycleScrollCell className]];
    [_collectionView registerClass:[HomeSection_RecommendHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HomeSection_RecommendHeader className]];
    
    [_collectionView setContentInset:UIEdgeInsetsMake(64 + Adapted(66) + 60 + 10, 0, Layout_customBar_height, 0)];
    [_collectionView setScrollIndicatorInsets:UIEdgeInsetsMake(64 + Adapted(66) + 60 + 10, 0, Layout_customBar_height, 0)];
    
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


#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = [GoodsTwoListSecondStyleCell cellHeight];
    CGSize cellSize = CGSizeMake(GoodsCell_W, cellHeight);
    if (indexPath.section == 0)
    {
        
        cellSize = CGSizeMake(collectionView.width, collectionView.width / Banner_Shop_W_H_Scale + 50);
    }
    return cellSize;
}

//每个item的edge
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
    if (section != 0)
    {
        return CGSizeMake(_collectionView.width, Layout_home_sectionHeader_height);
    }
    return CGSizeZero;
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
    return 2;
}

//每一组的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return self.listArray.count;
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        ShopCycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ShopCycleScrollCell className] forIndexPath:indexPath];
        cell.activityArray = @[@"满100送100", @"满100送50", @"满100送10", @"满100送100", @"满100送50", @"满100送10"];
        return cell;
    }
    else
    {
        GoodsTwoListSecondStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GoodsTwoListSecondStyleCell className] forIndexPath:indexPath];
        
        cell.model = self.listArray[indexPath.row];
        NSInteger num = indexPath.row % 2 + 1;
        NSString *imgString = [NSString stringWithFormat:@"goodsPic%ld", num];
        cell.imgView.image = Image(imgString);
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (indexPath.section == 1)
        {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HomeSection_RecommendHeader className] forIndexPath:indexPath];
            ((HomeSection_RecommendHeader *)reusableview).title = String(@"超值单品");
        }
        
    }
    
    return reusableview;
}

#pragma mark - <UICollectionViewDelegate>
//item的点击触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了：第%lu组，第%lu个", indexPath.section, indexPath.item);
}


#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
