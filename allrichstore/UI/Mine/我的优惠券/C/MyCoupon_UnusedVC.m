//
//  MyCoupon_UnusedVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCoupon_UnusedVC.h"
#import "MyCoupon_Cell.h"
#import "MyCouponModel.h"
@interface MyCoupon_UnusedVC ()

@end

@implementation MyCoupon_UnusedVC

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
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.view addSubview:self.tableView];
    self.tableView.bounces = NO;
    [self.tableView registerClass:[MyCoupon_Cell class] forCellReuseIdentifier:[MyCoupon_Cell className]];
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    //	0 未使用 1 已使用 2 已过期
    NSDictionary *parameters = @{@"uc_userid":[Single getUserModel].ID, @"index":@(0)};
    WS(weakSelf)
    [self POST:API_MyCoupon parameters:parameters success:^(NSDictionary *dic) {
        weakSelf.listArray = [MyCouponModel mj_objectArrayWithKeyValuesArray:dic];
        //修改上面的数组
        if (weakSelf.NetworkFinishBlock) {
            weakSelf.NetworkFinishBlock(weakSelf.listArray.count);
        }
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
    MyCoupon_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[MyCoupon_Cell className]];
    cell.model = self.listArray[indexPath.row];
    cell.usedState = @"点击使用";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[MyCoupon_Cell className] cacheByIndexPath:indexPath configuration:^(MyCoupon_Cell* cell) {
        cell.model = self.listArray[indexPath.row];
    }];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
