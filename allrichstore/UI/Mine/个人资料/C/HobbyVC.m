//
//  HobbyVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "HobbyVC.h"     //爱好选择VC
#import "HobbyCell.h"   //爱好标签cell

//单行cell个数
#define kCellCount_OneLine      4

#define kCell_Magin_Hor         Adapted(10)

#define kCell_Space_Hor       Adapted(10)
#define kCell_Space_Ver      Adapted(10)

#define kCell_Width     ((_collectionView.width - 2 * kCell_Magin_Hor - (kCellCount_OneLine - 1) * kCell_Space_Hor) / kCellCount_OneLine)
#define kCell_Height    kCell_Width / 2.8

@interface HobbyVC ()

@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

static NSString *identifierHobbyCell = @"identifierHobbyCell";
static NSString *cellIdentifier_SectionHeader = @"cellIdentifier_SectionHeader";
static NSString *cellIdentifier_SectionFooter = @"cellIdentifier_SectionFooter";


@implementation HobbyVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    NSArray *myHobbyArray = [Tools readFromSandBox:Key_PersonDataMyHobbyArray];
    self.selectedArray = [NSMutableArray arrayWithArray:myHobbyArray];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    self.title = String(@"兴趣爱好");
    //添加右侧导航按钮
    [self addRightTitle:@"保存" action:@selector(handleSaveHobby)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.collectionView.backgroundColor = kWhiteColor;
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellIdentifier_SectionFooter];
    [self.collectionView registerClass:[HobbyCell class] forCellWithReuseIdentifier:identifierHobbyCell];
    [self.view addSubview:_collectionView];
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
    self.listArray = [Tools readFromSandBox:Key_PersonDataHobbyArray];
    
    if (_listArray.count > 0) {
        [_collectionView reloadData];
        return;
    }
    NSDictionary *parameters = @{@"type":@"1"};
    [self POST:API_MineDataGetAllList parameters:parameters success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        self.listArray = [HobbyModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:_listArray key:Key_PersonDataHobbyArray];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action
//保存爱好信息
- (void)handleSaveHobby
{
    NSString *userID = [Single getUserModel].ID;
    NSMutableArray *muArray = [NSMutableArray array];
    for (int i = 0; i < _selectedArray.count; i++) {
        
        HobbySubModel *hobbyModel = _selectedArray[i];
        NSDictionary *dic = @{@"uhUserid":userID, @"uhHobbyid":hobbyModel.uh_hobbyid};
        [muArray addObject:dic];
    }
    NSString *jsonString = [NSString jsonStringWithObject:muArray];
    NSDictionary *parameters = @{@"param":jsonString};
    
    [self POST:API_MineModifyHobby parameters:parameters success:^(NSDictionary *dic) {
        
        [Tools writeToSandBox:self.selectedArray key:Key_PersonDataMyHobbyArray];
        [Tools showToastMsg:@"保存成功" completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.view animated:YES];
    
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCell_Width, kCell_Height);
}

//每个item的edge
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, kCell_Magin_Hor, 0, kCell_Magin_Hor);
}

//每组的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kCell_Space_Ver;
}

//每组的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kCell_Space_Hor;
}

//每组 组头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(_collectionView.width, Adapted(50));
}

//每组 组尾的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (section == _listArray.count - 1) ? CGSizeMake(_collectionView.width, Adapted(20)) : CGSizeZero;
}

#pragma mark - <UICollectionViewDataSource>
//collectionView包含的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _listArray.count;
}

//每一组的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    HobbyModel *hobbyModel = _listArray[section];
    return hobbyModel.list.count;
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HobbyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierHobbyCell forIndexPath:indexPath];
    HobbyModel *hobbyModel = _listArray[indexPath.section];
    HobbySubModel *hobbySubModel = hobbyModel.list[indexPath.row];
    hobbySubModel.isSelected = [self isInSelectedArrayModel:hobbySubModel];
    cell.model = hobbySubModel;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellIdentifier_SectionHeader forIndexPath:indexPath];
        UILabel *label = [reusableview viewWithTag:1001];
        if (!label)
        {
            label = [UILabel new];
            label.frame = CGRectMake(0, 0, _collectionView.width, Adapted(50));
            label.tag = 1001;
            label.textColor = QF_BlackColor;
            label.font = AdaptedFont(17);
            label.textAlignment = NSTextAlignmentCenter;
            [reusableview addSubview:label];
        }
        HobbyModel *hobbyModel = _listArray[indexPath.section];
        label.text = hobbyModel.h_name;
    }
    else
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellIdentifier_SectionFooter forIndexPath:indexPath];
    }
    
    return reusableview;
}


#pragma mark - <UICollectionViewDelegate>
//item的点击触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HobbyModel *hobbyModel = _listArray[indexPath.section];
    HobbySubModel *hobbySubModel = hobbyModel.list[indexPath.row];
    [self selectedModel:hobbySubModel];
    [collectionView reloadData];
}

#pragma mark - helper
//选中数组处理对象（有同ID移除，无则添加）
- (void)selectedModel:(HobbySubModel *)model
{
    BOOL isHave = NO;
    for (int i = 0; i < _selectedArray.count; i++)
    {
        HobbySubModel *subModel = _selectedArray[i];
        if ([model.uh_hobbyid integerValue] == [subModel.uh_hobbyid integerValue])
        {
            [_selectedArray removeObjectAtIndex:i];
            i--;
            isHave = YES;
        }
    }
    if (!isHave)
    {
        [_selectedArray addObject:model];
    }
}

//选中数组是否包含对象
- (BOOL)isInSelectedArrayModel:(HobbySubModel *)model
{
    for (int i = 0; i < _selectedArray.count; i++)
    {
        HobbySubModel *subModel = _selectedArray[i];
        if ([model.uh_hobbyid integerValue] == [subModel.uh_hobbyid integerValue])
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
