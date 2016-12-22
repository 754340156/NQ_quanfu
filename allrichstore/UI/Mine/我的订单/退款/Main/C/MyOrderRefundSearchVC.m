//
//  MyOrderRefundSearchVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderRefundSearchVC.h"
#import "MyOrderRefundSearchCell.h"
#import "MyOrderRefundSearchModel.h"
@interface MyOrderRefundSearchVC ()<MyOrderRefundSearchCellDelegate>

@end

@implementation MyOrderRefundSearchVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    NSArray *array = @[@{@"serviceNumber":@"9089009087690",
                         @"serviceStatus":@"您的服务已成功申请，待售后审核中",
                         @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                         @"goodImage":@"jingxuan_cover",
                         @"applyTime":@"2016-10-21"},
                       @{@"serviceNumber":@"9089009087690",
                         @"serviceStatus":@"您的服务已成功申请，待售后审核中",
                         @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                         @"goodImage":@"jingxuan_cover",
                         @"applyTime":@"2016-10-21"},
                       @{@"serviceNumber":@"9089009087690",
                         @"serviceStatus":@"您的服务已成功申请，待售后审核中",
                         @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                         @"goodImage":@"jingxuan_cover",
                         @"applyTime":@"2016-10-21"},
                       @{@"serviceNumber":@"9089009087690",
                         @"serviceStatus":@"您的服务已成功申请，待售后审核中",
                         @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                         @"goodImage":@"jingxuan_cover",
                         @"applyTime":@"2016-10-21"}];
    self.listArray = [MyOrderRefundSearchModel mj_objectArrayWithKeyValuesArray:array];
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
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH -TopBarHeight);
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.tableView registerClass:[MyOrderRefundSearchCell class] forCellReuseIdentifier:[MyOrderRefundSearchCell className]];
    
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
    MyOrderRefundSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderRefundSearchCell className]];
    cell.model = self.listArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[MyOrderRefundSearchCell className] cacheByIndexPath:indexPath configuration:^(MyOrderRefundSearchCell* cell) {
        cell.model = self.listArray[indexPath.row];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - MyOrderRefundSearchCellDelegate
//取消申请
- (void)MyOrderRefundSearchCellDelegate_clickCancelApply
{
    
}
//进度查询
- (void)MyOrderRefundSearchCellDelegate_clickProgressSearch
{
    
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
