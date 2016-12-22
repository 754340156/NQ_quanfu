//
//  MyOrderRefundProgressVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderRefundProgressVC.h"

@interface MyOrderRefundProgressVC ()

@end

@implementation MyOrderRefundProgressVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.listArray = @[@[@{@"title":@"服务单号：",
                           @"content":@"9089009087690"},
                         @{@"title":@"申请时间：",
                           @"content":@"2016-10-21"}],
                       @[@{@"title":@"您的服务单已申请成功，待售后审核...",
                           @"subTitle":@"2016-10-21 09：18：50"}]].mutableCopy;
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        NSDictionary *dic = self.listArray[indexPath.section][indexPath.row];
        cell.textLabel.text =[NSString stringWithFormat:@"%@%@",dic[@"title"],dic[@"content"]] ;
        return cell;
    }else if (indexPath.section == 1)
    {
        NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.textLabel.text = self.listArray[indexPath.section][indexPath.row][@"title"];
        cell.detailTextLabel.text = self.listArray[indexPath.section][indexPath.row][@"subTitle"];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  Adapted(5);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, Adapted(5))];
    footerView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
