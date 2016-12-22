//
//  AddressListVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddressListVC.h"       //我的收货地址列表VC
#import "AddressListCell.h"     //我的收货地址列表cell
#import "AddressManageVC.h"     //收货地址管理VC
#import "AddressEditVC.h"       //地址编辑VC
#import "AddAddressVC.h"        //新增收货地址VC

//底部新增收货地址按钮的高度
#define kHeight_addAddressBtn        45

@interface AddressListVC ()

@property (nonatomic, copy) ObjectBlock addressBlock;

@end

@implementation AddressListVC

//把选中的地址model通过block返回
- (instancetype)initWithBlock:(ObjectBlock)addressBlock
{
    self = [super init];
    if (self)
    {
        self.addressBlock = addressBlock;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.listArray = [Single addressListArray];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    self.title = String(@"选择收货地址");
    [self addRightTitle:String(@"管理") action:@selector(handleAddressManage)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.tableView.backgroundColor = kClearColor;
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, kHeight_addAddressBtn, 0)];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, kHeight_addAddressBtn, 0)];
    [self.tableView registerClass:[AddressListCell class] forCellReuseIdentifier:[AddressListCell className]];
    [self.view addSubview:_tableView];
    [self createAddAddressBtn]; //创建新增地址
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
//    NSDictionary *parameters = @{@"":@"", @"":@""};
//    WS(weakSelf)
//    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
//        
//    } fail:^(NSError *error) {
//        
//        
//    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method
//创建保存按钮
- (void)createAddAddressBtn
{
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addBtn addTopLine];
    [addBtn setShadowWithColor:[UIColor colorWithWhite:0.0 alpha:0.3] offset:CGSizeMake(-1, -1)];
    addBtn.backgroundColor = kWhiteColor;
    addBtn.frame = CGRectMake(0, self.view.height - kHeight_addAddressBtn, self.view.width, kHeight_addAddressBtn);
    [addBtn setTitle:String(@"+新增收货地址") forState:UIControlStateNormal];
    [addBtn setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(handleAddressBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

#pragma mark - handle action
//收货地址管理
- (void)handleAddressManage
{
    AddressManageVC *addressManageVC = [AddressManageVC new];
    [self.navigationController pushVC:addressManageVC animated:YES];
}

//新增收货地址
- (void)handleAddressBtn
{
   //跳转到新增地址vc
    AddAddressVC *addAddressVC = [AddAddressVC new];
    [self.navigationController pushVC:addAddressVC animated:YES];
}

#pragma mark - <UITableViewDataSource>
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _listArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddressListCell className] forIndexPath:indexPath];
    cell.model = self.listArray[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.addressBlock)
    {
        self.addressBlock(_listArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[AddressListCell className] cacheByIndexPath:indexPath configuration:^(AddressListCell *cell)
    {
        cell.model = self.listArray[indexPath.row];
    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:String(@"删除") handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        if (_listArray.count == 1)
        {
            [UIAlertController qb_showAlertWithTitle:nil message:String(@"至少要保留一个收货地址哦！") cancelTitle:String(@"好") otherTitles:nil handler:nil vc:self];
            return;
        }
        [UIAlertController qb_showAlertWithTitle:nil message:String(@"确定要删除该地址吗？") cancelTitle:String(@"取消") otherTitles:@[String(@"确定")] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
            
            [self.listArray removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
        } vc:self];
    }];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:String(@"编辑") handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        //跳转到地址编辑控制器
        AddressEditVC *addressEditVC = [AddressEditVC new];
        AddressListModel *addressModel = self.listArray[indexPath.row];
        addressEditVC.addressModel = addressModel;
        [self.navigationController pushVC:addressEditVC animated:YES];
    }];
    editAction.backgroundColor = QF_YellowColor;
    return @[deleteAction, editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
