//
//  MyOrderListCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderListCell.h"
#import "MyOrderListCell_Cell.h"
#import "MyOrderListCell_HeaderView.h"
#import "MyOrderListCell_FooterView.h"
#import "MyOrderListModel.h"
#define kCellMargin 5.0f
@interface MyOrderListCell ()<UITableViewDelegate,UITableViewDataSource,MyOrderListCell_FooterViewDelegate>
/**  <#注释#> */
@property(nonatomic,strong) UITableView * tableView;
/**  <#注释#> */
@property(nonatomic,strong) NSMutableArray * listArray;
@end


@implementation MyOrderListCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[MyOrderListCell_Cell class] forCellReuseIdentifier:[MyOrderListCell_Cell className]];
    
    [self.tableView registerClass:[MyOrderListCell_HeaderView class] forHeaderFooterViewReuseIdentifier:[MyOrderListCell_HeaderView className]];
    
    [self.tableView registerClass:[MyOrderListCell_FooterView class] forHeaderFooterViewReuseIdentifier:[MyOrderListCell_FooterView className]];
}

//布局子视图
- (void)layoutViews
{
    
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
    MyOrderListCell_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderListCell_Cell className]];
    cell.model = self.listArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.model ? Adapted(kMyOrderListCell_FooterViewH):0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Adapted(kHeaderH);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.listArray[indexPath.row] cellHeight];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyOrderListCell_HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[MyOrderListCell_HeaderView className]];
    headerView.model = self.model;
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    MyOrderListCell_FooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[MyOrderListCell_FooterView className]];
    footerView.model = self.model;
    footerView.delegate = self;
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(MyOrderListCellDelegate_clickCellWithModel:)]) {
        [self.delegate MyOrderListCellDelegate_clickCellWithModel:self.model];
    }
}
#pragma mark - MyOrderListCell_FooterViewDelegate
- (void)MyOrderListCell_FooterViewDelegate_clickButtonWithButton:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderListCellDelegate_clickWithButton:)]) {
        [self.delegate MyOrderListCellDelegate_clickWithButton:sender];
    }
}
#pragma mark - setter model
- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
- (void)setModel:(MyOrderListModel *)model
{
    _model = model;
    self.listArray = model.goods.mutableCopy;
    self.tableView.height = model.cellHeight;
    [self.tableView reloadData];
}
@end
