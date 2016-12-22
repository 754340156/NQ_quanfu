//
//  RefundDetailApplyVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundDetailApplyVC.h"
#import "RefundComplaintVC.h"//投诉
#import "GoodGobBackTypeVC.h"//商品返回方式
#import "RefundDetailApplyPhotosCell.h"
#import "RefundDetailApplyScrollView.h"
#import "RefundDetailApplyModel.h"
#import "TZImagePickerController.h"

@interface RefundDetailApplyVC ()<RefundDetailApplyHeaderViewDelegate,TZImagePickerControllerDelegate>
/**  <#注释#> */
@property(nonatomic,strong) RefundDetailApplyScrollView * baseScrollV;
/**  next */
@property(nonatomic,strong) UIButton * nextButton;
/**  model */
@property(nonatomic,strong) RefundDetailApplyModel * model;
/**  选择图片数组 */
@property(nonatomic,strong) NSMutableArray * selectedPhotos;
/**  phasset图片数组 */
@property(nonatomic,strong) NSMutableArray * selectedAssets;
@end

@implementation RefundDetailApplyVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    [self addRightTitle:@"投诉" action:@selector(complainAction)];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.baseScrollV = [[RefundDetailApplyScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kBottomH)];
    self.baseScrollV.headerView.delegate = self;
    self.baseScrollV.photosView.collectionView.delegate = self;
    self.baseScrollV.photosView.collectionView.dataSource = self;
    [self.baseScrollV.photosView.collectionView registerClass:[RefundDetailApplyPhotosCell class] forCellWithReuseIdentifier:[RefundDetailApplyPhotosCell className]];
    self.baseScrollV.model = self.model;
    WS(weakSelf)
    //选择服务类型回调
    self.baseScrollV.typeView.clickTypeBlock = ^(NSString *currentStr)
    {
        weakSelf.model.currentType = currentStr;
    };
    //加回调
    self.baseScrollV.countView.clickAddBlock = ^(UILabel *numberLabel)
    {
        NSInteger count = [numberLabel.text integerValue];
        count ++;
        if(count > 999) {
            NSLog(@"超出最大范围");
            return ;
        }
        if (count > [weakSelf.model.count intValue]) {
            NSLog(@"没有有那么多库存");
            return ;
        }
        numberLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
        weakSelf.model.applyCount = [NSString stringWithFormat:@"%ld",(long)count];
    };
    //减回调
    self.baseScrollV.countView.clickReduceBlock = ^(UILabel *numberLabel)
    {
        NSInteger count = [numberLabel.text integerValue];
        count --;
        if(count <= 0) {
            NSLog(@"再减就没了");
            return ;
        }
        numberLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
        weakSelf.model.applyCount = [NSString stringWithFormat:@"%ld",(long)count];
    };
    [self.view addSubview:self.baseScrollV];
    
    [self.view addSubview:self.nextButton];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(kBottomH);
    }];
    
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
//预览图片
- (void)previewPhotosWithIndex:(NSInteger)index
{
    //预览
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets selectedPhotos:self.selectedPhotos index:index];
    imagePickerVC.maxImagesCount = maxCount;
    imagePickerVC.allowPickingOriginalPhoto = NO;
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
        self.selectedAssets = [NSMutableArray arrayWithArray:assets];
        [self.baseScrollV.photosView.collectionView reloadData];
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (void)choosePhotos
{
    TZImagePickerController * imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount delegate:self];
    imagePickerVC.selectedAssets = self.selectedAssets;
    imagePickerVC.allowPickingVideo = NO;
    imagePickerVC.allowPickingOriginalPhoto = NO;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
#pragma mark - handle action
//下一步
- (void)nextAction
{
    GoodGobBackTypeVC * typeVC = [[GoodGobBackTypeVC alloc] init];
    [self.navigationController pushVC:typeVC animated:YES];
}
//投诉
- (void)complainAction
{
    RefundComplaintVC * VC = [[RefundComplaintVC alloc] init];
    VC.model = self.model;
    [self.navigationController pushVC:VC animated:YES];
}
#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.selectedPhotos.count == maxCount) {
        return self.selectedPhotos.count;
    }else
    {
        return self.selectedPhotos.count + 1;
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RefundDetailApplyPhotosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RefundDetailApplyPhotosCell className] forIndexPath:indexPath];
    //有图片付给按钮背景图
    if (self.selectedPhotos.count) {
        if (self.selectedPhotos.count == maxCount) {
            cell.imageView.image = self.selectedPhotos[indexPath.row];
        }else
        {
            if (indexPath.row < self.selectedPhotos.count) {
                cell.imageView.image = self.selectedPhotos[indexPath.row];
            }else
            {
                cell.imageView.image = Image(@"shangchuan");
            }
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedPhotos.count != maxCount && indexPath.row == self.selectedPhotos.count) {
        //选图片
        [self choosePhotos];
    }else
    {
        //预览
        [self previewPhotosWithIndex:indexPath.row];
    }

}
#pragma mark - RefundDetailApplyHeaderViewDelegate
//联系卖家
- (void)RefundDetailApplyHeaderViewDelegate_clickContactSellerBtn
{

}
#pragma mark - TZImagePickerControllerDelegate
//选择完图片回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    NSInteger count = self.selectedPhotos.count / singleLineCount;
    //判断修改高度
    [self.baseScrollV.photosView.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset((count + 1) * Adapted(kItemHeight) + count * Adapted(kMargin));
    }];
    [self.baseScrollV.photosView layoutIfNeeded];
    [self.baseScrollV.photosView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(kPhotosViewH(count));
    }];
    
    [self.baseScrollV layoutIfNeeded];
    
    [self.baseScrollV.photosView.collectionView reloadData];
}
#pragma mark - lazy
- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.titleLabel.font = Font(18);
        [_nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:QF_RedColor];
        [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}
- (RefundDetailApplyModel *)model
{
    if (!_model) {
        NSDictionary *dic = @{@"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                              @"count":@"5",
                              @"icon":@"jingxuan_cover",
                              @"typeArray":@[@"退货",@"退货",@"退货",@"退货",@"退货",@"退货"],
                              @"":@"",
                              @"":@"",
                              @"":@[]};
        _model = [RefundDetailApplyModel mj_objectWithKeyValues:dic];
    }
    return  _model;
}
- (NSMutableArray *)selectedPhotos
{
    if (!_selectedPhotos) {
        _selectedPhotos = [NSMutableArray array];
    }
    return _selectedPhotos;
}
- (NSMutableArray *)selectedAssets
{
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableArray array];
    }
    return _selectedAssets;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
