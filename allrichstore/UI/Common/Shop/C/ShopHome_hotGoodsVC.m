//
//  ShopHome_hotGoodsVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopHome_hotGoodsVC.h"
#import "GoodsTwoListFirstStyleCell.h"  //双列cell
#import "GoodsModel.h"                  //商品列表model

#define ListCell_Space  1

#define ListGoodsCell_W (collectionView.width - ListCell_Space * 1.0) / 2.0

@interface ShopHome_hotGoodsVC ()

@end

@implementation ShopHome_hotGoodsVC

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
    [_collectionView setContentInset:UIEdgeInsetsMake(64 + Adapted(66) + 60 + 10, 0, Layout_customBar_height, 0)];
    [_collectionView setScrollIndicatorInsets:UIEdgeInsetsMake(64 + Adapted(66) + 60 + 10, 0, Layout_customBar_height, 0)];
    
    [_collectionView registerClass:[GoodsTwoListFirstStyleCell class] forCellWithReuseIdentifier:[GoodsTwoListFirstStyleCell className]];
    
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
    CGSize cellSize = CGSizeZero;
    
    CGFloat cellHeight = [GoodsTwoListFirstStyleCell cellHeight];
    cellSize = CGSizeMake(ListGoodsCell_W, cellHeight);
    
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
    return CGSizeZero;
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
    GoodsTwoListFirstStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GoodsTwoListFirstStyleCell className] forIndexPath:indexPath];
    cell.model = self.listArray[indexPath.row];
    NSInteger num = indexPath.row % 2 + 1;
    NSString *imgString = [NSString stringWithFormat:@"goodsPic%ld", num];
    cell.imgView.image = ImageStr(imgString);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转详情
    GoodsDetailVC *detailVC = [[GoodsDetailVC alloc] init];
    [self.navigationController pushVC:detailVC animated:YES];
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
