//
//  ShopInformationVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopInformationVC.h"
#import "ShopsApplyCalendarVC.h"
#import "FirstClassVC.h"
#import "NewBrandHomeVC.h"

#import "ShopInformationView.h"
#import "ManageClassCell.h"//品牌的cell
#import "ManageClassModel.h"
@interface ShopInformationVC ()<ShopInformationViewDelegate,ManageClassCellDelegate,UIImagePickerControllerDelegate>
/**  backView */
@property(nonatomic,strong) ShopInformationView * backView;
/**  经营分类数组 */
@property(nonatomic,strong) NSMutableArray * classArray;
/**  记录当前选中的选图片按钮 */
@property(nonatomic,strong) UIButton * selectedPhotosBtn;
@end

@implementation ShopInformationVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddClass:) name:kShopInformationAddClass object:nil];
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
    self.backView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ShopInformationView class]) owner:nil options:nil].lastObject;
    self.backView.frame = kCommentRect;
    self.backView.delegate = self;
    self.backView.tableView.delegate = self;
    self.backView.tableView.dataSource = self;
    [self.backView.tableView registerClass:[ManageClassCell class] forCellReuseIdentifier:[ManageClassCell className]];
    [self.view addSubview:self.backView];
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
//添加经营类目成功的通知
- (void)AddClass:(NSNotification *)noti
{
    self.classArray = [(NSArray *)noti.object mutableCopy];
    [[NSNotificationCenter defaultCenter] postNotificationName:kTableViewHeightNotification object:@(self.classArray.count)];
    [self.backView.tableView reloadData];
}
#pragma mark - handle action
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return self.classArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManageClassCell *cell = [tableView dequeueReusableCellWithIdentifier:[ManageClassCell className]];
    cell.delegate = self;
    if (indexPath.section == 0) {
        ManageClassModel *model =[[ManageClassModel alloc] init];
        model.index = @"序号";
        model.firstClass = @"一级分类";
        model.secondClass = @"二级分类";
        model.threeClass = @"三级分类";
        model.isTitle = YES;
        cell.model = model;
    }else
    {
        cell.model = self.classArray[indexPath.row];
    }
    
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kBottomH;
}
#pragma mark - ManageClassCellDelegate
//点击删除
- (void)ManageClassCellDelegate_clickDeleteWithCell:(ManageClassCell *)cell
{
    NSIndexPath *indexPath = [self.backView.tableView indexPathForCell:cell];
    if (indexPath.section == 0) return;
    [self.classArray removeObjectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:kTableViewHeightNotification object:@(self.classArray.count)];
    [self.backView.tableView reloadData];
}
#pragma mark - ShopInformationViewDelegate
//添加
- (void)ShopInformationViewDelegate_clickAddClass
{
    FirstClassVC *VC = [[FirstClassVC alloc] init];
    BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:VC];
    [self presentVC:nc animated:YES completion:nil];
}
//下一步
- (void)ShopInformationViewDelegate_clickNext
{
    NewBrandHomeVC *homeVC = [[NewBrandHomeVC alloc] init];
    [self.navigationController pushVC:homeVC animated:YES];
}
//有效期
- (void)ShopInformationViewDelegate_clickTimeWithLabel:(UILabel *)label
{
    ShopsApplyCalendarVC * calendarVC = [[ShopsApplyCalendarVC alloc] init];
    calendarVC.dateBlock = ^(NSDate * selectedDate)
    {
        label.text = [[NSString stringWithFormat:@"%@",selectedDate] substringToIndex:10];
    };
    BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:calendarVC];
    [self presentVC:nc animated:YES completion:nil];
}
//上传图片
- (void)ShopInformationViewDelegate_clickPhotosWithButton:(UIButton *)button
{
    self.selectedPhotosBtn = button;
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (!self.selectedPhotosBtn) return;
    if ([self.selectedPhotosBtn isEqual:self.backView.photoBtn]) {
        [self.backView.photoBtn setImage: info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - lazy
- (NSMutableArray *)classArray
{
    if (!_classArray) {
        _classArray = [NSMutableArray array];
    }
    return _classArray;
}
#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
