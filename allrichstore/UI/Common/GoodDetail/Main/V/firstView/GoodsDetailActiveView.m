//
//  GoodsDetailActiveView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsDetailActiveView.h"
#import "GD_ActiveCell.h"
#import "GoodsDetailModel.h"
@interface GoodsDetailActiveView ()<UITableViewDelegate,UITableViewDataSource>
/**   */
@property(nonatomic,strong) UITableView * tableView;
/**   */
@property(nonatomic,strong) NSMutableArray * listArray;
@end


@implementation GoodsDetailActiveView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, GD_ActiveViewH) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self addSubview:self.tableView];
    [self.tableView registerClass:[GD_ActiveCell class] forCellReuseIdentifier:[GD_ActiveCell className]];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GD_ActiveCell *cell = [tableView dequeueReusableCellWithIdentifier:[GD_ActiveCell className]];
    cell.model = self.listArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Adapted(GD_ActiveViewH);
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
    self.listArray = model.coupon.mutableCopy;
    self.tableView.height = model.active_height;
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
