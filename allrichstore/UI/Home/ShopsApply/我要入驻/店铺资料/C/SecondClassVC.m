//
//  SecondClassVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SecondClassVC.h"
#import "ThreeClassVC.h"
@interface SecondClassVC ()

@end

@implementation SecondClassVC
#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.listArray = @[@"男装",@"女装",@"内衣",@"童装",@"睡衣"].mutableCopy;
    
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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
    
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

#pragma mark - <UITableViewDataSource>
//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.listArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className] forIndexPath:indexPath];
    [cell addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    cell.textLabel.text = self.listArray[indexPath.row];
    cell.textLabel.font = Font(14);
    cell.textLabel.textColor = QF_BlackColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThreeClassVC * VC = [[ThreeClassVC alloc] init];
    VC.secondClass = self.listArray[indexPath.row];
    VC.firstClass = self.firstClass;
    [self.navigationController pushVC:VC animated:YES];
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
