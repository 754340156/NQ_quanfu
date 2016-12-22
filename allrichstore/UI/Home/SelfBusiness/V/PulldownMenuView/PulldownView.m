//
//  PulldownView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/4.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "PulldownView.h"

//切换一级之后 是否清空其他的选中状态
#define kSetAllNotSelected  1

/*******************默认颜色*******************/
//一级菜单cell的默认颜色
#define kOneMenuCell_NormalColor    [UIColor colorWithWhite:0.45 alpha:1.0]
//一级菜单cell的选中颜色
#define kOneMenuCell_SelectedColor    [UIColor colorWithRed:232 / 255.0 green:35 / 255.0 blue:45 / 255.0 alpha:1.0]

//二级菜单cell的默认颜色
#define kTwoMenuCell_NormalColor    [UIColor colorWithWhite:0.5 alpha:1.0]
//二级菜单cell的选中颜色
#define kTwoMenuCell_SelectedColor    [UIColor colorWithRed:232 / 255.0 green:35 / 255.0 blue:45 / 255.0 alpha:1.0]

//一级菜单底部的slider的默认颜色
#define kSlideDefaultColor  kOneMenuCell_SelectedColor


/*******************布局的配置*******************/
//一级菜单前面的 悬浮视图的宽度
#define kHeaderView_Width   Adapted(50)


//一级菜单展示出来的cell的个数
#define kOneMenu_ShowCellCount      4

//一级菜单的高度
#define kOneMenu_Height _oneLevelCollectView.height
//一级菜单组头的宽度(可修改)
#define kOneMenu_Header_Width   Adapted(0)
//一级菜单组尾的宽度(可修改)
#define kOneMenu_Footer_Width   Adapted(0)
//一级菜单的左内距(可修改)
#define kOneMenu_Inset_Left   Adapted(0)
//一级菜单的右内距(可修改)
#define kOneMenu_Inset_Right   Adapted(0)

//一级菜单cell的宽度
#define kOneMenu_Cell_Width   ((_oneLevelCollectView.width - kOneMenu_Header_Width - kOneMenu_Inset_Left - kOneMenu_Inset_Right - kHeaderView_Width) / _oneMenu_ShowCellCount)
//一级菜单cell的高度
#define kOneMenu_Cell_Height  kOneMenu_Height

//一级菜单底部的slider的默认高度(可修改)
#define kSlideDefault_Height    2.0
//一级菜单底部的slider的默认宽度(可修改)
#define kSlideDefault_Width     (kOneMenu_Cell_Width - Adapted(0))

//二级菜单展示出来的cell的个数
#define kTwoMenu_ShowCellCount      4

//二级菜单的cell的水平间距
#define kTwoMenu_Cell_LevelSpace    Adapted(16)

//二级菜单的cell的垂直间距
#define kTwoMenu_Cell_VerticalSpace    Adapted(10)

//二级菜单的水平组内距
#define kTwoMenu_Section_LevelInset Adapted(10)

//二级菜单的垂直组内距
#define kTwoMenu_Section_VerticalInset Adapted(10)

//二级菜单cell的宽度
#define kTwoMenu_Cell_Width   ((_twoLevelCollectView.width - kTwoMenu_Section_LevelInset * 2 - kTwoMenu_Cell_LevelSpace * (kTwoMenu_ShowCellCount - 1)) / kTwoMenu_ShowCellCount)

//二级菜单的宽高比
#define kTwoMenu_Cell_W_H_Scale 3.0

//二级菜单cell的高度
#define kTwoMenu_Cell_Height  (kTwoMenu_Cell_Width / kTwoMenu_Cell_W_H_Scale)

#define kBtnCornerRadius    Adapted(5)

/*******************字体配置*******************/
#define kOneMenu_Cell_Font  Font_Mid
#define kTwoMenu_Cell_Font  AdaptedFont(13)


@interface PulldownView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
//一级菜单选中的路径
@property (nonatomic, strong) NSIndexPath *oneMenuSelectedIndePath;

//头视图上的按钮（用来控制下拉菜单的）
@property (nonatomic, strong) UIButton *headerBtn;
@property (nonatomic, assign) NSInteger oneMenu_ShowCellCount;

@end

static NSString *identifier_OneMenuCell = @"PulldownOneMenuCell";
static NSString *identifier_TwoMenuCell = @"PulldownTwoMenuCell";

static NSString *cellIdentifier_SectionHeader = @"cellIdentifierSectionHeader";
static NSString *cellIdentifier_SectionFooter = @"cellIdentifierSectionfooter";

@implementation PulldownView

/**
 二级下拉菜单
 @param frame 初始frame
 @param menuModel 菜单数据源model
 */
- (instancetype)initWithFrame:(CGRect)frame
                    menuModel:(PulldownModel *)menuModel
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    
        self.menuModel = menuModel;
        
        self.oneMenuCell_NormalColor = kOneMenuCell_NormalColor;
        self.oneMenuCell_SelectedColor = kOneMenuCell_SelectedColor;
        self.twoMenuCell_NormalColor = kTwoMenuCell_NormalColor;
        self.twoMenuCell_SelectedColor = kTwoMenuCell_SelectedColor;
        
        _oneMenu_ShowCellCount = 1;
        
        self.isMultiselect = YES;
        self.oneMenuSelectedIndePath = [NSIndexPath indexPathForItem:0 inSection:0];
        self.menuModel = menuModel;
        
        [self configParams];
        
        [self.oneLevelCollectView registerClass:[PulldownOneMenuCell class] forCellWithReuseIdentifier:identifier_OneMenuCell];
        [self.twoLevelCollectView registerClass:[PulldownTwoMenuCell class] forCellWithReuseIdentifier:identifier_TwoMenuCell];
        
        //把二级菜单放在一级的底部
        [self addSubview:self.twoLevelCollectView];
        [self addSubview:self.oneLevelCollectView];
        [self addSubview:self.headerBtn];
    }
    return self;
}

//配置参数
- (void)configParams
{
    
}

#pragma mark - layz
//一级菜单
- (UICollectionView *)oneLevelCollectView
{
    if (!_oneLevelCollectView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.oneLevelCollectView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _oneLevelCollectView.contentInset = UIEdgeInsetsMake(0, 0, 0, kHeaderView_Width);
        _oneLevelCollectView.showsHorizontalScrollIndicator = NO;
        _oneLevelCollectView.backgroundColor = [UIColor whiteColor];
        _oneLevelCollectView.dataSource = self;
        _oneLevelCollectView.delegate = self;
        [_oneLevelCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader];
        [_oneLevelCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellIdentifier_SectionFooter];
        [_oneLevelCollectView addBottomLine];
        
    }
    return _oneLevelCollectView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_oneLevelCollectView bringSubviewToFront:_bottomLineView];
}

//二级菜单
- (UICollectionView *)twoLevelCollectView
{
    if (!_twoLevelCollectView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.twoLevelCollectView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _twoLevelCollectView.backgroundColor = [UIColor whiteColor];
        _twoLevelCollectView.dataSource = self;
        _twoLevelCollectView.delegate = self;
        [_twoLevelCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader];
        [_twoLevelCollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellIdentifier_SectionFooter];
    }
    return _twoLevelCollectView;
}

//一级菜单底部滑条
- (UIImageView *)bottomLineView
{
    if (!_bottomLineView)
    {
        self.bottomLineView = [[UIImageView alloc] init];
        _bottomLineView.frame = CGRectMake(kOneMenu_Header_Width + kOneMenu_Inset_Left + (kOneMenu_Cell_Width - kSlideDefault_Width) / 2.0, _oneLevelCollectView.height - kSlideDefault_Height, kSlideDefault_Width, kSlideDefault_Height);
        //默认宽度是cell的宽度
        _slideBarWidth = _bottomLineView.width;
        //默认颜色
        _bottomLineView.backgroundColor = kSlideDefaultColor;

        _slideBarColor = _bottomLineView.backgroundColor;
        
        [_oneLevelCollectView addSubview:_bottomLineView];
    }
    return _bottomLineView;
}

- (UIButton *)headerBtn
{
    if (!_headerBtn)
    {
        self.headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerBtn.backgroundColor = kWhiteColor;
        _headerBtn.frame = CGRectMake(self.width - kHeaderView_Width, 0, kHeaderView_Width, self.height);
        [_headerBtn setTitleColor:kOneMenuCell_NormalColor forState:UIControlStateNormal];
        [_headerBtn setTitleColor:kOneMenuCell_SelectedColor forState:UIControlStateSelected];
        [_headerBtn setImage:[UIImage imageNamed:@"pulldownMenuHeader_Normal"] forState:UIControlStateNormal];
        [_headerBtn setImage:[UIImage imageNamed:@"pulldownMenuHeader_Selected"] forState:UIControlStateSelected];
        [_headerBtn addTarget:self action:@selector(handleHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_headerBtn addLeftLine];
        [_headerBtn addBottomLine];
    }
    return _headerBtn;
}

#pragma mark - 一级菜单滑条设置方法
//数据的setter
- (void)setMenuModel:(PulldownModel *)menuModel
{
    _menuModel = menuModel;
    if (_menuModel.oneMenuArray.count < kOneMenu_ShowCellCount)
    {
        _oneMenu_ShowCellCount = _menuModel.oneMenuArray.count;
        if (_menuModel.oneMenuArray.count == 0)
        {
            _oneMenu_ShowCellCount = 1;
        }
    }
    else
    {
        _oneMenu_ShowCellCount = kOneMenu_ShowCellCount;
    }
    [_oneLevelCollectView reloadData];
}

//一级菜单滑条设置方法
//设置图片
- (void)setSliderImage:(UIImage *)sliderImage
{
    self.bottomLineView.image = sliderImage;
}

//设置底部滑动条高度
- (void)setSlideBarHeight:(CGFloat)slideBarHeight
{
    if (_slideBarHeight == slideBarHeight)
    {
        return;
    }
    _slideBarHeight = slideBarHeight;
    
    if (slideBarHeight > 0)
    {
        CGRect tempFrame = self.bottomLineView.frame;
        tempFrame.size.height = slideBarHeight;
        _bottomLineView.frame = tempFrame;
    }
}

//设置底部滑动条的宽度
- (void)setSlideBarWidth:(CGFloat)slideBarWidth
{
    if (_slideBarWidth == slideBarWidth)
    {
        return;
    }
    _slideBarWidth = slideBarWidth;
    
    if (slideBarWidth > 0)
    {
        CGRect tempFrame = self.bottomLineView.frame;
        tempFrame.size.height = slideBarWidth;
        _bottomLineView.frame = tempFrame;
    }
}

//设置底部滑动条颜色
- (void)setSlideBarColor:(UIColor *)slideBarColor
{
    if (_slideBarColor == slideBarColor)
    {
        return;
    }
    _slideBarColor = slideBarColor;
    self.bottomLineView.backgroundColor = slideBarColor;
}

//滑动条的上偏移
- (void)setSlideBarOffSetH:(CGFloat)slideBarOffSetH
{
    if (_slideBarOffSetH == slideBarOffSetH)
    {
        return;
    }
    _slideBarOffSetH = slideBarOffSetH;
    CGRect tempFrame = self.bottomLineView.frame;
    tempFrame.origin.y = _oneLevelCollectView.frame.size.height - self.bottomLineView.frame.size.height + slideBarOffSetH;
    _bottomLineView.frame = tempFrame;
}

#pragma mark - handle action
- (void)handleHeaderBtn:(UIButton *)sender
{
    if (_oneMenu_ShowCellCount <= kOneMenu_ShowCellCount)
    {
        return;
    }
    sender.selected = !sender.selected;
    [self updateFrames];    //更新frame
}

//更新frame
- (void)updateFrames
{
    [UIView animateWithDuration:0.3 animations:^{
        
        if (_headerBtn.selected)
        {
            _twoLevelCollectView.frame = CGRectMake(0, _oneLevelCollectView.bottom , self.width, _twoLevelCollectView.contentSize.height);
            self.height = _twoLevelCollectView.bottom + Adapted(6);
            _bottomLineView.hidden = NO;
        }
        else
        {
            _twoLevelCollectView.frame = CGRectMake(0, _oneLevelCollectView.height - _twoLevelCollectView.contentSize.height , self.width, _twoLevelCollectView.contentSize.height);
            self.height = _twoLevelCollectView.bottom;
            _bottomLineView.hidden = YES;
        }
        
    }];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _oneLevelCollectView)
    {
        return CGSizeMake(kOneMenu_Cell_Width, kOneMenu_Cell_Height);
    }
    else
    {
        return CGSizeMake(kTwoMenu_Cell_Width, kTwoMenu_Cell_Height);
    }
}

//每组的edge
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == _oneLevelCollectView)
    {
        return UIEdgeInsetsMake(0, kOneMenu_Inset_Left, 0, kOneMenu_Inset_Right);
    }
    else
    {
        return UIEdgeInsetsMake(kTwoMenu_Section_VerticalInset, kTwoMenu_Section_LevelInset, kTwoMenu_Section_VerticalInset, kTwoMenu_Section_LevelInset);
    }
}

//每组的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == _oneLevelCollectView)
    {
        return 0;
    }
    else
    {
        return kTwoMenu_Cell_VerticalSpace;
    }
}

//每组的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == _oneLevelCollectView)
    {
        return 0;
    }
    else
    {
        return kTwoMenu_Cell_LevelSpace;
    }
}

//每组 组头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (collectionView == _oneLevelCollectView)
    {
        return CGSizeMake(kOneMenu_Header_Width, kOneMenu_Height);
    }
    else
    {
        return CGSizeZero;
    }
}

//每组 组尾的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (collectionView == _oneLevelCollectView)
    {
        return CGSizeMake(kOneMenu_Footer_Width, kOneMenu_Height);
    }
    else
    {
        return CGSizeZero;
    }
}

#pragma mark - <UICollectionViewDataSource>
//collectionView包含的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == _oneLevelCollectView)
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
    if (collectionView == _oneLevelCollectView)
    {
        return self.menuModel.oneMenuArray.count;
    }
    else
    {
        OneMenuModel *oneMenuModel = [self.menuModel.oneMenuArray objectAtIndex:_oneMenuSelectedIndePath.item];
        return oneMenuModel.twoMenuArray.count;
    }
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _oneLevelCollectView)
    {
        PulldownOneMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_OneMenuCell forIndexPath:indexPath];
        OneMenuModel *oneMenuModel = [self.menuModel.oneMenuArray objectAtIndex:indexPath.item];
        NSString *btnTitle = oneMenuModel.title;
        [cell.btn setTitle:btnTitle forState:UIControlStateNormal];
        
        cell.btn.selected = (indexPath.item == _oneMenuSelectedIndePath.item);
        NSLog(@"%@", btnTitle);
        return cell;
    }
    else
    {
        PulldownTwoMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_TwoMenuCell forIndexPath:indexPath];
        OneMenuModel *oneMenuModel = [self.menuModel.oneMenuArray objectAtIndex:_oneMenuSelectedIndePath.item];
        TwoMenuModel *twoMenuModel = [oneMenuModel.twoMenuArray objectAtIndex:indexPath.item];
        NSString *btnTitle = twoMenuModel.title;
        [cell.btn setTitle:btnTitle forState:UIControlStateNormal];
        cell.btn.selected = twoMenuModel.isSelected;
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        if (collectionView == _oneLevelCollectView)
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
        if (collectionView == _oneLevelCollectView)
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
    if (collectionView == _oneLevelCollectView)
    {
        if (_oneMenuSelectedIndePath.item == indexPath.item)
        {
            return;
        }
#if kSetAllNotSelected

        OneMenuModel *oneMenuModel = [self.menuModel.oneMenuArray objectAtIndex:_oneMenuSelectedIndePath.item];
        [self setNotSelectedInArray:oneMenuModel.twoMenuArray];
#endif
        self.oneMenuSelectedIndePath = indexPath;
        [_oneLevelCollectView reloadData];
        [_oneLevelCollectView layoutIfNeeded];
        
        if (_bottomLineView)
        {
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
            CGPoint tempCenter = _bottomLineView.center;
            tempCenter.x = cell.center.x;
            
            [UIView animateWithDuration:0.15 animations:^{
                _bottomLineView.center = tempCenter;
            }];
        }
        
        [_twoLevelCollectView reloadData];
        [_twoLevelCollectView layoutIfNeeded];
        [self updateFrames];    //更新frame
    }
    else
    {
        if (_isMultiselect)
        {
            OneMenuModel *oneMenuModel = [self.menuModel.oneMenuArray objectAtIndex:_oneMenuSelectedIndePath.item];
            TwoMenuModel *twoMenuModel = [oneMenuModel.twoMenuArray objectAtIndex:indexPath.item];
            twoMenuModel.isSelected = !twoMenuModel.isSelected;
            
            [_twoLevelCollectView reloadData];
            [_twoLevelCollectView layoutIfNeeded];
        }
        else
        {
            OneMenuModel *oneMenuModel = [self.menuModel.oneMenuArray objectAtIndex:_oneMenuSelectedIndePath.item];
            [self setNotSelectedInArray:oneMenuModel.twoMenuArray];
            TwoMenuModel *twoMenuModel = [oneMenuModel.twoMenuArray objectAtIndex:indexPath.item];
            twoMenuModel.isSelected = YES;
            
            [_twoLevelCollectView reloadData];
            [_twoLevelCollectView layoutIfNeeded];
            
        }
    }
}

#pragma mark - helper
//筛选出二级菜单选中的数组
- (NSArray<TwoMenuModel *> *)getSelectedArrayFromArray:(NSArray<TwoMenuModel *> *)array
{
    NSMutableArray *muArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++)
    {
        TwoMenuModel *model = array[i];
        if (model.isSelected)
        {
            [muArray addObject:model];
        }
    }
    return [NSArray arrayWithArray:muArray];
}

//数组中所有的选中 置为NO
- (void)setNotSelectedInArray:(NSArray<TwoMenuModel *> *)array
{
    for (int i = 0; i < array.count; i++)
    {
        TwoMenuModel *model = array[i];
        model.isSelected = NO;
    }
}

@end

@implementation CellButton

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        self.layer.borderColor = kTwoMenuCell_SelectedColor.CGColor;
    }
    else
    {
        self.layer.borderColor = kTwoMenuCell_NormalColor.CGColor;
    }
}

@end

#pragma mark - 一级菜单的cell
//一级菜单的cell
@implementation PulldownOneMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = self.bounds;
        [_btn setTitleColor:kOneMenuCell_NormalColor forState:UIControlStateNormal];
        [_btn setTitleColor:kOneMenuCell_SelectedColor forState:UIControlStateSelected];
        _btn.titleLabel.font = kOneMenu_Cell_Font;
        _btn.userInteractionEnabled = NO;
        [self addSubview:_btn];
    }
    return self;
}

@end


#pragma mark - 二级菜单的cell
//二级菜单的cell
@implementation PulldownTwoMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.btn = [CellButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = self.bounds;
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = kBtnCornerRadius;
        _btn.layer.borderWidth = 0.6;
        _btn.layer.borderColor = kTwoMenuCell_NormalColor.CGColor;
        
        [_btn setTitleColor:kTwoMenuCell_NormalColor forState:UIControlStateNormal];
        [_btn setTitleColor:kTwoMenuCell_SelectedColor forState:UIControlStateSelected];
        _btn.titleLabel.font = kTwoMenu_Cell_Font;
        _btn.userInteractionEnabled = NO;
        [self addSubview:_btn];
    }
    return self;
}

@end

@implementation PulldownModel

+ (NSDictionary *)objectClassInArray{
    return @{@"oneMenuArray" : [OneMenuModel class]};
}

@end


@implementation OneMenuModel

+ (NSDictionary *)objectClassInArray{
    return @{@"TwoMenuArray" : [TwoMenuModel class]};
}

@end


@implementation TwoMenuModel


@end

