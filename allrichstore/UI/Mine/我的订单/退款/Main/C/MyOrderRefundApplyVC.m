//
//  MyOrderRefundApplyVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderRefundApplyVC.h"
#import "RefundDetailApplyVC.h"
#import "MyOrderRefundApplyCell.h"
#import "MyOrderRefundApplyModel.h"
@interface MyOrderRefundApplyVC ()<MyOrderRefundApplyCellDelegate>

@end

@implementation MyOrderRefundApplyVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    NSArray *array = @[@{@"orderNumber":@"9089009087690",
                         @"orderTime":@"2016-10-21",
                         @"goodImage":@"jingxuan_cover",
                         @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                         @"number":@"1"},
                       @{@"orderNumber":@"9089009087690",
                         @"orderTime":@"2016-10-21",
                         @"goodImage":@"jingxuan_cover",
                         @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                         @"number":@"1"},
                       @{@"orderNumber":@"9089009087690",
                         @"orderTime":@"2016-10-21",
                         @"goodImage":@"jingxuan_cover",
                         @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                         @"number":@"1"},
                       @{@"orderNumber":@"9089009087690",
                         @"orderTime":@"2016-10-21",
                         @"goodImage":@"jingxuan_cover",
                         @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                         @"number":@"1"}];
    self.listArray = [MyOrderRefundApplyModel mj_objectArrayWithKeyValuesArray:array];
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
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH -TopBarHeight);
    [self.tableView registerClass:[MyOrderRefundApplyCell class] forCellReuseIdentifier:[MyOrderRefundApplyCell className]];
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


#pragma mark - handle action

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderRefundApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderRefundApplyCell className]];
    cell.model = self.listArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[MyOrderRefundApplyCell className] cacheByIndexPath:indexPath configuration:^(MyOrderRefundApplyCell* cell) {
        cell.model = self.listArray[indexPath.row];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - MyOrderRefundApplyCellDelegate
//申请售后
- (void)MyOrderRefundApplyCellDelegate_clickApply
{
    RefundDetailApplyVC *applyVC = [[RefundDetailApplyVC alloc] init];
    [self.navigationController pushVC:applyVC animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
