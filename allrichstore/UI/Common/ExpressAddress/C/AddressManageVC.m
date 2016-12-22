//
//  AddressManageVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddressManageVC.h"     //收货地址管理vc
#import "AddressManageCell.h"   //收货地址管理cell
#import "AddressEditVC.h"       //地址编辑控制器

@interface AddressManageVC ()<AddressManageCellDelgate>

@property (nonatomic, strong) UIView *btnBarView;

@end

@implementation AddressManageVC

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
    self.title = String(@"管理收货地址");
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];

    self.tableView.backgroundColor = kClearColor;
    [_tableView registerClass:[AddressManageCell class] forCellReuseIdentifier:[AddressManageCell className]];
    [self.view addSubview:_tableView];
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


#pragma mark - handle action

#pragma mark - <UITableViewDataSource>
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _listArray.count;;
}

//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressManageCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddressManageCell className] forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = _listArray[indexPath.section];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[AddressManageCell className] cacheByIndexPath:indexPath configuration:^(AddressManageCell *cell) {
        cell.model = _listArray[indexPath.section];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section ? Adapted(12) : 0;
}


#pragma mark - <AddressManageCellDelgate>
- (void)addressManageCell:(AddressManageCell *)addressManageCell didseletedBtn:(UIButton *)btn actionType:(ActionType)actionType
{
    NSIndexPath *indexPath = [_tableView indexPathForCell:addressManageCell];
    switch (actionType)
    {
        case ActionTypeSelect:
        {
            AddressListModel *model = _listArray[indexPath.section];
            if(!model.isDefault)
            {
                [UIAlertController qb_showAlertWithTitle:nil message:String(@"确定要更换默认地址吗？") cancelTitle:String(@"取消") otherTitles:String(@[@"确定"]) handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
                    
                    for (int i = 0; i < _listArray.count; i++)
                    {
                        AddressListModel *aModel = _listArray[i];
                        aModel.isDefault = NO;
                    }
                    model.isDefault = YES;
                    [_listArray removeObject:model];
                    [_listArray insertObject:model atIndex:0];
                    [self.tableView reloadData];
                    [self.tableView setNeedsLayout];
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
                    
                } vc:self];
            }
        }
            break;
        case ActionTypeEdit:
        {
            //跳转到地址编辑控制器
            AddressEditVC *addressEditVC = [AddressEditVC new];
            AddressListModel *addressModel = self.listArray[indexPath.row];
            addressEditVC.addressModel = addressModel;
            [self.navigationController pushVC:addressEditVC animated:YES];
        }
            break;
        case ActionTypeDelete:
        {
            if (_listArray.count == 1)
            {
                [UIAlertController qb_showAlertWithTitle:nil message:String(@"至少要保留一个收货地址哦！") cancelTitle:String(@"好") otherTitles:nil handler:nil vc:self];
                return;
            }
            
            [UIAlertController qb_showAlertWithTitle:nil message:String(@"确定要删除该地址吗？") cancelTitle:String(@"取消") otherTitles:@[String(@"确定")] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
                
                if (indexPath.section == 0)
                {//如果删除的是默认地址，让下一个变成默认地址
                    AddressListModel *model = _listArray[indexPath.section + 1];
                    model.isDefault = YES;
                    [self.tableView reloadData];
                    [self.tableView setNeedsLayout];
                }
                
                [self.listArray removeObjectAtIndex:indexPath.section];
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                
            } vc:self];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
