//
//  PulldownMoreView.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "PulldownMoreView.h"

/*******************默认颜色*******************/
//cell的默认颜色
#define kCell_normalColor    [UIColor colorWithWhite:0.45 alpha:1.0]
//cell的选中颜色
#define kCell_selectedColor    [UIColor colorWithRed:232 / 255.0 green:35 / 255.0 blue:45 / 255.0 alpha:1.0]

/*******************布局的配置*******************/
//点击展示更多的宽度
#define kHeaderView_Width   Adapted(50)

//菜单展示出来的cell的个数
#define kShowCellMaxCount      4

//cell的宽度
#define kTopMenuCell_width   ((_collectView.width - kHeaderView_Width) / ((_showCellCount < 1) ? 1 : _showCellCount))
//cell的高度
#define kTopMenuCell_height _collectView.height

//更多菜单展示出来的cell的个数
#define kMoreShowCellMaxCount      4

//更多菜单的cell的水平间距
#define kMoreMenu_Cell_LevelSpace       Adapted(16)

//更多菜单的cell的垂直间距
#define kMoreMenu_Cell_VerticalSpace    Adapted(10)

//更多菜单的水平组内距
#define kMoreMenu_Section_LevelInset    Adapted(10)

//更多菜单的垂直组内距
#define kMoreMenu_Section_VerticalInset Adapted(10)

//更多菜单cell的宽度
#define kMoreMenu_Cell_Width   ((_moreCollectView.width - kMoreMenu_Section_LevelInset * 2 - kMoreMenu_Cell_LevelSpace * (_moreShowCellMaxCount - 1)) / _moreShowCellMaxCount)

//更多菜单的宽高比
#define kMoreMenu_Cell_W_H_Scale 3.0

//更多菜单cell的高度
#define kMoreMenu_Cell_Height  (kMoreMenu_Cell_Width / kMoreMenu_Cell_W_H_Scale)

#define kBtnCornerRadius    Adapted(5)

/*******************字体配置*******************/
#define kCell_Font      Font_Mid
#define kMoreCell_Font  AdaptedFont(13)

@interface PulldownMoreView()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

//选中的路径
@property (nonatomic, assign) NSInteger selectedIndex;
//头视图上的按钮（用来控制下拉菜单的）
@property (nonatomic, assign) NSInteger showCellCount;
@property (nonatomic, assign) NSInteger moreShowCellCount;
@property (nonatomic, copy) PulldownMoreViewSelectedBlock actionBlock;

@end


static NSString *identifier_cell = @"identifier_cell";
static NSString *identifier_moreCell = @"identifier_moreCell";

static NSString *cellIdentifier_SectionHeader = @"cellIdentifierSectionHeader";
static NSString *cellIdentifier_SectionFooter = @"cellIdentifierSectionfooter";

@implementation PulldownMoreView

/**
 传数组和（配置，触发的block）的初始化
 @param menuArray 模型数组
 @param configureBlcok 配置块
 @param actionBlock 触发块
 */
- (instancetype)initWithFrame:(CGRect)frame
                    menuArray:(NSMutableArray *)menuArray
               configureBlcok:(PulldownMoreViewConfigureBlock)configureBlcok
                  actionBlock:(PulldownMoreViewSelectedBlock)actionBlock
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        //默认配置
        self.cell_normalColor = kCell_normalColor;
        self.cell_selectedColor = kCell_selectedColor;
        self.showCellMaxCount = kShowCellMaxCount;
        self.moreShowCellMaxCount = kMoreShowCellMaxCount;
        
        //外部配置
        self.actionBlock = actionBlock;
        configureBlcok(self);
        
        self.showCellCount = _showCellMaxCount;
        self.moreShowCellCount = _moreShowCellMaxCount;
        self.selectedIndex = -1;
        
        //把更多菜单放在的底部
        [self addSubview:self.moreCollectView];
        [self addSubview:self.collectView];
        [self addSubview:self.headerBtn];
        
        self.menuArray = menuArray;
    }
    return self;
}

#pragma mark - lazy
- (UICollectionView *)collectView
{
    if (!_collectView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectView.contentInset = UIEdgeInsetsMake(0, 0, 0, kHeaderView_Width);
        _collectView.showsHorizontalScrollIndicator = NO;
        _collectView.backgroundColor = [UIColor whiteColor];
        _collectView.dataSource = self;
        _collectView.delegate = self;
        [_collectView registerClass:[PulldownCell class] forCellWithReuseIdentifier:identifier_cell];
        [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader];
        [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellIdentifier_SectionFooter];
        [_collectView addBottomLine];
    }
    return _collectView;
}

- (UICollectionView *)moreCollectView
{
    if (!_moreCollectView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.moreCollectView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _moreCollectView.backgroundColor = [UIColor whiteColor];
        _moreCollectView.dataSource = self;
        _moreCollectView.delegate = self;
        [_moreCollectView registerClass:[PulldownMoreCell class] forCellWithReuseIdentifier:identifier_moreCell];
        [_moreCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader];
        [_moreCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellIdentifier_SectionFooter];
    }
    return _moreCollectView;
}

- (UIButton *)headerBtn
{
    if (!_headerBtn)
    {
        self.headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerBtn.backgroundColor = [UIColor whiteColor];
        _headerBtn.frame = CGRectMake(self.width - kHeaderView_Width, 0, kHeaderView_Width, self.height);
        [_headerBtn setTitleColor:_cell_normalColor forState:UIControlStateNormal];
        [_headerBtn setTitleColor:_cell_selectedColor forState:UIControlStateSelected];
        [_headerBtn setImage:[UIImage imageNamed:@"qb_pulldownMenuHeader_Normal"] forState:UIControlStateNormal];
        [_headerBtn setImage:[UIImage imageNamed:@"qb_pulldownMenuHeader_Selected"] forState:UIControlStateSelected];
        [_headerBtn addTarget:self action:@selector(handleHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_headerBtn addLeftLine];
        [_headerBtn addBottomLine];
    }
    return _headerBtn;
}

#pragma mark - setter
- (void)setMenuArray:(NSMutableArray *)menuArray
{
    BOOL lastArrayIsEmpty = NO;
    if (_menuArray.count == 0)
    {
        lastArrayIsEmpty = YES;
    }
    _menuArray = menuArray;
    if (_menuArray.count < _showCellMaxCount)
    {
        _showCellCount = _menuArray.count;
    }
    else
    {
        _showCellCount = _showCellMaxCount;
    }
    [_collectView reloadData];
    [_collectView setNeedsLayout];
    [_moreCollectView reloadData];
    [_moreCollectView setNeedsLayout];
    if (lastArrayIsEmpty)
    {
        //默认选中第一个
        [self selectedIndex:0];
    }
}

#pragma mark - handle action
//展开按钮的触发事件
- (void)handleHeaderBtn:(UIButton *)sender
{
    if (_menuArray.count <= _showCellMaxCount)
    {
        return;
    }
    sender.selected = !sender.selected;
    [self updateFrames];    //更新frame
}

//选中下标
- (void)selectedIndex:(NSInteger)index
{
    if (_menuArray.count > index)
    {
        [self collectionView:_collectView didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    }
}

//更新frame
- (void)updateFrames
{
    [UIView animateWithDuration:0.3 animations:^{
        
        if (_headerBtn.selected)
        {
            _moreCollectView.frame = CGRectMake(0, _collectView.bottom , self.width, _moreCollectView.contentSize.height);
            self.height = _moreCollectView.bottom + Adapted(6);
        }
        else
        {
            _moreCollectView.frame = CGRectMake(0, _collectView.height - _moreCollectView.contentSize.height , self.width, _moreCollectView.contentSize.height);
            self.height = _moreCollectView.bottom;
        }
        
    }];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectView)
    {
        CGSize size = CGSizeMake(kTopMenuCell_width, kTopMenuCell_height);
        return size;
    }
    else
    {
        return CGSizeMake(kMoreMenu_Cell_Width, kMoreMenu_Cell_Height);
    }
}

//每组的edge
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == _collectView)
    {
        return UIEdgeInsetsZero;
    }
    else
    {
        return UIEdgeInsetsMake(kMoreMenu_Cell_VerticalSpace, kMoreMenu_Section_LevelInset, kMoreMenu_Cell_VerticalSpace, kMoreMenu_Section_LevelInset);
    }
}

//每组的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == _collectView)
    {
        return 0;
    }
    else
    {
        return kMoreMenu_Cell_VerticalSpace;
    }
}

//每组的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == _collectView)
    {
        return 0;
    }
    else
    {
        return kMoreMenu_Cell_LevelSpace;
    }
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
    if (collectionView == _collectView)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}

//每一组的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _collectView)
    {
        return _showCellCount;
    }
    else
    {
        return _menuArray.count - _showCellCount;
    }
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectView)
    {
        PulldownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_cell forIndexPath:indexPath];
        [cell.btn setTitleColor:_cell_normalColor forState:UIControlStateNormal];
        [cell.btn setTitleColor:_cell_selectedColor forState:UIControlStateSelected];
        NSString *btnTitle;
        if ([_menuArray[indexPath.item] isKindOfClass:[NSString class]])
        {
            btnTitle = _menuArray[indexPath.item];
        }
        else
        {
            id<PulldownMoreModelAble> model = _menuArray[indexPath.item];
            btnTitle = [model title];
        }
        [cell.btn setTitle:btnTitle forState:UIControlStateNormal];
        cell.btn.selected = (indexPath.item == _selectedIndex);
        return cell;
    }
    else
    {
        PulldownMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_moreCell forIndexPath:indexPath];
        [cell.btn setTitleColor:_cell_normalColor forState:UIControlStateNormal];
        [cell.btn setTitleColor:_cell_selectedColor forState:UIControlStateSelected];
        cell.btn.normalBorderColor = _cell_normalColor;
        cell.btn.selectedBorderColor = _cell_selectedColor;
        NSString *btnTitle;
        if ([_menuArray[indexPath.item + _showCellCount] isKindOfClass:[NSString class]])
        {
            btnTitle = _menuArray[indexPath.item];
        }
        else
        {
            id<PulldownMoreModelAble> model = _menuArray[indexPath.item + _showCellCount];
            btnTitle = [model title];
        }
        [cell.btn setTitle:btnTitle forState:UIControlStateNormal];
        cell.btn.selected = ((indexPath.item + _showCellCount) == _selectedIndex);
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (collectionView == _collectView)
        {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader forIndexPath:indexPath];
        }
        else
        {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader forIndexPath:indexPath];
        }
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
        if (collectionView == _collectView)
        {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellIdentifier_SectionFooter forIndexPath:indexPath];
        }
        else
        {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellIdentifier_SectionFooter forIndexPath:indexPath];
        }
    }
    
    return reusableview;
}

#pragma mark - <UICollectionViewDelegate>
//item的点击触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectView)
    {
        if (_selectedIndex == indexPath.item)
        {
            return;
        }
        _selectedIndex = indexPath.item;
        [_collectView reloadData];
        [_collectView layoutIfNeeded];
        [_moreCollectView reloadData];
        [_moreCollectView layoutIfNeeded];
        [self updateFrames];    //更新frame
        self.actionBlock(_selectedIndex);
    }
    else
    {
        if (_selectedIndex == indexPath.item + _showCellCount)
        {
            return;
        }
        _selectedIndex = indexPath.item + _showCellCount;
        [_collectView reloadData];
        [_collectView layoutIfNeeded];
        [_moreCollectView reloadData];
        [_moreCollectView layoutIfNeeded];
        [self updateFrames];    //更新frame
        self.actionBlock(_selectedIndex);
    }
}

@end

#pragma mark - cell
//cell
@implementation PulldownCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = self.bounds;
        _btn.titleLabel.font = kCell_Font;
        _btn.userInteractionEnabled = NO;
        [self addSubview:_btn];
    }
    return self;
}

@end


#pragma mark - 展示更多的cell
//展示更多的cell
@implementation PulldownMoreCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.btn = [QButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = self.bounds;
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = kBtnCornerRadius;
        _btn.layer.borderWidth = 0.6;
        _btn.titleLabel.font = kMoreCell_Font;
        _btn.userInteractionEnabled = NO;
        [self addSubview:_btn];
    }
    return self;
}

@end
