//
//  MyOrderDetailScrollView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderDetailScrollView.h"
#import "MyOrderDetailHeaderView.h"
#import "MyOrderListCell.h"
#import "MyOrderDetailInvoiceCell.h"
#import "MyOrderDetailPriceCell.h"
#import "MyOrderDetailModel.h"
#import "MyOrderListModel.h"
@interface MyOrderDetailScrollView ()<UITableViewDelegate,UITableViewDataSource>
/**  headerView */
@property(nonatomic,strong) MyOrderDetailHeaderView * headerView;
/**  goodsTableView */
@property(nonatomic,strong) UITableView * goodsTableView;
/**  InvoiceTableView */
@property(nonatomic,strong) UITableView * invoiceTableView;
@end

@implementation MyOrderDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = QFColor_CoodsClassMenuViewBg;
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.headerView = [[MyOrderDetailHeaderView alloc] init];
    [self addSubview:self.headerView];
    
    //中间商品信息
    self.goodsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self setTableViewWithTableView:self.goodsTableView];
    [self addSubview:self.goodsTableView];
    [self.goodsTableView registerClass:[MyOrderListCell class] forCellReuseIdentifier:[MyOrderListCell className]];
    
    
    //发票信息
    self.invoiceTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self setTableViewWithTableView:self.invoiceTableView];
    [self addSubview:self.invoiceTableView];
    [self.invoiceTableView registerClass:[MyOrderDetailInvoiceCell class] forCellReuseIdentifier:[MyOrderDetailInvoiceCell className]];
    [self.invoiceTableView registerClass:[MyOrderDetailPriceCell class] forCellReuseIdentifier:[MyOrderDetailPriceCell className]];
}
- (void)setLayout
{

}
#pragma mark - custom method
- (void)setTableViewWithTableView:(UITableView *)tableView
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
}
#pragma mark - handle action
#pragma mark - UITableViewDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.goodsTableView]) {
        return self.model.listGoods.count;
    }else if ([tableView isEqual:self.invoiceTableView])
    {
        return self.model.priceCellArray.count + 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.goodsTableView]) {
        MyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderListCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model.listGoods[indexPath.row];
        return cell;
    }else if ([tableView isEqual:self.invoiceTableView])
    {
        if (indexPath.row == 0) {
            MyOrderDetailInvoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderDetailInvoiceCell className]];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            return cell;
        }
        MyOrderDetailPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderDetailPriceCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model.priceCellArray[indexPath.row - 1];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.goodsTableView]) {
        return [self.model.listGoods[indexPath.row] cellHeight];
    }else if ([tableView isEqual:self.invoiceTableView])
    {
        if (indexPath.row == 0) {
            return self.model.invoiceCellH;
        }
        return Adapted(kPriceCellHeight);
    }
    return 0;
}
#pragma mark - setter model
- (void)setModel:(MyOrderDetailModel *)model
{
    _model = model;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(kScreenW);
        make.top.left.right.offset(0);
        make.height.offset(model.headerViewH);
    }];
    self.headerView.model = model;
    
    [self.goodsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(Adapted(kMargin / 2));
        make.left.right.offset(0);
        make.height.offset(model.listGoodsH);
    }];
    
    [self.invoiceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsTableView.mas_bottom);
        make.left.bottom.right.offset(0);
        make.height.offset(model.invoiceTableViewH);
    }];
}

@end
