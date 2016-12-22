//
//  HomeHeaderViewCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "HomeHeaderViewCell.h"
#import "Home_HeaderCell_Cell.h"    //轮播图下面的菜单cell

//cell分割线的颜色
#define kCell_Line_Color  Home_ListCell_Line_Color

//布局
#define kCell_Level_Margin   0
#define kCell_Level_Space    0

#define kCellCount  4

#define kCell_Scale_W_H      1.2 //宽高比

#define kCell_W ((kScreenW - 2 * kCell_Level_Margin - (kCellCount - 1) * kCell_Level_Space) / kCellCount)

#define kCell_H    (kCell_W / kCell_Scale_W_H)

#define kAdvert_H  floorf(kScreenW / Advert_W_H_Scale)

@interface HomeHeaderViewCell ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end


static NSString *cellIdentifier_cell = @"cellIdentifier_cell";

@implementation HomeHeaderViewCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.backgroundColor = kWhiteColor;
    self.collectionlistArray = @[@{@"imageName":@"ziyingsuda", @"title":String(@"自营速达")}, @{@"imageName":@"jingpintuijian", @"title":String(@"精品推荐")}, @{@"imageName":@"quanfutese", @"title":String(@"全富特色")}, @{@"imageName":@"shangjiaruzhu", @"title":String(@"商家入驻")}];
    
    NSArray *cacheBannerArray = [Tools readFromSandBox:Key_BannerListById(BannerID_homeTop)];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, floorf(self.width / Banner_W_H_Scale)) modelArray:cacheBannerArray];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView.pageDotImage = Image_CyclePageDotImage;
    _cycleScrollView.currentPageDotImage = Image_CycleCurrentPageDotImage;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _cycleScrollView.bottom, self.width, kCell_H)  collectionViewLayout:layout];
    _collectionView.backgroundColor = kWhiteColor;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[Home_HeaderCell_Cell class] forCellWithReuseIdentifier:cellIdentifier_cell];
    
    //创建广告图
    NSArray *cacheBottomBannerArray = [Tools readFromSandBox:Key_BannerListById(BannerID_homeAdvert)];
    self.bottomCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, _collectionView.bottom, self.width, kAdvert_H)  modelArray:cacheBottomBannerArray];
    _bottomCycleScrollView.backgroundColor = Color_BaseVCViewBg;
    _bottomCycleScrollView.showPageControl = NO;
    
    [self addSubview:_cycleScrollView];
    [self addSubview:_collectionView];
    [self addSubview:_bottomCycleScrollView];
}

//布局子视图
- (void)layoutViews
{
    
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCell_W, kCell_H);
}

//每个item的edge
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

//每组的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kCell_Level_Space;
}

//每组的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
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

#pragma mark - <UICollectionViewDataSource>
//collectionView包含的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每一组的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _collectionlistArray.count;
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Home_HeaderCell_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier_cell forIndexPath:indexPath];
    NSString *imageString = _collectionlistArray[indexPath.row][@"imageName"];
    NSString *labelString = _collectionlistArray[indexPath.row][@"title"];
    cell.imgView.image = Image(imageString);
    cell.titleLabel.text = labelString;

    return cell;
}

#pragma mark - <UICollectionViewDelegate>
//item的点击触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate homeHeaderViewCell:self didSelectedIndex:indexPath.row];
}

#pragma mark - <SDCycleScrollViewDelegate>
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (cycleScrollView == _cycleScrollView)
    {//如果是首页轮播图
        
    }
    else
    {//如果是首页广告图
        
    }
    
    [self.currentVC presentViewController:[[BaseNC alloc] initWithBackBtnStyleRootViewController:[BaseVC new]] animated:YES completion:^{
        
    }];
}

#pragma mark - cellHeight
+ (CGFloat)cellHeight
{
    return kCell_H + floorf(kScreenW / Banner_W_H_Scale) + kAdvert_H;
}

#pragma mark - setter model


@end
