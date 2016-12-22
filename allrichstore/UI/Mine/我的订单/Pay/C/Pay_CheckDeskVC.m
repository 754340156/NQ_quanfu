//
//  Pay_CheckDeskVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Pay_CheckDeskVC.h"
#import "Pay_CheckDeskCell.h"
#import "Pay_CheckDeskModel.h"
@interface Pay_CheckDeskVC ()
/**  去付款 */
@property(nonatomic,strong) UIButton * gotoPay;
@end

@implementation Pay_CheckDeskVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    NSArray *array = @[@{@"icon":@"weixinzhifu",
                         @"title":@"微信支付",
                         @"isSelected":@(1)},
                       @{@"icon":@"yinlianzhifu",
                         @"title":@"银联支付"},
                       @{@"icon":@"zhifubaozhifu",
                         @"title":@"支付宝支付"}];
    self.listArray = [Pay_CheckDeskModel mj_objectArrayWithKeyValuesArray:array];
    
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
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - kBottomH);
    [self.tableView registerClass:[Pay_CheckDeskCell class] forCellReuseIdentifier:[Pay_CheckDeskCell className]];
    
    [self.view addSubview:self.gotoPay];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.gotoPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.offset(kBottomH);
    }];
    
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
//去付款
- (void)gotoPayAction
{
    
}
#pragma mark - <UITableViewDataSource>
//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.listArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Pay_CheckDeskCell *cell = [tableView dequeueReusableCellWithIdentifier:[Pay_CheckDeskCell className] forIndexPath:indexPath];
    WS(weakSelf)
   __block Pay_CheckDeskModel *model = self.listArray[indexPath.row];
    cell.model = model;
    cell.clickSelectedBtnBlock = ^()
    {
        [weakSelf.listArray enumerateObjectsUsingBlock:^(Pay_CheckDeskModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            model.isSelected = NO;
            if (idx == indexPath.row ) {
                model.isSelected = YES;
            }
        }];
        [weakSelf.tableView reloadData];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.listArray enumerateObjectsUsingBlock:^(Pay_CheckDeskModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.isSelected = NO;
        if (idx == indexPath.row ) {
            model.isSelected = YES;
        }
    }];
    [self.tableView reloadData];
}
#pragma mark - lazy
- (UIButton *)gotoPay
{
    if (!_gotoPay) {
        _gotoPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gotoPay setTitle:@"去付款" forState:UIControlStateNormal];
        _gotoPay.titleLabel.font = Font(18);
        [_gotoPay setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_gotoPay setBackgroundColor:QF_RedColor];
        [_gotoPay addTarget:self action:@selector(gotoPayAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoPay;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
