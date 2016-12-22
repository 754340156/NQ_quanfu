
//
//  MyCollection_ShopsVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCollection_ShopsVC.h"
#import "MyCollection_ShopsCell.h"
#import "MyCollection_ShopsModel.h"
@interface MyCollection_ShopsVC ()

@end

@implementation MyCollection_ShopsVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    self.tableView.backgroundColor =QFColor_CoodsClassMenuViewBg;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - TopBarHeight);
    self.tableView.estimatedRowHeight = 1000;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MyCollection_ShopsCell class] forCellReuseIdentifier:[MyCollection_ShopsCell className]];
    //接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectAction) name:kEditNotifiCation object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editfinsh:) name:kEditFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelAction) name:kCancelCollectionNotification object:nil];
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
    NSDictionary *parameters = @{@"userId":[Single getUserModel].ID, @"type":@"1"};
    WS(weakSelf)
    [self POST:API_MyCollection parameters:parameters success:^(NSDictionary *dic) {
        weakSelf.listArray = [MyCollection_ShopsModel mj_objectArrayWithKeyValuesArray:dic[@"response"]];
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action
//批量选择操作
- (void)selectAction
{
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}
//编辑完成修改tableViewframe
- (void)editfinsh:(NSNotification *)noti
{
    if ([(NSNumber *)noti.object boolValue]) {
        self.tableView.height = kScreenH - TopBarHeight - kBottomH;
    }else
    {
        self.tableView.height = kScreenH - TopBarHeight;
    }
}
- (void)cancelAction
{
    // 获得所有被选中的行
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    if (!indexPaths.count) return;
    NSMutableIndexSet * indexSets = [NSMutableIndexSet indexSet];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *  _Nonnull indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        [indexSets addIndex: indexPath.row];
    }];
    [self.listArray removeObjectsAtIndexes:indexSets];
    [self.tableView reloadData];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollection_ShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyCollection_ShopsCell className]];
    cell.model = self.listArray[indexPath.row];
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[MyCollection_ShopsCell className] cacheByIndexPath:indexPath configuration:^(MyCollection_ShopsCell* cell) {
        cell.model = self.listArray[indexPath.row];
    }];
}
#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
