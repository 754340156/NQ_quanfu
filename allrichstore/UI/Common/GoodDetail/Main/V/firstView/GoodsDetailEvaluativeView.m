//
//  GoodsDetailEvaluativeView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsDetailEvaluativeView.h"
#import "GoodsDetailModel.h"
#import "GD_EvaluativeCell.h"
#import "GD_EvaluativeHeaderView.h"
@interface GoodsDetailEvaluativeView ()<UITableViewDelegate,UITableViewDataSource>
/**   */
@property(nonatomic,strong) UITableView * tableView;
/**   */
@property(nonatomic,strong) NSMutableArray * listArray;
@end

@implementation GoodsDetailEvaluativeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setup];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, GD_EvaluativeHeaderH) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    [self.tableView registerClass:[GD_EvaluativeCell class] forCellReuseIdentifier:[GD_EvaluativeCell className]];
    [self.tableView registerClass:[GD_EvaluativeHeaderView class] forHeaderFooterViewReuseIdentifier:[GD_EvaluativeHeaderView className]];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GD_EvaluativeCell *cell = [tableView dequeueReusableCellWithIdentifier:[GD_EvaluativeCell className]];
    cell.model = self.listArray[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    GD_EvaluativeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[GD_EvaluativeHeaderView className]];
    headerView.totalCount = self.model.g_commentcount;
    headerView.rate = self.model.g_famerate;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.listArray[indexPath.row] evaluative_height];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!section) {
         return Adapted(GD_EvaluativeHeaderH);
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(GoodsDetailModel *)model
{
    _model = model;
    self.listArray = model.comment.mutableCopy;
    self.tableView.height = model.evaluative_height;
    [self.tableView reloadData];
}
#pragma mark - lazy
- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
@end
