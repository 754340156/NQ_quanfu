

//
//  ShopsApplyVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopsApplyVC.h"
#import "ShopsApplyCell.h"
#import "EnterDelegateVC.h"
@interface ShopsApplyVC ()
/**  我要入驻 */
@property(nonatomic,strong) UIButton * applyButton;
@end

@implementation ShopsApplyVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.listArray  = @[@{@"icon":@"shangjiaruzhuliucheng",
                          @"title":String(@"商家入驻流程")},
                        @{@"icon":@"zhaoshangbiaozhun",
                          @"title":String(@"招商标准")},
                        @{@"icon":@"zizhiyaoqiu",
                          @"title":String(@"资质要求")},
                        @{@"icon":@"feiyongbiaozhun",
                          @"title":String(@"费用标准")},
                        @{@"icon":@"lianxifangshi",
                          @"title":String(@"联系方式")},
                        @{@"icon":@"ruzhujinduchaxun",
                          @"title":String(@"入驻进度查询")}
                        ].mutableCopy;
    
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
    self.collectionView.frame = CGRectMake(0, 0, kScreenW, kScreenH - kBottomH);
    self.collectionView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[ShopsApplyCell class] forCellWithReuseIdentifier:[ShopsApplyCell className]];
    [self.view addSubview:self.applyButton];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(kBottomH);
    }];
    
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{

}

#pragma mark - custom method


#pragma mark - handle action
- (void)applyAction
{
    //跳转入驻流程
    EnterDelegateVC * delegateVC = [[EnterDelegateVC alloc] init];
    [self.navigationController pushVC:delegateVC animated:YES];
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.width) / 3.0, (collectionView.width) / 3.0);
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
    return 6;
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopsApplyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ShopsApplyCell className] forIndexPath:indexPath];
    cell.title = self.listArray[indexPath.row][@"title"];
    cell.icon = self.listArray[indexPath.row][@"icon"];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
//item的点击触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - lazy
- (UIButton *)applyButton
{
    if (!_applyButton) {
        _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applyButton setTitle:String(@"我要入驻") forState:UIControlStateNormal];
        [_applyButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_applyButton setBackgroundColor:QF_RedColor];
        [_applyButton addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyButton;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
