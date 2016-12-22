//
//  GoodsFilterView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsFilterView.h" //商品筛选视图
#import "PriceLimitCell.h"  //价格区间cell
#import "LBHeaderView.h"    //分区区头

#define kHeight_BottomView   49.0

#define kColor_resetBtnBg      [UIColor colorWithRed:253 / 255.0 green:187 / 255.0 blue:97 / 255.0 alpha:1.0]
#define kColor_completeBtnBg   [UIColor colorWithRed:239 / 255.0 green:87 / 255.0 blue:44 / 255.0 alpha:1.0]

//水平内距
#define kInsetLevel              Adapted(12)

//组头的高度
#define kHeight_headerView       Adapted(50)

//价格区间cell的宽度
#define kWidth_priceCell         (_collectionView.width - 2 * kInsetLevel)
//价格区间cell的高度
#define kHeight_priceCell        Adapted(46)

//标签cell之间的水平间距
#define kSpace_level_tagCell     Adapted(12)
//标签cell之间的垂直间距
#define kSpace_vertical_tagCell  Adapted(12)
//标签cell的宽度
#define kWidth_tagCell      (kWidth_priceCell - kSpace_level_tagCell * 2.0) / 3.0
//标签cell的高度
#define kHeight_tagCell          Adapted(36)

//组头按钮的tag的初始值
#define kTag_headerBtn          1001

@interface GoodsFilterView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate>

@property (nonatomic, copy) CompleteBlock completeBlock;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *completeBtn;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) PriceLimitCell *priceLimitCell;

@end

static NSString *identifier_priceLimitCell = @"identifierPriceLimitCell";
static NSString *identifier_tagCell = @"identifierTagCell";
static NSString *identifier_headerView = @"identifierHeaderView";

@implementation GoodsFilterView

- (instancetype)initWithFrame:(CGRect)frame completeBlock:(CompleteBlock)completeBlock
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.completeBlock = completeBlock;
        [self createViews];
        [self layoutViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame model:(id<GoodsFilterAble>)model completeBlock:(CompleteBlock)completeBlock
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.model = model;
        self.completeBlock = completeBlock;
        [self createViews];
        [self layoutViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createViews];
        [self layoutViews];
    }
    return self;
}

#pragma mark - override super
//创建子视图
- (void)createViews
{
    //创建添加帅选视图
    [self addSubview:self.collectionView];
    [_collectionView registerClass:[LBHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier_headerView];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter"];
    [_collectionView registerClass:[PriceLimitCell class] forCellWithReuseIdentifier:identifier_priceLimitCell];
    [_collectionView registerClass:[TagCell class] forCellWithReuseIdentifier:identifier_tagCell];
    
    //创建添加底部的bar和重置和完成按钮
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - kHeight_BottomView, self.width, kHeight_BottomView)];
    [self addSubview:bottomView];
    
    //重置按钮
    self.resetBtn.frame = CGRectMake(0, 0, bottomView.width / 2.0, bottomView.height);
    [_resetBtn addTarget:self action:@selector(handleResetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_resetBtn];
    
    //完成按钮
    self.completeBtn.frame = CGRectMake(_resetBtn.right, 0, bottomView.width / 2.0, bottomView.height);
    [_completeBtn addTarget:self action:@selector(handleCompleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_completeBtn];
}

//布局子视图
- (void)layoutViews
{
    
}

#pragma mark - lazy
//筛选菜单
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - kHeight_BottomView) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

//重置按钮
- (UIButton *)resetBtn
{
    if (!_resetBtn)
    {
        self.resetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _resetBtn.backgroundColor = kColor_resetBtnBg;
        [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_resetBtn setTitle:String(@"重置") forState:UIControlStateNormal];
    }
    return _resetBtn;
}

//完成按钮
- (UIButton *)completeBtn
{
    if (!_completeBtn)
    {
        self.completeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _completeBtn.backgroundColor = kColor_completeBtnBg;
        [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _completeBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_completeBtn setTitle:String(@"完成") forState:UIControlStateNormal];
    }
    return _completeBtn;
}

#pragma mark - custom method

#pragma mark - handle action
//重置按钮 -- 触发事件
- (void)handleResetBtn:(UIButton *)sender
{
    _model.priceMax = 0;
    _model.priceMin = 0;
    for (int i = 0; i < _model.propertyArray.count; i++)
    {
        id<GoodsPropertyAble> goodsProperty = [_model propertyArray][i];
        goodsProperty.isOpened = NO;
        [goodsProperty.seletedTagsArray removeAllObjects];
    }
    [_collectionView reloadData];
}

//完成按钮 -- 触发事件
- (void)handleCompleteBtn:(UIButton *)sender
{
    _completeBlock(_model);
}

//组头按钮 -- 触发事件
- (void)handleHeaderBtn:(UIButton *)sender
{
    NSInteger sectionIndex = sender.tag - kTag_headerBtn;
    id<GoodsPropertyAble> goodsProperty = [_model propertyArray][sectionIndex];
    NSInteger count = [[goodsProperty tagsArray] count];
    if (count > 3)
    {
        goodsProperty.isOpened = ![goodsProperty isOpened];
    }
    [_collectionView reloadData];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(kWidth_priceCell, kHeight_priceCell);
    }
    else
    {
        return CGSizeMake(kWidth_tagCell, kHeight_tagCell);
    }
}

//每组的edge
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, kInsetLevel, 0, kInsetLevel);
}

//每组的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kSpace_vertical_tagCell;
}

//每组的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kSpace_level_tagCell;
}

//每组 组头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.width, kHeight_headerView);
}

//每组 组尾的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.width, Adapted(8));
}

#pragma mark - <UICollectionViewDataSource>
//collectionView包含的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[_model propertyArray] count] + 1;
}

//每一组的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        id<GoodsPropertyAble> goodsProperty = [_model propertyArray][section - 1];
        NSInteger count;
        if ([goodsProperty isOpened])
        {
            count = goodsProperty.tagsArray.count;
        }
        else
        {
            if (goodsProperty.tagsArray.count < 3)
            {
                count = goodsProperty.tagsArray.count;
            }
            else
            {
                count = 3;
            }
        }
        
        return count;
    }
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        PriceLimitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_priceLimitCell forIndexPath:indexPath];
        self.priceLimitCell = cell;
        cell.leftTF.tag = 1001;
        cell.rightTF.tag = 1002;
        cell.leftTF.delegate = self;
        cell.rightTF.delegate = self;
        if ([_model priceMin] == 0 && [_model priceMax] == 0) {
            cell.leftTF.text = nil;
            cell.rightTF.text = nil;
        }
        else
        {
            cell.leftTF.text = [NSString stringWithFormat:@"%.0lf", [_model priceMin]];
            cell.rightTF.text = [NSString stringWithFormat:@"%.0lf", [_model priceMax]];;
        }
        return cell;
    }
    else
    {
        TagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_tagCell forIndexPath:indexPath];
        id<GoodsPropertyAble> goodsProperty = [_model propertyArray][indexPath.section - 1];
        NSString *btnTitle = [goodsProperty tagsArray][indexPath.row];
        [cell.tagBtn setTitle:btnTitle forState:UIControlStateNormal];
        NSMutableArray *muArray = [goodsProperty seletedTagsArray];
        if ([muArray isHaveString:btnTitle])
        {
            cell.tagBtn.selected = YES;
        }
        else
        {
            cell.tagBtn.selected = NO;
        }
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier_headerView forIndexPath:indexPath];
        LBHeaderView *headerView = (LBHeaderView *)reusableview;
        if (indexPath.section == 0)
        {
            headerView.label.text = String(@"价格区间（元）");
            headerView.btn.hidden = YES;
        }
        else
        {
            id<GoodsPropertyAble> goodsProperty = [_model propertyArray][indexPath.section - 1];
            headerView.label.text = [goodsProperty propertyName];
            headerView.btn.hidden = NO;
            headerView.btn.tag = kTag_headerBtn + indexPath.section - 1;
            headerView.btn.selected =  goodsProperty.isOpened;
            [headerView.btn addTarget:self action:@selector(handleHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    else if (kind == UICollectionElementKindSectionFooter)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sectionFooter" forIndexPath:indexPath];
    }
    
    return reusableview;
}

#pragma mark - <UICollectionViewDelegate>
//item的点击触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return;
    }
    TagCell *cell = (TagCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    id<GoodsPropertyAble> goodsProperty = [_model propertyArray][indexPath.section - 1];
    if([[goodsProperty seletedTagsArray] isHaveString:cell.tagBtn.currentTitle])
    {
        [[goodsProperty seletedTagsArray] removeObject:cell.tagBtn.currentTitle];
    }
    else
    {
        [[goodsProperty seletedTagsArray] addObject:cell.tagBtn.currentTitle];
    }
    [_collectionView reloadData];
}

#pragma mark - <UITextFieldDelegate>
//谓词限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

//编辑将要结束
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1001)
    {
        UITextField *rightTF = [self.priceLimitCell viewWithTag:1002];
        if (rightTF.text.length)
        {
            if ([textField.text floatValue] > [rightTF.text floatValue])
            {
                textField.text = rightTF.text;
            }
        }
        
        _model.priceMin = [textField.text floatValue];
    }
    else
    {
        UITextField *leftTF = [self.priceLimitCell viewWithTag:1001];
        if ([textField.text floatValue] < [leftTF.text floatValue])
        {
            textField.text = leftTF.text;
        }
        
        _model.priceMax = [textField.text floatValue];
    }
}

//回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    return YES;
}

#pragma mark - setter model

@end

#define TagCellAdapted(x)   Adapted(x)

//cell的背景颜色
#define kColor_Bg           [UIColor colorWithRed:240.0 / 255.0 green:242.0 / 255.0 blue:244.0 / 255.0 alpha:1.0]
#define kColor_selectedBg   [UIColor whiteColor]

//输入框的文字颜色
#define kColor_labelText    [UIColor colorWithWhite:0.2 alpha:1.0]

//cell的默认颜色
#define kCell_NormalColor    [UIColor clearColor]
//cell的选中颜色
#define kCell_SelectedColor  QF_RedColor

@implementation TagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.tagBtn = [[TagCellButton alloc] initWithFrame:self.contentView.bounds];
        _tagBtn.userInteractionEnabled = NO;
        _tagBtn.backgroundColor = kColor_Bg;
        _tagBtn.titleLabel.font = [UIFont systemFontOfSize:TagCellAdapted(16)];
        _tagBtn.layer.masksToBounds = YES;
        _tagBtn.layer.cornerRadius = 3.0;
        _tagBtn.layer.borderWidth = 0.6;
        _tagBtn.layer.borderColor = kCell_NormalColor.CGColor;
        [_tagBtn setTitleColor:kColor_labelText forState:UIControlStateNormal];
        [_tagBtn setTitleColor:kCell_SelectedColor forState:UIControlStateSelected];
        [self.contentView addSubview:_tagBtn];
        
    }
    return self;
}

@end


@implementation TagCellButton

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        self.backgroundColor = kColor_selectedBg;
        self.layer.borderColor = kCell_SelectedColor.CGColor;
    }
    else
    {
        self.backgroundColor = kColor_Bg;
        self.layer.borderColor = kCell_NormalColor.CGColor;
    }
}

@end
