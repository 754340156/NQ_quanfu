//
//  CreateOrderScrollView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderScrollView.h"
#import "CreateOrderHeaderView.h"
#import "CreateOrderServiceCell.h"  //配送方式/发票/优惠券/现金券
#import "CreateOrderMessageCell.h" //买家留言
#import "CreateOrderSwitchCell.h" //积分抵
#import "CreateOrderAmountCell.h" //商品金额
#import "CreateOrderModel.h"
#import "MyOrderListCell.h"
#import "MyOrderListModel.h"
@interface CreateOrderScrollView ()<UITableViewDelegate,UITableViewDataSource,CreateOrderHeaderViewDelegate,CreateOrderSwitchCellDelegate>
/**  headerView */
@property(nonatomic,strong) CreateOrderHeaderView * headerView;
/**  tableView */
@property(nonatomic,strong) UITableView * tableView;

@end


@implementation CreateOrderScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.headerView = [[CreateOrderHeaderView alloc] init];
    self.headerView.delegate = self;
    [self addSubview:self.headerView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    [self.tableView registerClass:[MyOrderListCell class] forCellReuseIdentifier:[MyOrderListCell className]];
    [self.tableView registerClass:[CreateOrderServiceCell class] forCellReuseIdentifier:[CreateOrderServiceCell className]];
    [self.tableView registerClass:[CreateOrderAmountCell class] forCellReuseIdentifier:[CreateOrderAmountCell className]];
    [self.tableView registerClass:[CreateOrderMessageCell class] forCellReuseIdentifier:[CreateOrderMessageCell className]];
    [self.tableView registerClass:[CreateOrderSwitchCell class] forCellReuseIdentifier:[CreateOrderSwitchCell className]];
}
- (void)setLayout
{

}
#pragma mark - custom method

#pragma mark - handle action
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.model.listGoods.count;
    }else
    {
        return self.model.servicesArray.count + 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderListCell className]];
        cell.model = self.model.listGoods[indexPath.row];
        return cell;
    }else if (indexPath.section == 1)
    {
        if (indexPath.row < self.model.servicesArray.count) {
            CreateOrderServiceCell* cell = [tableView dequeueReusableCellWithIdentifier:[CreateOrderServiceCell className]];
            cell.model = self.model.servicesArray[indexPath.row];
            return cell;
        }
        if (indexPath.row - self.model.servicesArray.count == 0) {
            CreateOrderMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[CreateOrderMessageCell className]];
            return cell;
        }
        if (indexPath.row - self.model.servicesArray.count == 1) {
            CreateOrderSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:[CreateOrderSwitchCell className]];
            cell.delegate = self;
            return cell;
        }
        CreateOrderAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:[CreateOrderAmountCell className]];
        cell.model = self.model.prices;
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self.model.listGoods[indexPath.row] cellHeight];
    }else if (indexPath.section == 1)
    {
        NSInteger index = indexPath.row - self.model.servicesArray.count;
        if (index < 2) {
            return Adapted(kServiceH);
        }
        return Adapted(kAmountCellH);
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.CO_delegate && [self.CO_delegate respondsToSelector:@selector(CreateOrderScrollViewdelegate_clickServiceCellWithIndexPath:)]) {
        [self.CO_delegate CreateOrderScrollViewdelegate_clickServiceCellWithIndexPath:indexPath];
    }
}
#pragma mark - CreateOrderHeaderViewDelegate
- (void)CreateOrderHeaderViewDelegate_clickSelf
{
    if (self.CO_delegate && [self.CO_delegate respondsToSelector:@selector(CreateOrderScrollViewdelegate_clickHeaderView)]) {
        [self.CO_delegate CreateOrderScrollViewdelegate_clickHeaderView];
    }
}
#pragma mark - CreateOrderSwitchCellDelegate
- (void)CreateOrderSwitchCellDelegate_clickSwitchWithIsSelected:(BOOL)isSelected
{
    if (self.CO_delegate && [self.CO_delegate respondsToSelector:@selector(CreateOrderScrollViewdelegate_clickSwitchWithIsSelected:)]) {
        [self.CO_delegate CreateOrderScrollViewdelegate_clickSwitchWithIsSelected:isSelected];
    }
}
#pragma mark - setter model
- (void)setModel:(CreateOrderModel *)model
{
    _model = model;
    self.headerView.model = model;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.width.offset(kScreenW);
        make.height.offset(model.headerViewH);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(Adapted(kMargin / 2));
        make.left.right.offset(0);
        make.height.offset(model.tableViewH);
        make.bottom.offset(0);
    }];
}

@end
