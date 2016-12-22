//
//  MyCashCouponSpendingVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCashCouponSpendingVC.h"
#import "MyCashCounponModel.h"
#import "MyCashCounponCell.h"
@interface MyCashCouponSpendingVC ()

@end

@implementation MyCashCouponSpendingVC

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
    [self.tableView registerClass:[MyCashCounponCell class] forCellReuseIdentifier:[MyCashCounponCell className]];
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
    //0收入1支出
    NSDictionary *parameters = @{@"cpr_userid":[Single getUserModel].ID, @"cpr_status":@"1"};
    WS(weakSelf)
    [self POST:API_MyCashCoupon parameters:parameters success:^(NSDictionary *dic) {
        weakSelf.listArray = [MyCashCounponModel mj_objectArrayWithKeyValuesArray:dic[@"response"]];
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCashCounponCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyCashCounponCell className]];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kBottomH;
}
#pragma mark - lazy
- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
