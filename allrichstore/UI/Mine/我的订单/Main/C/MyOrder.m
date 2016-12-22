//
//  MyOrder.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrder.h"
#import "MyOrderDetailVC.h"
#import "MyOrderPopView.h"
#import "MyOrderListCell.h"
#import "MyOrderListModel.h"
@interface MyOrder ()<MyOrderPopViewDelegate,MyOrderListCellDelegate>
/**  titleButton */
@property(nonatomic,strong) QButton * titleButton;
/**  popView */
@property(nonatomic,strong) MyOrderPopView * popView;
@end

@implementation MyOrder

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    NSArray *array = @[@{@"shopName":@"柏杨九天",
                         @"shopIcon":@"jingxuan_icon",
                         @"goodsStatus":@"等待买家付款",
                         @"buttonArray":@[@"付款",@"123"],
                         @"goods":@[@{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"}]},
                       @{@"shopName":@"柏杨九天",
                         @"shopIcon":@"jingxuan_icon",
                         @"goodsStatus":@"已取消",
                         @"buttonArray":@[@"再次购买"],
                         @"goods":@[@{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"},
                                    @{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"},
                                    @{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"}]},
                       @{@"shopName":@"柏杨九天",
                         @"shopIcon":@"jingxuan_icon",
                         @"goodsStatus":@"已完成",
                         @"buttonArray":@[@"再次购买"],
                         @"goods":@[@{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"},
                                    @{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"}]},
                       @{@"shopName":@"柏杨九天",
                         @"shopIcon":@"jingxuan_icon",
                         @"goodsStatus":@"买家已付款",
                         @"buttonArray":@[],
                         @"goods":@[@{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                       @"subTitle1":@"颜色分类：白色",
                                       @"subTitle2":@"尺寸：S码",
                                       @"price":@"218.00",
                                       @"count":@"1"}]}];
    self.listArray = [MyOrderListModel mj_objectArrayWithKeyValuesArray:array];
    
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    self.titleButton.frame = CGRectMake(0, 0, 150, 44);
    self.navigationItem.titleView = self.titleButton;
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MyOrderListCell class] forCellReuseIdentifier:[MyOrderListCell className]];
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
- (void)titleAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.popView show];
        
    }else
    {
        [self.popView hidden];
    }
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderListCell className]];
    cell.model = self.listArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.listArray[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MyOrderPopViewDelegate
- (void)MyOrderPopViewDelegate_clickWithButton:(QButton *)sender
{
    [self.titleButton setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    [self.popView hidden];
    self.titleButton.selected = NO;
}
- (void)MyOrderPopViewDelegate_clickPopView
{
    [self.popView hidden];
    self.titleButton.selected = NO;
}
#pragma mark - MyOrderListCellDelegate
- (void)MyOrderListCellDelegate_clickWithButton:(UIButton *)sender
{
    
}
- (void)MyOrderListCellDelegate_clickCellWithModel:(MyOrderListModel *)model
{
    MyOrderDetailVC *detailVC = [[MyOrderDetailVC alloc] init];
    detailVC.style = self.style;
    [self.navigationController pushVC:detailVC animated:YES];
}
#pragma mark - setter model
- (QButton *)titleButton
{
    if (!_titleButton) {
        _titleButton = [[QButton alloc] init];
        _titleButton.space = 2.0f;
        _titleButton.style = QButtonStyleImageRight;
        [_titleButton setTitleColor:QF_BlackColor forState:UIControlStateNormal];
        [_titleButton setTitle:String(@"全部订单") forState:UIControlStateNormal];
        [_titleButton setImage:Image(@"") forState:UIControlStateNormal];
        [_titleButton setImage:Image(@"") forState:UIControlStateSelected];
        [_titleButton addTarget:self action:@selector(titleAction:) forControlEvents:UIControlEventTouchUpInside];
        _titleButton.titleLabel.font = Font_Mid;
    }
    return _titleButton;
}
- (MyOrderPopView *)popView
{
    if (!_popView) {
        _popView = [[MyOrderPopView alloc] initWithFrame:CGRectMake(0, TopBarHeight, kScreenW, kScreenH - TopBarHeight ) TitleArray:@[String(@"全部订单"),String(@"已完成订单"),String(@"已取消订单")] imageArray:@[@"quanbudingdan copy",@"yiwanchengdingdan copy",@"yiquxiaodingdan  copy"] SeletedImageA:@[@"quanbudingdan",@"yiwanchengdingdan",@"yiquxiaodingdan"]];
        _popView.delegate = self;
        [self.view addSubview:_popView];
    }
    return _popView;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
