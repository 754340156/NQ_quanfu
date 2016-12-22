//
//  SendCommentVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SendCommentVC.h"
#import "SendCommentSuccessVC.h"
#import "SendCommentMainCell.h"
#import "SendCommentShopCell.h"
#import "SendCommentModel.h"
#import "TZImagePickerController.h"
#import "SendCommentPhotosCell.h"
#define kButtonW 100.0f
@interface SendCommentVC ()<SendCommentMainCellDelegate,TZImagePickerControllerDelegate>
/**  model */
@property(nonatomic,strong) SendCommentModel * model;
/**  sendBtn */
@property(nonatomic,strong) UIButton * sendBtn;
/**  选择图片数组 */
@property(nonatomic,strong) NSMutableArray * selectedPhotos;
/**  phasset图片数组 */
@property(nonatomic,strong) NSMutableArray * selectedAssets;
@end

@implementation SendCommentVC

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
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - kBottomH);
    [self.tableView registerClass:[SendCommentMainCell class] forCellReuseIdentifier:[SendCommentMainCell className]];
    
    [self.tableView registerClass:[SendCommentShopCell class] forCellReuseIdentifier:[SendCommentShopCell className]];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.width.offset(Adapted(kButtonW));
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
        [self.tableView reloadData];
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
//选择图片
- (void)choosePhotos
{
    TZImagePickerController * imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount delegate:self];
    imagePickerVC.selectedAssets = self.selectedAssets;
    imagePickerVC.allowPickingVideo = NO;
    imagePickerVC.allowPickingOriginalPhoto = NO;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - handle action
//发表评论
- (void)sendCommentAction
{
    SendCommentSuccessVC *successVC = [[SendCommentSuccessVC alloc] init];
    [self.navigationController pushVC:successVC animated:YES];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return self.model.shopsModel.count;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf)
    if (indexPath.section == 0) {
        SendCommentMainCell *cell = [tableView dequeueReusableCellWithIdentifier:[SendCommentMainCell className]];
        cell.delegate = self;
        __block SendCommentShopModel *model = weakSelf.model.shopsModel[indexPath.row];
        cell.model = model;
        cell.clickStarBlock = ^(NSInteger count)
        {
            model.evaluateStarLevel = count;
        };
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            cell.collectionView.delegate = self;
            cell.collectionView.dataSource = self;
            [cell.collectionView registerClass:[SendCommentPhotosCell class] forCellWithReuseIdentifier:[SendCommentPhotosCell className]];
        });
        [cell.collectionView reloadData];
        return cell;
    }
    SendCommentShopCell *cell = [tableView dequeueReusableCellWithIdentifier:[SendCommentShopCell className]];
    __block SendCommentModel *model = weakSelf.model;
    cell.model = model;
    cell.clickStarBlock1 = ^(NSInteger count)
    {
        model.attitudeCount = count;
    };
    cell.clickStarBlock2 = ^(NSInteger count)
    {
        model.logisticsCount = count;
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf)
    if (indexPath.section == 0) {
        return  [tableView fd_heightForCellWithIdentifier:[SendCommentMainCell className] cacheByIndexPath:indexPath configuration:^(SendCommentMainCell* cell) {
            cell.model = weakSelf.model.shopsModel[indexPath.row];
        }];
    }
    return Adapted(kMargin * 3 + kStarViewH * 2);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kFooterViewH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kFooterViewH)];
    view.backgroundColor = QFColor_CoodsClassMenuViewBg;
    return view;
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
    SendCommentPhotosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SendCommentPhotosCell className] forIndexPath:indexPath];
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
                cell.imageView.image = Image(@"fabiaopinglun_shangchuan");
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
#pragma mark - TZImagePickerControllerDelegate
//选择完图片回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    [self.tableView reloadData];
}
#pragma mark - SendCommentMainCellDelegate
- (void)SendCommentMainCellDelegate_clickButtonViewWithSendCommentMainCell:(SendCommentMainCell *)cell Index:(NSInteger)index
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    SendCommentShopModel *model = self.model.shopsModel[indexPath.row];
    model.evaluateLevel = index;
}
#pragma mark - lazy
- (SendCommentModel *)model
{
    if (!_model) {
        NSDictionary *dic = @{@"shopsModel":@[@{@"cover":@"jingxuan_cover"}]};
        _model = [SendCommentModel mj_objectWithKeyValues:dic];
    }
    return _model;
}
- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        UIView *backView = [[UIView alloc] init];
        [self.view addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(kBottomH);
        }];
        
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:String(@"发表评论") forState:UIControlStateNormal];
        [_sendBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _sendBtn.titleLabel.font = Font_Max;
        [_sendBtn setBackgroundColor:QF_OrangeColor];
        [_sendBtn addTarget:self action:@selector(sendCommentAction) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:_sendBtn];
    }
    return _sendBtn;
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
